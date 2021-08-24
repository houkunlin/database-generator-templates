<#include '/jdbc-typescript-type.ftl'>
${gen.setFilename("FormPage.tsx")}
${gen.setFilepath("ui/${entity.name}/")}
import { PageContainer } from '@ant-design/pro-layout';
import ProForm, {
  ProFormDatePicker,
  ProFormDigit,
  ProFormRadio,
  ProFormText,
  ProFormTextArea,
} from '@ant-design/pro-form';
import type { FormInstance } from 'antd';
import { Card, Divider, message, Spin } from 'antd';
import { history } from 'umi';
import { useEffect, useRef, useState } from 'react';
import type { ${entity.name}Field } from './service';
import { get${entity.name}, save${entity.name} } from './service';
import FooterButton from '@/components/FooterButton';
import type { Rule } from 'rc-field-form/lib/interface';
import { getDicTypeValue } from '@/services/system/dic';

const rules: Record<${entity.name}Field, Rule[]> = {
<#list fields as field>
    <#if field.selected>
        ${field.name}: [{ required: true, message: '请输入 ${field.comment}', type: '${getTypeScriptType(field.column)?lower_case}' }],
    </#if>
</#list>
};

export default () => {
  const formRef = useRef<FormInstance>();
  const [currentData, setCurrentData] = useState<any>({});
  const [loading, setLoading] = useState<boolean>(false);
  useEffect(() => {
    // 先从 state 中拿数据，然后再从 query 中拿数据，query 中的数据会覆盖 state 的数据
    const params: Struct.FormPageParams = { ...history.location.state, ...history.location.query };
    if (params.primaryKey) {
      setLoading(true);
      get${entity.name}(params.primaryKey)
        .then((data) => {
          setCurrentData(data);
          formRef.current?.setFieldsValue(data);
        })
        .finally(() => {
          setLoading(false);
        });
    }
  }, []);
  return (
    <PageContainer
      header={{
        breadcrumb: {},
        onBack: history.goBack,
      }}
    >
      <Card>
        <Spin spinning={loading}>
          <ProForm
            submitter={{
              render: (_, dom) => <FooterButton>{dom}</FooterButton>,
            }}
            formRef={formRef}
            onFinish={async (values) => {
              setLoading(true);
              const hide = message.loading('正在提交');
              return save${entity.name}({ ...currentData, ...values }).then(res=>{
                if(res){
                    history.goBack();
                }
              }).finally(() => {
                hide();
                setLoading(false);
              });
            }}
            initialValues={currentData}
          >
          <#list fields as field>
              <#if field.selected>
                  <#assign tsType = getTypeScriptType(field.column) />
                  <#if field.name?starts_with("created") || field.name?starts_with("updated") || field.name?starts_with("deleted") >
                  <#elseif tsType == 'any' || tsType == 'string'>
                      <ProFormText
                              width="sm"
                              name="${field.name}"
                              label="${field.comment}"
                              placeholder="请输入 ${field.comment}"
                              rules={rules.${field.name}}
                      />
                  <#elseif tsType == 'number'>
                      <ProFormDigit
                              width="sm"
                              name="${field.name}"
                              label="${field.comment}"
                              placeholder="请输入 ${field.comment}"
                              rules={rules.${field.name}}
                              min={0}
                              fieldProps={{ precision: ${(field.dataType.scale)!'2'} }}
                      />
                  <#elseif tsType == 'Date'>
                      <ProFormDatePicker
                              width="sm"
                              name="${field.name}"
                              label="${field.comment}"
                              placeholder="请输入 ${field.comment}"
                      />
                  <#else>
                      <ProFormTextArea name="${field.name}" label="${field.comment}" placeholder="请输入 ${field.comment}" />
                  </#if>
              </#if>
          </#list>
             {/** <ProFormRadio.Group
                      width="sm"
                      name="表单字段名称"
                      label="字典类型名称"
                      request={getDicTypeValue}
                      params={{ dicType: '字典类型代码' }}
                rules={rules.表单规则}
              />
              <ProFormSelect
                      width="sm"
                      name="表单字段名称"
                      label="字典类型名称"
                      placeholder="请输入 字段说明"
                      request={getDicTypeValue}
                      params={{ dicType: '字典类型代码' }}
              rules={rules.表单规则}
              />**/}
          </ProForm>
        </Spin>
      </Card>
    </PageContainer>
  );
};
