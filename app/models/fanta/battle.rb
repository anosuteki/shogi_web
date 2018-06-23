module Fanta
  class Battle < ApplicationRecord
    has_many :current_users, class_name: "User", foreign_key: :current_battle_id, dependent: :nullify

    scope :latest_list, -> { order(updated_at: :desc).limit(50) }
    scope :latest_list_for_profile, -> { order(updated_at: :desc).limit(25) }
    scope :st_battling, -> { where.not(begin_at: nil).where(end_at: nil) }

    serialize :clock_counts
    serialize :countdown_mode_hash

    before_validation on: :create do
      self.black_preset_key ||= "平手"
      self.white_preset_key ||= "平手"
      self.lifetime_key ||= :lifetime_m5
      self.platoon_key ||= :platoon_p1vs1
      self.turn_max ||= 0
      self.clock_counts ||= {black: [], white: []}
      self.countdown_mode_hash ||= {black: false, white: false}
    end

    before_validation do
      if changes_to_save[:black_preset_key] || changes_to_save[:white_preset_key]
        if black_preset_key && white_preset_key
          mediator = Warabi::Mediator.new
          mediator.board.placement_from_hash(black: black_preset_key, white: white_preset_key)
          mediator.turn_info.handicap = handicap
          self.kifu_body_sfen = "position #{mediator.to_long_sfen}"
        end
      end
    end

    def name
      # if users.present?
      #   users.collect(&:name).join(" vs ")
      # else
      #   names = []
      #   if room_owner
      #     names << "#{room_owner.name}の"
      #   end
      #   names << "対戦部屋 ##{Battle.count.next}"
      #   names.join
      # end
      "##{id}"
    end

    def xstate_key
      if begin_at && end_at
        :st_done
      elsif begin_at
        :st_battling
      else
        :st_before
      end
    end

    def xstate_info
      XstateInfo.fetch(xstate_key)
    end

    def human_kifu_text
      info = Warabi::Parser.parse(kifu_body_sfen, typical_error_case: :embed)
      begin
        mediator = info.mediator
      rescue => error
        return error.message
      end
      if begin_at
        info.header["開始日時"] = begin_at.to_s(:csa_ymdhms)
      end
      if end_at
        info.header["終了日時"] = end_at.to_s(:csa_ymdhms)
      end
      if persisted?
        info.header["場所"] = Rails.application.routes.url_helpers.url_for([self, {only_path: false}.merge(ActionMailer::Base.default_url_options)])
      end
      info.names_set(names_hash)
      info.to_ki2
    end

    # after_commit do
    #   broadcast
    # end

    # def broadcast
    #   # ActionCable.server.broadcast("lobby_channel", battles: JSON.load(self.class.latest_list.to_json(to_json_params)))
    #   # ActionCable.server.broadcast("battle_channel_#{id}", battle: js_attributes) # FIXME: これは重いだけで使ってないのではずす
    # end

    # def js_attributes
    #   JSON.load(to_json(to_json_params))
    # end

    def show_path
      Rails.application.routes.url_helpers.url_for([self, only_path: true])
    end

    def handicap
      !(black_preset_key == "平手" && white_preset_key == "平手")
    end

    def names_hash
      memberships.group_by(&:location_key).transform_values { |a| a.collect { |e| e.user.name }.join("・") }.symbolize_keys
    end

    # 対局者
    concerning :UserMethods do
      included do
        has_many :memberships, dependent: :destroy
        has_many :users, through: :memberships
      end
    end

    # 観戦者
    concerning :WatchUserMethods do
      included do
        has_many :watch_ships, dependent: :destroy                        # 観戦中の人たち(中間情報)
        has_many :watch_users, through: :watch_ships, source: :user # 観戦中の人たち
      end
    end

    # チャット関連
    concerning :ChatMessageMethods do
      included do
        cattr_accessor(:chat_window_size) { 10 }

        has_many :chat_messages, dependent: :destroy do
          def limited_latest_list
            latest_list.limit(chat_window_size)
          end
        end
      end
    end
  end
end
