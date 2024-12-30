<template>
  <div class="wedding-invitation">
    <BackgroundDecorations />
    <div class="wedding-container" :class="{ 'fade-in': showMainContent }">
      <div class="content">
        <main class="invitation-content" v-show="showMainContent" :class="{ 'slide-up': showMainContent }">
          <header class="header" v-show="showMainContent" :class="{ 'fade-in': showMainContent }">
            <h1 class="couple-names">{{ weddingDetails.coupleNames }}</h1>
            <p class="wedding-date">{{ weddingDetails.weddingDate }}</p>
          </header>

          <div class="invitation-text">
            <p class="intro">Together with their families</p>
            <h2 class="ceremony-text">We invite you to celebrate our wedding</h2>

            <WeddingCountdown 
              :wedding-date="weddingDetails.fullDate"
              :wedding-time="weddingDetails.time"
            />

            <div class="wedding-info" ref="weddingInfo">
              <div class="info-grid">
                <div class="info-card" v-for="(section, index) in sections" :key="index" :class="section.class">
                  <h4>{{ section.title }}</h4>
                  <template v-if="section.type === 'text'">
                    <p v-for="(line, i) in section.content" :key="i">{{ line }}</p>
                  </template>
                  <template v-else-if="section.type === 'datetime'">
                    <div class="date-time">
                      <p class="date">{{ section.date }}</p>
                      <p class="time">{{ section.time }}</p>
                    </div>
                  </template>
                  <template v-else-if="section.type === 'location'">
                    <p class="venue">{{ section.venue }}</p>
                    <p class="address">{{ section.address }}</p>
                  </template>
                </div>
              </div>
            </div>
          </div>

          <WeddingSchedule :schedule="weddingDetails.schedule" />

          <div class="rsvp-section">
            <p class="rsvp-text">Please RSVP by {{ weddingDetails.rsvpDeadline }}</p>
            <button @click="handleRSVP" class="rsvp-button" :class="{ 'pulse': showRSVPAnimation }">
              RSVP Now
            </button>
          </div>
        </main>
      </div>
    </div>

    <WelcomeScreen 
      :show="showWelcome"
      :couple-names="weddingDetails.coupleNames"
      :wedding-date="weddingDetails.weddingDate"
      @enter="enterInvitation"
    />
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import gsap from 'gsap'
import WelcomeScreen from '../components/WelcomeScreen.vue'
import BackgroundDecorations from '../components/BackgroundDecorations.vue'
import WeddingCountdown from '../components/WeddingCountdown.vue'
import WeddingSchedule from '../components/WeddingSchedule.vue'

const showWelcome = ref(false)
const showMainContent = ref(false)
const showRSVPAnimation = ref(false)
const weddingInfo = ref(null)

// Wedding details data
const weddingDetails = {
  coupleNames: 'Sarah & Michael',
  weddingDate: 'January 15, 2024',
  fullDate: 'Monday, January 15, 2024',
  time: '3:00 PM',
  venue: 'Grand Ballroom, The Ritz-Carlton',
  address: '123 Luxury Avenue, Beverly Hills, CA 90210',
  mapLink: 'https://maps.google.com',
  rsvpDeadline: 'December 31, 2023',
  schedule: [
    {
      time: '2:30 PM',
      name: 'Guest Arrival',
      description: 'Welcome drinks and seating'
    },
    {
      time: '3:00 PM',
      name: 'Ceremony',
      description: 'Exchange of vows and rings'
    },
    {
      time: '4:00 PM',
      name: 'Cocktail Hour',
      description: 'Hors d\'oeuvres and champagne'
    },
    {
      time: '5:00 PM',
      name: 'Reception',
      description: 'Dinner, dancing, and celebrations'
    }
  ]
}

const sections = [
  {
    title: "We're Getting Married",
    type: 'text',
    content: ['John & Jane'],
    class: 'main-title'
  },
  {
    title: "When",
    type: 'datetime',
    date: 'Saturday, December 31, 2024',
    time: '3:00 PM',
    class: 'date-section'
  },
  {
    title: "Where",
    type: 'location',
    venue: 'Grand Ballroom',
    address: '123 Wedding Avenue, Love City',
    class: 'location-section'
  }
]

const animateContent = () => {
  gsap.to(weddingInfo.value, {
    opacity: 1,
    y: 0,
    duration: 1,
    ease: 'power2.out'
  })
}

const enterInvitation = () => {
  showWelcome.value = false
  setTimeout(() => {
    showMainContent.value = true
    animateContent()
  }, 1000)
}

const handleRSVP = () => {
  showRSVPAnimation.value = true
  setTimeout(() => showRSVPAnimation.value = false, 1000)
}

onMounted(() => {
  showWelcome.value = true
})
</script>

<style scoped>
.wedding-invitation {
  min-height: 100vh;
  position: relative;
  background: #fff;
  overflow: hidden;
}

.wedding-container {
  max-width: 1200px;
  margin: 0 auto;
  padding: 2rem;
  opacity: 0;
  transform: translateY(20px);
  transition: opacity 1s ease, transform 1s ease;
}

.wedding-container.fade-in {
  opacity: 1;
  transform: translateY(0);
}

.content {
  position: relative;
  z-index: 1;
}

.invitation-content {
  text-align: center;
  opacity: 0;
  transform: translateY(20px);
  transition: opacity 1s ease, transform 1s ease;
}

.invitation-content.slide-up {
  opacity: 1;
  transform: translateY(0);
}

.couple-names {
  font-size: 3rem;
  color: #d4a373;
  margin-bottom: 1rem;
}

.wedding-date {
  font-size: 1.5rem;
  color: #666;
}

.invitation-text {
  margin: 3rem 0;
}

.intro {
  font-size: 1.2rem;
  color: #666;
}

.ceremony-text {
  font-size: 2rem;
  color: #d4a373;
  margin: 1rem 0 2rem;
}

.wedding-info {
  opacity: 0;
  transform: translateY(20px);
}

.info-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
  gap: 2rem;
  margin: 2rem 0;
}

.info-card {
  padding: 2rem;
  background: rgba(255, 255, 255, 0.9);
  border-radius: 10px;
  box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
}

.rsvp-section {
  margin: 3rem 0;
}

.rsvp-button {
  padding: 1rem 3rem;
  font-size: 1.2rem;
  background: #d4a373;
  color: white;
  border: none;
  border-radius: 30px;
  cursor: pointer;
  transition: transform 0.3s ease, box-shadow 0.3s ease;
}

.rsvp-button:hover {
  transform: translateY(-2px);
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
}

.rsvp-button.pulse {
  animation: pulse 1s ease;
}

@keyframes pulse {
  0% {
    transform: scale(1);
  }
  50% {
    transform: scale(1.05);
  }
  100% {
    transform: scale(1);
  }
}
</style>
