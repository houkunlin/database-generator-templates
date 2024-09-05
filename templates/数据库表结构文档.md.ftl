${gen.setFilepath("doc/db")}
${gen.setFilename("${table.name}.md")}

# 数据库表结构文档
> 作者：${developer.author}
>
> 日期：${date.toString("yyyy-MM-dd HH:mm:ss")}

## ${table.name}
${table.comment}

| 序号 | DB名称 | DB类型 | Java名称 |  Java类型 | 主键 | 描述 |
|----|------|------|------|---|----|----|
<#list columns as column>
|${column?index + 1}|${column.name}|${column.fullTypeName}|<#if column.name?starts_with("is_")>${column.field.name?replace('is','','f')?uncap_first}<#else>${column.field.name}</#if>|${column.field.typeName}|<#if column.primaryKey>是</#if>|${column.comment}|
</#list>
