import { SingleClock } from "./single_clock.js"
import Location from "shogi-player/src/location.js"

export class ChessClock {
  constructor(params = {}) {
    this.params = {
      every_add_value: null,    // リアクティブにするため null でも定義が必要
      ...params,
    }
    this.reset()
  }

  initial_boot_from(i) {
    if (this.turn == null) {
      this.turn = i
      this.timer_restart()
    }
  }

  reset() {
    this.turn = null
    this.counter = 0
    this.single_clocks = Location.values.map((e, i) => new SingleClock(this, i))
    this.timer_stop()
  }

  // 切り替え
  clock_switch() {
    this.turn += 1
    this.counter += 1
    if (this.timer_active_p) {
      this.timer_restart()
    }
  }

  // 時間経過
  generation_next(value) {
    this.current.generation_next(value)
  }

  timer_start() {
    if (!this.timer) {
      this.timer = setInterval(() => this.generation_next(-1), 1000)
    }
  }

  timer_stop() {
    if (this.timer) {
      clearTimeout(this.timer)
      this.timer = null
    }
  }

  timer_restart() {
    this.timer_stop()
    this.timer_start()
  }

  turn_wrap(v) {
    return v % Location.values.length
  }

  get timer_active_p() {
    return !!this.timer
  }

  get current() {
    return this.single_clocks[this.current_location.code]
  }

  get current_index() {
    return this.turn_wrap(this.turn)
  }

  get current_location() {
    return Location.fetch(this.current_index)
  }
}
