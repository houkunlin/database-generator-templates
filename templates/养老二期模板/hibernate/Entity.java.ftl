${gen.setType("entity")}
package ${entity.packages.entity};

${entity.packages}

import javax.persistence.*;
import java.io.Serializable;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.FieldNameConstants;
import org.hibernate.annotations.GenericGenerator;
import org.springline.beans.dictionary.support.DictionaryBuilder;
import org.springline.beans.dictionary.DictionaryUtils;

/**
* 实体类：${entity.comment}<#if table.comment?trim?length gt 0 && entity.comment != table.comment> (${table.comment})</#if>
*
* @author ${developer.author}
*/
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@FieldNameConstants
@Entity
@Table(name = "${table.name}")
public class ${entity.name.entity} implements Serializable {
<#list fields as field>
    <#if field.selected>

        /**
        * ${field.comment}
        */
        <#if field.primaryKey>
            @Id
            @GenericGenerator(name="id", strategy="uuid")
            @GeneratedValue(generator="id")
        <#else>
            @Basic
        </#if>
        <#if (field.name?starts_with("create") || field.name?starts_with("update")) && field.column.name?contains("time") >
            @Column(name = "${field.column.name}", insertable = false, updatable = false)
        <#else>
            @Column(name = "${field.column.name}")
        </#if>
        private ${field.typeName} ${field.name};
    </#if>
</#list>
}
