<template>
  <section class="schedule-section">
    <h3>Wedding Schedule</h3>
    <div class="timeline">
      <div class="timeline-item" v-for="(event, index) in schedule" :key="index">
        <div class="time">{{ event.time }}</div>
        <div class="event-details">
          <h4>{{ event.name }}</h4>
          <p>{{ event.description }}</p>
        </div>
      </div>
    </div>
  </section>
</template>

<script setup>
defineProps({
  schedule: {
    type: Array,
    required: true,
    validator: (value) => {
      return value.every(item => 
        typeof item.time === 'string' &&
        typeof item.name === 'string' &&
        typeof item.description === 'string'
      )
    }
  }
})
</script>

<style scoped>
.schedule-section {
  margin: 3rem 0;
}

.timeline {
  position: relative;
  max-width: 800px;
  margin: 2rem auto;
  padding: 1rem;
}

.timeline::before {
  content: '';
  position: absolute;
  left: 50%;
  transform: translateX(-50%);
  width: 2px;
  height: 100%;
  background: #d4a373;
  opacity: 0.3;
}

.timeline-item {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin: 2rem 0;
  opacity: 0;
  animation: fadeIn 0.5s ease forwards;
}

.time {
  width: 30%;
  text-align: right;
  padding-right: 2rem;
  font-weight: bold;
  color: #d4a373;
}

.event-details {
  width: 70%;
  padding-left: 2rem;
  border-left: 2px solid #d4a373;
}

.event-details h4 {
  margin: 0;
  color: #333;
}

.event-details p {
  margin: 0.5rem 0 0;
  color: #666;
}

@keyframes fadeIn {
  from {
    opacity: 0;
    transform: translateY(20px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}
</style>
