<template>
  <div class="product-manage bg-white dark:bg-gray-800">
    <div class="header">
      <h2 class="text-gray-900 dark:text-white">{{ $t('admin.productManage') }}</h2>
      <el-button type="primary">{{ $t('admin.addProduct') }}</el-button>
    </div>
    
    <el-table :data="tableData" style="width: 100%" v-loading="loading" class="dark:bg-gray-800">
      <el-table-column prop="id" label="ID" width="80" />
      <el-table-column prop="name" :label="$t('admin.productName')" />
      <el-table-column prop="price" :label="$t('admin.price')" width="120">
        <template #default="scope">
          ¥{{ scope.row.price }}
        </template>
      </el-table-column>
      <el-table-column prop="status" :label="$t('admin.status')" width="100">
        <template #default="scope">
          <el-tag :type="scope.row.status === 1 ? 'success' : 'info'">
            {{ scope.row.status === 1 ? 'Active' : 'Inactive' }}
          </el-tag>
        </template>
      </el-table-column>
      <el-table-column :label="$t('admin.operations')" width="180">
        <template #default>
          <el-button link type="primary" size="small">{{ $t('admin.edit') }}</el-button>
          <el-button link type="danger" size="small">{{ $t('admin.delete') }}</el-button>
        </template>
      </el-table-column>
    </el-table>

    <div class="pagination">
      <el-pagination background layout="prev, pager, next" :total="total" />
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import axios from 'axios'

const tableData = ref([])
const loading = ref(false)
const total = ref(0)

const fetchProducts = async () => {
  loading.value = true
  try {
    const res = await axios.get('/api/backend/product/list')
    if (res.data.code === 200) {
      tableData.value = res.data.data.records
      total.value = res.data.data.total
    }
  } catch (e) {
    console.error(e)
  } finally {
    loading.value = false
  }
}

onMounted(() => {
  fetchProducts()
})
</script>

<style scoped>
.product-manage {
  padding: 20px;
  border-radius: 8px;
}
.header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 20px;
}
.pagination {
  margin-top: 20px;
  display: flex;
  justify-content: flex-end;
}
</style>
