<#include '/jdbc-typescript-type.ftl'>
${gen.setFilename("typings.d.ts")}
${gen.setFilepath("ui/${entity.name}/")}
declare namespace ${entity.name} {
    // ${entity.comment}<#if table.comment?trim?length gt 0 && entity.comment != table.comment> (${table.comment})</#if>
    type Field =
    <#list fields as field>
        <#if field.selected>
            | '${field.name}' // ${field.comment}<#if field.column.comment?trim?length gt 0 && field.comment != field.column.comment> (数据库字段说明：${field.column.comment})</#if>
        </#if>
    </#list>
    ;
    // ${entity.comment}<#if table.comment?trim?length gt 0 && entity.comment != table.comment> (${table.comment})</#if>
    type Entity = {
    <#list fields as field>
        <#if field.selected>
            // ${field.typeName} ${field.comment}
            ${field.name}?: ${getTypeScriptType(field.column)};
        </#if>
    </#list>

      [key: string]: any;
    };
    type Page = API.Page<Entity>;
    type Query = {
     id?: string;
    [key: string]: any;
    }
}
