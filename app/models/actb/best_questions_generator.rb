module Actb
  class BestQuestionsGenerator
    attr_accessor :params

    def initialize(params)
      @params = {
      }.merge(params)

      if block_given?
        yield self
      end
    end

    def generate
      s = db_scope

      # DBから取得
      raise unless rule_info.best_questions_limit
      s = s.limit(rule_info.best_questions_limit)

      ################################################################################ 取得後

      # まぜる(DBから取得の際に何かの順序に依存していた場合など)
      if rule_info.after_order == :shuffle
        s = s.shuffle
      end

      # 最近投稿されたN個だけランダムに最初の方に登場させる
      if n = rule_info.atarasiinosaki
        ary = s.sort_by(&:created_at).last(n)
        ary.shuffle.each do |e|
          s = [e] + (s - [e])
        end
      end

      s.collect(&:as_json_type3)
    end

    def db_scope
      s = Question.all
      s = s.active_only

      # 指定の評価以上のもの(good_rateが空のものは1.0と見なす)
      if v = rule_info.good_rate_gteq
        s = s.where("(good_rate IS NULL OR (good_rate >= ?))", v)
      end

      # 指定の正解率以上のもの(o_rateが空のものは1.0と見なす)
      if v = rule_info.o_rate_gteq
        s = s.joins(:ox_record).where("(o_rate IS NULL OR (o_rate >= ?))", v)
      end

      # 指定の手数のもの(Rangeでも指定可)
      if v = rule_info.turn_max
        s = s.where(turn_max: v)
      end

      # 指定のタグ(オプション含めて指定する)
      if v = rule_info.tagged_with_args
        s = s.tagged_with(*v)
      end

      # 指定の種類(複数指定可)
      if v = Array(rule_info.lineage_keys).presence
        s = s.where(lineage: v.collect { |e| Lineage.fetch(e) })
      end

      # 取得するまえに順番をどうするか
      case rule_info.pre_order
      when :o_rate_desc
        s = s.joins(:ox_record).order(o_rate: :desc)
      when :random
        s = s.order("rand()")
      else
        raise ArgumentError, rule_info.pre_order.inspect
      end

      s
    end

    private

    def battle
      params[:battle]
    end

    def room
      params[:battle].room
    end

    def rule_info
      room.rule.pure_info
    end
  end
end
