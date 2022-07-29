<#include "/base.ftl">
${gen.setFilepath(basePath(entity.packages.controller, 'command'))}
${gen.setFilename(entity.name.entity + "QueryInfo.java")}
package ${basePackage(entity.packages.controller, 'command')};

${entity.packages}

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import javax.persistence.*;
import java.io.Serializable;
import lombok.Builder;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.FieldNameConstants;

import org.springline.SpringlineHelper;
import org.springline.web.pagination.PaginationInfo;

/**
* 前端传入查询参数对象：${entity.comment}<#if table.comment?trim?length gt 0 && entity.comment != table.comment> (${table.comment})</#if>
*
* @author ${developer.author}
*/
@ApiModel("查询参数对象：${entity.comment}")
@Data
@Builder
@FieldNameConstants
@EqualsAndHashCode(callSuper=true)
public class ${entity.name.entity}QueryInfo extends PaginationInfo {
<#list fields as field>
    <#if field.selected>

        /**
        * ${field.comment}
        */
        @ApiModelProperty("${field.comment}")
        <#if field.name == 'isValid'>
            private ${field.typeName} ${field.name} = SpringlineHelper.YES;
        <#else>
            private ${field.typeName} ${field.name};
        </#if>
    </#if>
</#list>

}
