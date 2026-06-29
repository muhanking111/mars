<script setup lang="tsx">
import {ref, onMounted} from 'vue';
import {Card as ACard, Table as ATable, Button, Modal, Popconfirm, Tag} from 'ant-design-vue';
import {useTable, useTableOperate} from '@/hooks/common/table';
import {
  fetchGetBannerList,
  fetchDeleteBanner,
  fetchDeleteBanners
} from '@/service/api/banner-manage';
import {$t} from '@/locales';
import {enableStatusRecord} from '@/constants/business';
import TableHeaderOperation from '@/components/advanced/table-header-operation.vue';
import BannerOperateDrawer from './modules/banner-operate-drawer.vue';
import BannerSearch from './modules/banner-search.vue';

const wrapperEl = ref<HTMLElement>();

const { columns, columnChecks, data, getData, loading, mobilePagination, updatePagination, searchParams } = useTable({
  apiFn: fetchGetBannerList,
  apiParams: {
    current: 1,
    size: 10,
    title: null,
    type: null,
    position: null,
    status: null
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
      title: $t('common.index'),
      align: 'center',
      customRender: ({ index }) => index + 1
    },
    {
      key: 'title',
      dataIndex: 'title',
      title: '轮播图标题',
      align: 'center'
    },
    {
      key: 'type',
      dataIndex: 'type',
      title: '轮播图类型',
      align: 'center'
    },
    {
      key: 'imageUrl',
      dataIndex: 'imageUrl',
      title: '图片',
      align: 'center',
      customRender: ({ record }) => {
        if (record.imageUrl) {
          return (
            <img 
              src={record.imageUrl} 
              alt={record.title}
              style={{ width: '60px', height: '40px', objectFit: 'cover', borderRadius: '4px' }}
            />
          );
        }
        return '暂无图片';
      }
    },
    {
      key: 'position',
      dataIndex: 'position',
      title: '展示位置',
      align: 'center'
    },
    {
      key: 'sort',
      dataIndex: 'sort',
      title: '排序值',
      align: 'center'
    },
    {
      key: 'status',
      dataIndex: 'status',
      title: '状态',
      align: 'center',
      customRender: ({record}) => {
        if (record.status === null) {
          return null;
        }
        const label = $t(enableStatusRecord[record.status]);
        return <Tag color={record.status === 1 ? 'success' : 'error'}>{label}</Tag>;
      }
    },
    {
      key: 'createTime',
      dataIndex: 'createTime',
      title: '创建时间',
      align: 'center'
    },
    {
      key: 'operate',
      title: $t('common.operate'),
      align: 'center',
      customRender: ({record}) => (
        <div class="flex-center gap-8px">
          <Button type="primary" ghost size="small" onClick={() => edit(record.id)}>
            {$t('common.edit')}
          </Button>
          <Popconfirm title={$t('common.confirmDelete')} onConfirm={() => handleDelete(record.id)}>
            <Button danger size="small">
              {$t('common.delete')}
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

// 安全的编辑函数
function edit(id: number) {
  // 确保数据已加载
  if (!data.value || data.value.length === 0) {
    window.$message?.warning('数据未加载完成，请稍后再试');
    return;
  }
  
  // 检查ID是否有效
  if (!id) {
    window.$message?.error('无效的数据ID');
    return;
  }
  
  handleEdit(id);
}

async function handleBatchDelete() {
  try {
    if (checkedRowKeys.value.length === 0) {
      window.$message?.warning('请选择要删除的轮播图');
      return;
    }

    Modal.confirm({
      title: '批量删除轮播图',
      content: `确定要删除选中的 ${checkedRowKeys.value.length} 个轮播图吗？删除后无法恢复！`,
      okText: '确定',
      cancelText: '取消',
      async onOk() {
        const {error} = await fetchDeleteBanners(checkedRowKeys.value);
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
    const {error} = await fetchDeleteBanner(id);
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

function handleTableChange(paginationInfo: any) {
  if (paginationInfo) {
    const {current, pageSize} = paginationInfo;
    updatePagination({
      current: current || 1,
      pageSize: pageSize || mobilePagination.value.pageSize
    });
    searchParams.current = current || 1;
    searchParams.size = pageSize || mobilePagination.value.pageSize;
    getData();
  }
}

// 确保组件挂载后立即加载数据
onMounted(() => {
  getData();
});
</script>

<template>
  <div ref="wrapperEl" class="flex-col-stretch gap-16px overflow-hidden lt-sm:overflow-auto">
    <BannerSearch v-model:model="searchParams" @reset="getData" @search="getData"/>
    <ACard title="轮播图列表" :bordered="false" :body-style="{ paddingTop: '0px' }" class="sm:flex-1-hidden card-wrapper">
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
    <BannerOperateDrawer
      v-model:visible="drawerVisible"
      :operate-type="operateType"
      :row-data="editingData"
      @submitted="getData"
    />
  </div>
</template>

<style scoped></style>
