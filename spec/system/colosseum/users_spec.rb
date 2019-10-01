require "rails_helper"

RSpec.describe "対戦", type: :system do
  context "ログインしてない状態" do
    it "ログイン画面" do
      visit "/colosseum/battles"
      doc_image
    end

    it "アカウント登録" do
      visit "/xusers/sign_up"
      doc_image
    end

    it "パスワードを忘れた" do
      visit "/xusers/password/new"
      doc_image
    end
  end

  context "ロビー" do
    before do
      visit_and_login
    end

    it "トップ" do
      expect(page).to have_content "Rails"
      doc_image
    end

    it "チャットでメッセージ送信" do
      find(".media-content textarea").set(message)
      click_on("送信")
      expect(page).to have_content message

      # リロード
      refresh
      expect(page).to have_content message
    end

    it "ルール設定の変更" do
      find("#rule_set_dialog_button").click
      expect(page).to have_content "人数"

      rule_set("チーム戦")
      assert_rule("チーム戦")
      click_on("閉じる")
      refresh

      # 反映されている
      find("#rule_set_dialog_button").click
      assert_rule("チーム戦")
    end

    it "全体通知" do
      click_on("全体通知")
      find(".modal.is-active textarea").set(message)
      find(".modal.is-active footer button").click # 「送信」
      sleep(0.5)
      expect(page).to have_content message
      doc_image
    end
  end

  # できればクリックしたい
  it "プロフィール表示" do
    @alice = create(:colosseum_user)
    visit "/colosseum/users/#{@alice.id}"
    doc_image
  end

  it "プロフィール設定" do
    @alice = create(:colosseum_user)
    visit "/colosseum/users/#{@alice.id}/edit"
    doc_image
  end

  describe "自動マッチング" do
    it "シングルス" do
      using_session(:user1) do
        visit_and_login
        click_on("対局開始")
        expect(page).to have_content "対戦相手を探しています"
        doc_image("待ち")
      end
      using_session(:user2) do
        visit_and_login
        click_on("対局開始")
      end
      sleep(5)

      using_session(:user1) do
        assert { current_path == polymorphic_path(Colosseum::Battle.last) }
        doc_image("user1_部屋移動")
      end
      using_session(:user2) do
        assert { current_path == polymorphic_path(Colosseum::Battle.last) }
        doc_image("user2_部屋移動")
      end

      # 観戦者登場
      if true
        using_session(:user3) do
          visit_and_login
          visit "/colosseum/battles/#{Colosseum::Battle.last.id}"
          expect(page).to have_content "観戦者"
          expect(page).to have_content "user3"
          doc_image("user3_観戦者視点")
        end
      end

      battle = Colosseum::Battle.last
      black_user_name = battle.memberships.black.first.user.name
      white_user_name = battle.memberships.white.first.user.name

      using_session(black_user_name) do
        click_on("投了")
        sleep(1)
        doc_image("投了_確認")
        click_on("投了する")
        sleep(1)
        doc_image("投了_実行")
      end

      using_session(white_user_name) do
        expect(page).to have_content "勝利"
        doc_image("勝ち")
      end
    end

    it "ダブルス" do
      # refresh
      sleep(15)

      matching_set("user1", "ダブルス")
      matching_set("user2", "ダブルス")
      matching_set("user3", "ダブルス")

      if ENV["CI"]
        tp Colosseum::User.all
        tp Colosseum::Rule.all
        tp Colosseum::Battle.all
      end

      using_session("user4") do
        __choise_rule_and_start("team_p2vs2")
        sleep(10)
        assert { current_path == polymorphic_path(Colosseum::Battle.last) }
        doc_image("成立")
        # TODO: 4人そろっていることを確認したい
      end
    end

    it "チーム戦" do
      matching_set("user1", "チーム戦")
      matching_set("user2", "チーム戦")
      matching_set("user3", "チーム戦")
      matching_set("user4", "チーム戦")
      matching_set("user5", "チーム戦")
      matching_set("user6", "チーム戦")
      matching_set("user7", "チーム戦")

      if ENV["CI"]
        tp Colosseum::User.all
        tp Colosseum::Rule.all
        tp Colosseum::Battle.all
      end

      using_session("user8") do
        __choise_rule_and_start("チーム戦")
        sleep(10)
        assert { current_path == polymorphic_path([Colosseum::Battle.last]) }
        doc_image("成立")
      end
    end
  end

  context "対局リクエスト" do
    it "自分vs自分" do
      visit_and_login
      refresh
      find(".message_link_to img.user_#{Colosseum::User.last.id}").click
      expect(page).to have_content "対局申し込み"
      doc_image("申込")
      click_on("対局申し込み")
      expect(page).to have_content "さんからの挑戦状"
      doc_image("受諾")
      click_on("受ける")
      sleep(2)
      assert { current_path == polymorphic_path([Colosseum::Battle.last]) }
      doc_image("対局")
    end

    it "自分vs他人" do
      using_session("user1") do
        visit_and_login
        @user1 = Colosseum::User.last
      end
      using_session("user2") do
        visit_and_login
        find(".message_link_to img.user_#{@user1.id}").click
        expect(page).to have_content "対局申し込み"
        doc_image("申込")
        click_on("対局申し込み")
      end
      using_session("user1") do
        expect(page).to have_content "さんからの挑戦状"
        doc_image("挑戦状受信")
        click_on("受ける")
        sleep(2)
        # 対局画面に移動
        assert { current_path == polymorphic_path([Colosseum::Battle.last]) }
        doc_image("成立移動1")
      end
      using_session("user2") do
        # 対局画面に移動
        assert { current_path == polymorphic_path([Colosseum::Battle.last]) }
        doc_image("成立移動2")
      end
    end
  end

  context "メッセージ送信" do
    it "自分宛" do
      visit_and_login
      refresh
      find(".message_link_to img.user_#{Colosseum::User.last.id}").click
      within(".modal-card") do
        expect(page).to have_content "対局申し込み"
        find("textarea").set(message)
        click_on("送信")
      end
      expect(page).to have_content message
      doc_image("受信")
    end

    it "他者宛" do
      @alice = create(:colosseum_user)
      visit_and_login
      find(".message_link_to img.user_#{@alice.id}").click
      expect(page).to have_content "対局申し込み"
      within(".modal-card") do
        find("textarea").set(message)
        click_on("送信")
      end
      doc_image("送信直後")
    end

    it "常駐CPUに送信" do
      Colosseum::User.setup     # ロボットたちを準備

      visit_and_login
      find(".message_link_to img.user_#{cpu_level1.id}").click
      expect(page).to have_content "対局申し込み"
      within(".modal-card") do
        find("textarea").set(message)
        click_on("送信")
      end
      sleep(3)                             # 待ち時間が微妙
      expect(page).to have_content message # オウム返し
      doc_image("返信")
    end
  end

  def matching_set(name, rule)
    using_session(name) do
      __choise_rule_and_start(rule)
      expect(page).to have_content "対戦相手を探しています"
    end

    assert { Colosseum::User.all.all?(&:joined_at) }
  end

  def rule_find(name)
    find(:xpath, "//label[text()='#{name} ']")
  end

  def rule_set(rule)
    rule_find(rule).click
  end

  def assert_rule(rule)
    v = rule_find(rule)[:class].include?("is-primary")
    assert { v }                # このなかで実行すると power_assert がこわれる
  end

  def choose3(rule)
    find(:xpath, "//label[text()='#{rule} ']/input")
  end

  def __choise_rule_and_start(rule)
    visit_and_login
    find("#rule_set_dialog_button").click

    rule_set(rule)
    assert_rule(rule)

    # if true
    #   # choose(rule)
    #   first(:xpath, "//span[text()='弱い']").click
    # else
    #   Capybara.execute_script("window.scrollTo(0, document.body.scrollHeight)")
    #   find(:xpath, "//*[@value='#{rule}']", visible: false).hover.choose
    # end

    click_on("閉じる")
    sleep(5)
    click_on("対局開始")
    sleep(2)
  end

  def visit_and_login
    visit "/colosseum/battles?__create_user_name__=#{Capybara.session_name}"

    # Travis CI の場合ランダムに転けるので余裕を持って待つ
    if ENV["CI"]
      sleep(3)
    end
  end

  def message
    "おーい！対戦しようぜ！"
  end

  def cpu_level1
    Colosseum::User.find_by!(key: Colosseum::CpuBrainInfo[:level1].key)
  end
end
