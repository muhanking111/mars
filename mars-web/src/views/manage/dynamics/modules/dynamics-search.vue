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
            <AFormItem label="关键词" name="keyword" class="m-0">
              <AInput v-model:value="model.keyword" placeholder="请输入标题或内容关键词" @pressEnter="search" />
            </AFormItem>
          </ACol>
          <ACol :span="24" :md="12" :lg="8">
            <AFormItem label="帖子类型" name="postType" class="m-0">
              <ASelect
                v-model:value="model.postType"
                placeholder="请选择帖子类型"
                :options="postTypeOptions"
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
            <AFormItem label="是否推荐" name="isRecommend" class="m-0">
              <ASelect
                v-model:value="model.isRecommend"
                placeholder="请选择是否推荐"
                :options="recommendOptions"
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
            <AFormItem label="审核状态" name="auditStatus" class="m-0">
              <ASelect
                v-model:value="model.auditStatus"
                placeholder="请选择审核状态"
                :options="auditStatusOptions"
                clearable
              />
            </AFormItem>
          </ACol>
          <ACol :span="24" :md="12" :lg="8">
            <AFormItem label="创建时间" name="createTime" class="m-0">
              <ARangePicker
                v-model:value="model.createTime"
                class="w-full"
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

<script setup lang="ts">
import { ref } from 'vue';
import { useAntdForm } from '@/hooks/common/form';

export interface Emits {
  (e: 'reset'): void;
  (e: 'search'): void;
}

defineOptions({
  name: 'DynamicsSearch'
});

const emit = defineEmits<Emits>();

const { formRef, resetFields } = useAntdForm();

const model = defineModel<Api.PostManage.PostSearchParams>('model', {
  required: true
});

// 折叠状态
const collapsed = ref(false);

const postTypeOptions = [
  { label: '全部', value: null },
  { label: '图文', value: 1 },
  { label: '视频', value: 2 }
];

const hotOptions = [
  { label: '全部', value: null },
  { label: '是', value: 1 },
  { label: '否', value: 0 }
];

const recommendOptions = [
  { label: '全部', value: null },
  { label: '是', value: 1 },
  { label: '否', value: 0 }
];

const statusOptions = [
  { label: '全部', value: null },
  { label: '启用', value: 1 },
  { label: '禁用', value: 0 }
];

const auditStatusOptions = [
  { label: '全部', value: null },
  { label: '待审核', value: 0 },
  { label: '审核通过', value: 1 },
  { label: '审核拒绝', value: 2 }
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
