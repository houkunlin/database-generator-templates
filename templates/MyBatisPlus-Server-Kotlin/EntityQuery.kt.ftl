${gen.setType("query")}
package ${entity.packages.query}

import ${entity.packages.entity.full}

import com.baomidou.mybatisplus.extension.conditions.query.QueryChainWrapper
import com.baomidou.mybatisplus.extension.kotlin.KtQueryChainWrapper
import io.swagger.v3.oas.annotations.media.Schema
import kotlin.reflect.KMutableProperty1
import com.saas.query.ColumnQuery
import com.saas.query.KtQuery

/**
* 查询对象：${entity.comment}<#if table.comment?trim?length gt 0 && entity.comment != table.comment> (${table.comment})</#if>
*
* @author ${developer.author}
*/
@Schema(description = "查询对象：${entity.comment}")
class ${entity.name.query} : KtQuery<${entity.name.entity}>, ColumnQuery<${entity.name.entity}> {
<#list fields as field>
    <#if field.selected>
        <#if field.name?starts_with("created") || field.name?starts_with("updated") || field.name?starts_with("deleted") || field.name?starts_with("isDeleted") || field.name?starts_with("revision") || field.name?starts_with("tenantId") >
        <#else>
            /**
            * ${field.comment}<#if field.column.comment?trim?length gt 0 && field.comment != field.column.comment>
            * <p>数据库字段说明：${field.column.comment}</p></#if>
            */
            @Schema(description = "${field.comment}")
            <#if field.column.name?lower_case?starts_with("is_")>
                var ${field.name?replace('is','','f')?uncap_first}: ${field.typeName}? = null
            <#else>
                var ${field.name}: ${field.typeName}? = null
            </#if>
        </#if>
    </#if>
</#list>

    /**
    * 搜索关键词、关键字
    */
    @Schema(description = "搜索关键词、关键字")
    var keyword: String? = null

    override fun addQueryKeyword(
        keyword: String?,
        wrapper: KtQueryChainWrapper<${entity.name.entity}>,
        vararg sFunctions: KMutableProperty1<${entity.name.entity}, *>
    ) {
        addQueryKeyword(keyword, wrapper, null, *sFunctions)
    }

    override fun queryBuilder(wrapper: KtQueryChainWrapper<${entity.name.entity}>): KtQueryChainWrapper<${entity.name.entity}> {
        <#list fields as field>
            <#if field.selected>
                <#if field.name?starts_with("created") || field.name?starts_with("updated") || field.name?starts_with("deleted") || field.name?starts_with("isDeleted") || field.name?starts_with("revision") || field.name?starts_with("tenantId") >
                <#elseif field.typeName == 'Boolean'>
                    <#if field.column.name?lower_case?starts_with("is_")>
                        addQuery(${entity.name.entity}::${field.name?replace('is','','f')}, ${field.name?replace('is','','f')?uncap_first}, wrapper::eq)
                    <#else>
                        addQuery(${entity.name.entity}::${field.name}, ${field.name}, wrapper::eq)
                    </#if>
                <#elseif field.typeName == 'String'>
                    addQuery(${entity.name.entity}::${field.name}, ${field.name}, wrapper::like)
                <#else>
                    addQuery(${entity.name.entity}::${field.name}, ${field.name}, wrapper::eq)
                </#if>
            </#if>
        </#list>
        addQueryKeyword(
            keyword, wrapper,
            <#list fields as field>
                <#if field.selected>
                    <#if field.name?starts_with("created") || field.name?starts_with("updated") || field.name?starts_with("deleted") || field.name?starts_with("isDeleted") || field.name?starts_with("revision") || field.name?starts_with("tenantId") >
                    <#elseif field.typeName == 'String'>
                        ${entity.name.entity}::${field.name},
                    </#if>
                </#if>
            </#list>
        )
        return wrapper
    }

    override fun queryBuilder(wrapper: QueryChainWrapper<${entity.name.entity}>): QueryChainWrapper<${entity.name.entity}> {
        <#list fields as field>
            <#if field.selected>
                <#if field.name?starts_with("created") || field.name?starts_with("updated") || field.name?starts_with("deleted") || field.name?starts_with("isDeleted") || field.name?starts_with("revision") || field.name?starts_with("tenantId") >
                <#elseif field.typeName == 'Boolean'>
                    <#if field.column.name?lower_case?starts_with("is_")>
                        addQueryProperty(${entity.name.entity}::${field.name?replace('is','','f')}.name, ${field.name?replace('is','','f')?uncap_first}, wrapper::eq)
                    <#else>
                        addQueryProperty(${entity.name.entity}::${field.name}.name, ${field.name}, wrapper::eq)
                    </#if>
                <#elseif field.typeName == 'String'>
                    addQueryProperty(${entity.name.entity}::${field.name}.name, ${field.name}, wrapper::like)
                <#else>
                    addQueryProperty(${entity.name.entity}::${field.name}.name, ${field.name}, wrapper::eq)
                </#if>
            </#if>
        </#list>
        addQueryKeywordProperty(
            keyword, wrapper,
            <#list fields as field>
                <#if field.selected>
                    <#if field.name?starts_with("created") || field.name?starts_with("updated") || field.name?starts_with("deleted") || field.name?starts_with("isDeleted") || field.name?starts_with("revision") || field.name?starts_with("tenantId") >
                    <#elseif field.typeName == 'String'>
                        ${entity.name.entity}::${field.name}.name,
                    </#if>
                </#if>
            </#list>
        )
        return wrapper
    }
}
