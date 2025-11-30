<template>
  <div class="shop-layout min-h-screen transition-colors duration-300" :style="{ backgroundColor: themeStore.isDark ? '#111827' : '#ffffff' }">
    <!-- 公共导航栏：所有 shop 子路由复用 -->
    <Navbar />
    <!-- 主内容区：由 vue-router 注入具体页面 -->
    <main>
      <router-view></router-view>
    </main>
  </div>
</template>

<script setup>
import Navbar from '../components/Navbar.vue'
import { useThemeStore } from '../stores/theme'

// 布局层也需要读取主题，以便统一控制背景
const themeStore = useThemeStore()
</script>

<style scoped>
</style>
