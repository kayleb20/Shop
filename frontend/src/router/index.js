import { createRouter, createWebHistory } from 'vue-router'

const routes = [
  {
    path: '/',
    redirect: '/shop/home'
  },
  // Shop Routes
  {
    path: '/shop',
    component: () => import('../layout/ShopLayout.vue'),
    children: [
      {
        path: 'home',
        component: () => import('../views/shop/Home.vue')
      },
      {
        path: 'login',
        component: () => import('../views/shop/Login.vue')
      },
      {
        path: 'product/:id',
        component: () => import('../views/shop/ProductDetail.vue')
      },
      {
        path: 'cart',
        component: () => import('../views/shop/Cart.vue')
      }
    ]
  },
  // Backend Routes
  {
    path: '/backend',
    component: () => import('../layout/BackendLayout.vue'),
    children: [
      {
        path: 'login',
        component: () => import('../views/backend/Login.vue')
      },
      {
        path: 'dashboard',
        component: () => import('../views/backend/Dashboard.vue'),
        meta: { requiresAuth: true, role: 'ADMIN' }
      },
      {
        path: 'product',
        component: () => import('../views/backend/ProductManage.vue'),
        meta: { requiresAuth: true, role: 'ADMIN' }
      }
    ]
  }
]

const router = createRouter({
  history: createWebHistory(),
  routes
})

// Navigation Guard
router.beforeEach((to, from, next) => {
  const token = localStorage.getItem('token')
  // Simple check, in production use a proper auth store
  if (to.meta.requiresAuth && !token) {
    if (to.path.startsWith('/backend')) {
      next('/backend/login')
    } else {
      next('/shop/login')
    }
  } else {
    next()
  }
})

export default router
