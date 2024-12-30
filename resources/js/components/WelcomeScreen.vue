<template>
  <div class="welcome-screen" :class="{ 'fade-out': !show }">
    <div class="welcome-content">
      <h1 class="welcome-text" :class="{ 'show': show }">Welcome to our wedding invitation</h1>
      <div class="couple-intro" :class="{ 'show': show }">
        <h2 class="names">{{ coupleNames }}</h2>
        <p class="date">{{ weddingDate }}</p>
        <p class="welcome-message">We are delighted to share our special day with you</p>
      </div>
      <button @click="$emit('enter')" class="enter-button" :class="{ 'show': show }">Enter</button>
    </div>
  </div>
</template>

<script setup>
defineProps({
  show: {
    type: Boolean,
    default: false
  },
  coupleNames: {
    type: String,
    required: true
  },
  weddingDate: {
    type: String,
    required: true
  }
})

defineEmits(['enter'])
</script>

<style scoped>
.welcome-screen {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  display: flex;
  justify-content: center;
  align-items: center;
  background: linear-gradient(135deg, rgba(245, 247, 250, 0.95) 0%, rgba(232, 236, 241, 0.95) 100%);
  z-index: 1000;
  transition: opacity 1s ease;
}

.welcome-screen.fade-out {
  opacity: 0;
  pointer-events: none;
}

.welcome-content {
  text-align: center;
  padding: 2rem;
  background: rgba(255, 255, 255, 0.9);
  border-radius: 20px;
  box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
  max-width: 600px;
  width: 90%;
}

.welcome-text {
  font-family: 'Great Vibes', cursive;
  font-size: 3.5rem;
  color: #1a1a1a;
  margin-bottom: 2rem;
  opacity: 0;
  transform: translateY(20px);
}

.couple-intro {
  margin: 2rem 0;
  opacity: 0;
  transform: translateY(20px);
}

.names {
  font-family: 'Great Vibes', cursive;
  font-size: 3rem;
  color: #d4a373;
  margin-bottom: 1rem;
}

.date {
  font-size: 1.5rem;
  color: #666;
  margin-bottom: 1rem;
}

.welcome-message {
  font-size: 1.2rem;
  color: #888;
  font-style: italic;
  margin-bottom: 2rem;
}

.enter-button {
  padding: 1rem 3rem;
  font-size: 1.2rem;
  background: #d4a373;
  color: white;
  border: none;
  border-radius: 30px;
  cursor: pointer;
  opacity: 0;
  transform: translateY(20px);
  transition: transform 0.3s ease, background-color 0.3s ease;
}

.enter-button:hover {
  transform: translateY(-2px);
  background: #c69b7b;
}

.welcome-text.show,
.couple-intro.show,
.enter-button.show {
  animation: fadeInUp 1s ease forwards;
}

.welcome-text.show {
  animation-delay: 0.5s;
}

.couple-intro.show {
  animation-delay: 1s;
}

.enter-button.show {
  animation-delay: 1.5s;
}

@keyframes fadeInUp {
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

@media (max-width: 768px) {
  .welcome-content {
    width: 95%;
    padding: 1.5rem;
  }

  .welcome-text {
    font-size: 2.5rem;
  }

  .names {
    font-size: 2.2rem;
  }

  .date {
    font-size: 1.2rem;
  }
}
</style>
