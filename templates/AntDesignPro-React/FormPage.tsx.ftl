<#include '/jdbc-typescript-type.ftl'>
${gen.setFilename("FormPage.tsx")}
${gen.setFilepath("ui/${entity.name}/")}
import useUrlState from '@ahooksjs/use-url-state';
import {
  PageContainer,
  FooterToolbar,
  DrawerForm,
  ModalForm,
  PageContainer,
  ProCard,
  ProForm,
  ProFormDatePicker,
  ProFormDigit,
  ProFormRadio,
  ProFormSwitch,
  ProFormText,
  ProFormTextArea,
  ProFormInstance,
} from '@ant-design/pro-components';
import { Form, Divider, message, Spin } from 'antd';
import { history } from '@umijs/max';
import React, { createContext, useEffect, useRef, useState,useCallback, useMemo } from 'react';
import { get${entity.name}, save${entity.name} } from './service';
import FooterButton from '@/components/FooterButton';
import { getDict } from "@/antd-utils";
import { usePanelTab } from "@/services/utils";
import { Rule } from "rc-field-form/lib/interface";
import { useRequest } from "ahooks";

type FormDataType = SERVER.${entity.name};

// 表单初始化数据上下文信息
const ${entity.name}DataContext = createContext<FormDataType|undefined>(undefined);

type RulesType = {
<#list fields as field>
    <#if field.selected>
        <#if isIgnoreField(field)>
        <#elseif field.column.name?lower_case?starts_with("is_")>
            ${field.name?replace('is','','f')?uncap_first}: Rule[];
        <#else>
            ${field.name}: Rule[];
        </#if>
    </#if>
</#list>
}
const rules: RulesType = {
<#list fields as field>
    <#if field.selected>
        <#if isIgnoreField(field)>
        <#elseif field.column.name?lower_case?starts_with("is_")>
            ${field.name?replace('is','','f')?uncap_first}: [{ required: true, message: '请输入${field.comment}', type: '${getTypeScriptType(field.column)?lower_case}' }],
        <#else>
            ${field.name}: [{ required: true, message: '请输入${field.comment}', type: '${getTypeScriptType(field.column)?lower_case}' }],
        </#if>
    </#if>
</#list>
};

export function FormFieldContent(){
    return (<>
        <#list fields as field>
            <#if field.selected>
                <#assign tsType = getTypeScriptType(field.column) />
                <#if isIgnoreField(field)>
                <#elseif tsType == 'any' || tsType == 'string'>
                    <ProFormText
                            width="md"
                            name="${field.name}"
                            label="${field.comment}"
                            placeholder="请输入${field.comment}"
                            rules={rules.${field.name}}
                    />
                <#elseif tsType == 'number'>
                    <ProFormDigit
                            width="md"
                            name="${field.name}"
                            label="${field.comment}"
                            placeholder="请输入${field.comment}"
                            rules={rules.${field.name}}
                            min={0}
                            fieldProps={{ precision: ${(field.dataType.scale)!'2'} }}
                    />
                <#elseif tsType == 'Date'>
                    <ProFormDatePicker
                            width="md"
                            name="${field.name}"
                            label="${field.comment}"
                            placeholder="请选择${field.comment}"
                    />
                <#elseif tsType == 'boolean'>
                    <ProFormSwitch
                            name="${field.name}"
                            label="${field.comment}"
                    />
                    <ProFormRadio.Group
                            width="md"
                            name="${field.name}"
                            radioType={'button'}
                            fieldProps={{ buttonStyle: 'solid' }}
                            label="${field.comment}"
                            rules={rules.${field.name}}
                            params={{ dict: 'Whether' }}
                            request={getDict}
                    />
                <#else>
                    <ProFormTextArea name="${field.name}" label="${field.comment}" placeholder="请输入${field.comment}" />
                </#if>
            </#if>
        </#list>
    </>)
}

const FORM_DEFAULT_VALUES = {};

export async function load${entity.name}FormData(params: Record<any, any>) {
  if (params.${primary.field.name}) {
    return await get${entity.name}(params.${primary.field.name}) || { ...FORM_DEFAULT_VALUES };
  }
  return { ...FORM_DEFAULT_VALUES };
}

export async function save${entity.name}FormData(values: any) {
  return await save${entity.name}(values);
}

export function ${entity.name}ProForm<T = any>(props: Readonly<{
  params?: any;
  onOk?: (submitData: any, responseData?: any) => void;
  // request?: ProRequestData<T, any>;
  // onFinish?: (values: any)=>Promise<any>;
}>) {
  const formRef = useRef<ProFormInstance>();
  const [messageApi, contextHolder] = message.useMessage();
  const {
    data: formData,
    loading: getLoading,
    runAsync: getFormValues
  } = useRequest(load${entity.name}FormData, { manual: true });
  const { loading: saveLoading, runAsync: saveFormValues } = useRequest(async (values) => {
    const submitData = { ...(props.params ?? {}), ...(formData ?? {}), ...values };
    const responseData = await save${entity.name}FormData(submitData);
    messageApi.success('保存成功');
    props.onOk?.(submitData, responseData);
    return true;
  }, { manual: true });
  const loading = getLoading || saveLoading;

  return (<>
    {contextHolder}
    <ProForm
      formRef={formRef}
      submitter={{
        // render: (_props1, dom) => <FooterToolbar>{dom}</FooterToolbar>
      }}
      params={props.params}
      request={getFormValues}
      onFinish={saveFormValues}
    >
      <Spin spinning={loading}>
        <${entity.name}DataContext.Provider value={formData}>
          <FormFieldContent />
        </${entity.name}DataContext.Provider>
      </Spin>
    </ProForm>
  </>);
}

