<template>
  <div class="landing-page">
    <BackgroundDecorations />
    
    <header class="navbar" :class="{ 'scrolled': isScrolled }">
      <nav class="nav-container">
        <div class="nav-logo">
          <h2>Wedding Bliss</h2>
        </div>
        <div class="nav-menu" :class="{ 'active': mobileMenuOpen }">
          <a href="#home" @click="scrollToSection('home')" class="nav-link">Home</a>
          <a href="#about" @click="scrollToSection('about')" class="nav-link">About</a>
          <a href="#services" @click="scrollToSection('services')" class="nav-link">Services</a>
          <a href="#contact" @click="scrollToSection('contact')" class="nav-link">Contact</a>
        </div>
        <button class="mobile-menu-toggle" @click="toggleMobileMenu">
          <span></span>
          <span></span>
          <span></span>
        </button>
      </nav>
    </header>

    <main>
      <section id="home" class="hero-section">
        <div class="hero-content">
          <h1 class="hero-title" ref="heroTitle">
            Create Your Dream Wedding
          </h1>
          <p class="hero-subtitle" ref="heroSubtitle">
            Let us help you craft the perfect celebration of love
          </p>
          <div class="hero-buttons" ref="heroButtons">
            <button @click="navigateToInvitation" class="btn-primary">
              View Invitation
            </button>
            <button @click="scrollToSection('contact')" class="btn-secondary">
              Get Started
            </button>
          </div>
        </div>
        <div class="hero-image" ref="heroImage">
          <div class="floating-hearts">
            <div class="heart" v-for="n in 6" :key="n"></div>
          </div>
        </div>
      </section>

      <section id="about" class="about-section">
        <div class="container">
          <h2 class="section-title" ref="aboutTitle">About Us</h2>
          <div class="about-grid">
            <div class="about-text" ref="aboutText">
              <p>We believe every love story deserves a beautiful beginning. With years of experience in creating magical wedding experiences, we bring your dreams to life with attention to detail and personal care.</p>
              <p>From intimate gatherings to grand celebrations, we're here to make your special day unforgettable.</p>
            </div>
            <div class="about-features" ref="aboutFeatures">
              <div class="feature-card" v-for="(feature, index) in features" :key="index">
                <div class="feature-icon">{{ feature.icon }}</div>
                <h3>{{ feature.title }}</h3>
                <p>{{ feature.description }}</p>
              </div>
            </div>
          </div>
        </div>
      </section>

      <section id="services" class="services-section">
        <div class="container">
          <h2 class="section-title" ref="servicesTitle">Our Services</h2>
          <div class="services-grid">
            <div class="service-card" v-for="(service, index) in services" :key="index" ref="serviceCards">
              <div class="service-image">
                <div class="service-placeholder">{{ service.emoji }}</div>
              </div>
              <div class="service-content">
                <h3>{{ service.title }}</h3>
                <p>{{ service.description }}</p>
                <ul>
                  <li v-for="(item, i) in service.features" :key="i">{{ item }}</li>
                </ul>
              </div>
            </div>
          </div>
        </div>
      </section>

      <section id="contact" class="contact-section">
        <div class="container">
          <h2 class="section-title" ref="contactTitle">Get In Touch</h2>
          <div class="contact-content">
            <div class="contact-info" ref="contactInfo">
              <h3>Let's Create Something Beautiful Together</h3>
              <p>Ready to start planning your perfect day? We'd love to hear from you.</p>
              <div class="contact-details">
                <div class="contact-item">
                  <span class="contact-icon">📧</span>
                  <span>hello@weddingbliss.com</span>
                </div>
                <div class="contact-item">
                  <span class="contact-icon">📱</span>
                  <span>+1 (555) 123-4567</span>
                </div>
                <div class="contact-item">
                  <span class="contact-icon">📍</span>
                  <span>123 Love Street, Romance City</span>
                </div>
              </div>
            </div>
            <div class="contact-form" ref="contactForm">
              <form @submit.prevent="submitForm">
                <div class="form-group">
                  <input v-model="form.name" type="text" placeholder="Your Name" required>
                </div>
                <div class="form-group">
                  <input v-model="form.email" type="email" placeholder="Your Email" required>
                </div>
                <div class="form-group">
                  <input v-model="form.date" type="date" placeholder="Wedding Date">
                </div>
                <div class="form-group">
                  <textarea v-model="form.message" placeholder="Tell us about your dream wedding" rows="4" required></textarea>
                </div>
                <button type="submit" class="btn-submit" :disabled="formSubmitting">
                  {{ formSubmitting ? 'Sending...' : 'Send Message' }}
                </button>
              </form>
            </div>
          </div>
        </div>
      </section>
    </main>

    <footer class="footer">
      <div class="container">
        <p>&copy; 2024 Wedding Bliss. Made with 💕 for couples in love.</p>
      </div>
    </footer>
  </div>
