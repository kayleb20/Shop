<template>
  <div class="cart-container">
    <h1>{{ $t('shop.cart') }}</h1>
    <el-empty :description="$t('shop.cartEmpty')" />
  </div>
</template>

<script setup>
</script>

<style scoped>
.cart-container {
  max-width: 1000px;
  margin: 40px auto;
  padding: 20px;
  background: white;
  border-radius: 16px;
  min-height: 400px;
}
</style>
