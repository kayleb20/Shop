<template>
  <el-container>
    <el-aside width="200px">
      <el-menu router>
        <el-menu-item index="/admin/product">商品管理</el-menu-item>
        <el-menu-item index="/admin/order">订单管理</el-menu-item>
      </el-menu>
    </el-aside>
    <el-main>
      <router-view></router-view>
    </el-main>
  </el-container>
</template>
