export const the_question_show_mod = {
  data() {
    return {
      ov_question_info: null,
    }
  },

  methods: {
    ov_question_info_set(question_id) {
      this.sound_play("click")
      this.remote_get(this.app.info.put_path, { question_single_fetch: true, question_id: question_id }, e => {
        if (e.ov_question_info) {
          this.ov_question_info = e.ov_question_info
        }
      })
    },

    ov_question_info_close() {
      this.sound_play("click")
      this.ov_question_info = null
    },
  },
}
