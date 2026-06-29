<script setup lang="tsx">
import { ref } from 'vue';
import { Card as ACard, Table as ATable, Button, Modal, Popconfirm, Tag } from 'ant-design-vue';
import { useTable, useTableOperate } from '@/hooks/common/table';
import {
  fetchDeleteActivityCategory,
  fetchDeleteActivityCategories,
  fetchGetActivityCategoryList
} from '@/service/api/activity-category-manage';
import { $t } from '@/locales';
import { enableStatusRecord } from '@/constants/business';
import TableHeaderOperation from '@/components/advanced/table-header-operation.vue';
import ActivitycategoryOperateDrawer from './modules/activitycategory-operate-drawer.vue';
import ActivitycategorySearch from './modules/activitycategory-search.vue';

const wrapperEl = ref<HTMLElement>();

const { columns, columnChecks, data, getData, loading, mobilePagination, updatePagination, searchParams } = useTable({
  apiFn: fetchGetActivityCategoryList,
  apiParams: {
    current: 1,
    size: 10,
    name: null,
    status: null,
    isHot: null
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
      key: 'name',
      dataIndex: 'name',
      title: '分类名称',
      align: 'center',
      width: 150
    },
    {
      key: 'icon',
      dataIndex: 'icon',
      title: '分类图标',
      align: 'center',
      width: 120
    },
    {
      key: 'description',
      dataIndex: 'description',
      title: '分类描述',
      align: 'center',
      width: 200,
      customRender: ({ record }) => {
        return record.description || '-';
      }
    },
    {
      key: 'sortOrder',
      dataIndex: 'sortOrder',
      title: '排序',
      align: 'center',
      width: 80
    },
    {
      key: 'isHot',
      dataIndex: 'isHot',
      title: '是否热门',
      align: 'center',
      width: 100,
      customRender: ({ record }) => {
        return (
          <Tag color={record.isHot === 1 ? 'red' : 'default'}>
            {record.isHot === 1 ? '热门' : '普通'}
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
      align: 'center',
      width: 180
    },
    {
      key: 'operate',
      title: '操作',
      align: 'center',
      width: 200,
      customRender: ({ record }) => (
        <div class="flex-center gap-8px">
          <Button type="primary" ghost size="small" onClick={() => edit(record.id)}>
            编辑
          </Button>
          <Popconfirm title="确定要删除这个活动分类吗？" onConfirm={() => handleDelete(record.id)}>
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
      window.$message?.warning('请选择要删除的活动分类');
      return;
    }

    // 使用ant-design-vue的Modal.confirm替代
    Modal.confirm({
      title: '批量删除活动分类',
      content: `确定要删除选中的 ${checkedRowKeys.value.length} 个活动分类吗？删除后无法恢复！`,
      okText: '确定',
      cancelText: '取消',
      async onOk() {
        // 发送请求
        const { error } = await fetchDeleteActivityCategories(checkedRowKeys.value);
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
    const { error } = await fetchDeleteActivityCategory(id);
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

// 移除这个函数 - 注释掉或删除
// function handleTableChange(paginationInfo: any) {
//   if (paginationInfo) {
//     const { current, pageSize } = paginationInfo;
//     updatePagination({
//       current: current || 1,
//       pageSize: pageSize || mobilePagination.value.pageSize
//     });
//     searchParams.current = current || 1;
//     searchParams.size = pageSize || mobilePagination.value.pageSize;
//     getData();
//   }
// }
</script>

<template>
  <div ref="wrapperEl" class="flex-col-stretch gap-16px overflow-hidden lt-sm:overflow-auto">
    <ActivitycategorySearch v-model:model="searchParams" @reset="getData" @search="getData" />
    <ACard title="活动分类列表" :bordered="false" :body-style="{ paddingTop: '0px' }" class="sm:flex-1-hidden card-wrapper">
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
    <ActivitycategoryOperateDrawer
      v-model:visible="drawerVisible"
      :operate-type="operateType"
      :row-data="editingData"
      @submitted="getData"
    />
  </div>
</template>

<style scoped></style>