</template>

<script setup>
import { ref, onMounted, nextTick } from 'vue'
import { router } from '@inertiajs/vue3'
import gsap from 'gsap'
import { ScrollTrigger } from 'gsap/ScrollTrigger'
import BackgroundDecorations from '../components/BackgroundDecorations.vue'

gsap.registerPlugin(ScrollTrigger)

const isScrolled = ref(false)
const mobileMenuOpen = ref(false)
const formSubmitting = ref(false)

const form = ref({
  name: '',
  email: '',
  date: '',
  message: ''
})

const features = [
  {
    icon: '💍',
    title: 'Personalized Planning',
    description: 'Custom wedding planning tailored to your unique love story'
  },
  {
    icon: '🌸',
    title: 'Beautiful Decorations',
    description: 'Stunning floral arrangements and venue decorations'
  },
  {
    icon: '📸',
    title: 'Professional Photography',
    description: 'Capture every precious moment with expert photographers'
  }
]

const services = [
  {
    emoji: '💑',
    title: 'Full Wedding Planning',
    description: 'Complete wedding planning from concept to execution',
    features: ['Venue selection', 'Vendor coordination', 'Timeline management', 'Day-of coordination']
  },
  {
    emoji: '🎂',
    title: 'Reception Services',
    description: 'Everything you need for the perfect celebration',
    features: ['Catering coordination', 'Entertainment booking', 'Decor setup', 'Guest management']
  },
  {
    emoji: '🎭',
    title: 'Custom Themes',
    description: 'Unique wedding themes that reflect your personality',
    features: ['Theme development', 'Color coordination', 'Custom decorations', 'Personalized details']
  }
]

const heroTitle = ref(null)
const heroSubtitle = ref(null)
const heroButtons = ref(null)
const heroImage = ref(null)
const aboutTitle = ref(null)
const aboutText = ref(null)
const aboutFeatures = ref(null)
const servicesTitle = ref(null)
const serviceCards = ref(null)
const contactTitle = ref(null)
const contactInfo = ref(null)
const contactForm = ref(null)

const toggleMobileMenu = () => {
  mobileMenuOpen.value = !mobileMenuOpen.value
}

const scrollToSection = (sectionId) => {
  const element = document.getElementById(sectionId)
  if (element) {
    element.scrollIntoView({ behavior: 'smooth' })
    mobileMenuOpen.value = false
  }
}

const navigateToInvitation = () => {
  router.visit('/wedding-invitation')
}

const submitForm = async () => {
  formSubmitting.value = true
  await new Promise(resolve => setTimeout(resolve, 1500))
  formSubmitting.value = false
  Object.keys(form.value).forEach(key => form.value[key] = '')
  alert('Thank you for your message! We\'ll get back to you soon.')
}

