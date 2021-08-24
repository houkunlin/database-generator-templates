
<#function basePath source p1>
    <#return settings.javaPath + "/" + basePackage(source, p1)>
</#function>

<#function basePackage source p1>
    <#return source?replace("(?<=\\.)\\w+$", p1, 'ri')>
</#function>

<#function subPath source p1>
    <#return settings.javaPath + "/" + subPackage(source, p1)>
</#function>

<#function subPackage source p1>
    <#return source + "." + p1>
</#function>
