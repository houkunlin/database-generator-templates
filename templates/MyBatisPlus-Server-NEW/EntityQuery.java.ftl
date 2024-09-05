${gen.setFilename("${entity.name}Query.java")}
${gen.setFilepath("${settings.javaPath}/${entity.packages.entity}/")}
package ${entity.packages.entity};

${entity.packages}
import io.swagger.v3.oas.annotations.media.Schema;
import com.baomidou.mybatisplus.extension.conditions.query.LambdaQueryChainWrapper;
import com.baomidou.mybatisplus.extension.conditions.query.QueryChainWrapper;
import com.houkunlin.cloud.micro.query.LambdaQuery;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
* 查询对象：${entity.comment}<#if table.comment?trim?length gt 0 && entity.comment != table.comment> (${table.comment})</#if>
*
* @author ${developer.author}
*/
@Schema(description = "查询对象：${entity.comment}")
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ${entity.name}Query implements LambdaQuery<${entity.name.entity}> {
<#list fields as field>
    <#if field.selected>
        <#if field.name?starts_with("created") || field.name?starts_with("updated") || field.name?starts_with("deleted") || field.name?starts_with("isDeleted") || field.name?starts_with("revision") || field.name?starts_with("tenantId") >
        <#else>
            /**
            * ${field.comment}
            <#if field.column.comment?trim?length gt 0 && field.comment != field.column.comment> * <p>数据库字段说明：${field.column.comment}</p></#if>
            */
            @Schema(description = "${field.comment}")
            <#if field.column.name?lower_case?starts_with("is_")>
            private ${field.typeName} ${field.name?replace('is','','f')?uncap_first};
            <#else>
            private ${field.typeName} ${field.name};
            </#if>
        </#if>
    </#if>
</#list>

    @Override
    public LambdaQueryChainWrapper<${entity.name.entity}> queryBuilder(final LambdaQueryChainWrapper<${entity.name.entity}> wrapper) {
        <#list fields as field>
            <#if field.selected>
                <#if field.name?starts_with("created") || field.name?starts_with("updated") || field.name?starts_with("deleted") || field.name?starts_with("isDeleted") || field.name?starts_with("revision") || field.name?starts_with("tenantId") >
                <#elseif field.typeName == 'Boolean'>
                    <#if field.column.name?lower_case?starts_with("is_")>
                        addQuery(${entity.name.entity}::is${field.name?replace('is','','f')}, ${field.name?replace('is','','f')?uncap_first}, wrapper::eq);
                    <#else>
                        addQuery(${entity.name.entity}::is${field.name.firstUpper}, ${field.name}, wrapper::eq);
                    </#if>
                <#elseif field.typeName == 'String'>
                    addQuery(${entity.name.entity}::get${field.name.firstUpper}, ${field.name}, wrapper::like);
                <#else>
                    addQuery(${entity.name.entity}::get${field.name.firstUpper}, ${field.name}, wrapper::eq);
                </#if>
            </#if>
        </#list>
            return wrapper;
    }

    @Override
    public QueryChainWrapper<${entity.name.entity}> queryBuilder(final QueryChainWrapper<${entity.name.entity}> wrapper) {
<#list fields as field>
    <#if field.selected>
        <#if field.name?starts_with("created") || field.name?starts_with("updated") || field.name?starts_with("deleted") || field.name?starts_with("isDeleted") || field.name?starts_with("revision") || field.name?starts_with("tenantId") >
        <#elseif field.typeName == 'Boolean'>
            <#if field.column.name?lower_case?starts_with("is_")>
                addQuery(getColumnByPropertyCache(${entity.name.entity}.Fields.${field.name?replace('is','','f')?uncap_first}), ${field.name?replace('is','','f')?uncap_first}, wrapper::eq);
            <#else>
                addQuery(getColumnByPropertyCache(${entity.name.entity}.Fields.${field.name}), ${field.name}, wrapper::eq);
            </#if>
        <#elseif field.typeName == 'String'>
            addQuery(getColumnByPropertyCache(${entity.name.entity}.Fields.${field.name}), ${field.name}, wrapper::like);
        <#else>
            addQuery(getColumnByPropertyCache(${entity.name.entity}.Fields.${field.name}), ${field.name}, wrapper::eq);
        </#if>
    </#if>
</#list>
            return wrapper;
    }
}
