import { defineStore } from 'pinia'
import { ref, watch } from 'vue'

// 主题配置仓库：统一管理暗色状态与主题主色
export const useThemeStore = defineStore('theme', () => {
  // 默认读取本地存储，提升用户返回时的体验
  const isDark = ref(localStorage.getItem('theme') === 'dark')
  const primaryColor = ref(localStorage.getItem('primaryColor') || '#8B5CF6')

  // 切换日/夜间模式
  const toggleDarkMode = () => {
    isDark.value = !isDark.value
  }

  // 设置主题色，可供设置面板调用
  const setPrimaryColor = (color) => {
    primaryColor.value = color
  }

  // 监听暗黑状态，动态给 html 根元素添加/移除 dark class
  watch(isDark, (val) => {
    if (val) {
      document.documentElement.classList.add('dark')
      localStorage.setItem('theme', 'dark')
    } else {
      document.documentElement.classList.remove('dark')
      localStorage.setItem('theme', 'light')
    }
  }, { immediate: true })

  // 监听主题色，实时注入 Element Plus 所需的若干变量
  watch(primaryColor, (val) => {
    const el = document.documentElement
    el.style.setProperty('--el-color-primary', val)
    
    // 颜色混合工具：根据权重生成浅/深色，用于 hover 与 active
    const mix = (color1, color2, weight) => {
      weight = Math.max(Math.min(Number(weight), 1), 0)
      let r1 = parseInt(color1.substring(1, 3), 16)
      let g1 = parseInt(color1.substring(3, 5), 16)
      let b1 = parseInt(color1.substring(5, 7), 16)
      let r2 = parseInt(color2.substring(1, 3), 16)
      let g2 = parseInt(color2.substring(3, 5), 16)
      let b2 = parseInt(color2.substring(5, 7), 16)
      let r = Math.round(r1 * (1 - weight) + r2 * weight)
      let g = Math.round(g1 * (1 - weight) + g2 * weight)
      let b = Math.round(b1 * (1 - weight) + b2 * weight)
      const _r = ('0' + (r || 0).toString(16)).slice(-2)
      const _g = ('0' + (g || 0).toString(16)).slice(-2)
      const _b = ('0' + (b || 0).toString(16)).slice(-2)
      return '#' + _r + _g + _b
    }

    el.style.setProperty('--el-color-primary-light-3', mix('#ffffff', val, 0.3))
    el.style.setProperty('--el-color-primary-light-5', mix('#ffffff', val, 0.5))
    el.style.setProperty('--el-color-primary-light-7', mix('#ffffff', val, 0.7))
    el.style.setProperty('--el-color-primary-light-8', mix('#ffffff', val, 0.8))
    el.style.setProperty('--el-color-primary-light-9', mix('#ffffff', val, 0.9))
    el.style.setProperty('--el-color-primary-dark-2', mix('#000000', val, 0.2))

    localStorage.setItem('primaryColor', val)
  }, { immediate: true })

  return {
    isDark,
    primaryColor,
    toggleDarkMode,
    setPrimaryColor
  }
})
