${gen.setFilename("${entity.name}Query.java")}
${gen.setFilepath("${settings.javaPath}/${entity.packages.entity}/")}
package ${entity.packages.entity};

${entity.packages}

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import com.baomidou.mybatisplus.extension.conditions.query.LambdaQueryChainWrapper;
import com.baomidou.mybatisplus.extension.conditions.query.QueryChainWrapper;
import com.houkunlin.dao.extend.mybatisplus.LambdaQuery;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
* 查询对象：${entity.comment}<#if table.comment?trim?length gt 0 && entity.comment != table.comment> (${table.comment})</#if>
*
* @author ${developer.author}
*/
@ApiModel("查询对象：${entity.comment}")
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ${entity.name}Query implements LambdaQuery<${entity.name.entity}> {
<#list fields as field>
    <#if field.selected>
        <#if field.name?starts_with("created") || field.name?starts_with("updated") || field.name?starts_with("deleted") >
        <#else>
            /**
            * ${field.comment}
            <#if field.column.comment?trim?length gt 0 && field.comment != field.column.comment> * <p>数据库字段说明：${field.column.comment}</p></#if>
            */
            @ApiModelProperty("${field.comment}")
            private ${field.typeName} ${field.name};
        </#if>
    </#if>
</#list>

    @Override
    public LambdaQueryChainWrapper<${entity.name.entity}> queryBuilder(final LambdaQueryChainWrapper<${entity.name.entity}> wrapper) {
        <#list fields as field>
            <#if field.selected>
                <#if field.name?starts_with("created") || field.name?starts_with("updated") || field.name?starts_with("deleted") >
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
        <#if field.name?starts_with("created") || field.name?starts_with("updated") || field.name?starts_with("deleted") >
        <#else>
            addQuery("${field.column.name}", ${field.name}, wrapper::eq);
        </#if>
    </#if>
</#list>
            return wrapper;
    }
}
