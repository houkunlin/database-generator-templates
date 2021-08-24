<#include "/jdbc-type.ftl">
${gen.setFilename("FormModel.vue")}
${gen.setFilepath("ui/${entity.name}/form")}
<template>
  <a-spin :spinning="loading">
    <a-form-model ref="ruleForm" :model="entity" :rules="rules" :label-col="labelCol" :wrapper-col="wrapperCol">
      <a-row :gutter="10">
        <#list fields as field>
          <#if field.selected>
              <#if field.primaryKey || field.name?starts_with("created") || field.name?starts_with("updated") || field.name?starts_with("deleted") >
              <#else>
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
                    <#elseif type == "LONGVARCHAR" || field.name == 'remark'>
                      <a-textarea rows="4" placeholder="请输入${field.comment}" v-model="entity.${field.name}" />
                    <#elseif ["BIT","BOOLEAN"]?seq_contains(type)>
                      <a-switch checkedChildren="是:true" unCheckedChildren="否:false" v-model="entity.${field.name}" />
                    <#else>
                      <a-input placeholder="请输入${field.comment}" v-model="entity.${field.name}" allowClear />
                    </#if>
                  </a-form-model-item>
                </a-col>
              </#if>
          </#if>
        </#list>
      </a-row>
    </a-form-model>
  </a-spin>
</template>

<script>
import PropTypes from 'ant-design-vue/lib/_util/vue-types'
import { ${entity.name} as defaultEntity } from '../model'
import { save${entity.name}, get${entity.name}Info } from './../service'
import { showError } from '@/utils/util'

export default {
  components: {
  },
  props: {
      // 正在编辑的 角色信息 ID
      editId: PropTypes.string.def(undefined)
  },
  data () {
    return {
      labelCol: {xs: { span: 24 }, sm: { span: 6 }},
      wrapperCol: {xs: { span: 24 }, sm: { span: 18 }},
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
      editId () {
      this.loadEntity()
    },
      loading(val){
          this.$emit('update:loading', val)
      }
  },
    computed: {
        // editId () {
        //     return this.editId
        // }
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
      const { editId } = this
      if (editId == null) {
        return
      }
        this.loading = true
      // 获取单个信息
      get${entity.name}Info(editId)
        .then(res => {
          // 数据获取成功
          this.entity = res
        })
        .catch(showError)
        .finally(() => {
            this.loading = false
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

        this.loading = true
          save${entity.name}(entity)
          .then(res => {
            // 调用回调事件：ok
            this.$emit('ok')
              this.$emit('update:editId', undefined)
          })
          .catch(showError)
          .finally(() => {
              this.loading = false
          })
      })
    },
    resetForm () {
      const { $refs: { ruleForm } } = this
      if (ruleForm != null) {
        ruleForm.resetFields()
      }
      this.loading = false
      this.entity = { ...defaultEntity }
    }
  }
}
</script>

<style scoped>

</style>
