// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
// require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

//////////////////////////////////////////////////////////////////////////////// Vue

import Vue from "vue/dist/vue.esm" // esm版はvueのtemplateをパースできる
window.Vue = Vue

import Vuex from "vuex"
Vue.use(Vuex)                   // これは一箇所だけで実行すること。shogi-player 側で実行すると干渉する

import VueRouter from "vue-router"
Vue.use(VueRouter)

// https://www.npmjs.com/package/vue-dump
import "vue-dump/dist/vue-dump.css"
import VueDump from "vue-dump/dist/vue-dump.common"
Vue.use(VueDump)

//////////////////////////////////////////////////////////////////////////////// lodash

import _ from "lodash"
window._ = _

import vue_actioncable from "support/vue_actioncable.js"

//////////////////////////////////////////////////////////////////////////////// Chart.js

////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////// タブがアクティブか？(見えているか？)

//////////////////////////////////////////////////////////////////////////////// どこからでも使いたい

//////////////////////////////////////////////////////////////////////////////// どこからでも使いたい2

import acns1_sample from "acns1_sample.vue"
import debug_print from "components/debug_print.vue"

Vue.mixin({
  router: new VueRouter({mode: "history"}),

  mixins: [
    vue_actioncable,
  ],

  // よくない命名規則だけどこっちの方が開発しやすい
  components: {
    acns1_sample,
    debug_print,
  },
})

window.GVI = new Vue()           // ActionCable 側から Vue のグローバルなメソッドを呼ぶため

// import ActionCable from "actioncable"

// このような書き方でいいのかどうかはわからない
window.App = {}
// document.addEventListener('DOMContentLoaded', () => {
//   console.log(window.Vue)
//   console.log(window.GVI)
// })
// if (GVI.$route) {
//   if (GVI.$route.path.includes("/colosseum/battles")) {
//     window.App.cable = ActionCable.createConsumer()
//     ActionCable.startDebugging()
//   }
// }
// import "action_cable_setup.js"
