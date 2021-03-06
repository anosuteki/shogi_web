require "rails_helper"

RSpec.describe "新プレイヤー情報", type: :system do
  before do
    Swars.setup
    Swars::Battle.create!
  end

  it "遷移" do
    visit "/w?query=user1"
    find(".player_info_show_button").click
    expect(page).to have_content "10分"
    doc_image
  end

  describe "中身" do
    before do
      visit "/w?query=user1&user_info_show=1&tab_index=0"
    end
    it "日付" do
      expect(page).to have_content "勝率"
      doc_image
    end
    it "段級" do
      find(".tabs li:nth-of-type(2)").click
      expect(page).to have_content "遭遇率"
      doc_image
    end
    it "戦法" do
      find(".tabs li:nth-of-type(3)").click
      expect(page).to have_content "使用率"
      doc_image
    end
    it "対抗" do
      find(".tabs li:nth-of-type(4)").click
      expect(page).to have_content "遭遇率"
      doc_image
    end
  end
end
