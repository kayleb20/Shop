import { createApp } from 'vue'
import ElementPlus from 'element-plus'
import 'element-plus/dist/index.css'
import 'element-plus/theme-chalk/dark/css-vars.css'
import './style.css'
import App from './App.vue'
import router from './router'
import { createPinia } from 'pinia'
import i18n from './locales'

const app = createApp(App)

app.use(ElementPlus)
app.use(router)
app.use(createPinia())
app.use(i18n)

app.mount('#app')
