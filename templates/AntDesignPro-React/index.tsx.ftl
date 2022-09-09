<#include '/jdbc-typescript-type.ftl'>
${gen.setFilename("index.tsx")}
${gen.setFilepath("ui/${entity.name}/")}
import { PageContainer } from '@ant-design/pro-layout';
import type { ActionType, ProColumns } from '@ant-design/pro-table';
import ProTable from '@ant-design/pro-table';
import { Button, message, Modal, Space } from 'antd';
import { DeleteOutlined, PlusOutlined, QuestionOutlined } from '@ant-design/icons';
import { delete${entity.name}ByIds, list${entity.name} } from './service';
import { useCallback, useRef, useState, useMemo } from 'react';
import { Link } from 'umi';
import { getDict, removeConfirmProTable } from "@houkunlin/antd-utils";

export default () => {
  const actionRef = useRef<ActionType>();
  const match = useRouteMatch();
  const editUri = useMemo(() => match.url + '/edit', [match.url]);
  const columns = useMemo<ProColumns<${entity.name}.Entity>[]>(() => [
    <#list fields as field>
        <#if field.selected>
            {<#if field.column.comment?trim?length gt 0 && field.comment != field.column.comment>// 数据库字段说明：${field.column.comment}</#if>
            title: '${field.comment}',
            dataIndex: '${field.name}',
            <#if field.name?starts_with("create") || field.name?starts_with("update") || field.name?starts_with("delete") >
                width: 160,
            </#if>
            align: 'center',
            <#if field.primaryKey>
                render: (dom, entity) => (
                <Link to={editUri + '?${field.name}=' + entity.${field.name}}>{dom}</Link>
                ),
            </#if>
            sorter: false,
            },
        </#if>
    </#list>
    ], [editUri]);

  const handlerRemove = useCallback((selectedRowKeys) => {
    return removeConfirmProTable(selectedRowKeys, delete${entity.name}ByIds, actionRef);
  }, []);

  return (
    <PageContainer>
      <ProTable<${entity.name}.Entity, API.PageParams>
        headerTitle="${entity.comment}"
        actionRef={actionRef}
        rowKey="${primary.field.name}"
        request={list${entity.name}}
        columns={columns}
        search={{ labelWidth: 80, defaultCollapsed: true }}
        options={{ fullScreen: true, reload: true, setting: true }}
        toolBarRender={() => [
        <Link to={editUri} key="add"><Button type="primary"><PlusOutlined /> 新增</Button></Link>,
        ]}
        rowSelection={{ alwaysShowAlert: true, }}
        tableAlertRender={({ selectedRowKeys, onCleanSelected }) => (
        <Space size={24}>
          <span>
            已选 {selectedRowKeys.length} 项
            <Button type='link' disabled={selectedRowKeys.length === 0} onClick={onCleanSelected}>取消选择</Button>
          </span>
        </Space>
        )}
        tableAlertOptionRender={({ selectedRowKeys: keys }) => {
        return (
        <Space size={16}>
            <Button type='link' disabled={keys.length === 0} onClick={() => handlerRemove(keys)}>批量删除</Button>
        </Space>
        );
        }}
      />
    </PageContainer>
  );
};
