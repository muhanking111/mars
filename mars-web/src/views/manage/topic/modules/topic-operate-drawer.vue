<script setup lang="ts">
import { computed, reactive, ref, watch } from 'vue';
import { useAntdForm, useFormRules } from '@/hooks/common/form';
import {
  fetchAddTopic,
  fetchGetTopicById,
  fetchUpdateTopic
} from '@/service/api';
import { $t } from '@/locales';

defineOptions({
  name: 'TopicOperateDrawer'
});

/**
 * the type of operation
 *
 * - add: add topic
 * - edit: edit topic
 */
export type OperateType = 'add' | 'edit';

interface Props {
  /** the type of operation */
  operateType: OperateType;
  /** the edit row data */
  rowData?: Api.TopicManage.Topic | null;
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
const { formRules } = useFormRules();

const title = computed(() => {
  const titles: Record<OperateType, string> = {
    add: '新增话题',
    edit: '编辑话题'
  };
  return titles[props.operateType];
});

type Model = Pick<
  Api.TopicManage.Topic,
  'name' | 'description' | 'coverImage' | 'icon' | 'color' | 'category' | 'isHot' | 'isOfficial' | 'sortOrder' | 'status'
>;

const model: Model = reactive(createDefaultModel());

function createDefaultModel(): Model {
  return {
    name: '',
    description: '',
    coverImage: '',
    icon: '',
    color: '#1890ff',
    category: 'general',
    isHot: 0,
    isOfficial: 0,
    sortOrder: 0,
    status: 1
  };
}

type RuleKey = Extract<keyof Model, 'name'>;

const rules = computed<Record<RuleKey, App.Global.FormRule[]>>(() => {
  return {
    name: [
      {
        required: true,
        message: '请输入话题名称',
        trigger: 'blur'
      },
      {
        min: 1,
        max: 50,
        message: '话题名称长度为1-50个字符',
        trigger: 'blur'
      }
    ]
  };
});

// 话题分类选项
const categoryOptions = [
  { label: '旅行', value: 'travel' },
  { label: '美食', value: 'food' },
  { label: '文化', value: 'culture' },
  { label: '户外', value: 'outdoor' },
  { label: '摄影', value: 'photography' },
  { label: '其他', value: 'general' }
];

// 状态选项
const statusOptions = [
  { label: '启用', value: 1 },
  { label: '禁用', value: 0 }
];

// 是否选项
const yesNoOptions = [
  { label: '否', value: 0 },
  { label: '是', value: 1 }
];

async function handleInitModel() {
  Object.assign(model, createDefaultModel());

  if (props.operateType === 'edit' && props.rowData?.id) {
    // 获取话题详情
    const { data: topicDetail } = await fetchGetTopicById(props.rowData.id);
    if (topicDetail) {
      // 确保将数据正确赋值到模型中
      Object.assign(model, topicDetail);
    } else {
      console.error('获取话题详情失败');
    }
  }
}

function closeDrawer() {
  visible.value = false;
}

async function handleSubmit() {
  await validate();

  let request;
  const isAdd = props.operateType === 'add';
  const submitData = { ...model };

  if (isAdd) {
    // 新增时删除id字段
    delete submitData.id;
    request = fetchAddTopic(submitData);
  } else {
    request = fetchUpdateTopic({ ...submitData, id: props.rowData?.id });
  }

  const { error } = await request;

  if (!error) {
    window.$message?.success(isAdd ? '新增话题成功' : '编辑话题成功');
    closeDrawer();
    emit('submitted');
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
    <AForm ref="formRef" :model="model" :rules="rules" :label-col="{ span: 4 }" :wrapper-col="{ span: 20 }">
      <AFormItem label="话题名称" name="name">
        <AInput v-model:value="model.name" placeholder="请输入话题名称" />
      </AFormItem>
      <AFormItem label="话题描述" name="description">
        <ATextarea v-model:value="model.description" placeholder="请输入话题描述" :rows="3" />
      </AFormItem>
      <AFormItem label="话题分类" name="category">
        <ASelect v-model:value="model.category" placeholder="请选择话题分类" :options="categoryOptions" />
      </AFormItem>
      <AFormItem label="话题颜色" name="color">
        <AInput v-model:value="model.color" placeholder="请输入话题颜色" />
      </AFormItem>
      <AFormItem label="话题图标" name="icon">
        <AInput v-model:value="model.icon" placeholder="请输入话题图标" />
      </AFormItem>
      <AFormItem label="封面图片" name="coverImage">
        <AInput v-model:value="model.coverImage" placeholder="请输入封面图片URL" />
      </AFormItem>
      <AFormItem label="排序" name="sortOrder">
        <AInputNumber v-model:value="model.sortOrder" placeholder="请输入排序" :min="0" />
      </AFormItem>
      <AFormItem label="是否热门" name="isHot">
        <ARadioGroup v-model:value="model.isHot" :options="yesNoOptions" />
      </AFormItem>
      <AFormItem label="是否官方" name="isOfficial">
        <ARadioGroup v-model:value="model.isOfficial" :options="yesNoOptions" />
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
