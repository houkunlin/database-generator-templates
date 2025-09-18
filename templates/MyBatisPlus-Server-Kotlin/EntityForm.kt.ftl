${gen.setType("form")}
package ${entity.packages.form}

${entity.packages}
import io.swagger.v3.oas.annotations.media.Schema
import jakarta.validation.constraints.NotBlank
import org.hibernate.validator.constraints.Length
import java.io.Serializable

/**
 * 表单对象：${entity.comment}<#if table.comment?trim?length gt 0 && entity.comment != table.comment> (${table.comment})</#if>
 *
 * @author ${developer.author}
 */
@Schema(description = "表单对象：${entity.comment}")
class ${entity.name.form} : Serializable {
<#list fields as field>
    <#if field.selected>
        <#if field.name?starts_with("created") || field.name?starts_with("updated") || field.name?starts_with("deleted") || field.name?starts_with("isDeleted") || field.name?starts_with("revision") || field.name?starts_with("tenantId") >
        <#else>
            /**
            * ${field.comment}<#if field.column.comment?trim?length gt 0 && field.comment != field.column.comment>
            * <p>数据库字段说明：${field.column.comment}</p></#if>
            */
            <#if field.typeName == "String">
                <#if field.primaryKey>
                    @Length(max = ${field.dataType.length}, message = "${field.comment} 在 ${field.dataType.length} 个字符以内")
                <#else>
                    <#if field.name == "remark">
                        @Length(max = ${field.dataType.length}, message = "${field.comment} 在 ${field.dataType.length} 个字符以内")
                    <#else>
                        @Length(max = ${field.dataType.length}, message = "${field.comment} 在 ${field.dataType.length} 个字符以内")
                        @NotBlank(message = "${field.comment} 不能为空")
                    </#if>
                </#if>
            </#if>
            @Schema(description = "${field.comment}")
            <#if field.typeName == 'Boolean'>
                <#if field.column.name?lower_case?starts_with("is_")>
                    var ${field.name?replace('is','','f')?uncap_first}: Boolean? = null
                <#else>
                    var ${field.name}: Boolean? = null
                </#if>
            <#else>
                var ${field.name}: ${field.typeName}? = null
            </#if>
        </#if>
    </#if>
</#list>
}
