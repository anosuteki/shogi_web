require "rails_helper"

RSpec.describe "sp_modal", type: :system do
  it "棋譜コピー" do
    visit "/adapter"
    find(".sp_modal_button").click
    find(".kif_copy_button").click
    expect(page).to have_content "コピーしました"
    doc_image
  end
end