const initAnimations = () => {
  gsap.timeline()
    .to(heroTitle.value, { opacity: 1, y: 0, duration: 1, ease: 'power3.out' })
    .to(heroSubtitle.value, { opacity: 1, y: 0, duration: 1, ease: 'power3.out' }, '-=0.5')
    .to(heroButtons.value, { opacity: 1, y: 0, duration: 1, ease: 'power3.out' }, '-=0.5')
    .to(heroImage.value, { opacity: 1, scale: 1, duration: 1, ease: 'power3.out' }, '-=0.3')

  gsap.utils.toArray('.floating-hearts .heart').forEach((heart, index) => {
    gsap.to(heart, {
      y: -20,
      rotation: 360,
      duration: 3 + index,
      repeat: -1,
      yoyo: true,
      ease: 'power1.inOut',
      delay: index * 0.5
    })
  })

  ScrollTrigger.batch([aboutTitle.value, aboutText.value, aboutFeatures.value], {
    onEnter: batch => gsap.to(batch, { opacity: 1, y: 0, duration: 1, stagger: 0.2, ease: 'power2.out' }),
    start: 'top 80%',
    onLeaveBack: batch => gsap.to(batch, { opacity: 0, y: 50, duration: 0.5 })
  })

  ScrollTrigger.batch([servicesTitle.value, ...serviceCards.value], {
    onEnter: batch => gsap.to(batch, { opacity: 1, y: 0, duration: 1, stagger: 0.2, ease: 'power2.out' }),
    start: 'top 80%',
    onLeaveBack: batch => gsap.to(batch, { opacity: 0, y: 50, duration: 0.5 })
  })

  ScrollTrigger.batch([contactTitle.value, contactInfo.value, contactForm.value], {
    onEnter: batch => gsap.to(batch, { opacity: 1, y: 0, duration: 1, stagger: 0.2, ease: 'power2.out' }),
    start: 'top 80%',
    onLeaveBack: batch => gsap.to(batch, { opacity: 0, y: 50, duration: 0.5 })
  })
}

onMounted(() => {
  const handleScroll = () => {
    isScrolled.value = window.scrollY > 50
  }

  window.addEventListener('scroll', handleScroll)
  
  nextTick(() => {
    initAnimations()
  })

  return () => {
    window.removeEventListener('scroll', handleScroll)
    ScrollTrigger.getAll().forEach(trigger => trigger.kill())
  }
})
</script>

