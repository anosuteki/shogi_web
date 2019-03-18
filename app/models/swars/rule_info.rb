# leave_alone_limit: 放置負け判定

module Swars
  class RuleInfo
    include ApplicationMemoryRecord
    memory_record [
      {key: :ten_min,   name: "10分", long_name: "10分切れ負け", swars_real_key: "",   csa_time_limit: "00:10+00", life_time: 10.minutes, leave_alone_limit: 3.minutes, player_info_show: true,  },
      {key: :three_min, name: "3分",  long_name: "3分切れ負け",  swars_real_key: "sb", csa_time_limit: "00:03+00", life_time: 3.minutes,  leave_alone_limit: 1.minutes, player_info_show: true,  },
      {key: :ten_sec,   name: "10秒", long_name: "1手10秒",      swars_real_key: "s1", csa_time_limit: "00:00+10", life_time: 1.hour,     leave_alone_limit: nil,       player_info_show: false, }, # 内部的には1時間設定になっている
    ]

    class << self
      def lookup(v)
        super || invert_table[v]
      end

      private

      def invert_table
        @invert_table ||= inject({}) {|a, e| a.merge(e.swars_real_key => e) }
      end
    end

    def short_name
      name
    end
  end

  if $0 == __FILE__
    tp RuleInfo[""]
    # |------|
    # | 10分 |
    # |------|
  end
end
