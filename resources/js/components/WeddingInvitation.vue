<template>
  <div class="wedding-container">
    <div class="flower-animation" ref="flowerContainer"></div>
    
    <div class="content">
      <header class="header" v-show="showContent" :class="{ 'fade-in': showContent }">
        <h1 class="couple-names">{{ coupleNames }}</h1>
        <p class="wedding-date">{{ weddingDate }}</p>
      </header>

      <main class="invitation-content" v-show="showContent" :class="{ 'slide-up': showContent }">
        <div class="invitation-text">
          <p class="intro">Together with their families</p>
          <h2 class="ceremony-text">We invite you to celebrate our wedding</h2>
          
          <div class="details">
            <p class="venue">{{ venue }}</p>
            <p class="date-time">{{ dateTime }}</p>
            <p class="address">{{ address }}</p>
          </div>
        </div>

        <div class="rsvp-section">
          <button @click="handleRSVP" class="rsvp-button" :class="{ 'pulse': showRSVPAnimation }">
            RSVP Now
          </button>
        </div>
      </main>
    </div>
  </div>
</template>

<script>
import { ref, onMounted } from 'vue'
import { gsap } from 'gsap'

export default {
  name: 'WeddingInvitation',
  setup() {
    const showContent = ref(false)
    const showRSVPAnimation = ref(false)
    const flowerContainer = ref(null)

    const weddingDetails = {
      coupleNames: 'John & Jane',
      weddingDate: 'December 31, 2024',
      venue: 'Grand Ballroom',
      dateTime: '4:00 PM in the afternoon',
      address: '123 Wedding Avenue, Love City'
    }

    const createFlower = () => {
      const flower = document.createElement('div')
      flower.className = 'flower'
      flower.style.left = `${Math.random() * 100}vw`
      
      const duration = 5 + Math.random() * 5
      gsap.fromTo(flower, 
        { y: -20, opacity: 0 },
        { 
          y: '100vh', 
          opacity: 1,
          duration: duration,
          ease: 'none',
          onComplete: () => flower.remove()
        }
      )
      
      flowerContainer.value.appendChild(flower)
    }

    const animateFlowers = () => {
      setInterval(createFlower, 300)
    }

    onMounted(() => {
      // Initial animations
      setTimeout(() => {
        showContent.value = true
      }, 1000)

      // Start flower animations
      animateFlowers()

      // RSVP button animation
      setInterval(() => {
        showRSVPAnimation.value = true
        setTimeout(() => {
          showRSVPAnimation.value = false
        }, 1000)
      }, 3000)
    })

    const handleRSVP = () => {
      // Handle RSVP logic here
      console.log('RSVP clicked')
    }

    return {
      ...weddingDetails,
      showContent,
      showRSVPAnimation,
      flowerContainer,
      handleRSVP
    }
  }
}
</script>

<style scoped>
.wedding-container {
  min-height: 100vh;
  background: linear-gradient(135deg, #f5f7fa 0%, #e8ecf1 100%);
  position: relative;
  overflow: hidden;
  display: flex;
  justify-content: center;
  align-items: center;
  font-family: 'Montserrat', sans-serif;
}

.flower-animation {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  pointer-events: none;
  z-index: 1;
}

.flower {
  position: absolute;
  width: 20px;
  height: 20px;
  background-image: url('/images/flower-petal.png');
  background-size: contain;
  background-repeat: no-repeat;
}

.content {
  text-align: center;
  padding: 2rem;
  background: rgba(255, 255, 255, 0.95);
  border-radius: 20px;
  box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
  max-width: 800px;
  width: 90%;
  z-index: 2;
}

.header {
  margin-bottom: 3rem;
  opacity: 0;
}

.couple-names {
  font-family: 'Great Vibes', cursive;
  font-size: 4rem;
  color: #1a1a1a;
  margin-bottom: 1rem;
}

.wedding-date {
  font-size: 1.5rem;
  color: #666;
}

.invitation-content {
  opacity: 0;
  transform: translateY(20px);
}

.invitation-text {
  margin-bottom: 3rem;
}

.intro {
  font-size: 1.2rem;
  color: #666;
  margin-bottom: 1rem;
}

.ceremony-text {
  font-family: 'Great Vibes', cursive;
  font-size: 2.5rem;
  color: #1a1a1a;
  margin-bottom: 2rem;
}

.details {
  font-size: 1.2rem;
  color: #444;
  line-height: 1.8;
}

.rsvp-button {
  background: #e2a8a8;
  color: white;
  border: none;
  padding: 1rem 3rem;
  font-size: 1.2rem;
  border-radius: 50px;
  cursor: pointer;
  transition: all 0.3s ease;
}

.rsvp-button:hover {
  background: #d88c8c;
  transform: translateY(-2px);
}

/* Animations */
.fade-in {
  animation: fadeIn 1.5s forwards;
}

.slide-up {
  animation: slideUp 1.5s forwards;
}

.pulse {
  animation: pulse 1s;
}

@keyframes fadeIn {
  from {
    opacity: 0;
  }
  to {
    opacity: 1;
  }
}

@keyframes slideUp {
  from {
    opacity: 0;
    transform: translateY(20px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
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

/* Responsive Design */
@media (max-width: 768px) {
  .couple-names {
    font-size: 3rem;
  }
  
  .ceremony-text {
    font-size: 2rem;
  }
  
  .content {
    padding: 1.5rem;
  }
}
</style>
