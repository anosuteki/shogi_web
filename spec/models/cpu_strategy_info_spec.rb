require 'rails_helper'

RSpec.describe CpuStrategyInfo, type: :model do
  it "score_table" do
    assert { CpuStrategyInfo["居飛車"].score_table }
  end
end
