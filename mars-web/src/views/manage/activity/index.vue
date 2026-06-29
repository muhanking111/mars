<script setup lang="tsx">
import { ref, onMounted } from 'vue';
import { Card as ACard, Table as ATable, Button, Modal, Popconfirm, Tag, Select, Input } from 'ant-design-vue';
import { useTable, useTableOperate } from '@/hooks/common/table';
import {
  fetchDeleteActivity,
  fetchDeleteActivities,
  fetchGetActivityList,
  fetchAuditActivity
} from '@/service/api/activity-manage';
import { fetchGetAllActivityCategories } from '@/service/api/activity-category-manage';
import { $t } from '@/locales';
import { enableStatusRecord } from '@/constants/business';
import TableHeaderOperation from '@/components/advanced/table-header-operation.vue';
import ActivityOperateDrawer from './modules/activity-operate-drawer.vue';
import ActivitySearch from './modules/activity-search.vue';

const wrapperEl = ref<HTMLElement>();

// 活动分类数据
const categoryMap = ref<Map<number, string>>(new Map());

// 活动状态选项
const activityStatusOptions = [
  { label: '草稿', value: 0, color: 'default' },
  { label: '已发布', value: 1, color: 'success' },
  { label: '已取消', value: 2, color: 'error' },
  { label: '已结束', value: 3, color: 'default' },
  { label: '审核中', value: 4, color: 'processing' },
  { label: '审核拒绝', value: 5, color: 'error' }
];

// 审核状态选项
const auditStatusOptions = [
  { label: '待审核', value: 0, color: 'default' },
  { label: '审核通过', value: 1, color: 'success' },
  { label: '审核拒绝', value: 2, color: 'error' }
];

// 活动类型选项
const activityTypeOptions = [
  { label: '线下活动', value: 1 },
  { label: '线上活动', value: 2 },
  { label: '混合活动', value: 3 }
];

// 获取活动分类数据
async function loadCategories() {
  try {
    const { data, error } = await fetchGetAllActivityCategories();
    if (!error && data?.records) {
      const map = new Map<number, string>();
      data.records.forEach(category => {
        if (category.id && category.name) {
          map.set(category.id, category.name);
        }
      });
      categoryMap.value = map;
    }
  } catch (error) {
    console.error('加载活动分类失败:', error);
  }
}

// 获取分类名称
function getCategoryName(categoryId: number): string {
  return categoryMap.value.get(categoryId) || '未知分类';
}

// 审核相关状态
const auditModalVisible = ref(false);
const currentAuditRecord = ref<any>(null);
const auditForm = ref({
  auditStatus: 1, // 默认审核通过
  auditReason: ''
});

