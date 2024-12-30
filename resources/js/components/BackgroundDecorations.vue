<template>
  <div class="background-decorations">
    <div class="background-flowers">
      <div class="corner-flower top-left" ref="topLeft"></div>
      <div class="corner-flower top-right" ref="topRight"></div>
      <div class="corner-flower bottom-left" ref="bottomLeft"></div>
      <div class="corner-flower bottom-right" ref="bottomRight"></div>
      <div class="side-flower left-middle" ref="leftMiddle"></div>
      <div class="side-flower right-middle" ref="rightMiddle"></div>
    </div>
    <div class="flower-animation" ref="flowerContainer"></div>
    <div class="butterfly-container" ref="butterflyContainer"></div>
  </div>
</template>

<script setup>
import { ref, onMounted, onUnmounted } from 'vue'
import gsap from 'gsap'
import { useAnimations } from '../composables/useAnimations'

const topLeft = ref(null)
const topRight = ref(null)
const bottomLeft = ref(null)
const bottomRight = ref(null)
const leftMiddle = ref(null)
const rightMiddle = ref(null)
const flowerContainer = ref(null)
const butterflyContainer = ref(null)

const { 
  animateBackgroundFlowers, 
  animateFlowers, 
  animateButterflies 
} = useAnimations({
  flowerContainer,
  butterflyContainer,
  topLeft,
  topRight,
  bottomLeft,
  bottomRight,
  leftMiddle,
  rightMiddle
})

onMounted(() => {
  animateBackgroundFlowers()
  const cleanupFlowers = animateFlowers()
  const cleanupButterflies = animateButterflies()

  onUnmounted(() => {
    cleanupFlowers()
    cleanupButterflies()
  })
})
</script>

<style scoped>
.background-decorations {
  position: absolute;
  width: 100%;
  height: 100%;
  pointer-events: none;
  overflow: hidden;
}

.background-flowers {
  position: absolute;
  width: 100%;
  height: 100%;
}

.corner-flower, .side-flower {
  position: absolute;
  width: 600px;
  height: 600px;
  background-size: contain;
  background-repeat: no-repeat;
  opacity: 0.8;
  filter: drop-shadow(0 0 10px rgba(255, 255, 255, 0.5));
  background-image: url('/images/bg-flower.png');
  transform-origin: center;
}

.side-flower {
  width: 500px;
  height: 500px;
}

.top-left {
  top: -60px;
  left: -60px;
}

.top-right {
  top: -60px;
  right: -60px;
}

.bottom-left {
  bottom: -60px;
  left: -60px;
}

.bottom-right {
  bottom: -60px;
  right: -60px;
}

.left-middle {
  left: -80px;
  top: 50%;
  transform: translateY(-50%);
}

.right-middle {
  right: -80px;
  top: 50%;
  transform: translateY(-50%);
}

.flower-animation, .butterfly-container {
  position: absolute;
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

.butterfly {
  position: absolute;
  width: 100px;
  height: 100px;
  pointer-events: none;
  filter: drop-shadow(0 2px 4px rgba(0, 0, 0, 0.05));
  will-change: transform;
}

@media (max-width: 768px) {
  .corner-flower {
    width: 400px;
    height: 400px;
  }

  .side-flower {
    width: 300px;
    height: 300px;
  }

  .top-left, .top-right {
    top: -40px;
  }

  .bottom-left, .bottom-right {
    bottom: -40px;
  }

  .left-middle, .right-middle {
    display: none;
  }

  .butterfly {
    width: 80px;
    height: 80px;
  }
}
</style>
