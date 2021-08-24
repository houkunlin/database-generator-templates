${gen.setFilename("service.js")}
${gen.setFilepath("ui/${entity.name}/")}
import { axios } from '@/utils/request'

const requestUri = '/${entity.uri?replace("_", '-', 'ri')}/'

/**
 * 分页获取 ${entity.comment} 列表
 * parameter = {
 *   page: 0,
 *   size: 10,
 *   sort: 'field,asc',
 *   field: '查询内容'
 * }
 * @param parameter 分页参数 + 排序参数 + 查询参数
 * @returns {AxiosPromise}
 */
export function get${entity.name} (parameter) {
  return axios({
    url: requestUri,
    method: 'get',
    params: parameter
  })
}

/**
 * 获取单个 ${entity.comment}
* @param id
 * @returns {AxiosPromise}
 */
export function get${entity.name}Info (id) {
  return axios({
    url: requestUri + id,
    method: 'get'
  })
}

/**
 * 添加 ${entity.comment}
* @param data
 * @returns {AxiosPromise}
 */
export function save${entity.name} (data) {
  return axios({
    url: requestUri,
    method: 'post',
    data
  })
}

/**
 * 删除多个 ${entity.comment}
* data = ["ID1", "ID2", "ID3", "ID4"]
 * @param data  ${entity.comment} ID列表
 * @returns {AxiosPromise}
 */
export function delete${entity.name}Ids (data) {
  return axios({
    url: requestUri,
    method: 'delete',
    data
  })
}
