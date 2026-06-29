<script setup lang="ts">
import { onActivated, onMounted, ref } from 'vue';
import { resolveIframeUrl } from '@/utils/iframe-url';

interface Props {
  url: string;
}

const props = defineProps<Props>();
const decodedUrl = ref('');

onMounted(() => {
  decodedUrl.value = resolveIframeUrl(props.url);
});

onActivated(() => {
  decodedUrl.value = resolveIframeUrl(props.url);
});
</script>

<template>
  <div class="h-full">
    <iframe v-if="decodedUrl" id="iframePage" class="size-full" :src="decodedUrl"></iframe>
    <div v-else class="flex-center h-full">
      <h2 class="text-error">URL 不在白名单内或格式无效</h2>
    </div>
  </div>
</template>

<style scoped></style>
