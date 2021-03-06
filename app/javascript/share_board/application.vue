<template lang="pug">
.share_board
  .columns
    .column.sp_mobile_padding
      the_pulldown_menu

      .title_container.has-text-centered(v-if="run_mode === 'play_mode'")
        .title.is-4.is-marginless
          span.is_clickable(@click="title_edit") {{current_title}}
        .turn_offset.has-text-weight-bold {{turn_offset}}手目

      .sp_container
        shogi_player(
          ref="main_sp"
          :run_mode="run_mode"
          :debug_mode="debug_mode"
          :start_turn="turn_offset"
          :kifu_body="current_sfen"
          :summary_show="false"
          :slider_show="true"
          :setting_button_show="development_p"
          :size="'large'"
          :sound_effect="true"
          :controller_show="true"
          :human_side_key="'both'"
          :theme="'real'"
          :flip.sync="board_flip"
          @update:play_mode_advanced_full_moves_sfen="play_mode_advanced_full_moves_sfen_set"
          @update:edit_mode_snapshot_sfen="edit_mode_snapshot_sfen_set"
          @update:mediator_snapshot_sfen="mediator_snapshot_sfen_set"
          @update:turn_offset="turn_offset_set"
        )

      .tweet_button_container
        .buttons.is-centered
          b-button.has-text-weight-bold(@click="tweet_handle" icon-left="twitter" :type="advanced_p ? 'is-info' : ''" v-if="run_mode === 'play_mode'")
          a.delete.page_delete.is-large(@click="mode_toggle_handle" v-if="run_mode === 'edit_mode'")

      .room_code.is_clickable(@click="room_code_edit" v-if="false")
        | {{room_code}}

  .columns(v-if="development_p")
    .column
      .box
        .buttons
          b-button(tag="a" :href="json_debug_url") JSON
          b-button(tag="a" :href="twitter_card_url") Twitter画像
        .content
          p
            b Twitter画像
          p
            img(:src="twitter_card_url" width="256")
          p {{twitter_card_url}}
        pre {{JSON.stringify(record, null, 4)}}
        debug_print
</template>

<script>
const RUN_MODE_DEFAULT = "play_mode"

import { store }   from "./store.js"
import { support } from "./support.js"

import { application_room      } from "./application_room.js"
import { application_room_init } from "./application_room_init.js"

import the_pulldown_menu                  from "./the_pulldown_menu.vue"
import the_image_view_point_setting_modal from "./the_image_view_point_setting_modal.vue"
import the_any_source_read_modal          from "./the_any_source_read_modal.vue"

