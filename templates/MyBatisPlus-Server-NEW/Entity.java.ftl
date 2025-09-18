${gen.setType("entity")}
package ${entity.packages.entity};

import com.baomidou.mybatisplus.annotation.*;
${entity.packages}
import java.io.Serializable;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import lombok.experimental.FieldNameConstants;
import lombok.experimental.SuperBuilder;

/**
* 实体类：${entity.comment}<#if table.comment?trim?length gt 0 && entity.comment != table.comment> (${table.comment})</#if>
*
* @author ${developer.author}
*/
@Data
@FieldNameConstants
@SuperBuilder
@EqualsAndHashCode(callSuper = true)
@NoArgsConstructor
@AllArgsConstructor
@TableName("${table.name}")
public class ${entity.name.entity} implements Serializable {
<#list fields as field>
    <#if field.selected>
        /**
        * ${field.comment}
        <#if field.column.comment?trim?length gt 0 && field.comment != field.column.comment> * <p>数据库字段说明：${field.column.comment}</p></#if>
        */
        <#if field.primaryKey>
            @OrderBy(asc = true)
            @TableId(value = "${field.column.name}", type = IdType.ASSIGN_ID)
        </#if>
        <#if field.name?starts_with("created") || field.name?starts_with("deleted") || field.name?starts_with("isDeleted")>
            @TableField(value = "${field.column.name}", updateStrategy = FieldStrategy.NEVER, fill = FieldFill.INSERT)
        <#elseif field.name?starts_with("updated")>
            @TableField(value = "${field.column.name}", fill = FieldFill.INSERT_UPDATE)
        <#elseif field.name?starts_with("revision") || field.name?starts_with("version")>
            @Version
            @TableField("${field.column.name}")
        <#elseif !field.primaryKey>
            @TableField("${field.column.name}")
        </#if>
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