const { columns, columnChecks, data, getData, loading, mobilePagination, updatePagination, searchParams } = useTable({
  apiFn: fetchGetActivityList,
  apiParams: {
    current: 1,
    size: 10,
    title: null,
    categoryId: null,
    status: null,
    auditStatus: null,
    activityType: null,
    isTop: null,
    isHot: null,
    isRecommend: null
  },
  columns: () => [
    {
      key: 'selection',
      title: '',
      align: 'center',
      type: 'selection',
      width: 48,
      fixed: 'left'
    },
    {
      key: 'index',
      dataIndex: 'index',
      title: '序号',
      align: 'center',
      customRender: ({ index }) => index + 1,
      width: 80
    },
    {
      key: 'title',
      dataIndex: 'title',
      title: '活动标题',
      align: 'center',
      width: 200,
      ellipsis: true
    },
    {
      key: 'categoryId',
      dataIndex: 'categoryId',
      title: '活动分类',
      align: 'center',
      width: 120,
      customRender: ({ record }) => {
        return getCategoryName(record.categoryId);
      }
    },
    {
      key: 'location',
      dataIndex: 'location',
      title: '活动地点',
      align: 'center',
      width: 150,
      ellipsis: true
    },
    {
      key: 'startTime',
      dataIndex: 'startTime',
      title: '开始时间',
      align: 'center',
      width: 180
    },
    {
      key: 'endTime',
      dataIndex: 'endTime',
      title: '结束时间',
      align: 'center',
      width: 180
    },
    {
      key: 'maxParticipants',
      dataIndex: 'maxParticipants',
      title: '最大人数',
      align: 'center',
      width: 100
    },
    {
      key: 'currentParticipants',
      dataIndex: 'currentParticipants',
      title: '当前人数',
      align: 'center',
      width: 100
    },
    {
      key: 'price',
      dataIndex: 'price',
      title: '价格',
      align: 'center',
      width: 100,
      customRender: ({ record }) => {
        return record.isFree === 1 ? '免费' : `¥${record.price || 0}`;
      }
    },
    {
      key: 'activityType',
      dataIndex: 'activityType',
      title: '活动类型',
      align: 'center',
      width: 100,
      customRender: ({ record }) => {
        const option = activityTypeOptions.find(opt => opt.value === record.activityType);
        return option ? option.label : '-';
      }
    },
    {
      key: 'isTop',
      dataIndex: 'isTop',
      title: '置顶',
      align: 'center',
      width: 80,
      customRender: ({ record }) => {
        return (
          <Tag color={record.isTop === 1 ? 'red' : 'default'}>
            {record.isTop === 1 ? '是' : '否'}
          </Tag>
        );
      }
    },
    {
      key: 'isHot',
      dataIndex: 'isHot',
      title: '热门',
      align: 'center',
      width: 80,
      customRender: ({ record }) => {
        return (
          <Tag color={record.isHot === 1 ? 'orange' : 'default'}>
            {record.isHot === 1 ? '是' : '否'}
          </Tag>
        );
      }
    },
    {
      key: 'status',
      dataIndex: 'status',
      title: '状态',
      align: 'center',
      width: 100,
      customRender: ({ record }) => {
        const option = activityStatusOptions.find(opt => opt.value === record.status);
        return option ? <Tag color={option.color}>{option.label}</Tag> : '-';
      }
    },
    {
      key: 'auditStatus',
      dataIndex: 'auditStatus',
      title: '审核状态',
      align: 'center',
      width: 100,
      customRender: ({ record }) => {
        const option = auditStatusOptions.find(opt => opt.value === record.auditStatus);
        return option ? <Tag color={option.color}>{option.label}</Tag> : '-';
      }
    },
    {
      key: 'createTime',
      dataIndex: 'createTime',
      title: '创建时间',
      align: 'center',
      width: 180
    },
    {
      key: 'operate',
      title: '操作',
      align: 'center',
      width: 280,
      customRender: ({ record }) => (
        <div class="flex-center gap-8px">
          <Button type="primary" ghost size="small" onClick={() => edit(record.id)}>
            编辑
          </Button>
          {record.auditStatus === 0 && (
            <Button type="primary" size="small" onClick={() => handleAudit(record)}>
              审核
            </Button>
          )}
          <Popconfirm title="确定要删除这个活动吗？" onConfirm={() => handleDelete(record.id)}>
            <Button danger size="small">
              删除
            </Button>
          </Popconfirm>
        </div>
      )
    }
  ]
});

const {
  drawerVisible,
  operateType,
  editingData,
  handleAdd,
  handleEdit,
  checkedRowKeys,
  onBatchDeleted,
  onDeleted,
  rowSelection
} = useTableOperate(data, getData);

async function handleBatchDelete() {
  try {
    // 先检查是否有选择记录
    if (checkedRowKeys.value.length === 0) {
      window.$message?.warning('请选择要删除的活动');
      return;
    }

    // 使用ant-design-vue的Modal.confirm替代
    Modal.confirm({
      title: '批量删除活动',
      content: `确定要删除选中的 ${checkedRowKeys.value.length} 个活动吗？删除后无法恢复！`,
      okText: '确定',
      cancelText: '取消',
      async onOk() {
        // 发送请求
        const { error } = await fetchDeleteActivities(checkedRowKeys.value);
        if (!error) {
          window.$message?.success('批量删除成功');
          onBatchDeleted();
        } else {
          window.$message?.error(`批量删除失败: ${error}`);
        }
      }
    });
  } catch (e) {
    window.$message?.error(`操作失败: ${e.message}`);
  }
}

