<#include '/jdbc-typescript-type.ftl'>
${gen.setFilename("FormPage.tsx")}
${gen.setFilepath("ui/${entity.name}/")}
import useUrlState from '@ahooksjs/use-url-state';
import { PageContainer } from '@ant-design/pro-layout';
import ProCard from '@ant-design/pro-card';
import ProForm, {
  ProFormDatePicker,
  ProFormDigit,
  ProFormRadio,
  ProFormSwitch,
  ProFormText,
  ProFormTextArea,
} from '@ant-design/pro-form';
import type { FormInstance } from 'antd';
import { Divider, message, Spin } from 'antd';
import { history } from 'umi';
import { useEffect, useRef, useState,useCallback } from 'react';
import { get${entity.name}, save${entity.name} } from './service';
import FooterButton from '@/components/FooterButton';
import { getDict } from "@houkunlin/antd-utils";

const rules: any = {
<#list fields as field>
    <#if field.selected>
        ${field.name}: [{ required: true, message: '请输入 ${field.comment}', type: '${getTypeScriptType(field.column)?lower_case}' }],
    </#if>
</#list>
};

export default () => {
  const [query] = useUrlState();
  const formRef = useRef<FormInstance>();
  const goBack = history.goBack;

  const load${entity.name} = useCallback((params: Record<any, any>) => {
    if (params.${primary.field.name}) {
      return get${entity.name}(params.${primary.field.name}).then(res => res || {});
    }
    return Promise.resolve({});
  }, []);

  return (
    <PageContainer header={{ onBack: goBack, }}>
      <ProCard>
      <ProForm
            formRef={formRef}
            params={query}
            request={load${entity.name}}
            onFinish={async (values) => {
              return save${entity.name}({ ...query, ...values }).then(()=>{
              message.success('保存成功');
              goBack();
              });
            }} >
          <#list fields as field>
              <#if field.selected>
                  <#assign tsType = getTypeScriptType(field.column) />
                  <#if field.name?starts_with("created") || field.name?starts_with("updated") || field.name?starts_with("deleted") >
                  <#elseif tsType == 'any' || tsType == 'string'>
                      <ProFormText
                              width="md"
                              name="${field.name}"
                              label="${field.comment}"
                              placeholder="请输入 ${field.comment}"
                              rules={rules.${field.name}}
                      />
                  <#elseif tsType == 'number'>
                      <ProFormDigit
                              width="md"
                              name="${field.name}"
                              label="${field.comment}"
                              placeholder="请输入 ${field.comment}"
                              rules={rules.${field.name}}
                              min={0}
                              fieldProps={{ precision: ${(field.dataType.scale)!'2'} }}
                      />
                  <#elseif tsType == 'Date'>
                      <ProFormDatePicker
                              width="md"
                              name="${field.name}"
                              label="${field.comment}"
                              placeholder="请选择 ${field.comment}"
                      />
                  <#elseif tsType == 'boolean'>
                      <ProFormSwitch
                              name="${field.name}"
                              label="${field.comment}"
                              help="请输入 ${field.comment}"
                      />
                  <#else>
                      <ProFormTextArea name="${field.name}" label="${field.comment}" placeholder="请输入 ${field.comment}" />
                  </#if>
              </#if>
          </#list>
          </ProForm>
      </ProCard>
    </PageContainer>
  );
};
