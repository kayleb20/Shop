<template>
  <div class="backend-layout">
    <el-container style="height: 100vh;">
      <el-aside width="200px" class="bg-[#001529] text-white dark:bg-gray-900 transition-colors duration-300">
        <div style="padding: 20px; font-size: 18px; font-weight: bold; text-align: center;">{{ $t('admin.title') }}</div>
        <el-menu
          router
          background-color="transparent"
          text-color="#fff"
          active-text-color="#409EFF"
          style="border-right: none;"
        >
          <el-menu-item index="/backend/dashboard">
            <el-icon><Odometer /></el-icon>
            <span>{{ $t('admin.dashboard') }}</span>
          </el-menu-item>
          <el-menu-item index="/backend/product">
            <el-icon><Goods /></el-icon>
            <span>{{ $t('admin.productManage') }}</span>
          </el-menu-item>
          <el-menu-item index="/backend/order">
            <el-icon><List /></el-icon>
            <span>{{ $t('admin.orderManage') }}</span>
          </el-menu-item>
        </el-menu>
      </el-aside>
      <el-container>
        <el-header class="bg-white dark:bg-gray-800 shadow-sm flex items-center justify-end transition-colors duration-300">
          <!-- Theme Toggle -->
          <button 
            @click="themeStore.toggleBackendTheme" 
            class="p-2 rounded-full hover:bg-gray-100 dark:hover:bg-gray-700 transition-colors mr-4"
            :title="themeStore.backendDark ? $t('common.lightMode') : $t('common.darkMode')"
          >
            <el-icon v-if="themeStore.backendDark" class="text-yellow-400 text-xl"><Sunny /></el-icon>
            <el-icon v-else class="text-gray-600 text-xl"><Moon /></el-icon>
          </button>

          <el-dropdown @command="handleLanguageChange" style="margin-right: 20px;">
            <span class="el-dropdown-link flex items-center gap-1 cursor-pointer text-gray-700 dark:text-gray-200">
              {{ currentLanguageLabel }}
              <el-icon class="el-icon--right"><arrow-down /></el-icon>
            </span>
            <template #dropdown>
              <el-dropdown-menu>
                <el-dropdown-item command="zh">中文</el-dropdown-item>
                <el-dropdown-item command="en">English</el-dropdown-item> 
              </el-dropdown-menu>
            </template>
          </el-dropdown>
          <el-dropdown>
            <span class="el-dropdown-link flex items-center gap-1 cursor-pointer text-gray-700 dark:text-gray-200">
              {{ $t('admin.adminUser') }} <el-icon class="el-icon--right"><arrow-down /></el-icon>
            </span>
            <template #dropdown>
              <el-dropdown-menu>
                <el-dropdown-item @click="$router.push('/backend/login')">{{ $t('common.logout') }}</el-dropdown-item>
              </el-dropdown-menu>
            </template>
          </el-dropdown>
        </el-header>
        <el-main class="bg-white dark:bg-gray-900 transition-colors duration-300">
          <router-view></router-view>
        </el-main>
      </el-container>
    </el-container>
  </div>
</template>

<script setup>
import { Odometer, Goods, ArrowDown, List, Sunny, Moon } from '@element-plus/icons-vue'
import { useI18n } from 'vue-i18n'
import { computed, onMounted, watch } from 'vue'
import { useThemeStore } from '../stores/theme'

const themeStore = useThemeStore()
const { locale, t } = useI18n()

// 初始化后台主题
onMounted(() => {
  themeStore.updateHtmlClass(themeStore.backendDark)
  // 强制设置后台主色调为蓝色，不使用 store 中的 primaryColor
  themeStore.updateCssVar('#409EFF')
})

// 监听后台暗黑模式变化
watch(() => themeStore.backendDark, (val) => {
  themeStore.updateHtmlClass(val)
})

const currentLanguageLabel = computed(() => {
  return locale.value === 'zh' ? '中文' : 'English'
})

const handleLanguageChange = (lang) => {
  locale.value = lang
}
</script>

<style>
body {
  margin: 0;
}
</style>
