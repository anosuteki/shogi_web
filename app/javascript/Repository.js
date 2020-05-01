import axios from "axios"

export default axios.create({
  // baseURL: process.env.NODE_ENV === "production" ? "https://shogi-flow.xyz/" : null,
  timeout: 1000 * 60 * 3,      // 3min
  headers: {
    "X-Requested-With": "XMLHttpRequest",
  },
})
