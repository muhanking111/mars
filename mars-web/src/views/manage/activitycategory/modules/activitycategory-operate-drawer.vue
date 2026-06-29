<script setup lang="ts">
import { computed, reactive, ref, watch } from 'vue';
import { useAntdForm, useFormRules } from '@/hooks/common/form';
import {
  fetchAddActivityCategory,
  fetchGetActivityCategoryById,
  fetchUpdateActivityCategory
} from '@/service/api/activity-category-manage';
import { $t } from '@/locales';

defineOptions({
  name: 'ActivityCategoryOperateDrawer'
});

export type OperateType = 'add' | 'edit';

interface Props {
  operateType: OperateType;
  rowData?: Api.ActivityCategoryManage.ActivityCategory | null;
}

const props = defineProps<Props>();

interface Emits {
  (e: 'submitted'): void;
}

const emit = defineEmits<Emits>();

const visible = defineModel<boolean>('visible', {
  default: false
});

const { formRef, validate, resetFields } = useAntdForm();
const { defaultRequiredRule } = useFormRules();

const title = computed(() => {
  const titles: Record<OperateType, string> = {
    add: '新增活动分类',
    edit: '编辑活动分类'
  };
  return titles[props.operateType];
});

type Model = Pick<
  Api.ActivityCategoryManage.ActivityCategory,
  'name' | 'parentId' | 'icon' | 'coverImage' | 'description' | 'sortOrder' | 'isHot' | 'status'
>;

const model: Model = reactive(createDefaultModel());

function createDefaultModel(): Model {
  return {
    name: '',
    parentId: 0,
    icon: '',
    coverImage: '',
    description: '',
    sortOrder: 1,
    isHot: 0,
    status: 1
  };
}

type RuleKey = Extract<keyof Model, 'name'>;

const rules = computed<Record<RuleKey, App.Global.FormRule[]>>(() => {
  return {
    name: [defaultRequiredRule]
  };
});

// 是否热门选项
const isHotOptions = [
  { label: '否', value: 0 },
  { label: '是', value: 1 }
];

// 状态选项
const statusOptions = [
  { label: '启用', value: 1 },
  { label: '禁用', value: 0 }
];

async function handleInitModel() {
  Object.assign(model, createDefaultModel());

  if (props.operateType === 'edit' && props.rowData?.id) {
    try {
      const { data: categoryDetail } = await fetchGetActivityCategoryById(props.rowData.id);
      if (categoryDetail) {
        Object.assign(model, categoryDetail);
      } else {
        console.error('获取活动分类详情失败');
      }
    } catch (error) {
      console.error('获取活动分类详情失败:', error);
      window.$message?.error('获取活动分类详情失败');
    }
  }
}

function closeDrawer() {
  visible.value = false;
}

async function handleSubmit() {
  try {
    await validate();

    let request;
    const isAdd = props.operateType === 'add';
    const categoryId = props.rowData?.id;

    if (isAdd) {
      request = fetchAddActivityCategory(model);
    } else {
      if (!categoryId) {
        window.$message?.error('缺少活动分类ID');
        return;
      }
      request = fetchUpdateActivityCategory({ ...model, id: categoryId });
    }

    const { error } = await request;

    if (!error) {
      window.$message?.success(isAdd ? '新增活动分类成功' : '编辑活动分类成功');
      closeDrawer();
      emit('submitted');
    }
  } catch (error) {
    console.error('提交失败:', error);
    window.$message?.error('提交失败，请重试');
  }
}

watch(visible, () => {
  if (visible.value) {
    handleInitModel();
    resetFields();
  }
});
</script>

<template>
  <ADrawer
    v-model:open="visible"
    :title="title"
    :width="500"
    :body-style="{ paddingRight: '20px' }"
    :footer-style="{ textAlign: 'right' }"
  >
    <AForm ref="formRef" :model="model" :rules="rules" :label-col="{ span: 6 }" :wrapper-col="{ span: 18 }">
      <AFormItem label="分类名称" name="name">
        <AInput v-model:value="model.name" placeholder="请输入分类名称" />
      </AFormItem>
      <AFormItem label="分类图标" name="icon">
        <AInput v-model:value="model.icon" placeholder="请输入分类图标" />
      </AFormItem>
      <AFormItem label="封面图片" name="coverImage">
        <AInput v-model:value="model.coverImage" placeholder="请输入封面图片URL" />
      </AFormItem>
      <AFormItem label="分类描述" name="description">
        <ATextarea v-model:value="model.description" placeholder="请输入分类描述" :rows="3" />
      </AFormItem>
      <AFormItem label="排序" name="sortOrder">
        <AInputNumber v-model:value="model.sortOrder" :min="1" placeholder="请输入排序" />
      </AFormItem>
      <AFormItem label="是否热门" name="isHot">
        <ARadioGroup v-model:value="model.isHot" :options="isHotOptions" />
      </AFormItem>
      <AFormItem label="状态" name="status">
        <ARadioGroup v-model:value="model.status" :options="statusOptions" />
      </AFormItem>
    </AForm>
    <template #footer>
      <div class="flex-y-center justify-end gap-12px">
        <AButton @click="closeDrawer">取消</AButton>
        <AButton type="primary" @click="handleSubmit">确认</AButton>
      </div>
    </template>
  </ADrawer>
</template>

<style scoped></style>
