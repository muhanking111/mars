<script setup lang="ts">
import { Card as ACard, Drawer as ADrawer, Tag as ATag } from 'ant-design-vue';

defineOptions({
  name: 'ApiLogDetailDrawer'
});

interface Props {
  rowData?: Api.LogManage.ApiLog | null;
  visible: boolean;
}

const props = withDefaults(defineProps<Props>(), {
  rowData: null
});

interface Emits {
  (e: 'update:visible', visible: boolean): void;
}

const emit = defineEmits<Emits>();

function handleClose() {
  emit('update:visible', false);
}
</script>

<template>
  <ADrawer
    :open="visible"
    title="接口日志详情"
    width="640"
    :closable="true"
    :destroy-on-close="true"
    @close="handleClose"
  >
    <div v-if="rowData" class="space-y-16px">
      <ACard title="请求信息" size="small">
        <div class="space-y-12px">
          <div class="flex items-start">
            <span class="label">请求方式：</span>
            <span class="value">{{ rowData.requestMethod || '-' }}</span>
          </div>
          <div class="flex items-start">
            <span class="label">请求地址：</span>
            <span class="value break-all">{{ rowData.requestUrl || '-' }}</span>
          </div>
          <div class="flex items-start">
            <span class="label">处理方法：</span>
            <span class="value break-all">{{ rowData.classMethod || '-' }}</span>
          </div>
          <div class="flex items-start">
            <span class="label">链路ID：</span>
            <span class="value break-all">{{ rowData.traceId || '-' }}</span>
          </div>
          <div class="flex items-start">
            <span class="label">请求参数：</span>
            <pre class="value pre-block">{{ rowData.requestParams || '-' }}</pre>
          </div>
        </div>
      </ACard>

      <ACard title="响应信息" size="small">
        <div class="space-y-12px">
          <div class="flex items-center">
            <span class="label">HTTP状态：</span>
            <span class="value">{{ rowData.responseCode ?? '-' }}</span>
          </div>
          <div class="flex items-center">
            <span class="label">请求状态：</span>
            <ATag :color="rowData.status === 0 ? 'success' : 'error'">
              {{ rowData.status === 0 ? '正常' : '异常' }}
            </ATag>
          </div>
          <div class="flex items-start">
            <span class="label">响应结果：</span>
            <pre class="value pre-block">{{ rowData.responseBody || '-' }}</pre>
          </div>
          <div class="flex items-start">
            <span class="label">错误信息：</span>
            <span class="value break-all">{{ rowData.errorMsg || '-' }}</span>
          </div>
          <div class="flex items-center">
            <span class="label">耗时(ms)：</span>
            <span class="value">{{ rowData.costTime ?? 0 }}</span>
          </div>
          <div class="flex items-center">
            <span class="label">请求时间：</span>
            <span class="value">{{ rowData.createTime || '-' }}</span>
          </div>
        </div>
      </ACard>

      <ACard title="操作人信息" size="small">
        <div class="space-y-12px">
          <div class="flex items-center">
            <span class="label">操作人员：</span>
            <span class="value">{{ rowData.operName || '-' }}</span>
          </div>
          <div class="flex items-center">
            <span class="label">操作IP：</span>
            <span class="value">{{ rowData.operIp || '-' }}</span>
          </div>
          <div class="flex items-center">
            <span class="label">操作地点：</span>
            <span class="value">{{ rowData.operLocation || '-' }}</span>
          </div>
          <div class="flex items-center">
            <span class="label">浏览器：</span>
            <span class="value">{{ rowData.browser || '-' }}</span>
          </div>
          <div class="flex items-center">
            <span class="label">操作系统：</span>
            <span class="value">{{ rowData.os || '-' }}</span>
          </div>
        </div>
      </ACard>
    </div>
  </ADrawer>
</template>

<style scoped>
.label {
  @apply text-sm font-medium w-100px flex-shrink-0;
  @apply text-gray-600 dark:text-gray-300;
}

.value {
  @apply text-sm flex-1;
  @apply text-gray-900 dark:text-gray-100;
}

.pre-block {
  @apply whitespace-pre-wrap break-all m-0 p-8px rounded bg-gray-50 dark:bg-gray-800;
  max-height: 240px;
  overflow: auto;
}
</style>
