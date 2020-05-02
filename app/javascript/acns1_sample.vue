<template lang="pug">
.acns1_sample
  input(v-model="message" @keypress.enter="speak" autofocus)
  button(@click="speak") 送信
  div(ref="messages_box")
    template(v-for="row in messages")
      div(v-html="row")
</template>

<script>
import consumer from "channels/consumer"

export default {
  name: "acns1_sample",
  props: {
    info: { required: true },
  },
  data() {
    return {
      messages: null,
      message: null,

      // private
      $channel: null,
    }
  },

  created() {
    this.messages = this.info.messages
    this.message = this.messages.length

    this.$channel = consumer.subscriptions.create({ channel: "Acns1::RoomChannel", room_id: this.info.room.id }, {
      connected: () => {
        console.log("connected")
      },
      disconnected: () => {
        console.log("disconnected")
      },
      received: (data) => {
        this.messages.push(data["message"])
        this.message = this.messages.length
      },
    })
  },

  watch: {
    messages() {
      this.scroll_to_bottom()
    },
  },

  methods: {
    speak() {
      console.log(`speak: ${this.message}`)
      this.$channel.perform("speak", {message: this.message})
    },
    scroll_to_bottom() {
      this.$refs.messages_box.scrollTop = this.$refs.messages_box.scrollHeight
    },
  },
}
</script>

<style lang="sass">
.acns1_sample
  .messages_box
    height: 20rem
    overflow-y: scroll
</style>
