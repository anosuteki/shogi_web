class BattleDecorator
  def self.format_foo1(value)
    m, s = value.divmod(1.minutes)
    if m == 0
      s
    else
      "#{m}:%02d" % s
    end
  end

  attr_accessor :params

  delegate :memberships, to: :battle

  def initialize(params)
    @params = params
  end

  def hand_log_for(*args)
    hand_logs[index_for(*args)]
  end

  def user_name_for(location)
    membership_for(location).user.key
  end

  def sengata_for(location)
    m = membership_for(location)
    m.attack_tag_list.first || m.defense_tag_list.first || m.note_tag_list.first
  end

  # battle に移動
  def battle_end_at
    battle.end_at
  end

  def jihunkara
    s = "#{spc(3)}時#{spc(3)}分"
    "#{s} 〜 #{s}".html_safe
  end

  def kirokugakari
  end

  def bikou_naiyou
    # "(bikou_naiyou)"
  end

  def teaiwari
    s = []
    name = battle.preset_info.name
    s << name
    if name == "平手"
      s << "振駒"
    end
    s.join(" ")
  end

  def kaku_jikan
    battle.rule_info.life_time / 1.minutes
  end

  def total_seconds_str_for(location)
    m = membership_for(location)
    min, sec = m.total_seconds.divmod(1.minutes)
    "#{min}分#{sec}秒"
  end

  def battle
    params[:battle]
  end

  def membership_for(location)
    location = Bioshogi::Location.fetch(location)
    battle.memberships[location.code]
  end

  private

  def index_for(x, y, left_or_right)
    x * (params[:cell_rows] * 2) + (y * 2) + left_or_right
  end

  def hand_logs
    @hand_logs ||= battle.heavy_parsed_info.mediator.hand_logs
  end

  def vc
    params[:view_context]
  end

  def spc(n = 1)
    "&nbsp;" * n
  end
end
