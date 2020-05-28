module Actb
  Config = {
    # マッチング
    math_pow_ruijou_base: 5,     # gap < 2**(○+カウンター) ならマッチングする
    matching_interval_second: 3, # カウンターをインクリメントする間隔(秒)

    best_questions_limit: 10, # 問題数

    # マラソンモード
    progress_list_take_display_count: 8, # ○×は最新何個表示する？

    # シングルトンモード
    ikkai_misuttara_mou_osenai: true, # 誤答すると相手が誤答するまで解答ボタンを押せない？
    q2_time_limit_sec: 300,           # 1手は○秒以内に操作しないとタイムアウトになる
    nanmonkotaetara_kati: 5,          # ○問正解したら勝ち
    asobi_count: 4,                   # 3手詰なら○手足した手数まで操作できる

    # 各タイミング
    readygo_wait_delay: 2.5,
    deden_mode_delay: 0.8,

    room_messages_display_lines: 20,

    # UI
    save_and_return: true, # プロフィール編集画面で「保存」と同時に戻るか？
  }
end
