<script setup lang="ts">
import { onActivated, onMounted, ref } from 'vue';
import { useRoute } from 'vue-router';
import { resolveIframeUrl } from '@/utils/iframe-url';

const route = useRoute();
const externalUrl = ref('');

function loadUrl() {
  const url = route.query.url as string;
  externalUrl.value = url ? resolveIframeUrl(url) : '';
}

onMounted(loadUrl);
onActivated(loadUrl);
</script>

<template>
  <div class="h-full">
    <iframe v-if="externalUrl" id="iframePage" class="size-full" :src="externalUrl"></iframe>
    <div v-else class="flex-center h-full">
      <h2 class="text-error">未提供有效的外部 URL 或 URL 不在白名单内</h2>
    </div>
  </div>
</template>

<style scoped></style>
