require "rails_helper"

RSpec.describe "CPU対戦", type: :system do
  it "トップ" do
    visit "/cpu-versus"
    expect(page).to have_content "CPUの強さ"
    doc_image
  end

  it "CPUの強さ変更" do
    visit "/cpu-versus"
    choose("弱い")
    doc_image
  end

  it "対局" do
    visit "/cpu-versus"

    # 1手目「６八銀」
    first(".place_79").click
    first(".place_68").click
    doc_image("1手目")
    expect(page).to have_content "2手目" # CPUがすぐに指したため2手目になっている

    first(".place_28").click
    first(".place_51").click
    sleep(1)

    # 3手目「５一飛成」
    doc_image("3手目")
    expect(page).to have_content "成りますか？"
    click_on("成")
    sleep(1)

    expect(page).to have_content "反則負け"
    doc_image("反則負け")
  end
end
