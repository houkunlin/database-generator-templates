<#include '/jdbc-typescript-type.ftl'>
${gen.setFilename("service.ts")}
${gen.setFilepath("ui/${entity.name}/")}
import { request } from '@umijs/max';
import { transformParams } from '@/antd-utils';
import { Key } from "react";

const apiUri = SYSTEM_CONTEXT_PATH + '/${entity.uri}/';

export async function list${entity.name}All(params?: API.PageParams,sorter?: Record<string, any>,filter?: Record<string, any>, options: Record<string, any> = {}) {
const queryParams = transformParams(params, sorter, filter)
  return request<SERVER.${entity.name}VoList[]>(apiUri + 'all', {method: 'GET',params: {...queryParams},...options,});
}

export async function list${entity.name}Page(params?: API.PageParams,sorter?: Record<string, any>,filter?: Record<string, any>, options: Record<string, any> = {}) {
const queryParams = transformParams(params, sorter, filter)
  return request<API.Page<SERVER.${entity.name}VoList>>(apiUri + 'page', {method: 'GET',params: {...queryParams},...options,});
}

export async function get${entity.name}(${entity.name.firstLower}Id: Key, options: Record<string, any> = {}) {
  return request<SERVER.${entity.name}Vo>(apiUri + ${entity.name.firstLower}Id, { method: 'GET', ...options, });
}

export async function get${entity.name}Detail(${entity.name.firstLower}Id: Key, options: Record<string, any> = {}) {
  return request<SERVER.${entity.name}VoDetail>(apiUri + ${entity.name.firstLower}Id + '/detail', { method: 'GET', ...options, });
}

export async function save${entity.name}(data: SERVER.${entity.name}Form, options: Record<string, any> = {}) {
  return request<SERVER.${entity.name}Vo>(apiUri + 'edit', { method: 'POST', data, ...options, });
}

export async function delete${entity.name}ByIds(${entity.name.firstLower}Ids: any[], options: Record<string, any> = {}) {
  return request<any>(apiUri, { method: 'DELETE', data: ${entity.name.firstLower}Ids, ...options, });
}
