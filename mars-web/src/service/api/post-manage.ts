import { request } from '../request';

/**
 * 分页查询帖子列表
 */
export function fetchGetPostList(params: Api.PostManage.PostSearchParams) {
  return request<Api.PostManage.PostList>({
    url: '/post/page',
    method: 'get',
    params
  });
}

/**
 * 根据ID查询帖子详情
 */
export function fetchGetPostById(id: number) {
  return request<Api.PostManage.Post>({
    url: `/post/${id}`,
    method: 'get'
  });
}

/**
 * 创建帖子
 */
export function fetchAddPost(data: Api.PostManage.Post) {
  return request({
    url: '/post/publish',
    method: 'post',
    data
  });
}

/**
 * 更新帖子
 */
export function fetchUpdatePost(data: Api.PostManage.Post) {
  return request({
    url: '/post',
    method: 'put',
    data
  });
}

/**
 * 删除帖子
 */
export function fetchDeletePost(id: number) {
  return request({
    url: `/post/${id}`,
    method: 'delete'
  });
}

/**
 * 设置帖子置顶状态
 */
export function fetchSetPostTop(id: number, isTop: number) {
  return request({
    url: `/post/${id}/top`,
    method: 'put',
    params: { isTop }
  });
}

/**
 * 设置帖子热门状态
 */
export function fetchSetPostHot(id: number, isHot: number) {
  return request({
    url: `/post/${id}/hot`,
    method: 'put',
    params: { isHot }
  });
}

/**
 * 设置帖子推荐状态
 */
export function fetchSetPostRecommend(id: number, isRecommend: number) {
  return request({
    url: `/post/${id}/recommend`,
    method: 'put',
    params: { isRecommend }
  });
}

/**
 * 审核帖子
 */
export function fetchAuditPost(id: number, auditStatus: number, auditRemark?: string) {
  return request({
    url: `/post/${id}/audit`,
    method: 'put',
    data: { auditStatus, auditRemark }
  });
}