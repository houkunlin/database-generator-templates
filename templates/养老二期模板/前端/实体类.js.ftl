${gen.setFilepath("temp/")}
${gen.setFilename(table.name?lower_case?replace("_", "-") + "-data.js")}

// ${entity.comment}
export const ${entity.name} = {
<#list fields as field>
    <#if field.selected>
        // ${field.typeName} ${field.comment}
        ${field.name}: null,
    </#if>
</#list>
}
