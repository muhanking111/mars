<script setup lang="ts">
import { computed, reactive, ref, watch } from 'vue';
import { useAntdForm, useFormRules } from '@/hooks/common/form';
import { $t } from '@/locales';
import dayjs from 'dayjs';
import { fetchGetActivityById, fetchAddActivity, fetchUpdateActivity } from '@/service/api/activity-manage';
import { fetchGetActivityCategoryList } from '@/service/api/activity-category-manage';

defineOptions({
  name: 'ActivityOperateDrawer'
});

/**
 * the type of operation
 *
 * - add: add activity
 * - edit: edit activity
 */
export type OperateType = 'add' | 'edit';

interface Props {
  /** the type of operation */
  operateType: OperateType;
  /** the edit row data */
  rowData?: any | null;
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
    add: '新增活动',
    edit: '编辑活动'
  };
  return titles[props.operateType];
});

// 活动数据模型
interface ActivityModel {
  id?: number;
  categoryId: number | null;
  title: string;
  subtitle: string;
  description: string;
  coverImage: string;
  images: string;
  location: string;
  address: string;
  latitude: number | null;
  longitude: number | null;
  regionId: number | null;
  startTime: string;
  endTime: string;
  registrationStartTime: string;
  registrationEndTime: string;
  maxParticipants: number | null;
  minParticipants: number | null;
  price: number | null;
  originalPrice: number | null;
  isFree: number;
  activityType: number;
  difficultyLevel: number;
  ageLimitMin: number | null;
  ageLimitMax: number | null;
  genderLimit: number;
  contactPerson: string;
  contactPhone: string;
  contactWechat: string;
  requirements: string;
  includes: string;
  excludes: string;
  notes: string;
  tags: string;
  isTop: number;
  isHot: number;
  isRecommend: number;
  status: number;
  auditStatus: number;
}

const model: ActivityModel = reactive(createDefaultModel());

function createDefaultModel(): ActivityModel {
  return {
    id: undefined, // 显式设置id为undefined
    categoryId: null,
    title: '',
    subtitle: '',
    description: '',
    coverImage: '',
    images: '',
    location: '',
    address: '',
    latitude: null,
    longitude: null,
    regionId: null,
    startTime: '',
    endTime: '',
    registrationStartTime: '',
    registrationEndTime: '',
    maxParticipants: null,
    minParticipants: null,
    price: null,
    originalPrice: null,
    isFree: 0,
    activityType: 1,
    difficultyLevel: 1,
    ageLimitMin: null,
    ageLimitMax: null,
    genderLimit: 0,
    contactPerson: '',
    contactPhone: '',
    contactWechat: '',
    requirements: '',
    includes: '',
    excludes: '',
    notes: '',
    tags: '',
    isTop: 0,
    isHot: 0,
    isRecommend: 0,
    status: 0,
    auditStatus: 0
  };
}

type RuleKey = Extract<keyof ActivityModel, 'title' | 'categoryId' | 'startTime' | 'endTime' | 'contactPhone'>;

const rules = computed<Record<RuleKey, App.Global.FormRule[]>>(() => {
  const { patternRules } = useFormRules();

  return {
    title: [{ required: true, message: '请输入活动标题', trigger: 'blur' }],
    categoryId: [{ required: true, message: '请选择活动分类', trigger: 'change' }],
    startTime: [{ required: true, message: '请选择开始时间', trigger: 'change' }],
    endTime: [{ required: true, message: '请选择结束时间', trigger: 'change' }],
    contactPhone: [patternRules.phone]
  };
});

// 选项数据
const categoryOptions = ref<any[]>([]);

// 活动类型选项
const activityTypeOptions = [
  { label: '线下活动', value: 1 },
  { label: '线上活动', value: 2 },
  { label: '混合活动', value: 3 }
];

// 难度等级选项
const difficultyOptions = [
  { label: '简单', value: 1 },
  { label: '中等', value: 2 },
  { label: '困难', value: 3 },
  { label: '极限', value: 4 }
];

// 性别限制选项
const genderLimitOptions = [
  { label: '不限', value: 0 },
  { label: '仅男性', value: 1 },
  { label: '仅女性', value: 2 }
];

// 是否免费选项
const isFreeOptions = [
  { label: '收费', value: 0 },
  { label: '免费', value: 1 }
];

// 状态选项
const statusOptions = [
  { label: '草稿', value: 0 },
  { label: '已发布', value: 1 },
  { label: '已取消', value: 2 },
  { label: '已结束', value: 3 },
  { label: '审核中', value: 4 },
  { label: '审核拒绝', value: 5 }
];

// 加载分类选项
async function loadCategoryOptions() {
  try {
    // 使用封装的API函数获取分类列表
    const { data: result, error } = await fetchGetActivityCategoryList({
      current: 1,
      size: 100,
      status: 1 // 只获取启用的分类
    });
    
    if (!error && result?.records) {
      categoryOptions.value = result.records.map((item: any) => ({
        label: item.name,
        value: item.id
      }));
    } else {
      console.error('加载分类选项失败:', error);
      window.$message?.error('加载分类选项失败');
    }
  } catch (error) {
    console.error('加载分类选项失败:', error);
    window.$message?.error('加载分类选项失败');
  }
}