export default {
  store,
  name: "share_board",
  mixins: [
    support,
    application_room,
    application_room_init,
  ],
  components: {
    the_pulldown_menu,
    the_image_view_point_setting_modal,
    the_any_source_read_modal,
  },
  props: {
    info: { required: false },
  },
  data() {
    return {
      // watch して url に反映するもの
      current_sfen:     this.info.record.sfen_body,        // 渡している棋譜
      current_title:    this.info.record.title,            // 現在のタイトル
      turn_offset:      this.info.record.initial_turn,     // 現在の手数
      image_view_point: this.info.record.image_view_point, // Twitter画像の向き

      // urlには反映しない
      board_flip: this.info.record.board_flip,       // 反転用

      record: this.info.record, // バリデーション目的だったが自由になったので棋譜コピー用だけのためにある
      run_mode: this.defval(this.$route.query.run_mode, RUN_MODE_DEFAULT),  // 操作モードと局面編集モードの切り替え用
      edit_mode_sfen: null,     // 局面編集モードの局面
    }
  },
  beforeCreate() {
    this.$store.state.app = this
  },
  created() {
    // どれかが変更されたらURLを更新
    this.$watch(() => [
      this.run_mode,
      this.current_sfen,
      this.edit_mode_sfen,      // 編集モード中でもURLを変更したいため
      this.turn_offset,
      this.current_title,
      this.image_view_point,
      this.room_code,
    ], () => this.url_replace())
  },
  methods: {
    // 現在の手数を受けとる(URLに反映する)
    turn_offset_set(v) {
      this.turn_offset = v
    },

    // 再生モードで指したときmovesあり棋譜(URLに反映する)
    play_mode_advanced_full_moves_sfen_set(v) {
      this.current_sfen = v
      this.sfen_share(this.current_sfen)
    },

    // デバッグ用
    mediator_snapshot_sfen_set(sfen) {
      if (this.development_p) {
        this.$buefy.toast.open({message: `mediator_snapshot_sfen -> ${sfen}`, queue: false})
      }
    },

    // 編集モード時の局面
    // ・常に更新するが、URLにはすぐには反映しない→やっぱり反映する
    // ・あとで current_sfen に設定する
    // ・すぐに反映しないのは駒箱が消えてしまうから
    edit_mode_snapshot_sfen_set(v) {
      if (this.run_mode === "edit_mode") { // 操作モードでも呼ばれるから
        this.edit_mode_sfen = v
      }
    },

    // 棋譜コピー
    kifu_copy_handle() {
      this.general_kifu_copy(this.current_body, {to_format: "kif"})
    },

    // ツイートする
    tweet_handle() {
      this.tweet_share_open({url: this.current_url, text: this.tweet_hash_tag})
    },

    // 操作←→編集 切り替え
    mode_toggle_handle() {
      if (this.run_mode === "play_mode") {
        this.$gtag.event("open", {event_category: "共有将棋盤(編集)"})
        this.run_mode = "edit_mode"
        if (true) {
          this.board_flip = false // ▲視点にしておく(お好み)
        }
      } else {
        this.run_mode = "play_mode"

        // 局面編集から操作モードに戻した瞬間に局面編集モードでの局面を反映しURLを更新する
        // 局面編集モードでの変化をそのまま current_sfen に反映しない理由は駒箱の駒が消えるため
        // 消えるのはsfenに駒箱の情報が含まれないから
        if (this.edit_mode_sfen) {
          this.current_sfen = this.edit_mode_sfen
          this.edit_mode_sfen = null
        }
      }
      this.sound_play("click")
    },

    // private

    url_replace() {
      window.history.replaceState("", null, this.current_url)
    },

    // タイトル編集
    title_edit() {
      this.$buefy.dialog.prompt({
        title: "タイトル",
        confirmText: "更新",
        cancelText: "キャンセル",
        inputAttrs: { type: "text", value: this.current_title, required: false },
        onConfirm: value => {
          this.current_title_set(value)
          this.sound_play("click")
        },
      })
    },

    current_title_set(title) {
      this.current_title = _.trim(title)
      this.title_share(this.current_title)
    },

    room_code_edit() {
      this.$buefy.dialog.prompt({
        title: "リアルタイム共有",
        size: "is-small",
        message: `
          <div class="content">
            <ul>
              <li>同じ合言葉を設定した人とリアルタイムに盤を共有できます</li>
              <li>合言葉を設定したら同じ合言葉を相手に伝えてください</li>
              <li>合言葉はURLにも付加するので、たんにURLを伝えてもかまいません</li>
            </ul>
          </div>`,
        confirmText: "設定",
        cancelText: "キャンセル",
        inputAttrs: { type: "text", value: this.room_code, required: false },
        onConfirm: value => this.room_code_set(value),
      })
    },

    // Twitter画像の視点変更
    image_view_point_setting_handle() {
      const modal_instance = this.$buefy.modal.open({
        parent: this,
        trapFocus: true,
        hasModalCard: true,
        animation: "",
        props: {
          image_view_point: this.image_view_point,
          permalink_for: this.permalink_for,
        },
        component: the_image_view_point_setting_modal,
        events: {
          "update:image_view_point": v => {
            this.image_view_point = v
            this.sound_play("click")
            modal_instance.close()
          }
        },
      })
    },

    // 棋譜の読み込みタップ時の処理
    any_source_read_handle() {
      const modal_instance = this.$buefy.modal.open({
        parent: this,
        hasModalCard: true,
        animation: "",
        component: the_any_source_read_modal,
        events: {
          "update:any_source": any_source => {
            this.remote_fetch("POST", "/api/general/any_source_to", { any_source: any_source, to_format: "sfen" }, e => {
              if (e.body) {
                this.general_ok_notice("正常に読み込みました")
                this.current_sfen = e.body
                this.turn_offset = e.turn_max
                this.board_flip = false
                modal_instance.close()
              }
            })
          },
        },
      })
    },

    permalink_for(params = {}) {
      const url = new URL(location)
      url.searchParams.set("body", this.current_body) // 編集モードでもURLを更新するため
      url.searchParams.set("turn", this.turn_offset)
      url.searchParams.set("title", this.current_title)
      url.searchParams.set("image_view_point", this.image_view_point)
      url.searchParams.set("room_code", this.room_code)

      _.each(params, (v, k) => url.searchParams.set(k, v))

      // 編集モードでの状態を維持したいのでURLに含めておく
      // 操作モードのときは常にURLに入っているのはアレなので消す
      if (this.run_mode === RUN_MODE_DEFAULT) {
        url.searchParams.delete("run_mode")
      } else {
        url.searchParams.set("run_mode", this.run_mode)
      }

      return url.toString()
    },

    // 盤面のみ最初の状態に戻す
    reset_handle() {
      this.current_sfen = this.info.record.sfen_body        // 渡している棋譜
      this.turn_offset  = this.info.record.initial_turn     // 現在の手数
      this.general_ok_notice("盤面を最初の状態に戻しました")
    },
  },

  computed: {
    // URL
    current_url()        { return this.permalink_for()                                                                        },
    json_debug_url()     { return this.permalink_for({format: "json"})                                                        },
    twitter_card_url()   { return this.permalink_for({format: "png"})                                                         },
    snapshot_image_url() { return this.permalink_for({format: "png", image_flip: this.board_flip, disposition: "attachment"}) },

    // 外部アプリ
    piyo_shogi_app_with_params_url() { return this.piyo_shogi_auto_url({path: this.current_url, sfen: this.current_sfen, turn: this.turn_offset, flip: this.board_flip, game_name: this.current_title}) },
    kento_app_with_params_url()      { return this.kento_full_url({sfen: this.current_sfen, turn: this.turn_offset, flip: this.board_flip})   },

    ////////////////////////////////////////////////////////////////////////////////

    // 最初に表示した手数より進めたか？
    advanced_p() { return this.turn_offset > this.info.record.initial_turn },

    // 常に画面上の盤面と一致している
    current_body() { return this.edit_mode_sfen || this.current_sfen },

    tweet_hash_tag() {
      if (this.current_title) {
        return "#" + this.current_title
      }
    },

    debug_mode() { return this.$route.query.debug_mode === "true" },
  },
}
</script>

<style lang="sass">
@import "support.sass"
@import "application.sass"

.share_board
  ////////////////////////////////////////////////////////////////////////////////
  .title_container
    padding-top: 0.65rem
    .title
    .turn_offset
      margin-top: 0.65rem

  ////////////////////////////////////////////////////////////////////////////////
  position: relative
  .dropdown_menu, .delete
    position: absolute
    top: 0rem
    right: 0rem
    z-index: 1

  ////////////////////////////////////////////////////////////////////////////////
  .sp_container
    margin-top: 0.8rem

  ////////////////////////////////////////////////////////////////////////////////
  .tweet_button_container
    margin-top: 1.5rem
</style>
