<#include '/jdbc-typescript-type.ftl'>
${gen.setFilename("index.tsx")}
${gen.setFilepath("ui/${entity.name}/")}
import { PageContainer } from '@ant-design/pro-layout';
import type { ActionType, ProColumns } from '@ant-design/pro-table';
import ProTable from '@ant-design/pro-table';
import { Button, message, Modal } from 'antd';
import { DeleteOutlined, PlusOutlined, QuestionOutlined } from '@ant-design/icons';
import type { ${entity.name}Entity } from './service';
import { delete${entity.name}, list${entity.name} } from './service';
import { useCallback, useRef, useState } from 'react';
import { Link } from 'umi';
import { hasRouteChildren } from '@/utils/utils';
import { getDicTypeValue } from '@/services/system/dic';

const editPagePathname = '${entity.uri}/edit';
const columns: ProColumns<${entity.name}Entity>[] = [
<#list fields as field>
    <#if field.selected>
        {<#if field.column.comment?trim?length gt 0 && field.comment != field.column.comment>// 数据库字段说明：${field.column.comment}</#if>
        title: '${field.comment}',
        dataIndex: '${field.name}',
        <#if field.name?starts_with("created") || field.name?starts_with("updated") || field.name?starts_with("deleted") >
            width: 160,
        </#if>
        align: 'center',
        <#if field.primaryKey>
            render: (dom, entity) => (
            <Link to={{ pathname: editPagePathname, state: { primaryKey: entity.${field.name} } }}>{dom}</Link>
            ),
            // renderText: (text) => `${r'$'}{text} 显示`,
        </#if>
        sorter: false,
        // search: true,
        // valueType: 'money',
        // sorter: true,
        },
    </#if>
</#list>
  // {
  //  title: '字典名称',
  //  dataIndex: 'isTransferText',// 列表对象的字段名称
  //  valueType: 'select',// 字典显示类型
  //  key: 'isTransfer',// 查询参数的字段名称
  //  // initialValue: '0',
  //  // initialValue: ['0'],
  //  width: 100,
  //  request: getDicTypeValue,
  //  params: { dicType: 'WhetherEnum' },// 请求字典信息的请求参数
  //  // filters: true,
  //  // onFilter: true,
  // },
];

export default (props: any) => {
  if (hasRouteChildren(props)) {
    return <>{props.children}</>;
  }
  const actionRef = useRef<ActionType>();
  const [selectedRows, setSelectedRows] = useState<${entity.name}Entity[]>([]);

  const handlerRemove = useCallback(() => {
    Modal.confirm({
      title: (
        <>
          确定要删除选中的 <strong>{selectedRows.length}</strong> 项信息吗？
        </>
      ),
      content: '您正在进行危险操作，请核对后确认删除！',
      icon: <QuestionOutlined />,
      centered: true,
      maskClosable: true,
      onOk() {
        const hide = message.loading('正在删除');
        return delete${entity.name}(selectedRows.map((value) => value.${primary.field.name})).finally(() => {
          setSelectedRows([]);
          actionRef.current?.reloadAndRest?.();
          hide();
        });
      },
    });
  }, [selectedRows]);
  const toolBarBtn = useCallback(() => {
    const list = [
      <Link to={editPagePathname}>
        <Button type="primary">
          <PlusOutlined /> 添加
        </Button>
      </Link>,
    ];
    list.push(
      <Button danger onClick={handlerRemove} disabled={selectedRows?.length <= 0}>
        <DeleteOutlined /> 批量删除
      </Button>,
    );
    return list;
  }, [handlerRemove, selectedRows?.length]);

  return (
    <PageContainer header={{ breadcrumb: {} }}>
      <ProTable<${entity.name}Entity, API.PageParams>
        headerTitle="${entity.comment}"
        actionRef={actionRef}
        rowKey="cardId"
        request={list${entity.name}}
        columns={columns}
        search={{ labelWidth: 80, defaultCollapsed: true }}
        tableAlertRender={false}
        options={{ fullScreen: true, reload: true, setting: true }}
        toolBarRender={toolBarBtn}
        rowSelection={{
          onChange: (_, rows) => {
            setSelectedRows(rows);
          },
        }}
      />
    </PageContainer>
  );
};