export type ${entity.name}FormProps = {
  params?: any;
  onOk?: (submitData: any, responseData?: any) => void;
  onClose?: () => void;
  trigger: React.JSX.Element;
}

export function ${entity.name}ModalForm(props: ${entity.name}FormProps) {
  const [query] = useUrlState();
  const [form] = Form.useForm<FormDataType>();
  const [openForm, setOpenForm] = useState<boolean>(false);
  const params = useMemo(() => ({ ...query, ...(props.params ?? {}) }), [query, props.params]);
  const [messageApi, contextHolder] = message.useMessage();
  const {
    data: formData,
    loading: getLoading,
    runAsync: getFormValues
  } = useRequest(load${entity.name}FormData, { manual: true });
  const { loading: saveLoading, runAsync: saveFormValues } = useRequest(async (values) => {
    const submitData = { ...params, ...(formData ?? {}), ...values };
    const responseData = await save${entity.name}FormData(submitData);
    messageApi.success('保存成功');
    props.onOk?.(submitData, responseData);
    return true;
  }, { manual: true });
  const loading = getLoading || saveLoading;

  useEffect(() => {
    if (params.${primary.field.name}) {
      setOpenForm(true);
      getFormValues(params).then(values => form.setFieldsValue(values));
    }
  }, [params.${primary.field.name}]);

  return (<>
    {contextHolder}
    <ModalForm<FormDataType>
      title={'编辑${entity.comment}'}
      form={form}
      initialValues={{ ...FORM_DEFAULT_VALUES }}
      onFinish={saveFormValues}
      trigger={props.trigger}
      open={openForm}
      onOpenChange={setOpenForm}
      width={1200}
      modalProps={{
        destroyOnClose: true,
        centered: true,
        onCancel: () => setOpenForm(false),
        afterClose: props.onClose,
      }}
      loading={loading}
    >
      <Spin spinning={loading}>
        <${entity.name}DataContext.Provider value={formData}>
            <FormFieldContent />
        </${entity.name}DataContext.Provider>
      </Spin>
    </ModalForm>
  </>);
}

export function ${entity.name}DrawerForm(props: ${entity.name}FormProps) {
  const [query] = useUrlState();
  const [form] = Form.useForm<FormDataType>();
  const [openForm, setOpenForm] = useState<boolean>(false);
  const params = useMemo(() => ({ ...query, ...(props.params ?? {}) }), [query, props.params]);
  const [messageApi, contextHolder] = message.useMessage();
  const {
    data: formData,
    loading: getLoading,
    runAsync: getFormValues
  } = useRequest(load${entity.name}FormData, { manual: true });
  const { loading: saveLoading, runAsync: saveFormValues } = useRequest(async (values) => {
    const submitData = { ...params, ...(formData ?? {}), ...values };
    const responseData = await save${entity.name}FormData(submitData);
    messageApi.success('保存成功');
    props.onOk?.(submitData, responseData);
    return true;
  }, { manual: true });
  const loading = getLoading || saveLoading;

  useEffect(() => {
    if (params.${primary.field.name}) {
      setOpenForm(true);
      getFormValues(params).then(values => form.setFieldsValue(values));
    }
  }, [params.${primary.field.name}]);

  return (<>
    {contextHolder}
    <DrawerForm<FormDataType>
      title={'编辑${entity.comment}'}
      form={form}
      initialValues={{ ...FORM_DEFAULT_VALUES }}
      onFinish={saveFormValues}
      trigger={props.trigger}
      open={openForm}
      onOpenChange={setOpenForm}
      width={1200}
      drawerProps={{
        destroyOnClose: true,
        onClose: props.onClose,
      }}
      loading={loading}
    >
      <Spin spinning={loading}>
        <${entity.name}DataContext.Provider value={formData}>
            <FormFieldContent />
        </${entity.name}DataContext.Provider>
      </Spin>
    </DrawerForm>
  </>);
}

export function ${entity.name}ProFormPage() {
  const { goBack } = usePanelTab();
  const [query] = useUrlState();
  const formRef = useRef<ProFormInstance>();
  const params = useMemo(() => ({ ...query, }), [query]);
  const [messageApi, contextHolder] = message.useMessage();
  const {
    data: formData,
    loading: getLoading,
    runAsync: getFormValues
  } = useRequest(load${entity.name}FormData, { manual: true });
  const { loading: saveLoading, runAsync: saveFormValues } = useRequest(async (values) => {
    await save${entity.name}FormData({ ...params, ...(formData ?? {}), ...values });
    messageApi.success('保存成功');
    goBack();
    return true;
  }, { manual: true });
  const loading = getLoading || saveLoading;

  return (
    <PageContainer header={{ onBack: goBack, }}>
      {contextHolder}
      <ProCard>
        <ProForm
          formRef={formRef}
          submitter={{
            render: (_props1, dom) => <FooterToolbar>{dom}</FooterToolbar>
          }}
          params={params}
          request={getFormValues}
          onFinish={saveFormValues}
        >
          <Spin spinning={loading}>
            <${entity.name}DataContext.Provider value={formData}>
                <FormFieldContent />
            </${entity.name}DataContext.Provider>
          </Spin>
        </ProForm>
      </ProCard>
    </PageContainer>
  );
}

export default ${entity.name}ProFormPage;
