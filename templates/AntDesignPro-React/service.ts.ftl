<#include '/jdbc-typescript-type.ftl'>
${gen.setFilename("service.ts")}
${gen.setFilepath("ui/${entity.name}/")}
import { request } from 'umi';
import { transformParams } from '@houkunlin/antd-utils'

const apiUri = SYSTEM_CONTEXT_PATH + '/${entity.uri}/';

export async function list${entity.name}(params?: API.PageParams,sorter?: Record<string, any>,filter?: Record<string, any>, options: Record<string, any> = {}) {
const queryParams = transformParams(params, sorter, filter)
  return request<${entity.name}.Page>(apiUri, {method: 'GET',params: {...queryParams},...options,});
}

export async function get${entity.name}(id: string, options: Record<string, any> = {}) {
  return request<${entity.name}.Entity>(apiUri + id, { method: 'GET', ...options, });
}

export async function save${entity.name}(data: ${entity.name}.Entity, options: Record<string, any> = {}) {
  return request<${entity.name}.Entity>(apiUri, { method: 'POST', data, ...options, });
}

export async function delete${entity.name}ByIds(ids: any[], options: Record<string, any> = {}) {
  return request<any>(apiUri, { method: 'DELETE', data: ids, ...options, });
}
