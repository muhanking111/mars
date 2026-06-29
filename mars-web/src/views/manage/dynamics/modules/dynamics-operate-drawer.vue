<template>
  <ADrawer
    v-model:open="drawerVisible"
    :title="title"
    :width="600"
    :body-style="{ paddingRight: '20px' }"
    :footer-style="{ textAlign: 'right' }"
  >
    <AForm ref="formRef" :model="model" :rules="rules" :label-col="{ span: 6 }" :wrapper-col="{ span: 18 }">
      <AFormItem label="帖子标题" name="title">
        <AInput v-model:value="model.title" placeholder="请输入帖子标题" />
      </AFormItem>
      <AFormItem label="帖子内容" name="content">
        <ATextarea
          v-model:value="model.content"
          :rows="4"
          placeholder="请输入帖子内容"
        />
      </AFormItem>
      <AFormItem label="帖子类型" name="postType">
        <ASelect v-model:value="model.postType" placeholder="请选择帖子类型" :options="postTypeOptions" @change="handlePostTypeChange" />
      </AFormItem>
      
      <!-- 添加话题选择 -->
      <AFormItem label="选择话题" name="topicIds">
        <ASelect
          v-model:value="model.topicIds"
          mode="multiple"
          placeholder="请选择至少一个话题"
          :options="topicOptions"
          :loading="topicLoading"
          show-search
          :filter-option="filterTopicOption"
        />
      </AFormItem>
      
      <!-- 图片上传 -->
      <AFormItem v-if="model.postType === 1" label="图片" name="images">
        <div class="upload-container">
          <AUpload
            v-model:file-list="imageFileList"
            list-type="picture-card"
            :before-upload="beforeImageUpload"
            :custom-request="handleImageUpload"
            :on-remove="handleImageRemove"
            :multiple="true"
            :max-count="9"
            accept="image/*"
          >
            <div v-if="imageFileList.length < 9">
              <PlusOutlined />
              <div style="margin-top: 8px">上传图片</div>
            </div>
          </AUpload>
          <div class="upload-tip">支持 JPG、PNG、GIF 格式，单张图片不超过 5MB，最多上传 9 张</div>
        </div>
      </AFormItem>
      
      <!-- 视频上传 -->
      <AFormItem v-if="model.postType === 2" label="视频" name="video">
        <div class="upload-container">
          <AUpload
            v-model:file-list="videoFileList"
            list-type="picture-card"
            :before-upload="beforeVideoUpload"
            :custom-request="handleVideoUpload"
            :on-remove="handleVideoRemove"
            :max-count="1"
            accept="video/*"
          >
            <div v-if="videoFileList.length === 0">
              <VideoCameraOutlined />
              <div style="margin-top: 8px">上传视频</div>
            </div>
          </AUpload>
          <div class="upload-tip">支持 MP4、AVI、MOV 格式，视频大小不超过 100MB</div>
        </div>
      </AFormItem>
      
      <AFormItem label="是否置顶" name="isTop">
        <ASwitch v-model:checked="model.isTop" :checked-value="1" :unchecked-value="0" />
      </AFormItem>
      <AFormItem label="是否热门" name="isHot">
        <ASwitch v-model:checked="model.isHot" :checked-value="1" :unchecked-value="0" />
      </AFormItem>
      <AFormItem label="是否推荐" name="isRecommend">
        <ASwitch v-model:checked="model.isRecommend" :checked-value="1" :unchecked-value="0" />
      </AFormItem>
      <AFormItem label="状态" name="status">
        <ARadioGroup v-model:value="model.status">
          <ARadio :value="1">启用</ARadio>
          <ARadio :value="0">禁用</ARadio>
        </ARadioGroup>
      </AFormItem>
      <AFormItem label="审核状态" name="auditStatus">
        <ASelect v-model:value="model.auditStatus" placeholder="请选择审核状态" :options="auditStatusOptions" />
      </AFormItem>
      <AFormItem v-if="model.auditStatus === 2" label="审核备注" name="auditRemark">
        <ATextarea
          v-model:value="model.auditRemark"
          :rows="3"
          placeholder="请输入审核备注"
        />
      </AFormItem>
    </AForm>
    <template #footer>
      <div class="flex-y-center justify-end gap-12px">
        <AButton @click="closeDrawer">取消</AButton>
        <AButton type="primary" :loading="submitLoading" @click="handleSubmit">确定</AButton>
      </div>
    </template>
  </ADrawer>
