<template>
  <div class="admin-login-container">
    <div class="login-card">
      <div class="header">
        <h1>{{ $t('admin.title') }}</h1>
        <p>{{ $t('admin.secureAccess') }}</p>
      </div>
      <el-form :model="form" size="large">
        <el-form-item>
          <el-input v-model="form.username" :placeholder="$t('common.username')" prefix-icon="User" />
        </el-form-item>
        <el-form-item>
          <el-input v-model="form.password" type="password" :placeholder="$t('common.password')" prefix-icon="Lock" show-password />
        </el-form-item>
        <el-button type="primary" class="submit-btn" @click="login" :loading="loading">
          {{ $t('common.login') }}
        </el-button>
      </el-form>
    </div>
  </div>
</template>

<script setup>
import { ref } from 'vue'
import { User, Lock } from '@element-plus/icons-vue'
import axios from 'axios'
import { useRouter } from 'vue-router'

const router = useRouter()
const loading = ref(false)
const form = ref({
  username: '',
  password: ''
})

const login = async () => {
  loading.value = true
  try {
    // In real scenario, use a dedicated admin login endpoint
    const res = await axios.post('/api/user/login', form.value)
    if (res.data.code === 200) {
      localStorage.setItem('token', res.data.data)
      router.push('/backend/dashboard')
    } else {
      alert(res.data.message)
    }
  } catch (e) {
    console.error(e)
  } finally {
    loading.value = false
  }
}
</script>

<style scoped>
.admin-login-container {
  height: 100vh;
  background: #2d3a4b;
  display: flex;
  justify-content: center;
  align-items: center;
}
.login-card {
  width: 400px;
  padding: 50px;
  background: white;
  border-radius: 4px;
}
.header {
  text-align: center;
  margin-bottom: 40px;
}
.header h1 {
  margin: 0;
  color: #2d3a4b;
}
.header p {
  color: #909399;
  margin-top: 10px;
}
.submit-btn {
  width: 100%;
  background-color: #2d3a4b;
  border-color: #2d3a4b;
}
.submit-btn:hover {
  background-color: #1f2d3d;
  border-color: #1f2d3d;
}
</style>
