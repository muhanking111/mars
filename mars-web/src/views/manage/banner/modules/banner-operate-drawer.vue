<script setup lang="ts">
import { computed, reactive, ref, watch } from 'vue';
import { useAntdForm, useFormRules } from '@/hooks/common/form';
import dayjs from 'dayjs';
import {
  fetchAddBanner,
  fetchGetBannerById,
  fetchUpdateBanner
} from '@/service/api/banner-manage';
import { $t } from '@/locales';

defineOptions({
  name: 'BannerOperateDrawer'
});

export type OperateType = 'add' | 'edit';

interface Props {
  operateType: OperateType;
  rowData?: Api.BannerManage.Banner | null;
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
    add: '新增轮播图',
    edit: '编辑轮播图'
  };
  return titles[props.operateType];
});

type Model = Pick<
  Api.BannerManage.Banner,
  'title' | 'type' | 'imageUrl' | 'link' | 'position' | 'sort' | 'status' | 'startTime' | 'endTime' | 'remark'
>;

const model: Model = reactive(createDefaultModel());

function createDefaultModel(): Model {
  return {
    title: '',
    type: '',
    imageUrl: '',
    link: '',
    position: '',
    sort: 1,
    status: 1,
    startTime: '',
    endTime: '',
    remark: ''
  };
}

type RuleKey = Extract<keyof Model, 'title' | 'type' | 'imageUrl' | 'position'>;

const rules = computed<Record<RuleKey, App.Global.FormRule[]>>(() => {
  return {
    title: [defaultRequiredRule],
    type: [defaultRequiredRule],
    imageUrl: [defaultRequiredRule],
    position: [defaultRequiredRule]
  };
});

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

// 状态选项
const statusOptions = [
  { label: '启用', value: 1 },
  { label: '禁用', value: 0 }
];

async function handleInitModel() {
  Object.assign(model, createDefaultModel());

  if (props.operateType === 'edit' && props.rowData?.id) {
    try {
      const { data: bannerDetail, error } = await fetchGetBannerById(props.rowData.id);
      
      if (error) {
        window.$message?.error(`获取轮播图详情失败: ${error}`);
        return;
      }
      
      if (bannerDetail) {
        // 安全的时间字段处理
        const processedData = {
          ...bannerDetail,
          startTime: bannerDetail.startTime ? dayjs(bannerDetail.startTime) : null,
          endTime: bannerDetail.endTime ? dayjs(bannerDetail.endTime) : null
        };
        Object.assign(model, processedData);
      } else {
        window.$message?.error('获取轮播图详情失败：数据为空');
      }
    } catch (error) {
      console.error('获取轮播图详情失败:', error);
      window.$message?.error('获取轮播图详情失败');
    }
  }
}

async function handleSubmit() {
  try {
    await validate();

    // 安全的时间字段格式化
    const submitData = {
      ...model,
      startTime: model.startTime && dayjs.isDayjs(model.startTime) 
        ? model.startTime.format('YYYY-MM-DD HH:mm:ss') 
        : (model.startTime || ''),
      endTime: model.endTime && dayjs.isDayjs(model.endTime) 
        ? model.endTime.format('YYYY-MM-DD HH:mm:ss') 
        : (model.endTime || '')
    };

    let request;
    const isAdd = props.operateType === 'add';
    const bannerId = props.rowData?.id;

    if (isAdd) {
      request = fetchAddBanner(submitData);
    } else {
      if (!bannerId) {
        window.$message?.error('编辑失败：缺少轮播图ID');
        return;
      }
      request = fetchUpdateBanner({ ...submitData, id: bannerId });
    }

    const { error } = await request;

    if (!error) {
      window.$message?.success(isAdd ? '新增轮播图成功' : '编辑轮播图成功');
      closeDrawer();
      emit('submitted');
    } else {
      window.$message?.error(`操作失败: ${error}`);
    }
  } catch (error) {
    console.error('提交失败:', error);
    window.$message?.error(`提交失败: ${error?.message || '未知错误'}`);
  }
}

function closeDrawer() {
  visible.value = false;
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
      <AFormItem label="标题" name="title">
        <AInput v-model:value="model.title" placeholder="请输入轮播图标题" />
      </AFormItem>
      <AFormItem label="类型" name="type">
        <ASelect v-model:value="model.type" placeholder="请选择轮播图类型" :options="bannerTypeOptions" />
      </AFormItem>
      <AFormItem label="图片URL" name="imageUrl">
        <AInput v-model:value="model.imageUrl" placeholder="请输入图片URL" />
      </AFormItem>
      <AFormItem label="跳转链接" name="link">
        <AInput v-model:value="model.link" placeholder="请输入跳转链接" />
      </AFormItem>
      <AFormItem label="展示位置" name="position">
        <ASelect v-model:value="model.position" placeholder="请选择展示位置" :options="positionOptions" />
      </AFormItem>
      <AFormItem label="排序值" name="sort">
        <AInputNumber v-model:value="model.sort" placeholder="请输入排序值" :min="1" style="width: 100%" />
      </AFormItem>
      <AFormItem label="状态" name="status">
        <ARadioGroup v-model:value="model.status" :options="statusOptions" />
      </AFormItem>
      <AFormItem label="开始时间" name="startTime">
        <ADatePicker 
          v-model:value="model.startTime" 
          placeholder="请选择开始时间" 
          show-time 
          format="YYYY-MM-DD HH:mm:ss"
          value-format="YYYY-MM-DD HH:mm:ss"
          style="width: 100%" 
        />
      </AFormItem>
      <AFormItem label="结束时间" name="endTime">
        <ADatePicker 
          v-model:value="model.endTime" 
          placeholder="请选择结束时间" 
          show-time 
          format="YYYY-MM-DD HH:mm:ss"
          value-format="YYYY-MM-DD HH:mm:ss"
          style="width: 100%" 
        />
      </AFormItem>
      <AFormItem label="备注" name="remark">
        <ATextarea v-model:value="model.remark" placeholder="请输入备注" :rows="3" />
      </AFormItem>
    </AForm>
    <template #footer>
      <div class="flex-y-center justify-end gap-12px">
        <AButton @click="closeDrawer">取消</AButton>
        <AButton type="primary" :loading="false" @click="handleSubmit">确认</AButton>
      </div>
    </template>
  </ADrawer>
</template>

<style scoped></style>
