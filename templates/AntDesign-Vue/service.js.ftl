${gen.setFilename("service.js")}
${gen.setFilepath("${settings.sourcesPath}/ui/${entity.name}/")}
import { axios } from '@/utils/request'

/**
 * 获取所有的 ${entity.comment} 列表
 * parameter = {
 *   sort: 'field,asc',
 *   field: '查询内容'
 * }
 * @param parameter 排序参数 + 查询参数
 * @returns {AxiosPromise}
 */
export function get${entity.name}All (parameter) {
  return axios({
    url: '/${table.name}/all',
    method: 'get',
    params: parameter
  })
}

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
    url: '/${table.name}',
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
    url: '/${table.name}/' + id,
    method: 'get'
  })
}

/**
 * 添加 ${entity.comment}
* @param data
 * @returns {AxiosPromise}
 */
export function add${entity.name} (data) {
  return axios({
    url: '/${table.name}',
    method: 'post',
    data
  })
}

/**
 * 修改 ${entity.comment}
* @param id  ${entity.comment} 主键ID
 * @param data 新的数据
 * @returns {AxiosPromise}
 */
export function update${entity.name} (id, data) {
  return axios({
    url: '/${table.name}/' + id,
    method: 'put',
    data
  })
}

/**
 * 删除一个 ${entity.comment}
* @param id  ${entity.comment} ID
 * @returns {AxiosPromise}
 */
export function delete${entity.name} (id) {
  return axios({
    url: '/${table.name}/' + id,
    method: 'delete'
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
    url: '/${table.name}',
    method: 'delete',
    data
  })
}
