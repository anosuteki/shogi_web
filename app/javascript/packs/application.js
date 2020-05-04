// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("channels")

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

////////////////////////////////////////////////////////////////////////////////

import 'bulma/css/bulma.css'

//////////////////////////////////////////////////////////////////////////////// Vue

import Vue from "vue/dist/vue.esm" // esm版はvueのtemplateをパースできる
window.Vue = Vue

//////////////////////////////////////////////////////////////////////////////// lodash

import _ from "lodash"
window._ = _

import vue_actioncable from "support/vue_actioncable.js"

import acns1_sample from "acns1_sample.vue"
import debug_print from "components/debug_print.vue"

Vue.mixin({
  mixins: [
    vue_actioncable,
  ],

  // よくない命名規則だけどこっちの方が開発しやすい
  components: {
    acns1_sample,
    debug_print,
  },
})

// import ActionCable from "actioncable"
