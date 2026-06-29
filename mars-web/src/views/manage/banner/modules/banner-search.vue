<script setup lang="ts">
import { computed, ref } from 'vue';
import { $t } from '@/locales';
import { useAntdForm } from '@/hooks/common/form';
import { enableStatusOptions } from '@/constants/business';
import { translateOptions } from '@/utils/common';

defineOptions({
  name: 'BannerSearch'
});

interface Emits {
  (e: 'reset'): void;
  (e: 'search'): void;
}

const emit = defineEmits<Emits>();

const { formRef, validate, resetFields } = useAntdForm();

const model = defineModel<Api.BannerManage.BannerSearchParams>('model', { required: true });

// 折叠状态
const collapsed = ref(false);

// 轮播图类型选项
const bannerTypeOptions = [
  { label: '活动', value: 'activity' },
  { label: '话题', value: 'topic' },
  { label: '商品', value: 'goods' },
  { label: '其他', value: 'other' }
];

// 展示位置选项
const positionOptions = [
  { label: '首页', value: 'home' },
  { label: 'APP首页', value: 'app' },
  { label: 'Web首页', value: 'web' },
  { label: '活动页', value: 'activity' },
  { label: '商城页', value: 'mall' }
];

async function reset() {
  await resetFields();
  emit('reset');
}

async function search() {
  await validate();
  emit('search');
}

function toggleCollapsed() {
  collapsed.value = !collapsed.value;
}
</script>

<template>
  <ACard
    :title="$t('common.search')"
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
            <AFormItem label="轮播图标题" name="title" class="m-0">
              <AInput v-model:value="model.title" placeholder="请输入轮播图标题" @pressEnter="search" />
            </AFormItem>
          </ACol>
          <ACol :span="24" :md="12" :lg="8">
            <AFormItem label="轮播图类型" name="type" class="m-0">
              <ASelect
                v-model:value="model.type"
                placeholder="请选择轮播图类型"
                :options="bannerTypeOptions"
                clearable
              />
            </AFormItem>
          </ACol>
          <ACol :span="24" :md="12" :lg="8">
            <AFormItem label="展示位置" name="position" class="m-0">
              <ASelect
                v-model:value="model.position"
                placeholder="请选择展示位置"
                :options="positionOptions"
                clearable
              />
            </AFormItem>
          </ACol>
          <ACol :span="24" :md="12" :lg="8">
            <AFormItem label="状态" name="status" class="m-0">
              <ASelect
                v-model:value="model.status"
                placeholder="请选择状态"
                :options="translateOptions(enableStatusOptions)"
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
                  <span class="ml-8px">{{ $t('common.reset') }}</span>
                </AButton>
                <AButton type="primary" ghost @click="search">
                  <template #icon>
                    <icon-ic-round-search class="align-sub text-icon" />
                  </template>
                  <span class="ml-8px">{{ $t('common.search') }}</span>
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

.card-wrapper[data-collapsed="true"] :deep(.ant-card-body) {
  display: none !important;
  height: 0 !important;
  padding: 0 !important;
  margin: 0 !important;
}

.card-wrapper[data-collapsed="true"] :deep(.ant-card-head) {
  margin-bottom: 0 !important;
  border-bottom: none !important;
}
</style>