</template>

<script setup lang="ts">
import { computed, reactive, ref, watch, onMounted } from 'vue';
import { PlusOutlined, VideoCameraOutlined } from '@ant-design/icons-vue';
import type { UploadFile, UploadProps } from 'ant-design-vue';
import { useAntdForm } from '@/hooks/common/form';
import { fetchAddPost, fetchUpdatePost } from '@/service/api/post-manage';
import { fetchGetAllTopics } from '@/service/api/topic-manage';
import { request } from '@/service/request';

export interface Props {
  /** 弹窗可见性 */
  visible: boolean;
  /** 弹窗类型 add: 新增 edit: 编辑 */
  operateType: AntDesign.TableOperateType;
  /** 编辑的表格行数据 */
  rowData?: Api.PostManage.Post | null;
}

export type OperateType = NonNullable<Props['operateType']>;

defineOptions({
  name: 'DynamicsOperateDrawer'
});

const props = withDefaults(defineProps<Props>(), {
  rowData: null
});

interface Emits {
  (e: 'submitted'): void;
}

const emit = defineEmits<Emits>();

const drawerVisible = defineModel<boolean>('visible', {
  default: false
});

const title = computed(() => {
  const titles: Record<OperateType, string> = {
    add: '添加动态',
    edit: '编辑动态'
  };
  return titles[props.operateType];
});

const { formRef, validate, resetFields } = useAntdForm();

const model: Api.PostManage.Post = reactive(createDefaultModel());
const submitLoading = ref(false);
const imageFileList = ref<UploadFile[]>([]);
const videoFileList = ref<UploadFile[]>([]);
const uploadedImages = ref<string[]>([]);
const uploadedVideo = ref<string>('');

// 添加话题相关的响应式数据
const topicOptions = ref<Array<{ label: string; value: number }>>([]);
const topicLoading = ref(false);

function createDefaultModel(): Api.PostManage.Post {
  return {
    title: '',
    content: '',
    postType: 1,
    topicIds: [],
    isTop: 0,
    isHot: 0,
    isRecommend: 0,
    status: 0,        // 修改为0（草稿状态）
    auditStatus: 0,
    auditRemark: '',
    images: '',
    video: ''
  };
}

// 帖子类型选项
const postTypeOptions = [
  { label: '图文帖子', value: 1 },
  { label: '视频帖子', value: 2 }
];

// 审核状态选项
const auditStatusOptions = [
  { label: '待审核', value: 0 },
  { label: '审核通过', value: 1 },
  { label: '审核拒绝', value: 2 }
];

// 修改验证规则，添加话题验证
type RuleKey = Extract<keyof Api.PostManage.Post, 'title' | 'content' | 'postType' | 'topicIds'>;

const rules = computed<Record<RuleKey, App.Global.FormRule[]>>(() => {
  const baseRules = {
    title: [
      {
        required: true,
        message: '请输入帖子标题',
        trigger: 'blur'
      }
    ],
    content: [
      {
        required: true,
        message: '请输入帖子内容',
        trigger: 'blur'
      }
    ],
    postType: [
      {
        required: true,
        message: '请选择帖子类型',
        trigger: 'change'
      }
    ],
    topicIds: [
      {
        required: true,
        message: '请选择至少一个话题',
        trigger: 'change',
        validator: (rule: any, value: any) => {
          if (!value || value.length === 0) {
            return Promise.reject('请选择至少一个话题');
          }
          return Promise.resolve();
        }
      }
    ]
  };
  return baseRules;
});

