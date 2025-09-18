<#include '/jdbc-typescript-type.ftl'>
${gen.setFilename("index.tsx")}
${gen.setFilepath("ui/${entity.name}/")}
import { PageContainer, ProTable } from '@ant-design/pro-components';
import type { ActionType, ProColumns } from '@ant-design/pro-components';
import { Button, message, Modal, Space } from 'antd';
import { DeleteOutlined, PlusOutlined, QuestionOutlined } from '@ant-design/icons';
import { delete${entity.name}ByIds, list${entity.name}Page } from './service';
import { useCallback, useRef, useState, useMemo } from 'react';
import { Link } from '@umijs/max';
import { getDict, useAntdTableProBasicAction } from "@houkunlin/antd-utils";

type TableDataType = SERVER.${entity.name};

const editUri = './edit';
export default function ${entity.name}Index() {
  const actionRef = useRef<ActionType>();
  const [editRow, setEditRow] = useState<TableDataType | undefined>(undefined);
  const columns = useMemo<ProColumns<TableDataType>[]>(() => [
    <#list fields as field>
        <#if field.selected>
            {<#if field.column.comment?trim?length gt 0 && field.comment != field.column.comment>// 数据库字段说明：${field.column.comment}</#if>
            title: '${field.comment}',
            dataIndex: '${field.name}',
            <#if field.name?starts_with("created") || field.name?starts_with("updated") || field.name?starts_with("deleted") || field.name?starts_with("isDeleted") >
                width: 160,
            </#if>
            align: 'center',
            sorter: false,
            <#if field.primaryKey>
              render: (dom, entity) => {
                return (<Link to={editUri + '?${field.name}=' + entity.${field.name}}>{dom}</Link>)
              },
            </#if>
            },
        </#if>
    </#list>
    ], []);

  const { tableAlertRender, tableAlertOptionRender } = useAntdTableProBasicAction<TableDataType>({
    actionRef: actionRef,
    addPath: editUri,
    deleteFun: delete${entity.name}ByIds
  });

  return (
    <PageContainer>
      <ProTable<TableDataType, API.PageParams>
        headerTitle={'${entity.comment}'}
        actionRef={actionRef}
        rowKey={'${primary.field.name}'}
        request={list${entity.name}Page}
        columns={columns}
        search={{ labelWidth: 80, defaultCollapsed: true }}
        options={{
          fullScreen: true,
          reload: true,
          setting: true,
          search: {
            placeholder: '请输入搜索关键字',
            allowClear: true,
          }
        }}
        toolBarRender={() => [
        <Link to={editUri} key={'add'}><Button type={'primary'} icon={<PlusOutlined />}>新增</Button></Link>,
        ]}
        rowSelection={{ alwaysShowAlert: true, }}
        tableAlertRender={tableAlertRender}
        tableAlertOptionRender={tableAlertOptionRender}
      />
    </PageContainer>
  );
};
