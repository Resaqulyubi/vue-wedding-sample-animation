import gsap from 'gsap'

const flower1 = '/images/flower1.png'
const flower2 = '/images/flower2.png'

const MAX_FLOWERS = 15

export const useAnimations = (refs) => {
  const createFallingFlower = (fromLeft = false) => {
    if (!refs.flowerContainer.value) return

    const currentFlowers = refs.flowerContainer.value.getElementsByClassName('flower')
    if (currentFlowers.length >= MAX_FLOWERS) {
      return
    }

    const contentElement = document.querySelector('.content')
    if (!contentElement) return

    const flower = new Image()
    flower.className = 'flower'
    flower.style.opacity = '0'
    flower.onload = () => {
      refs.flowerContainer.value.appendChild(flower)

      const contentRect = contentElement.getBoundingClientRect()
      const containerRect = refs.flowerContainer.value.getBoundingClientRect()

      const startX = contentRect.left - containerRect.left + (contentRect.width / 2)
      const startY = contentRect.top - containerRect.top

      flower.style.left = `${startX}px`
      flower.style.top = `${startY}px`
      flower.style.position = 'absolute'

      const size = 70 + Math.random() * 40
      flower.style.width = `${size}px`
      flower.style.height = `${size}px`

      const rotation = Math.random() * 360
      flower.style.transform = `rotate(${rotation}deg)`

      const duration = 8 + Math.random() * 4

      const moveDistance = -100 + Math.random() * 200
      const endX = startX + moveDistance
      const endY = containerRect.height - size

      requestAnimationFrame(() => {
        gsap.to(flower, {
          x: endX - startX,
          y: endY - startY,
          opacity: 1,
          rotation: rotation + (Math.random() > 0.5 ? 180 : -180),
          duration: duration,
          ease: "power1.inOut",
          onComplete: () => {
            if (flower.parentNode === refs.flowerContainer.value) {
              refs.flowerContainer.value.removeChild(flower)
            }
          }
        })

        gsap.to(flower, {
          x: `+=${-30 + Math.random() * 60}`,
          duration: duration * 0.6,
          repeat: 2,
          yoyo: true,
          ease: "sine.inOut"
        })
      })
    }

    flower.src = Math.random() > 0.5 ? flower1 : flower2
  }

  const createFlowerBurst = () => {
    if (!refs.flowerContainer.value) return

    const burstCount = 5
    for (let i = 0; i < burstCount; i++) {
      setTimeout(() => {
        createFallingFlower()
      }, i * 150)
    }
  }

  const animateFlowers = () => {
    const fallingInterval = setInterval(() => {
      createFallingFlower()
    }, 2000)

    const burstInterval = setInterval(createFlowerBurst, 12000)

    return () => {
      clearInterval(fallingInterval)
      clearInterval(burstInterval)
    }
  }

  const animateBackgroundFlowers = () => {
    const flowers = [
      refs.topLeft.value,
      refs.topRight.value,
      refs.bottomLeft.value,
      refs.bottomRight.value,
      refs.leftMiddle.value,
      refs.rightMiddle.value
    ]

    flowers.forEach((flower, index) => {
      if (!flower) return

      gsap.to(flower, {
        scale: 1.05,
        duration: 5 + (index * 0.5),
        repeat: -1,
        yoyo: true,
        ease: 'power1.inOut'
      })
    })
  }

  const createButterfly = () => {
    if (!refs.butterflyContainer.value) return

    const butterfly = new Image()
    butterfly.src = '/images/butterfly.png'
    butterfly.className = 'butterfly'
    butterfly.style.opacity = '0'
    butterfly.style.position = 'absolute'

    butterfly.onload = () => {
      refs.butterflyContainer.value.appendChild(butterfly)

      const containerRect = refs.butterflyContainer.value.getBoundingClientRect()
      const size = 80 + Math.random() * 40

      butterfly.style.width = `${size}px`
      butterfly.style.height = `${size}px`

      const startX = -100
      const startY = Math.random() * (containerRect.height - size)

      butterfly.style.left = `${startX}px`
      butterfly.style.top = `${startY}px`

      const duration = 20 + Math.random() * 10
      const endX = containerRect.width + 100

      gsap.to(butterfly, {
        x: endX,
        y: '+=150',
        rotation: 15,
        opacity: 0.85,
        duration: duration,
        ease: 'none',
        onComplete: () => {
          if (butterfly.parentNode === refs.butterflyContainer.value) {
            refs.butterflyContainer.value.removeChild(butterfly)
          }
        }
      })

      gsap.to(butterfly, {
        y: '-=300',
        duration: duration / 4,
        repeat: 3,
        yoyo: true,
        ease: 'sine.inOut'
      })
    }
  }

  const animateButterflies = () => {
    const interval = setInterval(createButterfly, 8000)
    createButterfly()
    setTimeout(createButterfly, 2000)
    return () => clearInterval(interval)
  }

  return {
    createFallingFlower,
    createFlowerBurst,
    animateFlowers,
    animateBackgroundFlowers,
    createButterfly,
    animateButterflies
  }
}
