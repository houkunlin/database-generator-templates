${gen.setFilepath("doc/db")}
${gen.setFilename("${table.name}.md")}

# 数据库表结构文档
> 作者：${developer.author}
>
> 日期：${date.toString("yyyy-MM-dd HH:mm:ss")}

## ${table.name}
${table.comment}

| 序号 | DB字段 | Java字段 | DB类型 | Java类型 | 主键 | 描述 |
|----|------|------|------|---|----|----|
<#list columns as column>
|${column?index + 1}|${column.name}|<#if column.name?starts_with("is_")>${column.field.name?replace('is','','f')?uncap_first}<#else>${column.field.name}</#if>|${column.fullTypeName}|${column.field.typeName}|<#if column.primaryKey>是</#if>|${column.comment}|
</#list>
