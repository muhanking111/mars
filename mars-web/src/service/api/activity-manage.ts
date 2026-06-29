import { request } from '../request';

/**
 * 获取活动列表
 */
export function fetchGetActivityList(params: Api.ActivityManage.ActivitySearchParams) {
  return request<Api.ActivityManage.ActivityList>({
    url: '/admin/Activity/page',
    method: 'post',
    data: params
  });
}

/**
 * 根据ID获取活动详情
 */
export function fetchGetActivityById(id: number) {
  return request<Api.ActivityManage.Activity>({
    url: `/admin/Activity/get/${id}`,
    method: 'get'
  });
}

/**
 * 新增活动
 */
export function fetchAddActivity(data: Api.ActivityManage.Activity) {
  return request({
    url: '/admin/Activity/add',
    method: 'post',
    data
  });
}

/**
 * 更新活动
 */
export function fetchUpdateActivity(data: Api.ActivityManage.Activity) {
  return request({
    url: '/admin/Activity/update',
    method: 'post',
    data
  });
}

/**
 * 删除活动
 */
export function fetchDeleteActivity(id: number) {
  return request({
    url: `/admin/Activity/delete/${id}`,
    method: 'post'
  });
}

/**
 * 批量删除活动
 */
export function fetchDeleteActivities(ids: number[]) {
  return request({
    url: '/admin/Activity/batchDelete',
    method: 'post',
    data: { ids }
  });
}

/**
 * 审核活动
 */
export function fetchAuditActivity(id: number, auditStatus: number, auditReason?: string) {
  return request({
    url: `/admin/Activity/audit/${id}`,
    method: 'post',
    params: {
      auditStatus,
      auditReason
    }
  });
}