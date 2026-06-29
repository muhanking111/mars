<script setup lang="ts">
import { computed, ref, onMounted } from 'vue';
import { $t } from '@/locales';
import { useAntdForm } from '@/hooks/common/form';
import { fetchGetAllActivityCategories } from '@/service/api/activity-category-manage';

defineOptions({
  name: 'ActivitySearch'
});

interface Emits {
  (e: 'reset'): void;
  (e: 'search'): void;
}

const emit = defineEmits<Emits>();

const { formRef, resetFields } = useAntdForm();

// 搜索参数模型
interface SearchModel {
  title?: string;
  categoryId?: number;
  status?: number;
  auditStatus?: number;
  activityType?: number;
  regionId?: number;
  isTop?: number;
  isHot?: number;
  isRecommend?: number;
}

const model = defineModel<SearchModel>('model', { required: true });

// 折叠状态
const collapsed = ref(false);

// 选项数据
const categoryOptions = ref<any[]>([]);

// 状态选项
const statusOptions = [
  { label: '草稿', value: 0 },
  { label: '已发布', value: 1 },
  { label: '已取消', value: 2 },
  { label: '已结束', value: 3 },
  { label: '审核中', value: 4 },
  { label: '审核拒绝', value: 5 }
];

// 审核状态选项
const auditStatusOptions = [
  { label: '待审核', value: 0 },
  { label: '审核通过', value: 1 },
  { label: '审核拒绝', value: 2 }
];

// 活动类型选项
const activityTypeOptions = [
  { label: '线下活动', value: 1 },
  { label: '线上活动', value: 2 },
  { label: '混合活动', value: 3 }
];

// 是否选项
const yesNoOptions = [
  { label: '是', value: 1 },
  { label: '否', value: 0 }
];

// 加载分类选项
async function loadCategoryOptions() {
  try {
    const { data, error } = await fetchGetAllActivityCategories();
    if (!error && data?.records) {
      categoryOptions.value = data.records.map((item: any) => ({
        label: item.name,
        value: item.id
      }));
    }
  } catch (error) {
    console.error('加载分类选项失败:', error);
  }
}

async function reset() {
  await resetFields();
  emit('reset');
}

async function search() {
  emit('search');
}

function toggleCollapsed() {
  collapsed.value = !collapsed.value;
}

onMounted(() => {
  loadCategoryOptions();
});
</script>

<template>
  <ACard
    title="活动搜索"
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
            <AFormItem label="活动标题" name="title" class="m-0">
              <AInput v-model:value="model.title" placeholder="请输入活动标题" @pressEnter="search" />
            </AFormItem>
          </ACol>
          
          <ACol :span="24" :md="12" :lg="8">
            <AFormItem label="活动分类" name="categoryId" class="m-0">
              <ASelect
                v-model:value="model.categoryId"
                :options="categoryOptions"
                placeholder="请选择活动分类"
                allowClear
              />
            </AFormItem>
          </ACol>
          
          <ACol :span="24" :md="12" :lg="8">
            <AFormItem label="活动状态" name="status" class="m-0">
              <ASelect
                v-model:value="model.status"
                :options="statusOptions"
                placeholder="请选择活动状态"
                allowClear
              />
            </AFormItem>
          </ACol>
          
          <ACol :span="24" :md="12" :lg="8">
            <AFormItem label="审核状态" name="auditStatus" class="m-0">
              <ASelect
                v-model:value="model.auditStatus"
                :options="auditStatusOptions"
                placeholder="请选择审核状态"
                allowClear
              />
            </AFormItem>
          </ACol>
          
          <ACol :span="24" :md="12" :lg="8">
            <AFormItem label="活动类型" name="activityType" class="m-0">
              <ASelect
                v-model:value="model.activityType"
                :options="activityTypeOptions"
                placeholder="请选择活动类型"
                allowClear
              />
            </AFormItem>
          </ACol>
          
          <ACol :span="24" :md="12" :lg="8">
            <AFormItem label="是否置顶" name="isTop" class="m-0">
              <ASelect
                v-model:value="model.isTop"
                :options="yesNoOptions"
                placeholder="请选择是否置顶"
                allowClear
              />
            </AFormItem>
          </ACol>
          
          <ACol :span="24" :md="12" :lg="8">
            <AFormItem label="是否热门" name="isHot" class="m-0">
              <ASelect
                v-model:value="model.isHot"
                :options="yesNoOptions"
                placeholder="请选择是否热门"
                allowClear
              />
            </AFormItem>
          </ACol>
          
          <ACol :span="24" :md="12" :lg="8">
            <AFormItem label="是否推荐" name="isRecommend" class="m-0">
              <ASelect
                v-model:value="model.isRecommend"
                :options="yesNoOptions"
                placeholder="请选择是否推荐"
                allowClear
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
