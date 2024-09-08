<#include '/jdbc-typescript-type.ftl'>
${gen.setFilename("typings.d.ts")}
${gen.setFilepath("ui/${entity.name}/")}
declare namespace ${entity.name} {
    // ${entity.comment}<#if table.comment?trim?length gt 0 && entity.comment != table.comment> (${table.comment})</#if>
    type Field =
    <#list fields as field>
        <#if field.selected>
            <#if field.typeName == 'Boolean'>
                <#if field.column.name?lower_case?starts_with("is_")>
                    | '${field.name?replace('is','','f')?uncap_first}' // ${field.comment}<#if field.column.comment?trim?length gt 0 && field.comment != field.column.comment> (数据库字段说明：${field.column.comment})</#if>
                <#else>
                    | '${field.name}' // ${field.comment}<#if field.column.comment?trim?length gt 0 && field.comment != field.column.comment> (数据库字段说明：${field.column.comment})</#if>
                </#if>
            <#else>
                | '${field.name}' // ${field.comment}<#if field.column.comment?trim?length gt 0 && field.comment != field.column.comment> (数据库字段说明：${field.column.comment})</#if>
            </#if>
        </#if>
    </#list>
    ;
    // ${entity.comment}<#if table.comment?trim?length gt 0 && entity.comment != table.comment> (${table.comment})</#if>
    type Entity = {
    <#list fields as field>
        <#if field.selected>
            // ${field.typeName} ${field.comment}
            <#if field.typeName == 'Boolean'>
                <#if field.column.name?lower_case?starts_with("is_")>
                    ${field.name?replace('is','','f')?uncap_first}?: ${getTypeScriptType(field.column)};
                <#else>
                    ${field.name}?: ${getTypeScriptType(field.column)};
                </#if>
            <#else>
                ${field.name}?: ${getTypeScriptType(field.column)};
            </#if>
        </#if>
    </#list>

      [key: string]: any;
    };
    type Page = API.Page<Entity>;
    type Query = {
    ${primary.field.name}?: string;
    [key: string]: any;
    }
}

declare namespace SERVER {
    // ${entity.comment}<#if table.comment?trim?length gt 0 && entity.comment != table.comment> (${table.comment})</#if>
    export type ${entity.name} = {
    <#list fields as field>
        <#if field.selected>
            // ${field.typeName} ${field.comment}
            <#if field.typeName == 'Boolean'>
                <#if field.column.name?lower_case?starts_with("is_")>
                    ${field.name?replace('is','','f')?uncap_first}?: ${getTypeScriptType(field.column)};
                <#else>
                    ${field.name}?: ${getTypeScriptType(field.column)};
                </#if>
            <#else>
                ${field.name}?: ${getTypeScriptType(field.column)};
            </#if>
        </#if>
    </#list>

      [key: string]: any;
    };
    export type ${entity.name}Form = {
    <#list fields as field>
        <#if field.selected && !isIgnoreField(field)>
            // ${field.typeName} ${field.comment}
            <#if field.typeName == 'Boolean'>
                <#if field.column.name?lower_case?starts_with("is_")>
                    ${field.name?replace('is','','f')?uncap_first}?: ${getTypeScriptType(field.column)};
                <#else>
                    ${field.name}?: ${getTypeScriptType(field.column)};
                </#if>
            <#else>
                ${field.name}?: ${getTypeScriptType(field.column)};
            </#if>
        </#if>
    </#list>

      [key: string]: any;
    };
    export type ${entity.name}Query = {
    <#list fields as field>
        <#if field.selected && !isIgnoreField(field)>
            // ${field.typeName} ${field.comment}
            <#if field.typeName == 'Boolean'>
                <#if field.column.name?lower_case?starts_with("is_")>
                    ${field.name?replace('is','','f')?uncap_first}?: ${getTypeScriptType(field.column)};
                <#else>
                    ${field.name}?: ${getTypeScriptType(field.column)};
                </#if>
            <#else>
                ${field.name}?: ${getTypeScriptType(field.column)};
            </#if>
        </#if>
    </#list>

      [key: string]: any;
    };
    export type ${entity.name}Vo = ${entity.name};
    export type ${entity.name}VoDetail = ${entity.name};
    export type ${entity.name}VoList = ${entity.name};
}
