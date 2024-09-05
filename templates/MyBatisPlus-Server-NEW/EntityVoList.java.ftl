${gen.setFilename("${entity.name}VoList.java")}
${gen.setFilepath("${settings.javaPath}/${entity.packages.entity}/")}
package ${entity.packages.entity};

${entity.packages}
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import lombok.experimental.SuperBuilder;
import java.io.Serializable;

/**
* 视图对象：${entity.comment}<#if table.comment?trim?length gt 0 && entity.comment != table.comment> (${table.comment})</#if>
*
* @author ${developer.author}
*/
@Schema(description = "视图对象：${entity.comment}")
@Data
@SuperBuilder
@EqualsAndHashCode(callSuper = true)
@NoArgsConstructor
@AllArgsConstructor
public class ${entity.name}VoList implements Serializable {
<#list fields as field>
    <#if field.selected>
        /**
        * ${field.comment}
        <#if field.column.comment?trim?length gt 0 && field.comment != field.column.comment> * <p>数据库字段说明：${field.column.comment}</p></#if>
        */
        @Schema(description = "${field.comment}")
        <#if field.typeName == 'Boolean'>
            <#if field.column.name?lower_case?starts_with("is_")>
                private boolean ${field.name?replace('is','','f')?uncap_first};
            <#else>
                private boolean ${field.name};
            </#if>
        <#else>
        private ${field.typeName} ${field.name};
        </#if>
    </#if>
</#list>
}
