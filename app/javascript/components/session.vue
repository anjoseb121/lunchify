<template>
  <div>
    <p>Login with your email</p>
    <input type="text" name="username" v-model="input.email" placeholder="Email" />
    <input type="password" name="password" v-model="input.password" placeholder="Password" />
    <button type="button" @click="login">Login</button>
  </div>
</template>

<script>
import axios from "axios"

export default {
  name: 'Session',
  data: function () {
    return {
      input: {
        email: '',
        password: ''
      }
    }
  },
  methods: {
    login() {
      const { email, password } = this.input
      axios.post('http://localhost:3000/auth/sign_in', { email, password })
           .then((res) => {
             this.$emit('success', res)
           })
    }
  }
}
</script>
