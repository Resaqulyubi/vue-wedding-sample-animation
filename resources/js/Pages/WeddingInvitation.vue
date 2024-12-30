<template>
  <div class="wedding-invitation">
    <div class="background-flowers">
      <!-- Corner flowers -->
      <div class="corner-flower top-left" ref="topLeft"></div>
      <div class="corner-flower top-right" ref="topRight"></div>
      <div class="corner-flower bottom-left" ref="bottomLeft"></div>
      <div class="corner-flower bottom-right" ref="bottomRight"></div>

      <!-- Side flowers -->
      <div class="side-flower left-middle" ref="leftMiddle"></div>
      <div class="side-flower right-middle" ref="rightMiddle"></div>
    </div>
    <div class="wedding-container" :class="{ 'fade-in': showMainContent }">
      <div class="content">
        <div class="flower-animation" ref="flowerContainer"></div>
        <div class="butterfly-container" ref="butterflyContainer"></div>

        <header class="header" v-show="showWelcome" :class="{ 'fade-in': showWelcome }">
          <h1 class="welcome-text">Welcome to our wedding invitation</h1>
          <button @click="enterInvitation" class="enter-button" v-show="showEnterButton">Enter</button>
        </header>

        <main class="invitation-content" v-show="showMainContent" :class="{ 'slide-up': showMainContent }">
          <header class="header" v-show="showMainContent" :class="{ 'fade-in': showMainContent }">
            <h1 class="couple-names">{{ weddingDetails.coupleNames }}</h1>
            <p class="wedding-date">{{ weddingDetails.weddingDate }}</p>
          </header>

          <div class="invitation-text">
            <p class="intro">Together with their families</p>
            <h2 class="ceremony-text">We invite you to celebrate our wedding</h2>

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

          <div class="rsvp-section">
            <p class="rsvp-text">Please RSVP by {{ weddingDetails.rsvpDeadline }}</p>
            <p class="deadline">{{ weddingDetails.rsvpDeadline }}</p>
            <button @click="handleRSVP" class="rsvp-button" :class="{ 'pulse': showRSVPAnimation }">
              RSVP Now
            </button>
          </div>
        </main>

        <main class="main-content" v-show="showMainContent">
          <div class="invitation-text">
            <p class="intro">Together with their families</p>
            <h2 class="ceremony-text">We invite you to celebrate our wedding</h2>

            <!-- Countdown Section -->
            <div class="countdown-section">
              <div class="countdown-item" v-for="(value, unit) in countdown" :key="unit">
                <span class="count">{{ value }}</span>
                <span class="unit">{{ unit }}</span>
              </div>
            </div>

            <!-- Ceremony Details -->
            <section class="ceremony-details">
              <h3>Ceremony</h3>
              <div class="detail-card">
                <div class="icon-detail">
                  <i class="fas fa-calendar"></i>
                  <div class="text">
                    <strong>When</strong>
                    <p>{{ weddingDetails.fullDate }}</p>
                    <p>{{ weddingDetails.time }}</p>
                  </div>
                </div>
                <div class="icon-detail">
                  <i class="fas fa-map-marker-alt"></i>
                  <div class="text">
                    <strong>Where</strong>
                    <p>{{ weddingDetails.venue }}</p>
                    <p>{{ weddingDetails.address }}</p>
                    <a :href="weddingDetails.mapLink" target="_blank" class="map-button">View Map</a>
                  </div>
                </div>
              </div>
            </section>

            <!-- Schedule -->
            <section class="schedule-section">
              <h3>Wedding Schedule</h3>
              <div class="timeline">
                <div class="timeline-item" v-for="(event, index) in weddingDetails.schedule" :key="index">
                  <div class="time">{{ event.time }}</div>
                  <div class="event-details">
                    <h4>{{ event.name }}</h4>
                    <p>{{ event.description }}</p>
                  </div>
                </div>
              </div>
            </section>
          </div>
        </main>
      </div>
    </div>
    <div class="welcome-screen" :class="{ 'fade-out': !showWelcome }">
      <div class="welcome-content">
        <h1 class="welcome-text" :class="{ 'show': showWelcome }">Welcome to our wedding invitation</h1>
        <div class="couple-intro" :class="{ 'show': showWelcome }">
          <h2 class="names">{{ weddingDetails.coupleNames }}</h2>
          <p class="date">{{ weddingDetails.weddingDate }}</p>
          <p class="welcome-message">We are delighted to share our special day with you</p>
        </div>
        <button @click="enterInvitation" class="enter-button" :class="{ 'show': showWelcome }">Enter</button>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted, computed } from 'vue'
