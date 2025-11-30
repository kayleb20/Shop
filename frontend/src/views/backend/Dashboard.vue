<template>
  <div class="dashboard-container">
    <el-row :gutter="20">
      <el-col :span="6">
        <el-card class="stat-card" shadow="hover">
          <template #header>
            <div class="card-header">
              <span>{{ $t('admin.totalSales') }}</span>
            </div>
          </template>
          <div class="card-value">¥ 128,000</div>
          <div class="card-trend up">+12% vs last month</div>
        </el-card>
      </el-col>
      <el-col :span="6">
        <el-card class="stat-card" shadow="hover">
          <template #header>
            <div class="card-header">
              <span>{{ $t('admin.orders') }}</span>
            </div>
          </template>
          <div class="card-value">1,240</div>
          <div class="card-trend up">+5% vs last month</div>
        </el-card>
      </el-col>
      <el-col :span="6">
        <el-card class="stat-card" shadow="hover">
          <template #header>
            <div class="card-header">
              <span>New Users</span>
            </div>
          </template>
          <div class="card-value">350</div>
          <div class="card-trend down">-2% vs last month</div>
        </el-card>
      </el-col>
      <el-col :span="6">
        <el-card class="stat-card" shadow="hover">
          <template #header>
            <div class="card-header">
              <span>Pending Orders</span>
            </div>
          </template>
          <div class="card-value">12</div>
          <div class="card-trend">Action needed</div>
        </el-card>
      </el-col>
    </el-row>

    <el-row :gutter="20" style="margin-top: 20px;">
      <el-col :span="16">
        <el-card shadow="hover">
          <template #header>
            <div class="card-header">
              <span>Sales Overview</span>
            </div>
          </template>
          <div class="h-[300px] bg-[#f0f2f5] dark:bg-gray-700 flex items-center justify-center text-gray-400">
            Chart Placeholder (Integrate ECharts here)
          </div>
        </el-card>
      </el-col>
      <el-col :span="8">
        <el-card shadow="hover">
          <template #header>
            <div class="card-header">
              <span>Recent Activity</span>
            </div>
          </template>
          <el-timeline>
            <el-timeline-item timestamp="2023/11/25" placement="top">
              Order #12345 created
            </el-timeline-item>
            <el-timeline-item timestamp="2023/11/24" placement="top">
              New user registered
            </el-timeline-item>
            <el-timeline-item timestamp="2023/11/23" placement="top">
              Product "iPhone 15" updated
            </el-timeline-item>
          </el-timeline>
        </el-card>
      </el-col>
    </el-row>
  </div>
</template>

<style scoped>
.dashboard-container {
  padding: 20px;
}
.stat-card .card-value {
  font-size: 24px;
  font-weight: bold;
  margin: 10px 0;
}
.stat-card .card-trend {
  font-size: 12px;
  color: #909399;
}
.stat-card .card-trend.up {
  color: #67c23a;
}
.stat-card .card-trend.down {
  color: #f56c6c;
}
</style>
