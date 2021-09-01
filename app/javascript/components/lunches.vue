<template>
  <div>
    <p>Admin: Manage available lunches</p>
    <ul>
      <li v-for="(lunch, i) in lunches" :key="i">
        ID: {{ lunch.id}} - {{ lunch.name}} <span style="color:red;" @click="handleDelete(lunch)">&nbsp;x</span>
      </li>
    </ul>
    <p>Create a new Lunch</p>
    <input type="text" name="name" v-model="input.name" placeholder="Name" />
    <button type="button" @click="handleCreate">Create</button>
  </div>
</template>

<script>
import axios from "axios"

export default {
  name: 'Lunches',
  props: ['user'],
  data: function () {
    return {
      lunches: [],
      input: {
        name: ''
      }
    }
  },
  mounted() {
    this.getLunches()
  },
  methods: {
    headers () {
      return {
        'access-token': this.user.accessToken,
        uid: this.user.uid,
        client: this.user.client
      }
    },
    getLunches() {
      axios.get('http://localhost:3000/api/v1/lunches', { headers: this.headers() })
            .then((res) => {
              this.lunches = res.data
            })
            .catch((e) => {
             console.log('Error getting lunchs', e.message)
           })
    },
    handleCreate() {
      const { name } = this.input
      axios.post('http://localhost:3000/api/v1/lunches', { name }, { headers: this.headers() })
           .then((res) => {
             this.getLunches()
             this.input.name = ''
             alert('Lunch created with ID ' + res.data.id)
           })
           .catch((e) => {
             alert('Error creating lunch', e.message)
           })
    },
    handleDelete(lunch) {
      const { id } = lunch
      if (confirm('Do you want to delete this lunch?')) {
        axios.delete(`http://localhost:3000/api/v1/lunches/${id}`, { headers: this.headers() })
             .then((res) => {
               this.getLunches()
               alert('Lunch deleted')
             })
             .catch((e) => {
               alert('Error deleting lunch', e.message)
             })
      }
    }
  }
}
</script>
