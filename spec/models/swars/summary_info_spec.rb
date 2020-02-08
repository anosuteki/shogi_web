require 'rails_helper'

module Swars
  RSpec.describe User, type: :model do
    before do
      Swars.setup

      @user1 = User.create!
      @user2 = User.create!
    end

    it "10分先手放置切れ負け" do
      battle = Battle.new

      battle.csa_seq = [["+7776FU", 600], ["-3334FU", 600], ["+6978KI", 599], ["-4344FU", 597], ["+2726FU", 597], ["-3132GI", 595], ["+3948GI", 596], ["-3243GI", 594], ["+5756FU", 596], ["-2233KA", 593], ["+4857GI", 595], ["-8222HI", 591], ["+7968GI", 593], ["-5162OU", 590], ["+5969OU", 592], ["-7172GI", 589], ["+6979OU", 591], ["-6271OU", 588], ["+8866KA", 590], ["-9394FU", 586], ["+7988OU", 590], ["-7182OU", 585], ["+9998KY", 589], ["-4132KI", 583], ["+8899OU", 588], ["-2324FU", 579], ["+6877GI", 585], ["-4445FU", 577], ["+7788GI", 580], ["-3366KA", 567], ["+5766GI",574], ["-2133KE", 565], ["+6657GI", 568], ["-2425FU", 563], ["+2625FU", 567], ["-2225HI", 562], ["+0026FU", 561], ["-2521HI", 558], ["+7879KI", 559], ["-0044KA", 553], ["+4958KI", 550], ["-2126HI", 551], ["+2826HI", 545], ["-4426KA", 549], ["+0021HI", 537], ["-0028HI", 547], ["+5868KI", 533], ["-2829RY", 539], ["+2111RY", 531], ["-2637UM", 538], ["+0021KA", 513], ["-3719UM", 524], ["+0055KY", 482], ["-0051KY", 520], ["+2132UM", 476], ["-4332GI", 518], ["+0042KI", 471], ["-3221GI", 513], ["+1113RY", 446], ["-0012FU", 509], ["+1333RY", 444], ["-5354FU", 503], ["+4251KI", 434], ["-6151KI", 502], ["+5554KY", 433], ["-0042KI", 495], ["+3334RY", 417], ["-0053FU", 493], ["+5453NY", 416], ["-4253KI", 492], ["+0054KY", 415], ["-0042KE", 487], ["+3445RY", 404], ["-4254KE", 483], ["+5655FU", 400], ["-0044FU", 481], ["+4556RY", 398],["-0045KA", 452], ["+5665RY", 379], ["-5364KI", 449], ["+6585RY", 377], ["-8384FU", 446], ["+8586RY", 369], ["-6455KI", 442], ["+0075KE", 367], ["-0085KY", 420], ["+8677RY", 365], ["-0056FU", 413], ["+5746GI", 351], ["-5446KE", 412], ["+4746FU", 349], ["-5546KI", 410], ["+8786FU", 348], ["-8271OU", 395], ["+8685FU", 347], ["-8485FU", 393], ["+0086FU", 336], ["-5657TO", 391], ["+6878KI", 335], ["-4647KI", 377], ["+8685FU", 332], ["-0082FU", 375], ["+8584FU", 331], ["-1955UM", 371], ["+7786RY", 327], ["-5767TO", 368], ["+7867KI", 323], ["-4567UM", 366], ["+0085KY", 320], ["-2979RY", 359]]
      battle.rule_key = :ten_min
      battle.final_key = :TIMEOUT

      battle.memberships.build(user: @user1, judge_key: :lose, location_key: :black)
      battle.memberships.build(user: @user2, judge_key: :win,  location_key: :white)
      battle.save!

      v = @user1.secret_summary
      tp v if ENV["VERBOSE"]

      v = @user2.secret_summary
      tp v if ENV["VERBOSE"]

      #       @user1.secret_summary.to_t.should == <<~EOS
      # |-----------------------------------------+---------|
      # |                  サンプル対局数 | 1       |
      # |                                    勝ち | 0回     |
      # |                                    負け | 1回     |
      # |                                切れ負け | 1回     |
      # |                        【10分】最大長考 | 31秒    |
      # |                  【10分】最終着手の最長 | 3秒     |
      # | 【10分】最後の着手に3分以上かけて負けた | 0回     |
      # |    【10分】切れ負けたときの最長残り時間 | 5分20秒 |
      # |     【10分】3分以上考えたまま切れ負けた | 1回     |
      # | 【10分】1手詰勝ちのときの着手最長 |         |
      # |                                  投了率 | 0.0 %   |
      # |                                  切断率 | 0.0 %   |
      # |                          棋神召喚疑惑率 |         |
      # |-----------------------------------------+---------|
      # EOS
      #
      #       @user2.secret_summary.to_t.should == <<~EOS
      # |-----------------------------------------+-------|
      # |                  サンプル対局数 | 1     |
      # |                                    勝ち | 1回   |
      # |                                    負け | 0回   |
      # |                                切れ勝ち | 1回   |
      # |                        【10分】最大長考 | 29秒  |
      # |                  【10分】最終着手の最長 | 7秒   |
      # | 【10分】最後の着手に3分以上かけて負けた | 0回   |
      # |    【10分】切れ負けたときの最長残り時間 |       |
      # |     【10分】3分以上考えたまま切れ負けた | 0回   |
      # | 【10分】1手詰勝ちのときの着手最長 |       |
      # |                                  投了率 |       |
      # |                                  切断率 |       |
      # |                          棋神召喚疑惑率 | 0.0 % |
      # |-----------------------------------------+-------|
      # EOS
    end

    it "3分いやがらせ0秒指し" do
      battle = Battle.new

      battle.csa_seq = [["+7968GI", 180], ["-8384FU", 180], ["+5756FU", 180], ["-8485FU", 180], ["+6857GI", 179], ["-3334FU", 180], ["+6978KI", 179], ["-7162GI", 179], ["+2726FU", 178], ["-4132KI", 179], ["+2625FU", 177], ["-2233KA", 179], ["+8879KA", 177], ["-3122GI", 179], ["+3948GI", 175], ["-4344FU", 178], ["+3736FU", 175], ["-6152KI", 177], ["+3635FU", 174], ["-5243KI", 177], ["+3534FU", 173], ["-4334KI", 177], ["+5746GI", 171], ["-4445FU", 176], ["+4635GI", 171], ["-3435KI", 175], ["+7935KA", 170], ["-0034FU", 175], ["+3579KA", 169], ["-8586FU", 175], ["+8786FU",168], ["-8286HI", 174], ["+0087FU", 167], ["-8656HI", 173], ["+5969OU", 166], ["-9394FU", 172], ["+2524FU", 160], ["-2324FU", 171], ["+7924KA", 159], ["-3324KA", 165], ["+2824HI", 158], ["-0057GI", 160], ["+0065KA", 153], ["-5654HI", 144], ["+6554KA", 151], ["-5354FU", 144], ["+4857GI", 149], ["-0035KA", 143], ["+2422RY", 145], ["-3222KI", 142], ["+0043GI", 144], ["-5161OU", 135], ["+0082HI", 135], ["-3557KA", 126], ["+0052GI", 132], ["-6171OU", 1], ["+0072KI", 129]]
      battle.rule_key = :three_min
      battle.final_key = :TIMEOUT

      battle.memberships.build(user: @user1, judge_key: :win,  location_key: :black)
      battle.memberships.build(user: @user2, judge_key: :lose, location_key: :white)
      battle.save!

      v = @user1.secret_summary
      tp v if ENV["VERBOSE"]

      v = @user2.secret_summary
      tp v if ENV["VERBOSE"]

      #       @user1.secret_summary.to_t.should == <<~EOS
      # |----------------------------------------+-------|
      # |                 サンプル対局数 | 1     |
      # |                                   勝ち | 1回   |
      # |                                   負け | 0回   |
      # |                               切れ勝ち | 1回   |
      # |                        【3分】最大長考 | 9秒   |
      # |                  【3分】最終着手の最長 | 3秒   |
      # | 【3分】最後の着手に1分以上かけて負けた | 0回   |
      # |    【3分】切れ負けたときの最長残り時間 |       |
      # |     【3分】1分以上考えたまま切れ負けた | 0回   |
      # | 【3分】1手詰勝ちのときの着手最長 |       |
      # |                                 投了率 |       |
      # |                                 切断率 |       |
      # |                         棋神召喚疑惑率 | 0.0 % |
      # |----------------------------------------+-------|
      # EOS
      #
      #       @user2.secret_summary.to_t.should == <<~EOS
      # |----------------------------------------+--------|
      # |                 サンプル対局数 | 1      |
      # |                                   勝ち | 0回    |
      # |                                   負け | 1回    |
      # |                               切れ負け | 1回    |
      # |                        【3分】最大長考 | 2分5秒 |
      # |                  【3分】最終着手の最長 | 2分5秒 |
      # | 【3分】最後の着手に1分以上かけて負けた | 1回    |
      # |    【3分】切れ負けたときの最長残り時間 | 1秒    |
      # |     【3分】1分以上考えたまま切れ負けた | 0回    |
      # | 【3分】1手詰勝ちのときの着手最長 |        |
      # |                                 投了率 | 0.0 %  |
      # |                                 切断率 | 0.0 %  |
      # |                         棋神召喚疑惑率 |        |
      # |----------------------------------------+--------|
      # EOS
    end
  end
end
