<template>
  <div class="order-manage">
    <h2 class="text-2xl font-bold mb-4 text-gray-800 dark:text-white">{{ $t('admin.orderManage') }}</h2>
    
    <el-table :data="orders" style="width: 100%" v-loading="loading">
      <el-table-column prop="orderNo" :label="$t('order.orderNo')" width="180" />
      <el-table-column prop="totalAmount" :label="$t('order.totalAmount')" width="120">
        <template #default="scope">
          ￥{{ scope.row.totalAmount }}
        </template>
      </el-table-column>
      <el-table-column prop="status" :label="$t('order.status')" width="120">
        <template #default="scope">
          <el-tag :type="getStatusType(scope.row.status)">
            {{ getStatusText(scope.row.status) }}
          </el-tag>
        </template>
      </el-table-column>
      <el-table-column prop="createTime" :label="$t('order.createTime')" width="180" />
      <el-table-column prop="receiverName" :label="$t('order.receiverName')" width="120" />
      <el-table-column :label="$t('common.action')" width="200">
        <template #default="scope">
          <el-button size="small" @click="showDetail(scope.row)">{{ $t('common.detail') }}</el-button>
          <el-button 
            v-if="scope.row.status === 1" 
            size="small" 
            type="primary" 
            @click="handleSend(scope.row)"
          >
            {{ $t('order.ship') }}
          </el-button>
        </template>
      </el-table-column>
    </el-table>

    <div class="mt-4 flex justify-end">
      <el-pagination
        background
        layout="prev, pager, next"
        :total="total"
        :page-size="pageSize"
        @current-change="handlePageChange"
      />
    </div>

    <!-- Order Detail Dialog -->
    <el-dialog v-model="detailVisible" :title="$t('order.orderDetail')" width="50%">
      <div v-if="currentOrder">
        <el-descriptions :column="2" border>
          <el-descriptions-item :label="$t('order.orderNo')">{{ currentOrder.orderNo }}</el-descriptions-item>
          <el-descriptions-item :label="$t('order.status')">{{ getStatusText(currentOrder.status) }}</el-descriptions-item>
          <el-descriptions-item :label="$t('order.totalAmount')">￥{{ currentOrder.totalAmount }}</el-descriptions-item>
          <el-descriptions-item :label="$t('order.createTime')">{{ currentOrder.createTime }}</el-descriptions-item>
          <el-descriptions-item :label="$t('order.receiverName')">{{ currentOrder.receiverName }}</el-descriptions-item>
          <el-descriptions-item :label="$t('order.receiverPhone')">{{ currentOrder.receiverPhone }}</el-descriptions-item>
          <el-descriptions-item :label="$t('order.receiverAddress')" :span="2">{{ currentOrder.receiverAddress }}</el-descriptions-item>
        </el-descriptions>
      </div>
    </el-dialog>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import request from '@/utils/request'
import { ElMessage, ElMessageBox } from 'element-plus'
import { useI18n } from 'vue-i18n'

const { t } = useI18n()
const orders = ref([])
const loading = ref(false)
const total = ref(0)
const pageSize = ref(10)
const currentPage = ref(1)
const detailVisible = ref(false)
const currentOrder = ref(null)

const fetchOrders = async (page = 1) => {
  loading.value = true
  try {
    const res = await request.get('/backend/order/list', {
      params: { page, size: pageSize.value }
    })
    if (res.data.code === 200) {
      orders.value = res.data.data.records
      total.value = res.data.data.total
      currentPage.value = page
    }
  } catch (error) {
    console.error(error)
    ElMessage.error(t('common.networkError'))
  } finally {
    loading.value = false
  }
}

const handlePageChange = (page) => {
  fetchOrders(page)
}

const showDetail = (order) => {
  currentOrder.value = order
  detailVisible.value = true
}

const handleSend = (order) => {
  ElMessageBox.confirm(
    t('order.confirmShip'),
    t('common.warning'),
    {
      confirmButtonText: t('common.confirm'),
      cancelButtonText: t('common.cancel'),
      type: 'warning',
    }
  ).then(async () => {
    try {
      const res = await request.post(`/backend/order/send/${order.orderNo}`)
      if (res.data.code === 200) {
        ElMessage.success(t('order.shipSuccess'))
        fetchOrders(currentPage.value)
      } else {
        ElMessage.error(res.data.message || t('order.shipFailed'))
      }
    } catch (error) {
      console.error(error)
      ElMessage.error(t('common.networkError'))
    }
  })
}

const getStatusType = (status) => {
  const map = {
    0: 'warning', // 待付款
    1: 'success', // 已付款
    2: 'primary', // 已发货
    3: 'info',    // 已完成
    4: 'danger'   // 已取消
  }
  return map[status] || 'info'
}

const getStatusText = (status) => {
  const map = {
    0: t('order.statusPending'),
    1: t('order.statusPaid'),
    2: t('order.statusShipped'),
    3: t('order.statusCompleted'),
    4: t('order.statusCancelled')
  }
  return map[status] || t('common.unknown')
}

onMounted(() => {
  fetchOrders()
})
</script>

<style scoped>
.order-manage {
  padding: 20px;
}
</style>
