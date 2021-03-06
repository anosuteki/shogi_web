# -*- coding: utf-8 -*-
# == Schema Information ==
#
# 将棋ウォーズ対戦情報 (swars_battles as Swars::Battle)
#
# |---------------+------------------+--------------+-------------+-------------------+-------|
# | name          | desc             | type         | opts        | refs              | index |
# |---------------+------------------+--------------+-------------+-------------------+-------|
# | id            | ID               | integer(8)   | NOT NULL PK |                   |       |
# | key           | 対局ユニークキー | string(255)  | NOT NULL    |                   | A!    |
# | battled_at    | 対局日時         | datetime     | NOT NULL    |                   | G     |
# | rule_key      | ルール           | string(255)  | NOT NULL    |                   | B     |
# | csa_seq       | 棋譜             | text(65535)  | NOT NULL    |                   |       |
# | final_key     | 結末             | string(255)  | NOT NULL    |                   | C     |
# | win_user_id   | 勝者             | integer(8)   |             | => Swars::User#id | D     |
# | turn_max      | 手数             | integer(4)   | NOT NULL    |                   | H     |
# | meta_info     | メタ情報         | text(65535)  | NOT NULL    |                   |       |
# | accessed_at   | 最終アクセス日時 | datetime     | NOT NULL    |                   |       |
# | outbreak_turn | Outbreak turn    | integer(4)   |             |                   | E     |
# | created_at    | 作成日時         | datetime     | NOT NULL    |                   |       |
# | updated_at    | 更新日時         | datetime     | NOT NULL    |                   |       |
# | preset_key    | 手合割           | string(255)  | NOT NULL    |                   | F     |
# | start_turn    | 開始局面         | integer(4)   |             |                   | I     |
# | critical_turn | 開戦             | integer(4)   |             |                   | J     |
# | sfen_body     | SFEN形式棋譜     | string(8192) | NOT NULL    |                   |       |
# | image_turn    | OGP画像の局面    | integer(4)   |             |                   |       |
# | sfen_hash     | Sfen hash        | string(255)  | NOT NULL    |                   |       |
# |---------------+------------------+--------------+-------------+-------------------+-------|
#
#- Remarks ----------------------------------------------------------------------
# 【警告:リレーション欠如】Swars::Userモデルで has_many :swars/battles されていません
#--------------------------------------------------------------------------------

require "matrix"

