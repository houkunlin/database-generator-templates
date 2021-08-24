<#include "/jdbc-type.ftl">
${gen.setFilename("TableListSearchForm.vue")}
${gen.setFilepath("${settings.sourcesPath}/ui/${entity.name}/")}
<template>
  <!-- 查询表单信息 -->
  <div class="table-page-search-wrapper">
    <a-form :label-col="labelCol" :wrapper-col="wrapperCol">
      <a-row :gutter="10">
        <#list fields as field>
          <#if field.selected>
            <a-col v-bind="queryCol">
              <a-form-item label="${field.comment}"><#if field.column.comment?trim?length gt 0 && field.comment != field.column.comment><!-- 数据库字段说明：${field.column.comment} --></#if>
                <#assign type = jdbcType(field.column) />
                <#if ["INTEGER","FLOAT","DOUBLE","DECIMAL","TINYINT","SMALLINT","BIGINT"]?seq_contains(type)>
                  <a-input-number placeholder="请输入${field.comment}" v-model="queryParam.${field.name}" />
                <#elseif type == "DATE">
                  <a-date-picker
                    v-model="queryParam.${field.name}"
                    format="YYYY-MM-DD"
                    valueFormat="YYYY-MM-DD"
                    placeholder="请输入${field.comment}" />
                <#elseif type == "TIME">
                  <a-time-picker
                    v-model="queryParam.${field.name}"
                    valueFormat="HH:mm:ss"
                    placeholder="请输入${field.comment}" />
                <#elseif type == "TIMESTAMP">
                  <a-date-picker
                    v-model="queryParam.${field.name}"
                    :showTime="true"
                    format="YYYY-MM-DD HH:mm:ss"
                    valueFormat="YYYY-MM-DD HH:mm:ss"
                    placeholder="请输入${field.comment}" />
                <#elseif ["BIT","BOOLEAN"]?seq_contains(type)>
                  <a-select v-model="queryParam.${field.name}" placeholder="请选择${field.comment}" default-value="">
                    <a-select-option value="">全部</a-select-option>
                    <a-select-option :value="true">是：true</a-select-option>
                    <a-select-option :value="false">否：false</a-select-option>
                  </a-select>
                <#else>
                  <a-input placeholder="请输入${field.comment}" v-model="queryParam.${field.name}" allowClear />
                </#if>
              </a-form-item>
            </a-col>
          </#if>
        </#list>
        <div v-show="advanced" ref="advancedRef">
        </div>
      </a-row>
      <a-row>
        <a-col :span="24" :style="{ textAlign: 'right' }">
          <a-button type="primary" @click="onSearch">查询</a-button>
          <a-button style="margin-left: 8px" @click="onReset">重置</a-button>
          <a v-if="showAdvanced" @click="advanced = !advanced" style="margin-left: 8px">
            {{ advanced ? '收起' : '展开' }}
            <a-icon :type="advanced ? 'up' : 'down'" />
          </a>
        </a-col>
      </a-row>
    </a-form>
  </div>
</template>

<script>
import PropTypes from 'ant-design-vue/lib/_util/vue-types'

export default {
  name: 'TableListSearchForm',
  model: {
    prop: 'value',
    event: 'change.value'
  },
  props: {
    value: PropTypes.any.def({})
  },
  data () {
    return {
      queryParam: {},
      // 标记查询表单是否展开显示更多信息
      advanced: false,
      // 显示更过
      showAdvanced: false,
      labelCol: { sm: { span: 6 }, md: { span: 8 }, lg: { span: 10 }, xl: { span: 8 }, xxl: { span: 6 } },
      wrapperCol: { sm: { span: 18 }, md: { span: 16 }, lg: { span: 14 }, xl: { span: 16 }, xxl: { span: 18 } },
      queryCol: { sm: 24, md: 12, lg: 6, xl: 6, xxl: 6 }
    }
  },
  watch: {
    value (val) {
      this.queryParam = val
    },
    queryParam (val) {
      this.$emit('change.value', val)
      this.$emit('change', val)
    }
  },
  mounted () {
    this.showAdvanced = this.$refs.advancedRef && this.$refs.advancedRef.children.length > 0 || false
  },
  methods: {
    onSearch () {
      this.$emit('search', this.queryParam)
    },
    onReset () {
      this.queryParam = {}
      this.$emit('reset')
    }
  }
}
</script>

<style scoped>

</style>
