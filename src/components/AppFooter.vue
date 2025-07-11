<template>
  <v-footer class="d-flex align-center justify-center ga-2 flex-wrap flex-grow-1 py-3" color="surface-dark">
    <v-btn
      v-for="content in props.contents"
      :key="content.text"
      rounded
      :text="content.text"
      :to="content.href"
      variant="text"
    />

    <div class="flex-1-0-100 text-center mt-2">
      Copyright © {{ new Date().getFullYear() }} <strong>Takatomo Inoue</strong>
    </div>
  </v-footer>
</template>

<script setup>
  const props = defineProps({
    contents: Array,
  })
</script>
