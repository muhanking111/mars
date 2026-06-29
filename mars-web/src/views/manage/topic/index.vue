<script setup lang="tsx">
import { ref } from 'vue';
import { Card as ACard, Table as ATable, Button, Modal, Popconfirm, Tag } from 'ant-design-vue';
import { useTable, useTableOperate } from '@/hooks/common/table';
import {
  fetchDeleteTopic,
  fetchDeleteTopics,
  fetchGetTopicList,
  fetchSetTopicHot,
  fetchSetTopicOfficial
} from '@/service/api';
import { $t } from '@/locales';
import TableHeaderOperation from '@/components/advanced/table-header-operation.vue';
import TopicOperateDrawer from './modules/topic-operate-drawer.vue';
import TopicSearch from './modules/topic-search.vue';

const wrapperEl = ref<HTMLElement>();

const { columns, columnChecks, data, getData, loading, mobilePagination, updatePagination, searchParams } = useTable({
  apiFn: fetchGetTopicList,
  apiParams: {
    pageNumber: 1,
    pageSize: 10,
    name: null,
    category: null,
    status: null,
    isHot: null,
    isOfficial: null
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
      customRender: ({ index }) => index + 1
    },
    {
      key: 'name',
      dataIndex: 'name',
      title: '话题名称',
      align: 'center',
      customRender: ({ record }) => (
        <div class="flex items-center gap-8px">
          {record.color && (
            <div
              class="w-16px h-16px rounded-full"
              style={{ backgroundColor: record.color }}
            />
          )}
          <span>{record.name}</span>
        </div>
      )
    },
    {
      key: 'description',
      dataIndex: 'description',
      title: '话题描述',
      align: 'center',
      ellipsis: true
    },
    {
      key: 'category',
      dataIndex: 'category',
      title: '分类',
      align: 'center',
      customRender: ({ record }) => {
        const categoryMap: Record<string, string> = {
          travel: '旅行',
          food: '美食',
          culture: '文化',
          outdoor: '户外',
          photography: '摄影',
          general: '其他'
        };
        return categoryMap[record.category] || record.category;
      }
    },
    {
      key: 'postsCount',
      dataIndex: 'postsCount',
      title: '帖子数',
      align: 'center'
    },
    {
      key: 'followersCount',
      dataIndex: 'followersCount',
      title: '关注数',
      align: 'center'
    },
    {
      key: 'isHot',
      dataIndex: 'isHot',
      title: '是否热门',
      align: 'center',
      customRender: ({ record }) => (
        <Tag color={record.isHot === 1 ? 'red' : 'default'}>
          {record.isHot === 1 ? '热门' : '普通'}
        </Tag>
      )
    },
    {
      key: 'isOfficial',
      dataIndex: 'isOfficial',
      title: '是否官方',
      align: 'center',
      customRender: ({ record }) => (
        <Tag color={record.isOfficial === 1 ? 'blue' : 'default'}>
          {record.isOfficial === 1 ? '官方' : '用户'}
        </Tag>
      )
    },
    {
      key: 'status',
      dataIndex: 'status',
      title: '状态',
      align: 'center',
      customRender: ({ record }) => (
        <Tag color={record.status === 1 ? 'success' : 'error'}>
          {record.status === 1 ? '启用' : '禁用'}
        </Tag>
      )
    },
    {
      key: 'sortOrder',
      dataIndex: 'sortOrder',
      title: '排序',
      align: 'center'
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
      customRender: ({ record }) => (
        <div class="flex-center gap-8px">
          <Button type="primary" ghost size="small" onClick={() => edit(record.id)}>
            编辑
          </Button>
          <Button
            type={record.isHot === 1 ? 'default' : 'primary'}
            size="small"
            onClick={() => toggleHot(record.id, record.isHot)}
          >
            {record.isHot === 1 ? '取消热门' : '设为热门'}
          </Button>
          <Button
            type={record.isOfficial === 1 ? 'default' : 'primary'}
            size="small"
            onClick={() => toggleOfficial(record.id, record.isOfficial)}
          >
            {record.isOfficial === 1 ? '取消官方' : '设为官方'}
          </Button>
          <Popconfirm title="确定要删除这个话题吗？" onConfirm={() => handleDelete(record.id)}>
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
      window.$message?.warning('请选择要删除的话题');
      return;
    }

    // 使用ant-design-vue的Modal.confirm替代
    Modal.confirm({
      title: '批量删除话题',
      content: `确定要删除选中的 ${checkedRowKeys.value.length} 个话题吗？删除后无法恢复！`,
      okText: '确定',
      cancelText: '取消',
      async onOk() {
        // 发送请求
        const { error } = await fetchDeleteTopics(checkedRowKeys.value);
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
    const { error } = await fetchDeleteTopic(id);
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

async function toggleHot(id: number, isHot: number) {
  const newIsHot = isHot === 1 ? 0 : 1;
  const { error } = await fetchSetTopicHot(id, newIsHot);
  if (!error) {
    window.$message?.success('热门状态修改成功');
    getData();
  }
}

async function toggleOfficial(id: number, isOfficial: number) {
  const newIsOfficial = isOfficial === 1 ? 0 : 1;
  const { error } = await fetchSetTopicOfficial(id, newIsOfficial);
  if (!error) {
    window.$message?.success('官方状态修改成功');
    getData();
  }
}

function edit(id: number) {
  handleEdit(id);
}

// 处理表格变化事件（分页、排序、筛选）
function handleTableChange(paginationInfo: any) {
  // 处理分页变化（包括页码和分页大小）
  if (paginationInfo) {
    const { current, pageSize } = paginationInfo;

    // 处理分页大小变化
    updatePagination({
      current: current || 1,
      pageSize: pageSize || mobilePagination.value.pageSize
    });
    // 更新分页参数
    searchParams.pageNumber = current || 1;
    searchParams.pageSize = pageSize || mobilePagination.value.pageSize;

    // 刷新数据
    getData();
  }
}
</script>

<template>
  <div ref="wrapperEl" class="flex-col-stretch gap-16px overflow-hidden lt-sm:overflow-auto">
    <TopicSearch v-model:model="searchParams" @reset="getData" @search="getData" />
    <ACard title="话题列表" :bordered="false" :body-style="{ paddingTop: '0px' }" class="sm:flex-1-hidden card-wrapper">
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
        @change="handleTableChange"
      />
    </ACard>
    <TopicOperateDrawer
      v-model:visible="drawerVisible"
      :operate-type="operateType"
      :row-data="editingData"
      @submitted="getData"
    />
  </div>
</template>

<style scoped></style>
