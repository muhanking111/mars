import { request } from '../request';

// ==================== 轮播图管理 ====================

/** 分页查询轮播图列表 */
export function fetchGetBannerList(params?: Api.BannerManage.BannerSearchParams) {
  return request<Api.BannerManage.BannerList>({
    url: '/admin/banner/page',
    method: 'get',
    params
  }).catch(error => {
    console.error('获取轮播图列表失败:', error);
    // 返回空数据结构，避免undefined
    return {
      data: {
        current: params?.current || 1,
        size: params?.size || 10,
        total: 0,
        records: []
      },
      error: null
    };
  });
}

/** 根据ID获取轮播图信息 */
export function fetchGetBannerById(id: number) {
  if (!id) {
    return Promise.resolve({ data: null, error: '无效的ID' });
  }
  
  return request<Api.BannerManage.Banner>({
    url: `/admin/banner/get/${id}`,
    method: 'get'
  }).catch(error => {
    console.error('获取轮播图详情失败:', error);
    return { data: null, error: '获取详情失败' };
  });
}

/** 新增轮播图 */
export function fetchAddBanner(data: Partial<Api.BannerManage.Banner>) {
  return request({
    url: '/admin/banner/add',
    method: 'post',
    data
  }).catch(error => {
    console.error('新增轮播图失败:', error);
    return { error: '新增失败' };
  });
}

/** 更新轮播图 */
export function fetchUpdateBanner(data: Partial<Api.BannerManage.Banner>) {
  return request({
    url: '/admin/banner/update',
    method: 'post',
    data
  }).catch(error => {
    console.error('更新轮播图失败:', error);
    return { error: '更新失败' };
  });
}

/** 删除轮播图 */
export function fetchDeleteBanner(id: number) {
  return request({
    url: `/admin/banner/delete/${id}`,
    method: 'post'
  }).catch(error => {
    console.error('删除轮播图失败:', error);
    return { error: '删除失败' };
  });
}

/** 批量删除轮播图 */
export function fetchDeleteBanners(ids: number[]) {
  return request({
    url: '/admin/banner/batchDelete',
    method: 'post',
    data: { ids }
  }).catch(error => {
    console.error('批量删除轮播图失败:', error);
    return { error: '批量删除失败' };
  });
}