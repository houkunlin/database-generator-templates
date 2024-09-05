<#include '/jdbc-typescript-type.ftl'>
${gen.setFilename("FormPage.tsx")}
${gen.setFilepath("ui/${entity.name}/")}
import useUrlState from '@ahooksjs/use-url-state';
import {
  PageContainer,
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
import { useEffect, useRef, useState,useCallback, useMemo } from 'react';
import { get${entity.name}, save${entity.name} } from './service';
import FooterButton from '@/components/FooterButton';
import { getDict } from "@/antd-utils";
import { usePanelTab } from "@/services/utils";
import { Rule } from "rc-field-form/lib/interface";
import { useRequest } from "ahooks";

type FormDataType = SERVER.${entity.name};

type RulesType = {
<#list fields as field>
    <#if field.selected>
        <#if field.column.name?starts_with("is_")>
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
        <#if field.name?starts_with("created") || field.name?starts_with("updated") || field.name?starts_with("deleted") || field.name?starts_with("isDeleted") || field.name?starts_with("revision") || field.name?starts_with("tenantId") >
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
                <#if field.name?starts_with("created") || field.name?starts_with("updated") || field.name?starts_with("deleted") || field.name?starts_with("isDeleted") || field.name?starts_with("revision") || field.name?starts_with("tenantId") >
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
                            request={getDict}
                            params={{ dict: 'Whether' }}
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

export function ${entity.name}ProForm(props: Readonly<{footerToolbar?: boolean; params?: any; onFinish?: (values: any)=>Promise<any>;}>) {
  const formRef = useRef<ProFormInstance>();

  return (
  <ProForm
      formRef={formRef}
      submitter={props.footerToolbar ? {
        render: (_props1, dom) => <FooterToolbar>{dom}</FooterToolbar>
      } : undefined}
      params={props.params}
      request={load${entity.name}FormData}
      onFinish={props.onFinish} >
    <FormFieldContent />
  </ProForm>
  );
}

export function ${entity.name}ProFormPage() {
  const { goBack } = usePanelTab();
  const [query] = useUrlState();
  const params = useMemo(() => ({ ...query, }), [query]);
  const [messageApi, contextHolder] = message.useMessage();
  const { loading: saveLoading, runAsync: saveFormValues } = useRequest(async (values) => {
    await save${entity.name}FormData({ ...params, ...values });
    messageApi.success('保存成功');
    goBack();
    return true;
  }, { manual: true });

  return (
    <PageContainer header={{ onBack: goBack, }}>
      {contextHolder}
      <ProCard>
        <${entity.name}ProForm
          footerToolbar={true}
          params={params}
          onFinish={saveFormValues}
        />
      </ProCard>
    </PageContainer>
  );
}

export type ${entity.name}FormProps = {
  params?: any;
  onOk?: () => void;
  onClose?: () => void;
  trigger: React.JSX.Element;
}

export function ${entity.name}ModalForm(props: ${entity.name}FormProps) {
  const [query] = useUrlState();
  const [form] = Form.useForm<FormDataType>();
  const [openForm, setOpenForm] = useState<boolean>(false);
  const params = useMemo(() => ({ ...query, ...(props.params ?? {}) }), [query, props.params]);
  const [messageApi, contextHolder] = message.useMessage();
  const { loading: getLoading, runAsync: getFormValues } = useRequest(load${entity.name}FormData, { manual: true });
  const { loading: saveLoading, runAsync: saveFormValues } = useRequest(async (values) => {
    await save${entity.name}FormData({ ...params, ...values });
    messageApi.success('保存成功');
    props.onOk?.();
    return true;
  }, { manual: true });
  const loading = getLoading || saveLoading;

  useEffect(() => {
    if (params.id) {
      setOpenForm(true);
      getFormValues(params).then(values => form.setFieldsValue(values));
    }
  }, [params.id]);

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
        <FormFieldContent />
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
  const { loading: getLoading, runAsync: getFormValues } = useRequest(load${entity.name}FormData, { manual: true });
  const { loading: saveLoading, runAsync: saveFormValues } = useRequest(async (values) => {
    await save${entity.name}FormData({ ...params, ...values });
    messageApi.success('保存成功');
    props.onOk?.();
    return true;
  }, { manual: true });
  const loading = getLoading || saveLoading;

  useEffect(() => {
    if (params.id) {
      setOpenForm(true);
      getFormValues(params).then(values => form.setFieldsValue(values));
    }
  }, [params.id]);

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
        <FormFieldContent />
      </Spin>
    </DrawerForm>
  </>);
}

export default ${entity.name}ProFormPage;