// 帖子类型改变处理
function handlePostTypeChange(value: number) {
  // 清空上传的文件
  if (value === 1) {
    // 切换到图文帖子，清空视频
    videoFileList.value = [];
    uploadedVideo.value = '';
  } else if (value === 2) {
    // 切换到视频帖子，清空图片
    imageFileList.value = [];
    uploadedImages.value = [];
  }
}

// 图片上传前验证
const beforeImageUpload: UploadProps['beforeUpload'] = (file) => {
  const isJpgOrPng = file.type === 'image/jpeg' || file.type === 'image/png' || file.type === 'image/gif';
  if (!isJpgOrPng) {
    window.$message?.error('只能上传 JPG/PNG/GIF 格式的图片!');
    return false;
  }
  const isLt5M = file.size / 1024 / 1024 < 5;
  if (!isLt5M) {
    window.$message?.error('图片大小不能超过 5MB!');
    return false;
  }
  return true;
};

// 视频上传前验证
const beforeVideoUpload: UploadProps['beforeUpload'] = (file) => {
  const isVideo = file.type.startsWith('video/');
  if (!isVideo) {
    window.$message?.error('只能上传视频文件!');
    return false;
  }
  const isLt100M = file.size / 1024 / 1024 < 100;
  if (!isLt100M) {
    window.$message?.error('视频大小不能超过 100MB!');
    return false;
  }
  return true;
};

// 自定义图片上传
const handleImageUpload: UploadProps['customRequest'] = async (options) => {
  const { file, onSuccess, onError } = options;
  
  try {
    const formData = new FormData();
    formData.append('file', file);
    
    const response = await request({
      url: '/file/upload', // 修改：移除 /api 前缀
      method: 'post',
      data: formData,
      headers: {
        'Content-Type': 'multipart/form-data'
      }
    });
    
    if (response.data && response.data.url) {
      uploadedImages.value.push(response.data.url);
      onSuccess?.(response.data);
      window.$message?.success('图片上传成功');
    } else {
      throw new Error('上传失败');
    }
  } catch (error) {
    console.error('图片上传失败:', error);
    onError?.(error as Error);
    window.$message?.error('图片上传失败');
  }
};

// 自定义视频上传
const handleVideoUpload: UploadProps['customRequest'] = async (options) => {
  const { file, onSuccess, onError } = options;
  
  try {
    const formData = new FormData();
    formData.append('file', file);
    
    const response = await request({
      url: '/file/upload', // 修改：移除 /api 前缀
      method: 'post',
      data: formData,
      headers: {
        'Content-Type': 'multipart/form-data'
      }
    });
    
    if (response.data && response.data.url) {
      uploadedVideo.value = response.data.url;
      onSuccess?.(response.data);
      window.$message?.success('视频上传成功');
    } else {
      throw new Error('上传失败');
    }
  } catch (error) {
    console.error('视频上传失败:', error);
    onError?.(error as Error);
    window.$message?.error('视频上传失败');
  }
};

// 移除图片
const handleImageRemove: UploadProps['onRemove'] = (file) => {
  const index = imageFileList.value.findIndex(item => item.uid === file.uid);
  if (index > -1) {
    uploadedImages.value.splice(index, 1);
  }
};

// 移除视频
const handleVideoRemove: UploadProps['onRemove'] = () => {
  uploadedVideo.value = '';
};

