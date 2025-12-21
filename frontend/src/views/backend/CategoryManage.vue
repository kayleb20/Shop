<template>
  <div class="category-manage p-6 bg-white dark:bg-gray-800 rounded-lg shadow-sm">
    <div class="header flex justify-between items-center mb-6">
      <h2 class="text-xl font-bold text-gray-900 dark:text-white">{{ $t('admin.categoryManage') }}</h2>
      <el-button type="primary" @click="handleAdd">{{ $t('common.add') }}</el-button>
    </div>

    <el-table :data="tableData" style="width: 100%" v-loading="loading" class="dark:bg-gray-800">
      <el-table-column prop="id" :label="$t('admin.id')" width="80" />
      <el-table-column prop="name" :label="$t('shop.category')" />
      <el-table-column prop="sort" :label="$t('admin.sortOrder')" width="100" />
      <el-table-column :label="$t('admin.operations')" width="180">
        <template #default="scope">
          <el-button link type="primary" size="small" @click="handleEdit(scope.row)">{{ $t('admin.edit') }}</el-button>
          <el-button link type="danger" size="small" @click="handleDelete(scope.row)">{{ $t('admin.delete') }}</el-button>
        </template>
      </el-table-column>
    </el-table>

    <el-dialog v-model="dialogVisible" :title="dialogTitle" width="30%">
      <el-form :model="form" label-width="80px">
        <el-form-item :label="$t('shop.category')">
          <el-input v-model="form.name" />
        </el-form-item>
        <el-form-item :label="$t('admin.sortOrder')">
          <el-input-number v-model="form.sort" :min="0" />
        </el-form-item>
      </el-form>
      <template #footer>
        <span class="dialog-footer">
          <el-button @click="dialogVisible = false">{{ $t('common.cancel') }}</el-button>
          <el-button type="primary" @click="handleSubmit">{{ $t('common.save') }}</el-button>
        </span>
      </template>
    </el-dialog>
  </div>
</template>

<script setup>
import { ref, onMounted, computed } from 'vue'
import request from '@/utils/request'
import { ElMessage, ElMessageBox } from 'element-plus'
import { useI18n } from 'vue-i18n'

const { t } = useI18n()
const tableData = ref([])
const loading = ref(false)
const dialogVisible = ref(false)
const isEdit = ref(false)
const form = ref({
  id: null,
  name: '',
  sort: 0
})

const dialogTitle = computed(() => isEdit.value ? t('common.edit') : t('common.add'))

const fetchCategories = async () => {
  loading.value = true
  try {
    const res = await request.get('/backend/category/list')
    if (res.data.code === 200) {
      tableData.value = res.data.data
    }
  } catch (e) {
    console.error(e)
  } finally {
    loading.value = false
  }
}

const handleAdd = () => {
  isEdit.value = false
  form.value = { id: null, name: '', sort: 0 }
  dialogVisible.value = true
}

const handleEdit = (row) => {
  isEdit.value = true
  form.value = { ...row }
  dialogVisible.value = true
}

const handleDelete = (row) => {
  ElMessageBox.confirm(
    t('common.delete') + '?',
    t('common.warning'),
    {
      confirmButtonText: t('common.submit'),
      cancelButtonText: t('common.cancel'),
      type: 'warning',
    }
  ).then(async () => {
    try {
      const res = await request.delete(`/backend/category/${row.id}`)
      if (res.data.code === 200) {
        ElMessage.success(t('admin.deleted'))
        fetchCategories()
      }
    } catch (e) {
      console.error(e)
    }
  })
}

const handleSubmit = async () => {
  try {
    if (isEdit.value) {
      await request.put('/backend/category/update', form.value)
    } else {
      await request.post('/backend/category/add', form.value)
    }
    ElMessage.success(t('common.save') + ' success')
    dialogVisible.value = false
    fetchCategories()
  } catch (e) {
    console.error(e)
  }
}

onMounted(() => {
  fetchCategories()
})
</script>
