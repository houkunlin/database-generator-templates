<#include "/base.ftl">
${gen.setFilepath(basePath(entity.packages.controller, 'command'))}
${gen.setFilename(entity.name.entity + "EditInfo.java")}
package ${basePackage(entity.packages.controller, 'command')};

${entity.packages}

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import javax.persistence.*;
import java.io.Serializable;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.EqualsAndHashCode;
import org.hibernate.validator.constraints.Length;
import org.springline.web.mvc.SpringlineCommand;
import javax.validation.constraints.NotBlank;

/**
* 表单对象：${entity.comment}<#if table.comment?trim?length gt 0 && entity.comment != table.comment> (${table.comment})</#if>
*
* @author ${developer.author}
*/
@ApiModel("表单对象：${entity.comment}")
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@EqualsAndHashCode(callSuper=true)
public class ${entity.name.entity}EditInfo extends SpringlineCommand {
<#list fields as field>
    <#if field.selected>
        <#if (field.name?starts_with("create") || field.name?starts_with("update")) && field.column.name?contains("time") >
        <#else>

            /**
            * ${field.comment}
            */
            <#if field.typeName == "String">
                <#if field.primaryKey>
                    @Length(max = ${field.dataType.length}, message = "${field.comment} 在 ${field.dataType.length} 个字符以内")
                <#else>
                    @NotBlank(message = "${field.comment} 不能为空")
                </#if>
                <#if field.name == "remark">
                    @Length(max = ${field.dataType.length}, message = "${field.comment} 在 ${field.dataType.length} 个字符以内")
                </#if>
            </#if>
            @ApiModelProperty("${field.comment}")
            private ${field.typeName} ${field.name};
        </#if>
    </#if>
</#list>
}