import gsap from 'gsap'
import flower1 from '@/assets/images/flower1.png'
import flower2 from '@/assets/images/flower2.png'

const butterflyImage = '/images/butterfly.png'

const showWelcome = ref(false)
const showEnterButton = ref(false)
const showMainContent = ref(false)
const isTransitioning = ref(false)
const showContent = ref(false)
const showRSVPAnimation = ref(false)
const flowerContainer = ref(null)
const weddingInfo = ref(null)
const topLeft = ref(null)
const topRight = ref(null)
const bottomLeft = ref(null)
const bottomRight = ref(null)
const leftMiddle = ref(null)
const rightMiddle = ref(null)
const butterflyContainer = ref(null)

// Debug logs
console.log('WeddingInvitation component loaded')

// Add wedding details
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

const flowers = [
  flower1,
  flower2
]

const MAX_FLOWERS = 15 // Limit maximum flowers on screen

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

// Add computed countdown
const countdown = computed(() => {
  const weddingDate = new Date(weddingDetails.fullDate + ' ' + weddingDetails.time)
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

const createFallingFlower = (fromLeft = false) => {
  if (!flowerContainer.value) return

  // Limit maximum flowers
  const currentFlowers = flowerContainer.value.getElementsByClassName('flower')
  if (currentFlowers.length >= MAX_FLOWERS) {
    return
  }

  const contentElement = document.querySelector('.content')
  if (!contentElement) return

  const flower = new Image()
  flower.className = 'flower'
  flower.style.opacity = '0' // Start invisible
  flower.onload = () => {
    flowerContainer.value.appendChild(flower)

    const contentRect = contentElement.getBoundingClientRect()
    const containerRect = flowerContainer.value.getBoundingClientRect()

    // Start from center top
    const startX = contentRect.left - containerRect.left + (contentRect.width / 2)
    const startY = contentRect.top - containerRect.top

    // Set initial position
    flower.style.left = `${startX}px`
    flower.style.top = `${startY}px`
    flower.style.position = 'absolute'

    // Bigger size range
    const size = 70 + Math.random() * 40 // Range: 70-110px
    flower.style.width = `${size}px`
    flower.style.height = `${size}px`

    const rotation = Math.random() * 360
    flower.style.transform = `rotate(${rotation}deg)`

    const duration = 8 + Math.random() * 4 // 8-12 seconds, much slower fall

    // Random horizontal movement from center
    const moveDistance = -100 + Math.random() * 200 // -100 to +100px from center
    const endX = startX + moveDistance
    const endY = containerRect.height - size

    // Add slight swaying effect
    requestAnimationFrame(() => {
      // Main falling animation with slower ease
      gsap.to(flower, {
        x: endX - startX,
        y: endY - startY,
        opacity: 1,
        rotation: rotation + (Math.random() > 0.5 ? 180 : -180),
        duration: duration,
        ease: "power1.inOut", // Smoother easing
        onComplete: () => {
          if (flower.parentNode === flowerContainer.value) {
            flowerContainer.value.removeChild(flower)
          }
        }
      })

      // Add gentle swaying with longer duration
      gsap.to(flower, {
        x: `+=${-30 + Math.random() * 60}`,
        duration: duration * 0.6, // Synchronized with fall duration
        repeat: 2,
        yoyo: true,
        ease: "sine.inOut"
      })
    })
  }

  // Randomly choose between flower images
  flower.src = Math.random() > 0.5 ? flower1 : flower2
}

const createFlowerBurst = () => {
  if (!flowerContainer.value) return

  const burstCount = 5 // Slightly more flowers in burst
  for (let i = 0; i < burstCount; i++) {
    setTimeout(() => {
      createFallingFlower()
    }, i * 150)
  }
}

const animateFlowers = () => {
  const fallingInterval = setInterval(() => {
    createFallingFlower()
  }, 2000) // Longer interval between flowers (2 seconds)

  const burstInterval = setInterval(createFlowerBurst, 12000) // Less frequent bursts (12 seconds)

  return () => {
    clearInterval(fallingInterval)
    clearInterval(burstInterval)
  }
}

const animateContent = () => {
  // Main content animation
  gsap.to(weddingInfo.value, {
    opacity: 1,
    y: 0,
    duration: 1,
    ease: 'power2.out'
  })

  // Animate each section
  const sectionElements = document.querySelectorAll('.info-section')
  sectionElements.forEach((section, index) => {
    gsap.to(section, {
      opacity: 1,
      y: 0,
      duration: 1,
      delay: 0.2 * (index + 1),
      ease: 'power2.out'
    })

    // Animate title
    const title = section.querySelector('.section-title')
    gsap.to(title, {
      opacity: 1,
      x: 0,
      duration: 1,
      delay: 0.3 * (index + 1),
      ease: 'power2.out'
    })

    // Animate content
    const content = section.querySelector('.section-content')
    gsap.to(content, {
      opacity: 1,
      x: 0,
      duration: 1,
      delay: 0.4 * (index + 1),
      ease: 'power2.out'
    })
  })
}

const animateBackgroundFlowers = () => {
  // Corner flowers animation - slower breathing effect
  gsap.to('.top-left', {
    scale: 1.05,
    duration: 5,
    repeat: -1,
    yoyo: true,
    ease: 'power1.inOut'
  });

  gsap.to('.top-right', {
    scale: 1.05,
    duration: 5.5,
    repeat: -1,
    yoyo: true,
    ease: 'power1.inOut'
  });

  gsap.to('.bottom-left', {
    scale: 1.05,
    duration: 6,
    repeat: -1,
    yoyo: true,
    ease: 'power1.inOut'
  });

  gsap.to('.bottom-right', {
    scale: 1.05,
    duration: 5.2,
    repeat: -1,
    yoyo: true,
    ease: 'power1.inOut'
  });

  // Side flowers animation - slower breathing effect
  gsap.to('.left-middle', {
    scale: 1.08,
    duration: 6,
    repeat: -1,
    yoyo: true,
    ease: 'power1.inOut'
  });

  gsap.to('.right-middle', {
    scale: 1.08,
    duration: 6.2,
    repeat: -1,
    yoyo: true,
    ease: 'power1.inOut'
  });
};

const createButterfly = () => {
  if (!butterflyContainer.value) return

  const contentRect = document.querySelector('.content').getBoundingClientRect()
  const butterflyElem = document.createElement('img')
  butterflyElem.src = butterflyImage
  butterflyElem.className = 'butterfly'
  
  // Random starting position within content area
  const startFromSide = Math.random() > 0.5
  const margin = 40 // Margin from content edges
  const startX = startFromSide ? 
    contentRect.left + margin : 
    contentRect.right - margin
  const startY = contentRect.top + margin + Math.random() * (contentRect.height - margin * 2)
  
  gsap.set(butterflyElem, {
    x: startX,
    y: startY,
    scale: 0.3 + Math.random() * 0.3,
    opacity: 0
  })
  
  butterflyContainer.value.appendChild(butterflyElem)
  
  // Create a fluttering path within content bounds
  const endX = startFromSide ? 
    contentRect.right - margin : 
    contentRect.left + margin
  const controlPoint1X = startX + (endX - startX) * 0.3
  const controlPoint2X = startX + (endX - startX) * 0.7
  const controlPointsY = [
    Math.max(contentRect.top + margin, Math.min(contentRect.bottom - margin, startY - 50 + Math.random() * 100)),
    Math.max(contentRect.top + margin, Math.min(contentRect.bottom - margin, startY - 50 + Math.random() * 100))
  ]
  
  // Animate the butterfly
  const timeline = gsap.timeline({
    onComplete: () => butterflyElem.remove()
  })
  
  timeline
    .to(butterflyElem, {
      opacity: 0.6,
      duration: 0.5
    })
    .to(butterflyElem, {
      duration: 12 + Math.random() * 8,
      motionPath: {
        path: [
          { x: startX, y: startY },
          { x: controlPoint1X, y: controlPointsY[0] },
          { x: controlPoint2X, y: controlPointsY[1] },
          { x: endX, y: startY }
        ],
        curviness: 1.5
      },
      rotation: "random(-30, 30)",
      ease: "none"
    }, 0)
    .to(butterflyElem, {
      rotation: "random(-15, 15)",
      duration: 1.5,
      repeat: -1,
      yoyo: true,
      ease: "sine.inOut"
    }, 0)
    .to(butterflyElem, {
      opacity: 0,
      duration: 0.5,
      delay: 11
    })
}

const animateButterflies = () => {
  // Create initial butterflies
  for (let i = 0; i < 3; i++) {
    setTimeout(() => createButterfly(), i * 1500)
  }
  
  // Continue creating butterflies at intervals
  const butterflyInterval = setInterval(() => {
    if (!showMainContent.value) {
      clearInterval(butterflyInterval)
      return
    }
    createButterfly()
  }, 4000) // More frequent butterflies
  
  return () => clearInterval(butterflyInterval)
}

const animateWelcome = () => {
  showWelcome.value = true
  setTimeout(() => {
    showEnterButton.value = true
  }, 1000)
}

const enterInvitation = () => {
  isTransitioning.value = true
  setTimeout(() => {
    showMainContent.value = true
    showContent.value = true
    showWelcome.value = false
  }, 1000)
}

const handleRSVP = () => {
  console.log('RSVP clicked')
  createFlowerBurst() // Burst of flowers on click
}

onMounted(() => {
  console.log('Component mounted')
  // Initial animations
  animateWelcome()

  // Start flower animations
  const cleanup = animateFlowers()

  // RSVP button animation
  const rsvpInterval = setInterval(() => {
    showRSVPAnimation.value = true
    setTimeout(() => {
      showRSVPAnimation.value = false
    }, 1000)
  }, 3000)

  // Add scroll trigger for content animation
  const weddingInfoRect = weddingInfo.value.getBoundingClientRect()
  const contentRect = document.querySelector('.content').getBoundingClientRect()
  const triggerTop = contentRect.top + window.scrollY + weddingInfoRect.top
  const triggerBottom = triggerTop + weddingInfoRect.height

  gsap.to(weddingInfo.value, {
    opacity: 1,
    y: 0,
    duration: 1,
    ease: 'power2.out',
    scrollTrigger: {
      trigger: weddingInfo.value,
      start: `top ${triggerTop}px`,
      end: `bottom ${triggerBottom}px`,
      toggleActions: 'play none none reset',
    }
  })

  // Add background flower animations
  animateBackgroundFlowers()

  // Add butterfly animations
  animateButterflies()

  // Cleanup on component unmount
  return () => {
    cleanup()
    clearInterval(rsvpInterval)
  }
})
</script>

<style scoped>
.wedding-invitation {
  position: relative;
  min-height: 100vh;
  overflow: hidden;
  background: linear-gradient(135deg, rgba(245, 247, 250, 0.9) 0%, rgba(232, 236, 241, 0.9) 100%);
}

.background-flowers {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  pointer-events: none;
  z-index: 1;
}

.wedding-container {
  position: relative;
  z-index: 2;
  min-height: 100vh;
  padding: 2rem;
}

.corner-flower, .side-flower {
  position: absolute;
  background-size: contain;
  background-repeat: no-repeat;
  opacity: 0.8;
  filter: drop-shadow(0 0 10px rgba(255, 255, 255, 0.5));
}

.corner-flower {
  width: 600px;
  height: 600px;
}

.top-left {
  top: -60px;
  left: -60px;
  background-image: url('/images/bg-flower.png');
  transform-origin: center;
}

.top-right {
  top: -60px;
  right: -60px;
  background-image: url('/images/bg-flower.png');
  transform-origin: center;
}

.bottom-left {
  bottom: -60px;
  left: -60px;
  background-image: url('/images/bg-flower.png');
  transform-origin: center;
}

.bottom-right {
  bottom: -60px;
  right: -60px;
  background-image: url('/images/bg-flower.png');
  transform-origin: center;
}

.side-flower {
  width: 500px;
  height: 500px;
}

.left-middle {
  left: -80px;
  top: 50%;
  transform: translateY(-50%);
  background-image: url('/images/bg-flower.png');
  transform-origin: center;
}

.right-middle {
  right: -80px;
  top: 50%;
  transform: translateY(-50%);
  background-image: url('/images/bg-flower.png');
  transform-origin: center;
}

.content {
  position: relative;
  z-index: 2;
  max-width: 800px;
  margin: 0 auto;
  padding: 2rem;
  background: rgba(255, 255, 255, 0.9);
  border-radius: 20px;
  box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
  overflow: visible;
}

.flower-animation {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  pointer-events: none;
  z-index: 1;
}

.flower {
  position: absolute;
  width: 30px;
  height: 30px;
  object-fit: contain;
  pointer-events: none;
  filter: drop-shadow(0 2px 4px rgba(0, 0, 0, 0.1));
  will-change: transform;
}

.header {
  position: relative;
  z-index: 2;
  margin-bottom: 3rem;
  opacity: 0;
}

.welcome-text {
  font-family: 'Great Vibes', cursive;
  font-size: 4rem;
  color: #1a1a1a;
  margin-bottom: 1rem;
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
  position: relative;
  z-index: 2;
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

.rsvp-section {
  position: relative;
  z-index: 2;
  margin-top: 2rem;
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

.wedding-info {
  opacity: 0;
  transform: translateY(20px);
}

.info-section {
  margin: 4rem 0;
}

.info-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
  gap: 2rem;
  margin-top: 2rem;
}

.info-card {
  background: rgba(255, 255, 255, 0.9);
  padding: 2rem;
  border-radius: 15px;
  box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
  text-align: center;
}

.info-card h4 {
  color: #d4a373;
  font-size: 1.5rem;
  margin-bottom: 1rem;
}

.info-card p {
  color: #666;
  line-height: 1.6;
}

.rsvp-section {
  text-align: center;
  margin: 4rem 0;
  padding: 3rem;
  background: rgba(255, 255, 255, 0.9);
  border-radius: 20px;
  box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
}

.rsvp-text {
  font-size: 1.5rem;
  margin-bottom: 1rem;
  color: #666;
}

.deadline {
  color: #d4a373;
  margin-bottom: 2rem;
}

.rsvp-button {
  background: #d4a373;
  color: white;
  border: none;
  padding: 1rem 3rem;
  font-size: 1.2rem;
  border-radius: 30px;
  cursor: pointer;
  transition: all 0.3s ease;
}

.rsvp-button:hover {
  transform: scale(1.05);
  background: #c69b7b;
}

.ceremony-text {
  font-size: 2rem;
  color: #d4a373;
  text-align: center;
  margin: 2rem 0;
}

.intro {
  text-align: center;
  color: #666;
  font-size: 1.2rem;
  margin-bottom: 1rem;
}

.countdown-section {
  display: flex;
  justify-content: center;
  gap: 2rem;
  margin: 3rem 0;
}

.countdown-item {
  text-align: center;
  background: rgba(255, 255, 255, 0.9);
  padding: 1.5rem;
  border-radius: 15px;
  box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
  min-width: 120px;
}

.count {
  font-size: 2.5rem;
  font-weight: bold;
  color: #d4a373;
  display: block;
  margin-bottom: 0.5rem;
}

.unit {
  color: #666;
  font-size: 1rem;
}

.ceremony-details {
  margin: 4rem 0;
}

.detail-card {
  background: rgba(255, 255, 255, 0.9);
  padding: 2rem;
  border-radius: 15px;
  box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
}

.icon-detail {
  display: flex;
  align-items: flex-start;
  margin-bottom: 2rem;
}

.icon-detail:last-child {
  margin-bottom: 0;
}

.icon-detail i {
  font-size: 1.5rem;
  color: #d4a373;
  margin-right: 1rem;
  min-width: 30px;
}

.text strong {
  display: block;
  color: #d4a373;
  margin-bottom: 0.5rem;
}

.text p {
  color: #666;
  margin-bottom: 0.5rem;
}

.map-button {
  display: inline-block;
  color: #d4a373;
  text-decoration: none;
  margin-top: 1rem;
  border: 1px solid #d4a373;
  padding: 0.5rem 1rem;
  border-radius: 20px;
  transition: all 0.3s ease;
}

.map-button:hover {
  background: #d4a373;
  color: white;
}

.timeline {
  margin-top: 2rem;
}

.timeline-item {
  display: flex;
  margin-bottom: 2rem;
  background: rgba(255, 255, 255, 0.9);
  padding: 1.5rem;
  border-radius: 15px;
  box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
}

.time {
  color: #d4a373;
  font-weight: bold;
  min-width: 100px;
}

.event-details h4 {
  color: #333;
  margin-bottom: 0.5rem;
}

.event-details p {
  color: #666;
}

@media (max-width: 768px) {
  .countdown-section {
    flex-wrap: wrap;
    gap: 1rem;
  }

  .countdown-item {
    min-width: calc(50% - 1rem);
  }

  .timeline-item {
    flex-direction: column;
  }

  .time {
    margin-bottom: 1rem;
  }

  .info-grid {
    grid-template-columns: 1fr;
  }
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
    padding: 2rem;
  }
}

/* Welcome styles */
.welcome-content {
  text-align: center;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  gap: 2.5rem;
  padding: 2rem;
}

.welcome-text {
  font-family: 'Great Vibes', cursive;
  font-size: 4rem;
  color: #1a1a1a;
  margin: 0;
  opacity: 0;
  transform: translateY(20px);
  transition: all 1s ease;
  text-align: center;
}

.couple-intro {
  opacity: 0;
  transform: translateY(20px);
  transition: all 1s ease 0.3s;
}

.couple-intro.show {
  opacity: 1;
  transform: translateY(0);
}

.couple-intro .names {
  font-family: 'Great Vibes', cursive;
  font-size: 3.5rem;
  color: #d4a373;
  margin: 0 0 1rem;
}

.couple-intro .date {
  font-size: 1.5rem;
  color: #666;
  margin: 0 0 1rem;
}

.couple-intro .welcome-message {
  font-size: 1.2rem;
  color: #888;
  font-style: italic;
  margin: 0;
}

.welcome-text.show,
.enter-button.show {
  opacity: 1;
  transform: translateY(0);
}

.welcome-screen {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  display: flex;
  justify-content: center;
  align-items: center;
  background: rgba(255, 255, 255, 0.95);
  z-index: 10;
  transition: opacity 1s ease;
  overflow: hidden;
}

.welcome-screen.fade-out {
  opacity: 0;
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
  transform: scale(0.9);
  transition: all 0.3s ease;
  margin: 0 auto;
}

.enter-button:hover {
  transform: scale(1.05);
  background: #c69b7b;
}

.enter-button.show {
  opacity: 1;
  transform: scale(1);
  animation: pulse 2s infinite;
}

@keyframes pulse {
  0% { transform: scale(1); }
  50% { transform: scale(1.05); }
  100% { transform: scale(1); }
}

.butterfly-container {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  pointer-events: none;
  z-index: 1;
  overflow: visible;
}

.butterfly {
  position: absolute;
  width: 40px;
  height: 40px;
  pointer-events: none;
  filter: drop-shadow(0 2px 4px rgba(0, 0, 0, 0.05));
  will-change: transform;
}
</style>
