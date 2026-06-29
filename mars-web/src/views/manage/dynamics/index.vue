<script setup lang="tsx">
import { ref, reactive, onMounted } from 'vue';
import {
  Table,
  Button,
  Space,
  Tag,
  Popconfirm,
  message,
  Tooltip,
  Card as ACard,
  Table as ATable,
  Modal
} from 'ant-design-vue';
import { useTable, useTableOperate } from '@/hooks/common/table';
import {
  fetchDeletePost,
  fetchGetPostList,
  fetchSetPostHot,
  fetchSetPostRecommend,
  fetchSetPostTop
} from '@/service/api/post-manage';
import { $t } from '@/locales';
import TableHeaderOperation from '@/components/advanced/table-header-operation.vue';
import DynamicsOperateDrawer from './modules/dynamics-operate-drawer.vue';
import DynamicsSearch from './modules/dynamics-search.vue';

const wrapperEl = ref<HTMLElement>();

const { columns, columnChecks, data, getData, loading, mobilePagination, updatePagination, searchParams } = useTable({
  apiFn: fetchGetPostList,
  apiParams: {
    pageNumber: 1,
    pageSize: 10,
    keyword: null,
    postType: null,
    isHot: null,
    isRecommend: null,
    status: null,
    auditStatus: null,
    startTime: null,
    endTime: null
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
      width: 60
    },
    {
      key: 'userId',
      dataIndex: 'userId',
      title: '发布用户',
      align: 'center',
      width: 120,
      customRender: ({ record }) => {
        // 这里可以根据userId显示用户名称，如果后端没有返回用户名称的话
        // 可以考虑在API中关联查询用户信息，或者显示用户ID
        return record.userNickname || `用户${record.userId}`;
      }
    },
    {
      key: 'title',
      dataIndex: 'title',
      title: '标题',
      align: 'center',
      ellipsis: true,
      width: 200
    },
    {
      key: 'content',
      dataIndex: 'content',
      title: '内容',
      align: 'center',
      ellipsis: true,
      width: 150,
      customRender: ({ record }) => {
        const content = record.content || '';
        const displayContent = content.length > 20 ? `${content.substring(0, 20)}...` : content;
        
        return (
          <Tooltip 
            title={content} 
            placement="topLeft"
            overlayStyle={{ maxWidth: '400px' }}
          >
            <span style={{ cursor: 'pointer' }}>{displayContent}</span>
          </Tooltip>
        );
      }
    },
    {
      key: 'postType',
      dataIndex: 'postType',
      title: '类型',
      align: 'center',
      width: 80,
      customRender: ({ record }) => {
        const postTypeMap: Record<number, { label: string; color: string }> = {
          1: { label: '图文', color: 'blue' },
          2: { label: '视频', color: 'purple' }
        };
        const postType = postTypeMap[record.postType] || { label: '未知', color: 'default' };
        return <Tag color={postType.color}>{postType.label}</Tag>;
      }
    },
    {
      key: 'likeCount',
      dataIndex: 'likeCount',
      title: '点赞数',
      align: 'center',
      width: 80,
      customRender: ({ record }) => {
        return <span style={{ color: '#ff4d4f' }}>{record.likeCount || 0}</span>;
      }
    },
    {
      key: 'commentCount',
      dataIndex: 'commentCount',
      title: '评论数',
      align: 'center',
      width: 80,
      customRender: ({ record }) => {
        return <span style={{ color: '#1890ff' }}>{record.commentCount || 0}</span>;
      }
    },
    {
      key: 'viewCount',
      dataIndex: 'viewCount',
      title: '浏览数',
      align: 'center',
      width: 80,
      customRender: ({ record }) => {
        return <span style={{ color: '#52c41a' }}>{record.viewCount || 0}</span>;
      }
    },
    {
      key: 'collectCount',
      dataIndex: 'collectCount',
      title: '收藏数',
      align: 'center',
      width: 80,
      customRender: ({ record }) => {
        return <span style={{ color: '#faad14' }}>{record.collectCount || 0}</span>;
      }
    },
    {
      key: 'location',
      dataIndex: 'location',
      title: '位置',
      align: 'center',
      width: 120,
      ellipsis: true
    },
    {
      key: 'isTop',
      dataIndex: 'isTop',
      title: '置顶',
      align: 'center',
      width: 80,
      customRender: ({ record }) => (
        <Tag color={record.isTop === 1 ? 'red' : 'default'}>
          {record.isTop === 1 ? '置顶' : '普通'}
        </Tag>
      )
    },
    {
      key: 'isHot',
      dataIndex: 'isHot',
      title: '热门',
      align: 'center',
      width: 80,
      customRender: ({ record }) => (
        <Tag color={record.isHot === 1 ? 'orange' : 'default'}>
          {record.isHot === 1 ? '热门' : '普通'}
        </Tag>
      )
    },
    {
      key: 'isRecommend',
      dataIndex: 'isRecommend',
      title: '推荐',
      align: 'center',
      width: 80,
      customRender: ({ record }) => (
        <Tag color={record.isRecommend === 1 ? 'green' : 'default'}>
          {record.isRecommend === 1 ? '推荐' : '普通'}
        </Tag>
      )
    },
    {
      key: 'status',
      dataIndex: 'status',
      title: '状态',
      align: 'center',
      width: 80,
      customRender: ({ record }) => (
        <Tag color={record.status === 1 ? 'success' : 'error'}>
          {record.status === 1 ? '启用' : '禁用'}
        </Tag>
      )
    },
    {
      key: 'auditStatus',
      dataIndex: 'auditStatus',
      title: '审核状态',
      align: 'center',
      width: 100,
      customRender: ({ record }) => {
        const auditStatusMap: Record<number, { label: string; color: string }> = {
          0: { label: '待审核', color: 'warning' },
          1: { label: '审核通过', color: 'success' },
          2: { label: '审核拒绝', color: 'error' }
        };
        const auditStatus = auditStatusMap[record.auditStatus] || { label: '未知', color: 'default' };
        return <Tag color={auditStatus.color}>{auditStatus.label}</Tag>;
      }
    },
    {
      key: 'createTime',
      dataIndex: 'createTime',
      title: '创建时间',
      align: 'center',
      width: 180,
      customRender: ({ record }) => {
        return record.createTime ? new Date(record.createTime).toLocaleString() : '-';
      }
    },
    {
      key: 'operate',
      title: '操作',
      align: 'center',
      width: 300,
      fixed: 'right',
      customRender: ({ record }) => (
        <div class="flex-center gap-8px">
          <Button type="primary" ghost size="small" onClick={() => edit(record.id)}>
            编辑
          </Button>
          <Button
            type={record.isTop === 1 ? 'default' : 'primary'}
            size="small"
            onClick={() => toggleTop(record.id, record.isTop)}
          >
            {record.isTop === 1 ? '取消置顶' : '设为置顶'}
          </Button>
          <Button
            type={record.isHot === 1 ? 'default' : 'primary'}
            size="small"
            onClick={() => toggleHot(record.id, record.isHot)}
          >
            {record.isHot === 1 ? '取消热门' : '设为热门'}
          </Button>
          <Button
            type={record.isRecommend === 1 ? 'default' : 'primary'}
            size="small"
            onClick={() => toggleRecommend(record.id, record.isRecommend)}
          >
            {record.isRecommend === 1 ? '取消推荐' : '设为推荐'}
          </Button>
          <Popconfirm title="确定要删除这个动态吗？" onConfirm={() => handleDelete(record.id)}>
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
      window.$message?.warning('请选择要删除的动态');
      return;
    }

    // 使用ant-design-vue的Modal.confirm
    Modal.confirm({
      title: '批量删除动态',
      content: `确定要删除选中的 ${checkedRowKeys.value.length} 个动态吗？删除后无法恢复！`,
      okText: '确定',
      cancelText: '取消',
      async onOk() {
        // 这里需要实现批量删除的API
        // const { error } = await fetchDeletePosts(checkedRowKeys.value);
        // if (!error) {
        //   window.$message?.success('批量删除成功');
        //   onBatchDeleted();
        // } else {
        //   window.$message?.error(`批量删除失败: ${error}`);
        // }
        window.$message?.info('批量删除功能待实现');
      }
    });
  } catch (e) {
    window.$message?.error(`操作失败: ${e.message}`);
  }
}

async function handleDelete(id: number) {
  try {
    const { error } = await fetchDeletePost(id);
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

async function toggleTop(id: number, isTop: number) {
  const newIsTop = isTop === 1 ? 0 : 1;
  const { error } = await fetchSetPostTop(id, newIsTop);
  if (!error) {
    window.$message?.success('置顶状态修改成功');
    getData();
  }
}

async function toggleHot(id: number, isHot: number) {
  const newIsHot = isHot === 1 ? 0 : 1;
  const { error } = await fetchSetPostHot(id, newIsHot);
  if (!error) {
    window.$message?.success('热门状态修改成功');
    getData();
  }
}

async function toggleRecommend(id: number, isRecommend: number) {
  const newIsRecommend = isRecommend === 1 ? 0 : 1;
  const { error } = await fetchSetPostRecommend(id, newIsRecommend);
  if (!error) {
    window.$message?.success('推荐状态修改成功');
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
    <DynamicsSearch v-model:model="searchParams" @reset="getData" @search="getData" />
    <ACard title="动态列表" :bordered="false" :body-style="{ paddingTop: '0px' }" class="sm:flex-1-hidden card-wrapper">
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
    <DynamicsOperateDrawer
      v-model:visible="drawerVisible"
      :operate-type="operateType"
      :row-data="editingData"
      @submitted="getData"
    />
  </div>
</template>

<style scoped></style>
