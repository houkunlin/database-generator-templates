<#include '/jdbc-typescript-type.ftl'>
${gen.setFilename("service.ts")}
${gen.setFilepath("ui/${entity.name}/")}
import { request } from '@@/plugin-request/request';
import { transformParams, transformProTableData } from '@/utils/utils';

// ${entity.comment}<#if table.comment?trim?length gt 0 && entity.comment != table.comment> (${table.comment})</#if>
export declare type ${entity.name}Field =
<#list fields as field>
    <#if field.selected>
        | '${field.name}' // ${field.comment}<#if field.column.comment?trim?length gt 0 && field.comment != field.column.comment> (数据库字段说明：${field.column.comment})</#if>
    </#if>
</#list>
;
export type ${entity.name}Entity = {
<#list fields as field>
    <#if field.selected>
        // ${field.typeName} ${field.comment}
        ${field.name}?: ${getTypeScriptType(field.column)};
    </#if>
</#list>
  [key: string]: any;
};

const apiUri = '${entity.uri}';

export async function list${entity.name}(
  params?: API.PageParams,
  sorter?: Record<string, any>,
  filter?: Record<string, any>,
) {
  return request<Struct.PageResponse<${entity.name}Entity>>(apiUri, {
    method: 'GET',
    params: transformParams(params, sorter, filter),
  }).then(transformProTableData);
}

export async function get${entity.name}(id: string) {
  return request<${entity.name}Entity>(apiUri + id, { method: 'GET', });
}

export async function save${entity.name}(data: any) {
  return request(apiUri, { method: 'POST', data, });
}

export async function delete${entity.name}(ids: any[]) {
  return request(apiUri, { method: 'DELETE', data: ids, });
}
