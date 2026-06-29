<script setup lang="tsx">
import { Card as ACard, Table as ATable, Button, Modal, Popconfirm, Tag } from 'ant-design-vue';
import { useTable, useTableOperate } from '@/hooks/common/table';
import {
  fetchCleanApiLog,
  fetchDeleteApiLog,
  fetchDeleteApiLogs,
  fetchExportApiLog,
  fetchGetApiLogList
} from '@/service/api/log-manage';
import { $t } from '@/locales';
import ApiLogSearch from './modules/apilog-search.vue';
import ApiLogDetailDrawer from './modules/apilog-detail-drawer.vue';

defineOptions({
  name: 'ApiLog'
});

const { columns, data, getData, loading, mobilePagination, updatePagination, searchParams, updateSearchParams } =
  useTable({
    apiFn: fetchGetApiLogList,
    apiParams: {
      current: 1,
      size: 10,
      operName: '',
      requestUrl: '',
      requestMethod: '',
      status: null,
      operIp: ''
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
        title: $t('common.index'),
        align: 'center',
        customRender: ({ index }) => index + 1
      },
      {
        key: 'requestMethod',
        dataIndex: 'requestMethod',
        title: '请求方式',
        align: 'center',
        width: 90
      },
      {
        key: 'requestUrl',
        dataIndex: 'requestUrl',
        title: '请求地址',
        align: 'left',
        ellipsis: true
      },
      {
        key: 'operName',
        dataIndex: 'operName',
        title: '操作人员',
        align: 'center',
        ellipsis: true,
        customRender: ({ record }) => record.operName || '-'
      },
      {
        key: 'operIp',
        dataIndex: 'operIp',
        title: '操作IP',
        align: 'center',
        ellipsis: true
      },
      {
        key: 'responseCode',
        dataIndex: 'responseCode',
        title: '状态码',
        align: 'center',
        width: 80
      },
      {
        key: 'status',
        dataIndex: 'status',
        title: '请求状态',
        align: 'center',
        customRender: ({ record }) => (
          <Tag color={record.status === 0 ? 'success' : 'error'}>{record.status === 0 ? '正常' : '异常'}</Tag>
        )
      },
      {
        key: 'costTime',
        dataIndex: 'costTime',
        title: '耗时(ms)',
        align: 'center',
        customRender: ({ record }) => record.costTime || 0
      },
      {
        key: 'createTime',
        dataIndex: 'createTime',
        title: '请求时间',
        align: 'center',
        ellipsis: true
      },
      {
        key: 'operate',
        title: $t('common.operate'),
        align: 'center',
        fixed: 'right',
        customRender: ({ record }) => (
          <div class="flex-center gap-8px">
            <Button type="primary" ghost size="small" onClick={() => handleDetail(record.id)}>
              详情
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

const { drawerVisible, editingData, checkedRowKeys, onBatchDeleted, onDeleted, rowSelection } = useTableOperate(
  data,
  getData
);

function handleDetail(id: number) {
  const record = data.value.find(item => item.id === id);
  if (record) {
    editingData.value = record;
    drawerVisible.value = true;
  }
}

async function handleBatchDelete() {
  if (checkedRowKeys.value.length === 0) {
    window.$message?.warning('请选择要删除的接口日志');
    return;
  }

  Modal.confirm({
    title: '批量删除接口日志',
    content: `确定要删除选中的 ${checkedRowKeys.value.length} 条接口日志吗？`,
    okText: '确定',
    cancelText: '取消',
    async onOk() {
      const { error } = await fetchDeleteApiLogs(checkedRowKeys.value);
      if (!error) {
        window.$message?.success('批量删除成功');
        onBatchDeleted();
      }
    }
  });
}

async function handleDelete(id: number) {
  const { error } = await fetchDeleteApiLog(id);
  if (!error) {
    window.$message?.success('删除成功');
    onDeleted();
  }
}

async function handleCleanAll() {
  Modal.confirm({
    title: '清空接口日志',
    content: '确定要清空所有接口日志吗？此操作不可撤销！',
    okText: '确定',
    cancelText: '取消',
    async onOk() {
      const { error } = await fetchCleanApiLog();
      if (!error) {
        window.$message?.success('清空成功');
        getData();
      }
    }
  });
}

async function handleExport() {
  const exportParams: Api.LogManage.ApiLog = {};
  if (searchParams) {
    if (searchParams.operName) exportParams.operName = searchParams.operName;
    if (searchParams.requestUrl) exportParams.requestUrl = searchParams.requestUrl;
    if (searchParams.requestMethod) exportParams.requestMethod = searchParams.requestMethod;
    if (searchParams.status !== null && searchParams.status !== undefined) exportParams.status = searchParams.status;
    if (searchParams.operIp) exportParams.operIp = searchParams.operIp;
  }

  const { data: exportData, error } = await fetchExportApiLog(exportParams);
  if (error || !exportData) {
    window.$message?.error('导出失败');
    return;
  }

  const blob = new Blob([JSON.stringify(exportData, null, 2)], { type: 'application/json' });
  const url = window.URL.createObjectURL(blob);
  const link = document.createElement('a');
  link.href = url;
  link.download = `接口日志_${Date.now()}.json`;
  document.body.appendChild(link);
  link.click();
  document.body.removeChild(link);
  window.URL.revokeObjectURL(url);
  window.$message?.success('导出成功');
}

function handleTableChange(pagination: any) {
  if (pagination) {
    const { current, pageSize } = pagination;
    const currentParams = { ...searchParams };
    updatePagination({
      current: current || 1,
      pageSize: pageSize || 10,
      total: mobilePagination.value.total
    });
    currentParams.current = current || 1;
    currentParams.size = pageSize || 10;
    updateSearchParams(currentParams);
    getData();
  }
}
</script>

<template>
  <div class="min-h-500px flex-col-stretch gap-16px">
    <ApiLogSearch v-model:model="searchParams" @reset="getData" @search="getData" />

    <ACard :bordered="false" :body-style="{ padding: '0' }">
      <template #title>
        <div class="w-full flex items-center justify-between">
          <span class="text-base font-medium">接口日志</span>
          <div class="flex flex-wrap gap-12px">
            <AButton type="primary" danger ghost :disabled="checkedRowKeys.length === 0" @click="handleBatchDelete">
              批量删除
            </AButton>
            <AButton type="primary" danger ghost @click="handleCleanAll">
              <template #icon>
                <icon-ic-round-delete class="align-sub text-icon" />
              </template>
              清空日志
            </AButton>
            <AButton type="primary" ghost @click="handleExport">
              <template #icon>
                <icon-ic-round-download class="align-sub text-icon" />
              </template>
              导出日志
            </AButton>
          </div>
        </div>
      </template>

      <ATable
        :columns="columns"
        :data-source="data"
        size="small"
        :scroll="{ x: 'max-content' }"
        :loading="loading"
        :row-selection="rowSelection"
        row-key="id"
        :pagination="mobilePagination"
        class="h-full"
        @change="handleTableChange"
      />
    </ACard>

    <ApiLogDetailDrawer v-model:visible="drawerVisible" :row-data="editingData" />
  </div>
</template>

<style scoped></style>
