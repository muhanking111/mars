import { request } from '../request';

/**
 * 获取活动分类列表
 */
export function fetchGetActivityCategoryList(params: Api.ActivityCategoryManage.ActivityCategorySearchParams) {
  return request<Api.ActivityCategoryManage.ActivityCategoryList>({
    url: '/admin/ActivityCategory/page',
    method: 'post',
    data: params
  });
}

/**
 * 根据ID获取活动分类详情
 */
export function fetchGetActivityCategoryById(id: number) {
  return request<Api.ActivityCategoryManage.ActivityCategory>({
    url: `/admin/ActivityCategory/get/${id}`,
    method: 'get'
  });
}

/**
 * 新增活动分类
 */
export function fetchAddActivityCategory(data: Api.ActivityCategoryManage.ActivityCategory) {
  return request({
    url: '/admin/ActivityCategory/add',
    method: 'post',
    data
  });
}

/**
 * 更新活动分类
 */
export function fetchUpdateActivityCategory(data: Api.ActivityCategoryManage.ActivityCategory) {
  return request({
    url: '/admin/ActivityCategory/update',
    method: 'post',
    data
  });
}

/**
 * 删除活动分类
 */
export function fetchDeleteActivityCategory(id: number) {
  return request({
    url: `/admin/ActivityCategory/delete/${id}`,
    method: 'post'
  });
}

/**
 * 批量删除活动分类
 */
export function fetchDeleteActivityCategories(ids: number[]) {
  return request({
    url: '/admin/ActivityCategory/batchDelete',
    method: 'post',
    data: { ids }
  });
}

/**
 * 获取所有启用的活动分类（不分页）
 */
export function fetchGetAllActivityCategories() {
  return request<Api.ActivityCategoryManage.ActivityCategoryList>({
    url: '/admin/ActivityCategory/page',
    method: 'post',
    data: {
      current: 1,
      size: 1000, // 设置一个较大的数值获取所有分类
      status: 1 // 只获取启用的分类
    }
  });
}