<style scoped>
.landing-page {
  min-height: 100vh;
  position: relative;
  background: linear-gradient(135deg, #fef3f0 0%, #fff5f5 50%, #fef7f0 100%);
}

.navbar {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  z-index: 1000;
  background: transparent;
  transition: all 0.3s ease;
}

.navbar.scrolled {
  background: rgba(255, 255, 255, 0.95);
  backdrop-filter: blur(10px);
  box-shadow: 0 2px 20px rgba(0, 0, 0, 0.1);
}

.nav-container {
  max-width: 1200px;
  margin: 0 auto;
  padding: 1rem 2rem;
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.nav-logo h2 {
  color: #d4a373;
  font-size: 1.5rem;
  margin: 0;
}

.nav-menu {
  display: flex;
  gap: 2rem;
}

.nav-link {
  color: #666;
  text-decoration: none;
  font-weight: 500;
  transition: color 0.3s ease;
}

.nav-link:hover {
  color: #d4a373;
}

.mobile-menu-toggle {
  display: none;
  flex-direction: column;
  background: none;
  border: none;
  cursor: pointer;
  padding: 0.5rem;
}

.mobile-menu-toggle span {
  width: 25px;
  height: 3px;
  background: #d4a373;
  margin: 3px 0;
  transition: 0.3s;
}

.hero-section {
  min-height: 100vh;
  display: flex;
  align-items: center;
  padding: 0 2rem;
  position: relative;
  overflow: hidden;
}

.hero-content {
  flex: 1;
  max-width: 600px;
}

.hero-title {
  font-size: 3.5rem;
  color: #d4a373;
  margin-bottom: 1rem;
  opacity: 0;
  transform: translateY(30px);
}

.hero-subtitle {
  font-size: 1.25rem;
  color: #666;
  margin-bottom: 2rem;
  opacity: 0;
  transform: translateY(30px);
}

.hero-buttons {
  display: flex;
  gap: 1rem;
  opacity: 0;
  transform: translateY(30px);
}

.btn-primary, .btn-secondary {
  padding: 1rem 2rem;
  border: none;
  border-radius: 30px;
  font-size: 1rem;
  cursor: pointer;
  transition: all 0.3s ease;
  text-decoration: none;
  display: inline-block;
}

.btn-primary {
  background: #d4a373;
  color: white;
}

.btn-primary:hover {
  background: #c19660;
  transform: translateY(-2px);
  box-shadow: 0 8px 25px rgba(212, 163, 115, 0.3);
}

.btn-secondary {
  background: transparent;
  color: #d4a373;
  border: 2px solid #d4a373;
}

.btn-secondary:hover {
  background: #d4a373;
  color: white;
  transform: translateY(-2px);
}

.hero-image {
  flex: 1;
  display: flex;
  justify-content: center;
  align-items: center;
  opacity: 0;
  transform: scale(0.8);
  position: relative;
}

.floating-hearts {
  position: relative;
  width: 300px;
  height: 300px;
}

.heart {
  position: absolute;
  width: 40px;
  height: 40px;
  background: #d4a373;
  transform: rotate(45deg);
  opacity: 0.3;
}

.heart::before,
.heart::after {
  content: '';
  width: 40px;
  height: 40px;
  position: absolute;
  background: #d4a373;
  border-radius: 50%;
}

.heart::before {
  top: -20px;
  left: 0;
}

.heart::after {
  left: -20px;
  top: 0;
}

.heart:nth-child(1) { top: 10%; left: 20%; }
.heart:nth-child(2) { top: 30%; right: 20%; }
.heart:nth-child(3) { bottom: 20%; left: 30%; }
.heart:nth-child(4) { top: 50%; right: 40%; }
.heart:nth-child(5) { bottom: 40%; right: 10%; }
.heart:nth-child(6) { top: 70%; left: 50%; }

.container {
  max-width: 1200px;
  margin: 0 auto;
  padding: 0 2rem;
}

.section-title {
  font-size: 2.5rem;
  color: #d4a373;
  text-align: center;
  margin-bottom: 3rem;
  opacity: 0;
  transform: translateY(30px);
}

.about-section {
  padding: 5rem 0;
  background: white;
}

.about-grid {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 4rem;
  align-items: center;
}

.about-text {
  opacity: 0;
  transform: translateY(30px);
}

.about-text p {
  font-size: 1.1rem;
  color: #666;
  margin-bottom: 1.5rem;
  line-height: 1.6;
}

.about-features {
  display: grid;
  gap: 2rem;
  opacity: 0;
  transform: translateY(30px);
}

.feature-card {
  display: flex;
  align-items: flex-start;
  gap: 1rem;
  padding: 1.5rem;
  background: #fef9f7;
  border-radius: 10px;
  transition: transform 0.3s ease, box-shadow 0.3s ease;
}

.feature-card:hover {
  transform: translateY(-5px);
  box-shadow: 0 10px 30px rgba(212, 163, 115, 0.1);
}

.feature-icon {
  font-size: 2rem;
  min-width: 60px;
  height: 60px;
  display: flex;
  align-items: center;
  justify-content: center;
  background: white;
  border-radius: 50%;
  box-shadow: 0 4px 15px rgba(212, 163, 115, 0.2);
}

.feature-card h3 {
  color: #d4a373;
  margin-bottom: 0.5rem;
}

.feature-card p {
  color: #666;
  line-height: 1.5;
}

.services-section {
  padding: 5rem 0;
  background: #fef9f7;
}

.services-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
  gap: 2rem;
}

.service-card {
  background: white;
  border-radius: 15px;
  overflow: hidden;
  box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
  transition: transform 0.3s ease, box-shadow 0.3s ease;
  opacity: 0;
  transform: translateY(30px);
}

.service-card:hover {
  transform: translateY(-10px);
  box-shadow: 0 20px 40px rgba(0, 0, 0, 0.15);
}

.service-image {
  height: 200px;
  background: linear-gradient(135deg, #fef3f0, #fff5f5);
  display: flex;
  align-items: center;
  justify-content: center;
}

.service-placeholder {
  font-size: 4rem;
}

.service-content {
  padding: 2rem;
}

.service-content h3 {
  color: #d4a373;
  margin-bottom: 1rem;
  font-size: 1.5rem;
}

.service-content p {
  color: #666;
  margin-bottom: 1.5rem;
  line-height: 1.6;
}

.service-content ul {
  list-style: none;
  padding: 0;
}

.service-content li {
  color: #666;
  padding: 0.5rem 0;
  position: relative;
  padding-left: 1.5rem;
}

.service-content li::before {
  content: '✨';
  position: absolute;
  left: 0;
}

.contact-section {
  padding: 5rem 0;
  background: white;
}

.contact-content {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 4rem;
  align-items: start;
}

.contact-info {
  opacity: 0;
  transform: translateY(30px);
}

.contact-info h3 {
  color: #d4a373;
  margin-bottom: 1rem;
  font-size: 1.8rem;
}

.contact-info p {
  color: #666;
  margin-bottom: 2rem;
  line-height: 1.6;
}

.contact-details {
  display: flex;
  flex-direction: column;
  gap: 1rem;
}

.contact-item {
  display: flex;
  align-items: center;
  gap: 1rem;
  color: #666;
}

.contact-icon {
  font-size: 1.2rem;
  min-width: 30px;
}

.contact-form {
  opacity: 0;
  transform: translateY(30px);
}

.form-group {
  margin-bottom: 1.5rem;
}

.form-group input,
.form-group textarea {
  width: 100%;
  padding: 1rem;
  border: 2px solid #f0e5df;
  border-radius: 10px;
  font-size: 1rem;
  transition: border-color 0.3s ease;
  box-sizing: border-box;
}

.form-group input:focus,
.form-group textarea:focus {
  outline: none;
  border-color: #d4a373;
}

.btn-submit {
  width: 100%;
  padding: 1rem;
  background: #d4a373;
  color: white;
  border: none;
  border-radius: 10px;
  font-size: 1rem;
  cursor: pointer;
  transition: background 0.3s ease;
}

.btn-submit:hover:not(:disabled) {
  background: #c19660;
}

.btn-submit:disabled {
  opacity: 0.7;
  cursor: not-allowed;
}

.footer {
  background: #d4a373;
  color: white;
  text-align: center;
  padding: 2rem 0;
}

@media (max-width: 768px) {
  .mobile-menu-toggle {
    display: flex;
  }

  .nav-menu {
    position: fixed;
    top: 70px;
    left: 0;
    right: 0;
    background: white;
    flex-direction: column;
    padding: 2rem;
    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
    transform: translateY(-100%);
    opacity: 0;
    transition: all 0.3s ease;
  }

  .nav-menu.active {
    transform: translateY(0);
    opacity: 1;
  }

  .hero-section {
    flex-direction: column;
    text-align: center;
    padding: 2rem 1rem;
  }

  .hero-title {
    font-size: 2.5rem;
  }

  .hero-buttons {
    flex-direction: column;
    align-items: center;
  }

  .hero-image {
    margin-top: 2rem;
  }

  .about-grid,
  .contact-content {
    grid-template-columns: 1fr;
    gap: 2rem;
  }

  .services-grid {
    grid-template-columns: 1fr;
  }

  .section-title {
    font-size: 2rem;
  }
}
</style>