async function handleInitModel() {
  Object.assign(model, createDefaultModel());

  if (props.operateType === 'edit' && props.rowData?.id) {
    try {
      // 使用封装的API函数获取活动详情
      const { data: activityDetail, error } = await fetchGetActivityById(props.rowData.id);
      if (!error && activityDetail) {
        // 处理时间字段转换
        const timeFields = ['startTime', 'endTime', 'registrationStartTime', 'registrationEndTime'];
        timeFields.forEach(field => {
          if (activityDetail[field]) {
            activityDetail[field] = dayjs(activityDetail[field]);
          }
        });
        
        Object.assign(model, activityDetail);
      } else {
        console.error('获取活动详情失败:', error);
        window.$message?.error('获取活动详情失败');
      }
    } catch (error) {
      console.error('获取活动详情失败:', error);
      window.$message?.error('获取活动详情失败');
    }
  }
}

async function handleSubmit() {
  await validate();

  try {
    const isAdd = props.operateType === 'add';
    
    // 处理提交数据，将dayjs对象转换为字符串
    const submitData = { ...model };
    const timeFields = ['startTime', 'endTime', 'registrationStartTime', 'registrationEndTime'];
    timeFields.forEach(field => {
      if (submitData[field] && dayjs.isDayjs(submitData[field])) {
        submitData[field] = submitData[field].format('YYYY-MM-DD HH:mm:ss');
      }
    });
    
    // 新增时删除id字段，确保不传递id
    if (isAdd && submitData.id !== undefined) {
      delete submitData.id;
    }
    
    let request;
    if (isAdd) {
      request = fetchAddActivity(submitData);
    } else {
      request = fetchUpdateActivity({ ...submitData, id: props.rowData?.id });
    }

    const { data, error } = await request;
    if (!error) {
      window.$message?.success(isAdd ? '新增活动成功' : '编辑活动成功');
      closeDrawer();
      emit('submitted');
    } else {
      // 处理API返回的错误
      console.error('API错误:', error);
      window.$message?.error(error.message || '操作失败');
    }
  } catch (error) {
    console.error('提交失败:', error);
    window.$message?.error('操作失败');
  }
}

// 添加关闭抽屉函数
function closeDrawer() {
  visible.value = false;
}

watch(visible, () => {
  if (visible.value) {
    handleInitModel();
    resetFields();
    loadCategoryOptions();
  }
});
</script>

