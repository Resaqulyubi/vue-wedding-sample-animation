<template>
  <div class="countdown-section">
    <div class="countdown-item" v-for="(value, unit) in countdown" :key="unit">
      <span class="count">{{ value }}</span>
      <span class="unit">{{ unit }}</span>
    </div>
  </div>
</template>

<script setup>
import { computed } from 'vue'

const props = defineProps({
  weddingDate: {
    type: String,
    required: true
  },
  weddingTime: {
    type: String,
    required: true
  }
})

const countdown = computed(() => {
  const weddingDate = new Date(props.weddingDate + ' ' + props.weddingTime)
  const now = new Date()
  const diff = weddingDate - now

  const days = Math.floor(diff / (1000 * 60 * 60 * 24))
  const hours = Math.floor((diff % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60))
  const minutes = Math.floor((diff % (1000 * 60 * 60)) / (1000 * 60))

  return {
    Days: Math.max(0, days),
    Hours: Math.max(0, hours),
    Minutes: Math.max(0, minutes)
  }
})
</script>

<style scoped>
.countdown-section {
  display: flex;
  justify-content: center;
  gap: 2rem;
  margin: 2rem 0;
}

.countdown-item {
  text-align: center;
}

.count {
  font-size: 2.5rem;
  font-weight: bold;
  color: #d4a373;
  display: block;
}

.unit {
  font-size: 1rem;
  color: #666;
}
</style>
