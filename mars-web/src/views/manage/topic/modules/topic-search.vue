<script setup lang="ts">
import { computed, ref } from 'vue';
import { $t } from '@/locales';
import { useAntdForm } from '@/hooks/common/form';

defineOptions({
  name: 'TopicSearch'
});

interface Emits {
  (e: 'reset'): void;
  (e: 'search'): void;
}

const emit = defineEmits<Emits>();

const { formRef, resetFields } = useAntdForm();

const model = defineModel<Api.TopicManage.TopicSearchParams>('model', { required: true });

// 折叠状态
const collapsed = ref(false);

// 话题分类选项
const categoryOptions = [
  { label: '全部', value: '' },
  { label: '旅行', value: 'travel' },
  { label: '美食', value: 'food' },
  { label: '文化', value: 'culture' },
  { label: '户外', value: 'outdoor' },
  { label: '摄影', value: 'photography' },
  { label: '其他', value: 'general' }
];

// 状态选项
const statusOptions = [
  { label: '全部', value: null },
  { label: '启用', value: 1 },
  { label: '禁用', value: 0 }
];

// 热门选项
const hotOptions = [
  { label: '全部', value: null },
  { label: '热门', value: 1 },
  { label: '普通', value: 0 }
];

// 官方选项
const officialOptions = [
  { label: '全部', value: null },
  { label: '官方', value: 1 },
  { label: '用户', value: 0 }
];

async function reset() {
  await resetFields();
  emit('reset');
}

function search() {
  emit('search');
}

function toggleCollapsed() {
  collapsed.value = !collapsed.value;
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
        ref="formRef"
        :model="model"
        :label-col="{
          span: 5,
          md: 7
        }"
      >
        <ARow :gutter="[16, 16]" wrap>
          <ACol :span="24" :md="12" :lg="8">
            <AFormItem label="话题名称" name="name" class="m-0">
              <AInput v-model:value="model.name" placeholder="请输入话题名称" @pressEnter="search" />
            </AFormItem>
          </ACol>
          <ACol :span="24" :md="12" :lg="8">
            <AFormItem label="话题分类" name="category" class="m-0">
              <ASelect
                v-model:value="model.category"
                placeholder="请选择话题分类"
                :options="categoryOptions"
                clearable
              />
            </AFormItem>
          </ACol>
          <ACol :span="24" :md="12" :lg="8">
            <AFormItem label="状态" name="status" class="m-0">
              <ASelect
                v-model:value="model.status"
                placeholder="请选择状态"
                :options="statusOptions"
                clearable
              />
            </AFormItem>
          </ACol>
          <ACol :span="24" :md="12" :lg="8">
            <AFormItem label="是否热门" name="isHot" class="m-0">
              <ASelect
                v-model:value="model.isHot"
                placeholder="请选择是否热门"
                :options="hotOptions"
                clearable
              />
            </AFormItem>
          </ACol>
          <ACol :span="24" :md="12" :lg="8">
            <AFormItem label="是否官方" name="isOfficial" class="m-0">
              <ASelect
                v-model:value="model.isOfficial"
                placeholder="请选择是否官方"
                :options="officialOptions"
                clearable
              />
            </AFormItem>
          </ACol>
          <div class="flex-1">
            <AFormItem class="m-0">
              <div class="w-full flex-y-center justify-end gap-12px">
                <AButton @click="reset">
                  <template #icon>
                    <icon-ic-round-refresh class="align-sub text-icon" />
                  </template>
                  <span class="ml-8px">重置</span>
                </AButton>
                <AButton type="primary" ghost @click="search">
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

/* 折叠状态下的卡片样式优化 */
.card-wrapper {
  transition: all 0.3s ease;
}

/* 折叠时隐藏卡片主体，只保留标题栏 */
.card-wrapper :deep(.ant-card-body) {
  transition: all 0.3s ease;
}

/* 当折叠时，强制隐藏卡片主体 */
.card-wrapper[data-collapsed="true"] :deep(.ant-card-body) {
  display: none !important;
  height: 0 !important;
  padding: 0 !important;
  margin: 0 !important;
}

/* 优化折叠后的卡片头部样式 */
.card-wrapper[data-collapsed="true"] :deep(.ant-card-head) {
  margin-bottom: 0 !important;
  border-bottom: none !important;
}
</style>