<template>
  <ADrawer
    v-model:open="visible"
    :title="title"
    :width="800"
    :body-style="{ paddingRight: '20px' }"
    :footer-style="{ textAlign: 'right' }"
  >
    <AForm ref="formRef" :model="model" :rules="rules" :label-col="{ span: 6 }" :wrapper-col="{ span: 18 }">
      <!-- 基本信息 -->
      <ADivider>基本信息</ADivider>
      
      <AFormItem label="活动分类" name="categoryId">
        <ASelect
          v-model:value="model.categoryId"
          :options="categoryOptions"
          placeholder="请选择活动分类"
        />
      </AFormItem>
      
      <AFormItem label="活动标题" name="title">
        <AInput v-model:value="model.title" placeholder="请输入活动标题" />
      </AFormItem>
      
      <AFormItem label="活动副标题" name="subtitle">
        <AInput v-model:value="model.subtitle" placeholder="请输入活动副标题" />
      </AFormItem>
      
      <AFormItem label="活动描述" name="description">
        <ATextarea v-model:value="model.description" placeholder="请输入活动描述" :rows="3" />
      </AFormItem>
      
      <AFormItem label="封面图片" name="coverImage">
        <AInput v-model:value="model.coverImage" placeholder="请输入封面图片URL" />
      </AFormItem>
      
      <!-- 时间地点信息 -->
      <ADivider>时间地点</ADivider>
      
      <AFormItem label="活动地点" name="location">
        <AInput v-model:value="model.location" placeholder="请输入活动地点" />
      </AFormItem>
      
      <AFormItem label="详细地址" name="address">
        <AInput v-model:value="model.address" placeholder="请输入详细地址" />
      </AFormItem>
      
      <AFormItem label="开始时间" name="startTime">
        <ADatePicker
          v-model:value="model.startTime"
          show-time
          format="YYYY-MM-DD HH:mm:ss"
          placeholder="请选择开始时间"
          class="w-full"
        />
      </AFormItem>
      
      <AFormItem label="结束时间" name="endTime">
        <ADatePicker
          v-model:value="model.endTime"
          show-time
          format="YYYY-MM-DD HH:mm:ss"
          placeholder="请选择结束时间"
          class="w-full"
        />
      </AFormItem>
      
      <AFormItem label="报名开始时间" name="registrationStartTime">
        <ADatePicker
          v-model:value="model.registrationStartTime"
          show-time
          format="YYYY-MM-DD HH:mm:ss"
          placeholder="请选择报名开始时间"
          class="w-full"
        />
      </AFormItem>
      
      <AFormItem label="报名结束时间" name="registrationEndTime">
        <ADatePicker
          v-model:value="model.registrationEndTime"
          show-time
          format="YYYY-MM-DD HH:mm:ss"
          placeholder="请选择报名结束时间"
          class="w-full"
        />
      </AFormItem>
      
      <!-- 参与信息 -->
      <ADivider>参与信息</ADivider>
      
      <AFormItem label="最大参与人数" name="maxParticipants">
        <AInputNumber v-model:value="model.maxParticipants" placeholder="0表示不限制" :min="0" class="w-full" />
      </AFormItem>
      
      <AFormItem label="最小参与人数" name="minParticipants">
        <AInputNumber v-model:value="model.minParticipants" :min="0" class="w-full" />
      </AFormItem>
      
      <AFormItem label="是否免费" name="isFree">
        <ARadioGroup v-model:value="model.isFree" :options="isFreeOptions" />
      </AFormItem>
      
      <AFormItem v-if="model.isFree === 0" label="活动价格" name="price">
        <AInputNumber v-model:value="model.price" :min="0" :precision="2" class="w-full" />
      </AFormItem>
      
      <AFormItem v-if="model.isFree === 0" label="原价" name="originalPrice">
        <AInputNumber v-model:value="model.originalPrice" :min="0" :precision="2" class="w-full" />
      </AFormItem>
      
      <!-- 活动属性 -->
      <ADivider>活动属性</ADivider>
      
      <AFormItem label="活动类型" name="activityType">
        <ARadioGroup v-model:value="model.activityType" :options="activityTypeOptions" />
      </AFormItem>
      
      <AFormItem label="难度等级" name="difficultyLevel">
        <ASelect v-model:value="model.difficultyLevel" :options="difficultyOptions" />
      </AFormItem>
      
      <AFormItem label="年龄限制" name="ageLimit">
        <ARow :gutter="8">
          <ACol :span="12">
            <AInputNumber v-model:value="model.ageLimitMin" placeholder="最小年龄" :min="0" class="w-full" />
          </ACol>
          <ACol :span="12">
            <AInputNumber v-model:value="model.ageLimitMax" placeholder="最大年龄" :min="0" class="w-full" />
          </ACol>
        </ARow>
      </AFormItem>
      
      <AFormItem label="性别限制" name="genderLimit">
        <ARadioGroup v-model:value="model.genderLimit" :options="genderLimitOptions" />
      </AFormItem>
      
      <!-- 联系信息 -->
      <ADivider>联系信息</ADivider>
      
      <AFormItem label="联系人" name="contactPerson">
        <AInput v-model:value="model.contactPerson" placeholder="请输入联系人" />
      </AFormItem>
      
      <AFormItem label="联系电话" name="contactPhone">
        <AInput v-model:value="model.contactPhone" placeholder="请输入联系电话" />
      </AFormItem>
      
      <AFormItem label="微信号" name="contactWechat">
        <AInput v-model:value="model.contactWechat" placeholder="请输入微信号" />
      </AFormItem>
      
      <!-- 其他信息 -->
      <ADivider>其他信息</ADivider>
      
      <AFormItem label="参与要求" name="requirements">
        <ATextarea v-model:value="model.requirements" placeholder="请输入参与要求" :rows="2" />
      </AFormItem>
      
      <AFormItem label="费用包含" name="includes">
        <ATextarea v-model:value="model.includes" placeholder="请输入费用包含内容" :rows="2" />
      </AFormItem>
      
      <AFormItem label="费用不含" name="excludes">
        <ATextarea v-model:value="model.excludes" placeholder="请输入费用不含内容" :rows="2" />
      </AFormItem>
      
      <AFormItem label="注意事项" name="notes">
        <ATextarea v-model:value="model.notes" placeholder="请输入注意事项" :rows="2" />
      </AFormItem>
      
      <AFormItem label="活动标签" name="tags">
        <AInput v-model:value="model.tags" placeholder="请输入活动标签，多个标签用逗号分隔" />
      </AFormItem>
      
      <!-- 状态设置 -->
      <ADivider>状态设置</ADivider>
      
      <AFormItem label="置顶" name="isTop">
        <ASwitch v-model:checked="model.isTop" :checked-value="1" :un-checked-value="0" />
      </AFormItem>
      
      <AFormItem label="热门" name="isHot">
        <ASwitch v-model:checked="model.isHot" :checked-value="1" :un-checked-value="0" />
      </AFormItem>
      
      <AFormItem label="推荐" name="isRecommend">
        <ASwitch v-model:checked="model.isRecommend" :checked-value="1" :un-checked-value="0" />
      </AFormItem>
      
      <AFormItem label="状态" name="status">
        <ASelect v-model:value="model.status" :options="statusOptions" />
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