document.addEventListener('DOMContentLoaded', () => {
  if (App.cable) {
    App.system_notification = App.cable.subscriptions.create({channel: "SystemNotificationChannel"}, {
      connected() {
        App.system_notification_vm.puts("connected")
      },

      disconnected() {
        App.system_notification_vm.puts("disconnected")
      },

      rejected() {
        App.system_notification_vm.puts("rejected")
      },

      received(data) {
        App.system_notification_vm.puts("received")

        // 全体通知
        if (data["message"]) {
          const message = data["message"]
          const from = data["from"]
          const str = `${from.name}: ${message}`
          GVI.talk(message)
          GVI.$buefy.toast.open({message: str, position: "is-top", type: "is-success", duration: 1000 * 3})
        }

        // ロビーに入っている人数更新
        if (data["joined_only_count"]) {
          if (App.header_vm) {
            App.header_vm.joined_only_count = data["joined_only_count"]
          }
        }

        // バトル中の人数更新
        if (data["fighter_only_count"]) {
          if (App.header_vm) {
            App.header_vm.fighter_only_count = data["fighter_only_count"]
          }
        }
      },

      message_send_all(data) {
        this.perform("message_send_all", data)
      },

      // talk(data) {
      //   this.perform("talk", data)
      // },
    })

    if (document.querySelector("#system_notification_app")) {
      App.system_notification_vm = new Vue({
        el: "#system_notification_app",
        data() {
          return {
            system_logs: [],
          }
        },

        created() {
          // App.system_notification.talk({source_text: "こんにちは"})
          // GVI.talk("こんにちは")
        },

        methods: {
          puts(v) {
            this.system_logs.push(v)
          },
        },

        computed: {
          latest_system_logs() {
            return _.takeRight(this.system_logs, 10)
          },
        },
      })
    } else {
      App.system_notification_vm = {}
      App.system_notification_vm.puts = () => {}
    }

    if (document.querySelector("#header_app")) {
      App.header_vm = new Vue({
        el: "#header_app",
        data() {
          return {
            joined_only_count: js_global.joined_only_count,
            fighter_only_count: js_global.fighter_only_count,
          }
        },
      })
    }
  }
})
