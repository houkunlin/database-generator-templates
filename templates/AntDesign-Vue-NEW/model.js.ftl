${gen.setFilename("model.js")}
${gen.setFilepath("ui/${entity.name}/")}
// 分页参数设置
export const defaultPagination = {
  // 只有一页时是否隐藏分页器
  hideOnSinglePage: false,
  // 指定每页可以显示多少条
  pageSizeOptions: ['10', '20', '30', '40', '50', '100'],
  // 显示较少的页面项
  showLessItems: true,
  // 是否可以快速跳转至某页
  showQuickJumper: true,
  // 是否可以改变 pageSize
  showSizeChanger: true,
  // 数据总数
  total: 0,
  // 当前页数
  current: 1,
  // 每页条数
  pageSize: 10
}

export const columns = [
  <#list fields as field>
  <#if field.selected>
      <#if field.primaryKey>
      <#else>
{<#if field.column.comment?trim?length gt 0 && field.comment != field.column.comment>// 数据库字段说明：${field.column.comment}</#if>
title: '${field.comment}',
dataIndex: '${field.name}',
sorter: false,
          <#if field.name?starts_with("created") || field.name?starts_with("updated") >
              width: 160,
          </#if>
align: 'center'
},
      </#if>
  </#if>
  </#list>
  {
    title: '操作',
    dataIndex: 'action',
    width: 160,
    scopedSlots: {customRender: 'action'}
  }
]

// ${entity.comment}<#if table.comment?trim?length gt 0 && entity.comment != table.comment> (${table.comment})</#if>
export const ${entity.name} = {
<#list fields as field>
    <#if field.selected>
        // ${field.comment}<#if field.column.comment?trim?length gt 0 && field.comment != field.column.comment> (数据库字段说明：${field.column.comment})</#if>
        ${field.name}: undefined,
    </#if>
</#list>
}