async function handleDelete(id: number) {
  try {
    // 发送请求
    const { error } = await fetchDeleteActivity(id);
    if (!error) {
      window.$message?.success('删除成功');
      onDeleted();
    } else {
      window.$message?.error(`删除失败: ${error}`);
    }
  } catch (e) {
    window.$message?.error(`操作失败: ${e.message}`);
  }
}

function edit(id: number) {
  handleEdit(id);
}

// 处理审核
function handleAudit(record: any) {
  currentAuditRecord.value = record;
  auditForm.value = {
    auditStatus: 1,
    auditReason: ''
  };
  auditModalVisible.value = true;
}

// 提交审核
async function submitAudit() {
  try {
    if (!currentAuditRecord.value) return;

    const { error } = await fetchAuditActivity(
      currentAuditRecord.value.id,
      auditForm.value.auditStatus,
      auditForm.value.auditReason
    );

    if (!error) {
      window.$message?.success('审核成功');
      auditModalVisible.value = false;
      getData(); // 刷新列表
    } else {
      window.$message?.error(`审核失败: ${error}`);
    }
  } catch (e) {
    window.$message?.error(`操作失败: ${e.message}`);
  }
}

// 取消审核
function cancelAudit() {
  auditModalVisible.value = false;
  currentAuditRecord.value = null;
}

// 组件挂载时加载分类数据
onMounted(() => {
  loadCategories();
});
</script>

<template>
  <div ref="wrapperEl" class="flex-col-stretch gap-16px overflow-hidden lt-sm:overflow-auto">
    <ActivitySearch v-model:model="searchParams" @reset="getData" @search="getData" />
    <ACard title="活动列表" :bordered="false" :body-style="{ paddingTop: '0px' }" class="sm:flex-1-hidden card-wrapper">
      <template #extra>
        <TableHeaderOperation
          v-model:columns="columnChecks"
          :disabled-delete="checkedRowKeys.length === 0"
          :loading="loading"
          @add="handleAdd"
          @delete="handleBatchDelete"
          @refresh="getData"
        />
      </template>
      <ATable
        :columns="columns"
        :data-source="data"
        size="small"
        :scroll="{ x: 'max-content', y: 'calc(100vh - 320px)' }"
        :loading="loading"
        row-key="id"
        :row-selection="rowSelection"
        :pagination="mobilePagination"
        class="h-full"
      />
    </ACard>

    <!-- 活动操作抽屉 -->
    <ActivityOperateDrawer
      v-model:visible="drawerVisible"
      :operate-type="operateType"
      :row-data="editingData"
      @submitted="getData"
    />

    <!-- 审核弹窗 -->
    <Modal
      v-model:open="auditModalVisible"
      title="审核活动"
      @ok="submitAudit"
      @cancel="cancelAudit"
      :ok-text="'确定'"
      :cancel-text="'取消'"
    >
      <div class="space-y-4">
        <div>
          <label class="block text-sm font-medium mb-2">审核状态</label>
          <Select v-model:value="auditForm.auditStatus" class="w-full">
            <Select.Option :value="1">审核通过</Select.Option>
            <Select.Option :value="2">审核拒绝</Select.Option>
          </Select>
        </div>
        <div>
          <label class="block text-sm font-medium mb-2">审核意见</label>
          <Input.TextArea
            v-model:value="auditForm.auditReason"
            :rows="4"
            placeholder="请输入审核意见（审核拒绝时必填）"
          />
        </div>
      </div>
    </Modal>
  </div>
</template>

<style scoped></style>
