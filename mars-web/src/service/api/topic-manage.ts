import { request } from '../request';

/**
 * 分页查询话题列表
 */
export function fetchGetTopicList(params: Api.TopicManage.TopicSearchParams) {
  return request<Api.TopicManage.TopicList>({
    url: '/topic/page',
    method: 'get',
    params
  });
}

/**
 * 查询所有话题列表
 */
export function fetchGetAllTopics() {
  return request<Api.TopicManage.Topic[]>({
    url: '/topic/list',
    method: 'get'
  });
}

/**
 * 根据ID查询话题详情
 */
export function fetchGetTopicById(id: number) {
  return request<Api.TopicManage.Topic>({
    url: `/topic/${id}`,
    method: 'get'
  });
}

/**
 * 创建话题
 */
export function fetchAddTopic(data: Api.TopicManage.Topic) {
  return request({
    url: '/topic',
    method: 'post',
    data
  });
}

/**
 * 更新话题
 */
export function fetchUpdateTopic(data: Api.TopicManage.Topic) {
  return request({
    url: '/topic',
    method: 'put',
    data
  });
}

/**
 * 删除话题
 */
export function fetchDeleteTopic(id: number) {
  return request({
    url: `/topic/${id}`,
    method: 'delete'
  });
}

/**
 * 批量删除话题
 */
export function fetchDeleteTopics(ids: number[]) {
  return request({
    url: '/topic/batch',
    method: 'delete',
    data: ids
  });
}

/**
 * 根据分类查询话题列表
 */
export function fetchGetTopicsByCategory(category: string) {
  return request<Api.TopicManage.Topic[]>({
    url: `/topic/category/${category}`,
    method: 'get'
  });
}

/**
 * 查询热门话题
 */
export function fetchGetHotTopics(limit: number = 10) {
  return request<Api.TopicManage.Topic[]>({
    url: '/topic/hot',
    method: 'get',
    params: { limit }
  });
}

/**
 * 查询官方话题
 */
export function fetchGetOfficialTopics() {
  return request<Api.TopicManage.Topic[]>({
    url: '/topic/official',
    method: 'get'
  });
}

/**
 * 搜索话题
 */
export function fetchSearchTopics(keyword: string) {
  return request<Api.TopicManage.Topic[]>({
    url: '/topic/search',
    method: 'get',
    params: { keyword }
  });
}

/**
 * 设置话题热门状态
 */
export function fetchSetTopicHot(id: number, isHot: number) {
  return request({
    url: `/topic/${id}/hot`,
    method: 'put',
    params: { isHot }
  });
}

/**
 * 设置话题官方状态
 */
export function fetchSetTopicOfficial(id: number, isOfficial: number) {
  return request({
    url: `/topic/${id}/official`,
    method: 'put',
    params: { isOfficial }
  });
}