function handleUpdateModelWhenEdit() {
  if (props.operateType === 'add') {
    Object.assign(model, createDefaultModel());
    imageFileList.value = [];
    videoFileList.value = [];
    uploadedImages.value = [];
    uploadedVideo.value = '';
    return;
  }

  if (props.operateType === 'edit' && props.rowData) {
    Object.assign(model, props.rowData);
    
    // 处理已有的图片数据
    if (model.images) {
      try {
        const images = JSON.parse(model.images);
        uploadedImages.value = Array.isArray(images) ? images : [];
        imageFileList.value = uploadedImages.value.map((url, index) => ({
          uid: `image-${index}`,
          name: `image-${index}`,
          status: 'done',
          url
        }));
      } catch (error) {
        console.error('解析图片数据失败:', error);
        uploadedImages.value = [];
        imageFileList.value = [];
      }
    }
    
    // 处理已有的视频数据
    if (model.video) {
      uploadedVideo.value = model.video;
      videoFileList.value = [{
        uid: 'video-1',
        name: 'video',
        status: 'done',
        url: model.video
      }];
    }
  }
}

// 添加获取话题列表的函数
async function loadTopics() {
  try {
    topicLoading.value = true;
    const { data } = await fetchGetAllTopics();
    if (data) {
      topicOptions.value = data
        .filter(topic => topic.status === 1) // 只显示启用的话题
        .map(topic => ({
          label: topic.name || '',
          value: topic.id || 0
        }));
    }
  } catch (error) {
    console.error('获取话题列表失败:', error);
    window.$message?.error('获取话题列表失败');
  } finally {
    topicLoading.value = false;
  }
}

// 添加话题搜索过滤函数
function filterTopicOption(input: string, option: any) {
  return option.label.toLowerCase().includes(input.toLowerCase());
}

// 在组件挂载时加载话题列表
onMounted(() => {
  loadTopics();
});

function closeDrawer() {
  drawerVisible.value = false;
}

// 修改handleSubmit函数，确保包含topicIds
async function handleSubmit() {
  try {
    await validate();
    
    // 验证话题选择
    if (!model.topicIds || model.topicIds.length === 0) {
      window.$message?.error('请选择至少一个话题');
      return;
    }
    
    // 验证媒体文件
    if (model.postType === 1 && uploadedImages.value.length === 0) {
      window.$message?.error('图文帖子至少需要上传一张图片');
      return;
    }
    
    if (model.postType === 2 && !uploadedVideo.value) {
      window.$message?.error('视频帖子需要上传视频');
      return;
    }
    
    submitLoading.value = true;
    
    // 准备提交数据
    const submitData = {
      ...model,
      topicIds: model.topicIds, // 确保包含话题ID
      imgs: model.postType === 1 ? uploadedImages.value.map(url => ({
        url: url,
        status: 'success'
      })) : [],
      video: model.postType === 2 ? uploadedVideo.value : ''
    };
    
    // 移除原来的 images 字段
    delete submitData.images;
    
    const functions: Record<OperateType, () => Promise<any>> = {
      add: () => fetchAddPost(submitData),
      edit: () => fetchUpdatePost(submitData)
    };
    
    await functions[props.operateType]();
    window.$message?.success(`${title.value}成功!`);
    closeDrawer();
    emit('submitted');
  } catch (error) {
    console.error('提交失败:', error);
    window.$message?.error('提交失败，请重试');
  } finally {
    submitLoading.value = false;
  }
}

watch(drawerVisible, () => {
  if (drawerVisible.value) {
    resetFields();
    handleUpdateModelWhenEdit();
  }
});
</script>

<style scoped>
.upload-container {
  width: 100%;
}

.upload-tip {
  margin-top: 8px;
  color: #999;
  font-size: 12px;
  line-height: 1.4;
}

:deep(.ant-upload-select-picture-card) {
  width: 104px;
  height: 104px;
}

:deep(.ant-upload-list-picture-card .ant-upload-list-item) {
  width: 104px;
  height: 104px;
}

:deep(.ant-upload-list-picture-card .ant-upload-list-item-thumbnail img) {
  width: 100%;
  height: 100%;
  object-fit: cover;
}
</style>

