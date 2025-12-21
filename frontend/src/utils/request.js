import axios from 'axios'
import { ElMessage } from 'element-plus'

const service = axios.create({
  baseURL: '/api', // Use the proxy
  timeout: 5000
})

// Request interceptor
service.interceptors.request.use(
  config => {
    const token = localStorage.getItem('token')
    if (token) {
      config.headers['Authorization'] = 'Bearer ' + token
    }
    return config
  },
  error => {
    console.log(error)
    return Promise.reject(error)
  }
)

// Response interceptor
service.interceptors.response.use(
  response => {
    const res = response.data
    // You can add custom error handling here based on your backend code
    // For example if code !== 200
    return response
  },
  error => {
    console.log('err' + error)
    if (error.response && error.response.status === 401) {
        ElMessage.error('Unauthorized, please login again')
        // Optional: redirect to login
    } else {
        ElMessage.error(error.message)
    }
    return Promise.reject(error)
  }
)

export default service
