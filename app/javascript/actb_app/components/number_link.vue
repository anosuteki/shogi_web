<script>
import { support } from "../support.js"

export default {
  name: "number_link",
  props: {
    body: { type: String, required: true, },
  },
  mixins: [
    support,
  ],
  render(createElement) {
    const str = this.message_decorate(this.body)
    const parts = str.split(/(#\d+)/) // aa#12bb#34cc -> %w(aa #12 bb #34 cc) ※ ()で囲むこと
    const children = parts.map(e => {
      if (e.match(/^#\d+$/)) {            // "#12" の場合
        const id_str = e.replace(/#/, "") // "#12" -> "12"
        const id = parseInt(id_str)       // "12"  ->  12
        // https://jp.vuejs.org/v2/guide/render-function.html#createElement-%E5%BC%95%E6%95%B0
        // http://cream-worker.blog.jp/archives/1077088258.html
        e = createElement("a", {
          on: {
            click: e => this.click_handle(id, e),
          },
          attrs: {
            href: `/training?question_id=${id}`, // 無くてもよいがあると長押しで別タブで開けるようになる
          },
        }, `#${id}`)
      }
      e = createElement("span", {domProps: { innerHTML: e }})
      return e
    })

    return createElement("span", children)
    // return createElement("span", {domProps: { innerHTML: "<hr>" }})
    // return createElement("span", {domProps: { innerHTML: children.join("") }})
  },
  methods: {
    click_handle(id, e) {
      // .prevent.stop は自力で書く
      // https://jp.vuejs.org/v2/guide/render-function.html#%E3%82%A4%E3%83%99%E3%83%B3%E3%83%88%E3%81%A8%E3%82%AD%E3%83%BC%E4%BF%AE%E9%A3%BE%E5%AD%90
      e.preventDefault()
      e.stopPropagation()

      this.app.ov_question_info_set(id)
    },
  },
  computed: {
  },
}
</script>

<style lang="sass">
@import "../support.sass"
.number_link
</style>
