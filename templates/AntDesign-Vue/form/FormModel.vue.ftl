<#include "/jdbc-type.ftl">
${gen.setFilename("FormModel.vue")}
${gen.setFilepath("${settings.sourcesPath}/ui/${entity.name}/form")}
<template>
  <a-spin :spinning="loading">
    <a-form-model ref="ruleForm" :model="entity" :rules="rules" :label-col="labelCol" :wrapper-col="wrapperCol">
      <a-row :gutter="10">
        <#list fields as field>
          <#if field.selected>
            <a-col :span="colSpan">
              <a-form-model-item has-feedback prop="${field.name}" label="${field.comment}"><#if field.column.comment?trim?length gt 0 && field.comment != field.column.comment><!-- 数据库字段说明：${field.column.comment} --></#if>
                <#assign type = jdbcType(field.column) />
                <#if ["INTEGER","FLOAT","DOUBLE","DECIMAL","TINYINT","SMALLINT","BIGINT"]?seq_contains(type)>
                  <a-input-number placeholder="请输入${field.comment}" v-model="entity.${field.name}" />
                <#elseif type == "DATE">
                  <a-date-picker
                    v-model="entity.${field.name}"
                    format="YYYY-MM-DD"
                    valueFormat="YYYY-MM-DD"
                    placeholder="请输入${field.comment}" />
                <#elseif type == "TIME">
                  <a-time-picker
                    v-model="entity.${field.name}"
                    valueFormat="HH:mm:ss"
                    placeholder="请输入${field.comment}" />
                <#elseif type == "TIMESTAMP">
                  <a-date-picker
                    v-model="entity.${field.name}"
                    :showTime="true"
                    format="YYYY-MM-DD HH:mm:ss"
                    valueFormat="YYYY-MM-DD HH:mm:ss"
                    placeholder="请输入${field.comment}" />
                <#elseif type == "LONGVARCHAR">
                  <a-textarea rows="4" placeholder="请输入${field.comment}" v-model="entity.${field.name}" />
                <#elseif ["BIT","BOOLEAN"]?seq_contains(type)>
                  <a-switch checkedChildren="是:true" unCheckedChildren="否:false" v-model="entity.${field.name}" />
                <#else>
                  <a-input placeholder="请输入${field.comment}" v-model="entity.${field.name}" allowClear />
                </#if>
              </a-form-model-item>
            </a-col>
          </#if>
        </#list>
      </a-row>
    </a-form-model>
  </a-spin>
</template>

<script>
import DataDictionarySelect from '@/views/system/DataDictionary/DataDictionarySelect'
import DataDictionaryRadioGroup from '@/views/system/DataDictionary/DataDictionaryRadioGroup'
import { ${entity.name} as defaultEntity } from '../model'
import { add${entity.name}, get${entity.name}Info, update${entity.name} } from './../service'
import { showError } from '@/utils/util'
import { props } from './mixin'

export default {
  components: {
    DataDictionarySelect,
    DataDictionaryRadioGroup
  },
  props,
  data () {
    return {
      labelCol: {
        xs: { span: 24 },
        sm: { span: 6 }
      },
      wrapperCol: {
        xs: { span: 24 },
        sm: { span: 18 }
      },
      colSpan: 21,
      // 表单和确定按钮是否处于加载状态
      loading: false,
      // 当前正在编辑的 ${entity.comment} 信息
      entity: { ...defaultEntity },
      rules: {
    <#list fields as field>
    <#if field.selected>
    // ${field.comment}<#if field.column.comment?trim?length gt 0 && field.comment != field.column.comment> (数据库字段说明：${field.column.comment})</#if>
    ${field.name}: [{required: true, message: '请输入${field.comment}', trigger: 'change'}],
    </#if>
    </#list>
      }
    }
  },
  watch: {
    editInfoId (val) {
      this.loadEntity()
    }
  },
  mounted () {
    this.loadEntity()
  },
  methods: {
    /**
     * 加载数据信息
     */
    loadEntity () {
      // 重置表单内容和表单状态
      this.resetForm()
      const { editInfoId } = this
      if (editInfoId == null) {
        return
      }
      this.setLoading(true)
      // 获取单个信息
      get${entity.name}Info(editInfoId)
        .then(res => {
          // 数据获取成功
          this.entity = res.data
        })
        .catch(err => showError(err))
        .finally(() => {
          this.setLoading(false)
        })
    },
    /**
     * 处理表单提交事件
     */
    handleSubmit () {
      const { $refs: { ruleForm }, entity } = this
      ruleForm.validate((valid, errorValues) => {
        if (!valid) {
          return
        }
        let promise

        this.setLoading(true)
        if (entity.id && entity.id.trim().length > 0) {
          // 一个拥有 主键ID 的数据，采用修改操作
          promise = update${entity.name}(entity.id, entity)
        } else {
          // 新增数据
          promise = add${entity.name}(entity)
        }
        promise
          .then(res => {
            // 调用回调事件：ok
            this.$emit('ok')
          })
          .catch(err => showError(err))
          .finally(() => {
            this.setLoading(false)
          })
      })
    },
    resetForm () {
      const { $refs: { ruleForm } } = this
      if (ruleForm != null) {
        ruleForm.resetFields()
      }
      this.setLoading(false)
      this.entity = { ...defaultEntity }
    },
    setLoading (loading) {
      this.loading = loading
      this.$emit('loading', loading)
    }
  }
}
</script>

<style scoped>

</style>
