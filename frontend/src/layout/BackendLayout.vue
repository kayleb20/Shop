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
        </el-menu>
      </el-aside>
      <el-container>
        <el-header class="bg-white dark:bg-gray-800 shadow-sm flex items-center justify-end transition-colors duration-300">
          <el-dropdown @command="handleLanguageChange" style="margin-right: 20px;">
            <span class="el-dropdown-link">
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
            <span class="el-dropdown-link">
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
import { Odometer, Goods, ArrowDown } from '@element-plus/icons-vue'
import { useI18n } from 'vue-i18n'
import { computed } from 'vue'

const { locale, t } = useI18n()

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
