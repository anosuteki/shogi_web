<template lang="pug">
.simple_board
  .columns
    .column
      shogi_player(
        ref="main_sp"
        :run_mode="'play_mode'"
        :summary_show="true"
        :setting_button_show="true"
        :size="'large'"
        :sound_effect="true"
        :controller_show="true"
        :human_side_key="'both'"
        :theme="'simple'"
        :vlayout="false"
      )
</template>

<script>
export default {
  name: "simple_board",
  mixins: [
  ],
  data() {
    return {
    }
  },
}
</script>

<style lang="sass">
@import "./stylesheets/bulma_init.scss"
.simple_board
</style>
