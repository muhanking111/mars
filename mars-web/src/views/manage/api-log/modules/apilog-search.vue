<script setup lang="ts">
import { ref } from 'vue';
import {
  Button as AButton,
  Card as ACard,
  Col as ACol,
  Form as AForm,
  FormItem as AFormItem,
  Input as AInput,
  Row as ARow,
  Select as ASelect
} from 'ant-design-vue';

defineOptions({
  name: 'ApiLogSearch'
});

interface SearchModel {
  current?: number;
  size?: number;
  operName?: string;
  requestUrl?: string;
  requestMethod?: string;
  status?: number | null;
  operIp?: string;
}

interface Props {
  modelValue?: SearchModel;
}

const props = defineProps<Props>();

interface Emits {
  (e: 'update:modelValue', value: SearchModel): void;
  (e: 'reset'): void;
  (e: 'search'): void;
}

const emit = defineEmits<Emits>();

const collapsed = ref(false);

const methodOptions = [
  { label: 'GET', value: 'GET' },
  { label: 'POST', value: 'POST' },
  { label: 'PUT', value: 'PUT' },
  { label: 'DELETE', value: 'DELETE' }
];

const statusOptions = [
  { label: '正常', value: 0 },
  { label: '异常', value: 1 }
];

function toggleCollapsed() {
  collapsed.value = !collapsed.value;
}

function updateField(field: keyof SearchModel, value: any) {
  emit('update:modelValue', { ...props.modelValue, [field]: value });
}

function handleSearch() {
  emit('search');
}

function handleReset() {
  emit('reset');
}
</script>

<template>
  <ACard
    title="搜索"
    :bordered="false"
    class="card-wrapper"
    :body-style="collapsed ? { padding: '0', display: 'none' } : {}"
    :data-collapsed="collapsed"
  >
    <template #extra>
      <AButton type="text" @click="toggleCollapsed">
        <template #icon>
          <icon-mdi:chevron-down v-if="collapsed" class="text-icon" />
          <icon-mdi:chevron-up v-else class="text-icon" />
        </template>
        {{ collapsed ? '展开' : '收起' }}
      </AButton>
    </template>

    <div v-show="!collapsed">
      <AForm
        :model="modelValue"
        :label-col="{
          span: 5,
          md: 7
        }"
      >
        <ARow :gutter="[16, 16]" wrap>
          <ACol :span="24" :md="12" :lg="8">
            <AFormItem label="操作人员" name="operName" class="m-0">
              <AInput
                :value="modelValue?.operName || ''"
                placeholder="请输入操作人员"
                allow-clear
                @update:value="updateField('operName', $event)"
                @press-enter="handleSearch"
              />
            </AFormItem>
          </ACol>
          <ACol :span="24" :md="12" :lg="8">
            <AFormItem label="请求地址" name="requestUrl" class="m-0">
              <AInput
                :value="modelValue?.requestUrl || ''"
                placeholder="请输入请求地址"
                allow-clear
                @update:value="updateField('requestUrl', $event)"
                @press-enter="handleSearch"
              />
            </AFormItem>
          </ACol>
          <ACol :span="24" :md="12" :lg="8">
            <AFormItem label="请求方式" name="requestMethod" class="m-0">
              <ASelect
                :value="modelValue?.requestMethod || undefined"
                placeholder="请选择请求方式"
                :options="methodOptions"
                allow-clear
                @update:value="updateField('requestMethod', $event)"
              />
            </AFormItem>
          </ACol>
          <ACol :span="24" :md="12" :lg="8">
            <AFormItem label="请求状态" name="status" class="m-0">
              <ASelect
                :value="modelValue?.status ?? undefined"
                placeholder="请选择状态"
                :options="statusOptions"
                allow-clear
                @update:value="updateField('status', $event)"
              />
            </AFormItem>
          </ACol>
          <ACol :span="24" :md="12" :lg="8">
            <AFormItem label="操作IP" name="operIp" class="m-0">
              <AInput
                :value="modelValue?.operIp || ''"
                placeholder="请输入操作IP"
                allow-clear
                @update:value="updateField('operIp', $event)"
                @press-enter="handleSearch"
              />
            </AFormItem>
          </ACol>
          <div class="flex-1">
            <AFormItem class="m-0">
              <div class="w-full flex-y-center justify-end gap-12px">
                <AButton @click="handleReset">
                  <template #icon>
                    <icon-ic-round-refresh class="align-sub text-icon" />
                  </template>
                  <span class="ml-8px">重置</span>
                </AButton>
                <AButton type="primary" ghost @click="handleSearch">
                  <template #icon>
                    <icon-ic-round-search class="align-sub text-icon" />
                  </template>
                  <span class="ml-8px">搜索</span>
                </AButton>
              </div>
            </AFormItem>
          </div>
        </ARow>
      </AForm>
    </div>
  </ACard>
</template>

<style scoped>
.text-icon {
  font-size: 16px;
}

.card-wrapper {
  transition: all 0.3s ease;
}

.card-wrapper :deep(.ant-card-body) {
  transition: all 0.3s ease;
}

.card-wrapper[data-collapsed='true'] :deep(.ant-card-body) {
  display: none !important;
  height: 0 !important;
  padding: 0 !important;
  margin: 0 !important;
}

.card-wrapper[data-collapsed='true'] :deep(.ant-card-head) {
  margin-bottom: 0 !important;
  border-bottom: none !important;
}
</style>