module Swars
  class Battle < ApplicationRecord
    include BattleModelMod
    include ImportMethods
    include ConvertHookMethods

    belongs_to :win_user, class_name: "Swars::User", optional: true # 勝者プレイヤーへのショートカット。引き分けの場合は入っていない。memberships.win.user と同じ

    has_many :memberships, -> { order(:position) }, dependent: :destroy, inverse_of: :battle

    has_many :users, through: :memberships

    scope :win_lose_only, -> { where.not(win_user_id: nil) } # 勝敗が必ずあるもの
    scope :newest_order, -> { order(battled_at: :desc) }     # 新しい順

    before_validation on: :create do
      if Rails.env.development? || Rails.env.test?
        # Bioshogi::Parser.parse(Bioshogi::TacticInfo.flat_lookup(tactic_key).sample_kif_file.read).to_csa
        if kifu_body_for_test.blank? && tactic_key.blank?
          self.csa_seq ||= [["+7968GI", 599], ["-8232HI", 597], ["+5756FU", 594], ["-3334FU", 590], ["+6857GI", 592]]
        end

        (Bioshogi::Location.count - memberships.size).times do
          memberships.build
        end

        memberships.each do |m|
          m.user ||= User.create!
        end
      end

      memberships[0].op_user ||= memberships[1].user
      memberships[1].op_user ||= memberships[0].user

      if Rails.env.development? || Rails.env.test?
        self.key ||= "#{self.class.name.demodulize.underscore}#{self.class.count.next}"
      end
      self.key ||= SecureRandom.hex

      self.csa_seq ||= []

      self.rule_key ||= :ten_min

      # "" から ten_min への変換
      if rule_key
        self.rule_key = RuleInfo.fetch(rule_key).key
      end

      # キーは "(先手名)-(後手名)-(日付)" となっているので最後を開始日時とする
      if key
        if key.include?("-")
          ymd_str = key.split("-").last
          if ymd_str.match?(/\A\d+_\d+\z/)
            self.battled_at ||= Time.zone.parse(ymd_str) rescue nil
          end
        end
      end

      # if Rails.env.development? || Rails.env.test?
      #   self.battled_at ||= Time.current + (self.class.count * 6.hour)
      # end

      self.battled_at ||= Time.current
      self.final_key ||= :TORYO
    end

    with_options presence: true do
      validates :key
      validates :battled_at
      validates :rule_key
      validates :final_key
    end

    with_options allow_blank: true do
      validates :key, uniqueness: { case_sensitive: true }
      validates :final_key, inclusion: FinalInfo.keys.collect(&:to_s)
    end

    # after_create do
    #   memberships.each(&:opponent_id_set_if_blank)
    # end

    def to_param
      key
    end

    def rule_info
      RuleInfo.fetch(rule_key)
    end

    def final_info
      FinalInfo.fetch(final_key)
    end

    def battle_decorator_class
      BattleDecorator::SwarsBattleDecorator
    end

    # 将棋ウォーズの形式はCSAなのでパーサーを明示すると理論上は速くなる
    def parser_class
      if kifu_body_for_test || tactic_key
        return Bioshogi::Parser
      end
      Bioshogi::Parser::CsaParser
    end

    concerning :SummaryMethods do
      def total_seconds
        @total_seconds ||= memberships.sum(&:total_seconds)
      end

      def end_at
        @end_at ||= battled_at + total_seconds.seconds
      end
    end

    concerning :HelperMethods do
      class_methods do
        # continuity_run_counter("xxx_api")
        def continuity_run_counter(key, options = {})
          options = {
            interval: 1.seconds,
          }.merge(options)

          counter = (Rails.cache.read(key) || 0).next
          Rails.cache.write(key, counter, expires_in: options[:interval])
          counter
        end

        def battle_url_extract(str)
          if url = URI.extract(str, ["http", "https"]).first
            if url.match?(%r{\.heroz\.jp/games/})
              url
            end
          end
        end

        def battle_key_extract(str)
          if url = battle_url_extract(str)
            URI(url).path.split("/").last
          end
        end
      end

      # def header_detail(h)
      #   if v = super
      #     v.merge("場所" => h.link_to(key, official_swars_battle_url, target: "_self"))
      #   end
      # end

      def piyo_shogi_base_params
        a = {}
        a[:game_name] = tournament_name
        names = memberships.collect(&:name_with_grade)
        a.update([:sente_name, :gote_name].zip(names).to_h)
        a
      end

      def tournament_name
        "将棋ウォーズ(#{rule_info.name})"
      end

      def title
        memberships.collect(&:name_with_grade).join(" vs ")
      end

      def description
        out = []
        # out << tournament_name
        # out << final_info.name
        out << memberships.collect { |e|
          names = []
          names += e.tag_names_for(:attack)
          names += e.tag_names_for(:defense)

          # 「居飛車」という情報は戦型から自明なので戦型も囲いもないときだけ入れる
          if names.blank?
            names += e.tag_names_for(:note) - (reject_tag_keys[:note] || []).collect(&:to_s)
          end

          names = names.presence || ["その他"]
          names.join(" ")
        }.join(" vs ")

        out.join(" ")
      end
    end

    def self.rule_key_bugfix_process
      c = 0
      Swars::Battle.where(Swars::Battle.arel_table[:created_at].gteq("2020-01-17".to_time)).find_each do |battle|
        if battle.rule_key == "ten_min"
          if ary = battle.csa_seq.first
            v = ary.last
            rule_key = nil
            case
            when v <= 180
              rule_key = "three_min"
            when v >= 1000
              rule_key = "ten_sec"
            end
            if rule_key
              # p battle.id
              battle.update!(rule_key: rule_key)
              # print "."
              c += 1
              # break
            end
          end
        end
      end
      SlackAgent.message_send(key: "rule_key_bugfix_process", body: c.to_s)
    end

    concerning :TimeChartMod do
      def time_chart_datasets
        memberships.collect.with_index { |e, i|
          {
            label: e.user.key,  # グラフの上に出る名前
            data: e.time_chart_xy_list,
          }
        }
      end

      def time_chart_sec_list_of(location)
        memberships[location.code].sec_list
      end
    end

    concerning :ViewHelper do
      included do
        cattr_accessor(:labels_type1) { ["自分", "相手"] }
        cattr_accessor(:labels_type2) { ["勝ち", "負け"] }
      end

      def left_right_memberships(current_swars_user)
        flip = false
        a = memberships.to_a
        if current_swars_user
          labels = labels_type1
          if a.last.user == current_swars_user
            flip = true
          end
        else
          labels = labels_type2
          if win_user_id
            if a.last.judge_key == "win"
              flip = true
            end
          end
        end
        if flip
          a = a.reverse
        end
        [flip, labels.zip(a)]
      end
    end
  end
end
