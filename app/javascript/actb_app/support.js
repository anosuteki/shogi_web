import Vuex from 'vuex'

import Autolinker from 'autolinker'

// const POSITION_SFEN_PREFIX = "position sfen "

export const support = {
  methods: {
    warning_dialog(message_body) {
      this.$buefy.dialog.alert({
        title: "ERROR",
        message: message_body,
        canCancel: ["outside", "escape"],
        type: "is-danger",
        hasIcon: true,
        icon: "times-circle",
        iconPack: "fa",
        trapFocus: true,
      })
    },

    ok_notice(message_body, options = {}) {
      this.$buefy.toast.open({message: message_body, position: "is-bottom", type: "is-success", queue: false})
      this.talk2(message_body, options)
    },

    warning_notice(message_body) {
      this.sound_play("x")
      this.$buefy.toast.open({message: message_body, position: "is-bottom", type: "is-warning", queue: false})
      this.talk2(message_body)
    },

    // position_sfen_remove(sfen) {
    //   this.__assert__(sfen != null, "sfen != null")
    //   return sfen.replace(POSITION_SFEN_PREFIX, "")
    // },
    //
    // position_sfen_add(sfen) {
    //   this.__assert__(sfen != null, "sfen != null")
    //   if (!sfen.includes(POSITION_SFEN_PREFIX)) {
    //     sfen = POSITION_SFEN_PREFIX + sfen
    //   }
    //   return sfen
    // },

    main_nav_set(display_p) {
      return

      const el = document.querySelector("#main_nav")
      if (el) {
        if (display_p) {
          el.classList.remove("is-hidden")
        } else {
          el.classList.add("is-hidden")
        }
      }
    },

    delay(seconds, block) {
      return setTimeout(block, 1000 * seconds)
    },

    delay_stop(delay_id) {
      if (delay_id) {
        clearTimeout(delay_id)
      }
    },

    // { xxx: true, yyy: false } 形式に変換
    as_visible_hash(v) {
      return _.reduce(v, (a, e) => ({...a, [e.key]: e.visible}), {})
    },

    // ../../../node_modules/autolinker/README.md
    auto_link(str) {
      return Autolinker.link(str, {newWindow: false, truncate: 30, mention: "twitter"})
    },

    talk2(str, options = {}) {
      this.talk(str, {rate: 1.5, ...options})
    },

    login_required_warning_notice() {
      if (!this.app.current_user) {
        this.warning_notice("ログインしてください")
        return true
      }
    },
  },
  computed: {
    ...Vuex.mapState([
      'app',
    ]),
    ...Vuex.mapGetters([
      'current_gvar1',
    ]),
    // ...mapState([
    //   'fooKey',
    // ]),
  },
}
