import { defineStore } from 'pinia'
import { ref } from 'vue'
import i18n from '../locales'

export const useLocaleStore = defineStore('locale', () => {
  const currentLocale = ref(i18n.global.locale.value)
  const currency = ref('CNY')

  const setLocale = (lang) => {
    currentLocale.value = lang
    i18n.global.locale.value = lang
    localStorage.setItem('language', lang) // Changed key to match i18n config
  }

  return {
    currentLocale,
    currency,
    setLocale
  }
})
