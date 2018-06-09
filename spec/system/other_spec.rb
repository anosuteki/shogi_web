require "rails_helper"

RSpec.describe "その他", type: :system do
  it "トップ" do
    visit "/"
    expect(page).to have_content "Rails"
    doc_image("トップ")
  end

  it "符号入力ゲーム" do
    visit "/xy"
    expect(page).to have_content "Rails"
    doc_image("符号入力ゲーム")
  end

  it "CPU対戦" do
    visit "/cpu-versus"
    expect(page).to have_content "Rails"
    doc_image("CPU対戦")
  end

  it "局面編集" do
    visit "/position-editor"
    expect(page).to have_content "Rails"
    doc_image("局面編集")
  end

  it "戦法一覧" do
    visit "/tactics"
    expect(page).to have_content "Rails"
    doc_image("戦法一覧")
  end

  it "戦法詳細" do
    visit "/tactics/ダイヤモンド美濃"
    expect(page).to have_content "Rails"
    doc_image("戦法詳細")
  end

  it "戦法ツリー" do
    visit "/tactics-tree"
    expect(page).to have_content "Rails"
    doc_image("戦法ツリー")
  end

  it "今日の戦法占い" do
    visit "/tactics-fortune"
    expect(page).to have_content "Rails"
    doc_image("今日の戦法占い")
  end
end
