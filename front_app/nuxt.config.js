// export default {

const config = {
  mode: 'spa',
  // mode: 'universal',
  /*
  ** Nuxt target
  ** See https://nuxtjs.org/api/configuration-target
  */
  target: 'static',

  router: {
    base: process.env.NODE_ENV === 'production' ? "/s" : "/",
  },

  // generate: {
  //   // subFolders: false,
  //   dir: '../public', // Railsの / を直接置き換える
  // },

  /*
  ** Headers of the page
  */
  head: {
    title: null,
    titleTemplate: `%s - SHOGI-EXTEND`,
    htmlAttrs: {
      lang: "ja",
      class: process.env.NODE_ENV,
    },
    meta: [
      // https://ja.nuxtjs.org/faq/duplicated-meta-tags/
      { charset: 'utf-8' },
      { name: 'viewport', content: 'width=device-width, initial-scale=1' },
      { hid: 'description', name: 'description', content: "将棋に関連する便利サービスを提供するサイトです" },
      { name: "action-cable-url", content: (process.env.NODE_ENV === 'development' ? "http://localhost:3000" : "") + "/x-cable" },

      { hid: "og:site_name",   property: "og:site_name",   content: "SHOGI-EXTEND" },
      { hid: "og:type",        property: "og:type",        content: "website" },
      { hid: "og:url",         property: "og:url",         content: process.env.SITE_URL },
      { hid: "og:title",       property: "og:title",       content: "SHOGI-EXTEND" },
      { hid: "og:description", property: "og:description", content: "将棋に関連する便利サービスを提供するサイトです" },
      { hid: "og:image",       property: "og:image",       content: process.env.OGP_IMAGE },

      { hid: "og:card",       property: "og:card",       content: "summary_large_image" },
      { hid: "og:site",       property: "og:site",       content: "@sgkinakomochi" },
      { hid: "og:creator",    property: "og:creator",    content: "@sgkinakomochi" },

    ],
    link: [
      { rel: 'icon', type: 'image/x-icon', href: '/favicon.ico' }
    ],
    // base: { href: "http://localhost:3000" },
  },
  /*
  ** Customize the progress-bar color
  */
  loading: { color: '#fff' },
  /*
  ** Global CSS
  */
  css: [
    // 'application.sass'
    // '../app/javascript/stylesheets/bulma_init.scss',
    // '~/assets/css/buefy.scss',
    // '~/assets/sass/application.sass',
    '../app/javascript/stylesheets/application.sass',
    '~/assets/sass/application.sass',
  ],
  /*
  ** Plugins to load before mounting the App
  */
  plugins: [
    "~/plugins/mixin_mod.js",
    "~/plugins/axios_mod.js",
  ],
  /*
  ** Auto import components
  ** See https://nuxtjs.org/api/configuration-components
  */
  components: true,
  /*
  ** Nuxt.js dev-modules
  */
  buildModules: [
    // Doc: https://github.com/nuxt-community/dotenv-module
    // ['@nuxtjs/dotenv', { filename: `.env.${process.env.NODE_ENV}` }],
    // '@nuxtjs/dotenv',
  ],
  /*
  ** Nuxt.js modules
  */
  modules: [
    // Doc: https://buefy.github.io/#/documentation
    'nuxt-buefy',
    // Doc: https://axios.nuxtjs.org/usage
    '@nuxtjs/axios',
    '@nuxtjs/proxy',
    '@nuxtjs/pwa',
  ],
  /*
  ** Axios module configuration
  ** See https://axios.nuxtjs.org/options
  */
  axios: {
    debug: process.env.NODE_ENV === 'development',
    proxy: process.env.NODE_ENV === 'development',
    // // baseURL: process.env.API_URL,
    credentials: true,          // これを入れないと /talk のとき HTML が返ってきてしまう
  },

  proxy: {
    // "/api": "http://localhost:3000",
    // "/api": "http://localhost:3000",
    // "/api": "http://localhost:3000",
    // "/api": {
    //   target: "http://localhost:3000",
    // },
  },

  /*
  ** Build configuration
  */
  // オーディオファイルをロードするように Webpack の設定を拡張するには？
  // https://ja.nuxtjs.org/faq/webpack-audio-files
  build: {
    loaders: {
      vue: {
        transformAssetUrls: {
          audio: 'src'
        }
      }
    },

    extend (config, ctx) {
      config.module.rules.push({
        test: /\.(ogg|mp3|wav|mpe?g)$/i,
        loader: 'file-loader',
        options: {
          name: '[path][name].[ext]'
        },
      })
    },
  },

  // https://nuxtjs.org/guide/runtime-config
  publicRuntimeConfig: {
    SITE_URL: "",  // 空で上書きしたのではなく process.env.SITE_URL を定義(この仕様はひどい)
  },
  // SSR側での定義で publicRuntimeConfig を上書きする
  privateRuntimeConfig: {},

  // 面倒な process.env.XXX の再定義
  // ・ここで定義すると .vue 側で process.env.XXX で参照できる
  // ・が、だとテンプレートで使えなかったり単なる文字列だったり process.env が空だったりでデバッグしにくい
  // ・ので publicRuntimeConfig を使う方がよい
  // ・どうでもいいけど NUXT_ENV_ プレフィクスをつけた環境変数は自動的にここで定義したことになる(プレフィクスはついたまま)
  env: {
    // FOO: process.env.FOO,
  },
}

if (process.env.NODE_ENV === 'development') {
  config.proxy["/api"] = "http://localhost:3000"
}

export default config
