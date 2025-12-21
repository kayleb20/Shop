import { defineStore } from 'pinia'
import { ref, watch } from 'vue'

// 主题配置仓库：统一管理暗色状态与主题主色
export const useThemeStore = defineStore('theme', () => {
  // 独立管理前后台暗黑模式
  const shopDark = ref(localStorage.getItem('shopDark') === 'true')
  const backendDark = ref(localStorage.getItem('backendDark') === 'true')
  
  const primaryColor = ref(localStorage.getItem('primaryColor') || '#8B5CF6')

  // 切换前台模式
  const toggleShopTheme = () => {
    shopDark.value = !shopDark.value
    localStorage.setItem('shopDark', shopDark.value)
    updateHtmlClass(shopDark.value)
  }

  // 切换后台模式
  const toggleBackendTheme = () => {
    backendDark.value = !backendDark.value
    localStorage.setItem('backendDark', backendDark.value)
    updateHtmlClass(backendDark.value)
  }

  // 辅助函数：更新 html class
  const updateHtmlClass = (isDark) => {
    if (isDark) {
      document.documentElement.classList.add('dark')
    } else {
      document.documentElement.classList.remove('dark')
    }
  }

  // 设置主题色
  const setPrimaryColor = (color) => {
    primaryColor.value = color
    localStorage.setItem('primaryColor', color)
    updateCssVar(color)
  }

  const updateCssVar = (color) => {
    const el = document.documentElement
    el.style.setProperty('--el-color-primary', color)
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
    el.style.setProperty('--el-color-primary-light-3', mix(color, '#ffffff', 0.3))
    el.style.setProperty('--el-color-primary-light-5', mix(color, '#ffffff', 0.5))
    el.style.setProperty('--el-color-primary-light-7', mix(color, '#ffffff', 0.7))
    el.style.setProperty('--el-color-primary-light-8', mix(color, '#ffffff', 0.8))
    el.style.setProperty('--el-color-primary-light-9', mix(color, '#ffffff', 0.9))
    el.style.setProperty('--el-color-primary-dark-2', mix(color, '#000000', 0.2))
  }

  return {
    shopDark,
    backendDark,
    primaryColor,
    toggleShopTheme,
    toggleBackendTheme,
    setPrimaryColor,
    updateHtmlClass,
    updateCssVar
  }
})
