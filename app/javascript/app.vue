<template>
  <div id="app">
    <session v-if="user == null" @success="handleSuccessLogin" />
    <schedules v-else :user="user" />
  </div>
</template>

<script>
import Session from './components/session.vue'
import Schedules from './components/schedules.vue'

export default {
  components: {
    Session,
    Schedules
  },
  data: function () {
    return {
      user: null
    }
  },
  methods: {
    handleSuccessLogin(response) {
      this.user = {
        email: response.data.data.email,
        uid: response.headers.uid,
        client: response.headers.client,
        accessToken: response.headers['access-token'],
        role: response.data.data.role
      }
    }
  }
}
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>
