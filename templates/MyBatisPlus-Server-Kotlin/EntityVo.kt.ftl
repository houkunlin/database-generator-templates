${gen.setType("vo")}
package ${entity.packages.vo}

${entity.packages}
import io.swagger.v3.oas.annotations.media.Schema
import lombok.AllArgsConstructor
import lombok.Builder
import lombok.Data
import lombok.NoArgsConstructor
import lombok.experimental.SuperBuilder
import java.io.Serializable
import java.time.LocalDateTime

/**
* 视图对象：${entity.comment}<#if table.comment?trim?length gt 0 && entity.comment != table.comment> (${table.comment})</#if>
*
* @author ${developer.author}
*/
@Schema(description = "视图对象：${entity.comment}")
class ${entity.name.vo} : Serializable {
<#list fields as field>
    <#if field.selected>
        /**
        * ${field.comment}<#if field.column.comment?trim?length gt 0 && field.comment != field.column.comment>
        * <p>数据库字段说明：${field.column.comment}</p></#if>
        */
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
</#list>
}
