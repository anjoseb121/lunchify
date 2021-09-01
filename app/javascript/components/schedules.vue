<template>
  <div>
    <h1>Schedules</h1>
    <p>Hi, {{ user.email }}</p>

    <lunches :user="user" v-if="user.role === 'admin'" />

    <br>

    <p>Your lunches</p>
    <div v-for="(day, i) in days" :key="i">
      <h5>Week {{ day }}</h5>
      <ul>
        <li style="text-transform:capitalize;" v-for="(schedule, j) in schedules[day]" :key="j">
          {{ schedule.day }} -- {{ lunches.find(l => l.id === schedule.lunch_id).name }}
          <span style="color:red;" @click="handleDelete(schedule)">x</span>
        </li>
      </ul>
    </div>
    <div>
      <form>
        <h2>Select a new lunch</h2>
        <select v-model="input.week">
          <option value="this-week">This week</option>
          <option value="upcoming">Upcoming week</option>
        </select>
        <select v-model="input.day">
          <option value="monday">Monday</option>
          <option value="tuesday">Tuesday</option>
          <option value="wednesday">Wednesday</option>
          <option value="thursday">Thursday</option>
          <option value="friday">Friday</option>
        </select>
        <select v-model="input.lunch">
          <option v-for="(lunch, i) in lunches" :key="i" :value="lunch.id">{{ lunch.name}}</option>
        </select>
        <button type="button" @click="handleSave">Save</button>
      </form>
    </div>
  </div>
</template>

<script>
import axios from "axios"
import DateTime from 'luxon/src/datetime.js'
import Lunches from './lunches.vue'

export default {
  name: 'Schedules',
  components: {
    Lunches
  },
  props: ['user'],
  data: function () {
    return {
      schedules: [],
      lunches: [],
      days: [],
      input: {
        week: 'this-week',
        day: 'monday',
        lunch: 0
      }
    }
  },
  mounted() {
    this.getLunches()
    this.getSchedules()
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
             console.log('Error getting lunches', e.message)
           })
    },
    getSchedules() {
      axios.get('http://localhost:3000/api/v1/schedule_lunches', { headers: this.headers() })
            .then((res) => {
              this.schedules = res.data
              this.days = Object.keys(res.data)
              console.log('schedules', Object.keys(res.data))
              console.log('schedules', this.schedules[Object.keys(res.data)[0]])
              console.log('sch', this.schedules)
            })
            .catch((e) => {
             console.log('Error getting schedules', e.message)
           })
    },
    handleSave() {
      const { week, day, lunch } = this.input
      const weekNumber = week === 'this-week' ? DateTime.now().weekNumber : DateTime.now().weekNumber + 1
      const params = {
        lunch_id: lunch,
        week_of_year: weekNumber,
        day
      }
      axios.post('http://localhost:3000/api/v1/schedule_lunches', params, { headers: this.headers() })
            .then((res) => {
              this.getSchedules()
            })
            .catch((e) => {
             console.log('Error creating scheduled lunch', e.message)
           })
    },
    handleDelete(schedule) {
      if (confirm('Do you want to delete this schedule?')) {
        axios.delete(`http://localhost:3000/api/v1/schedule_lunches/${schedule.id}`, { headers: this.headers() })
            .then((res) => {
              this.getSchedules()
            })
            .catch((e) => {
             console.log('Error deleting scheduled lunch', e.message)
           })
      }
    }
  }
}
</script>