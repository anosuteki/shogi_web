export const application_room = {
  data() {
    return {
      room_code: "",                         // リアルタイム共有合言葉
      user_code: this.info.record.user_code, // 自分と他者を区別するためのコード
    }
  },
  created() {
    this.room_code_set(this.info.record.room_code, {initial: true})
  },
  methods: {
    room_code_set(room_code, options = {}) {
      options = {
        initial: false,
        ...options,
      }
      this.room_code = _.trim(room_code)
      this.room_unsubscribe() // 内容が変更になったかもしれないのでいったん解除
      if (this.room_code) {
        this.room_setup(options)
      }
    },

    room_setup(options = {}) {
      this.room_unsubscribe()

      this.__assert__(this.$ac_room == null, "this.$ac_room == null")
      this.$ac_room = this.ac_subscription_create({channel: "ShareBoard::RoomChannel", room_code: this.room_code}, {
        connected: () => {
          if (options.initial) {
          } else {
            this.general_ok_notice("合言葉を設定しました")
          }
        },
        disconnected: () => {
          if (this.development_p) {
            this.general_ok_notice("部屋を解放しました")
          }
        },
      })
    },

    room_unsubscribe() {
      this.ac_unsubscribe("$ac_room")
    },

    ac_room_perform(action, params = {}) {
      params = Object.assign({}, {
        user_code: this.user_code,
      }, params)

      if (this.$ac_room) {
        this.$ac_room.perform(action, params) // --> app/channels/share_board/room_channel.rb
      }
    },

    ////////////////////////////////////////////////////////////////////////////////
    sfen_share(sfen) {
      this.ac_room_perform("sfen_share", {
        sfen: sfen,
        title: this.current_title,
      }) // --> app/channels/share_board/room_channel.rb
    },
    sfen_share_broadcasted(params) {
      if (params.user_code === this.user_code) {
        // 自分から自分へ
      } else {
        this.current_title = params.title
        this.current_sfen = params.sfen
        this.turn_offset = this.sfen_parse(params.sfen).moves.length
      }
    },
    ////////////////////////////////////////////////////////////////////////////////
    title_share(share_sfen) {
      this.ac_room_perform("title_share", {
        title: this.current_title,
      }) // --> app/channels/share_board/room_channel.rb
    },
    title_share_broadcasted(params) {
      if (params.user_code === this.user_code) {
        // 自分から自分へ
      } else {
        this.current_title = params.title
        this.general_ok_notice("タイトルを変更しました")
      }
    },
  },
}
