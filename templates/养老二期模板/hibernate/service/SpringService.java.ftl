<#include "/base.ftl">
${gen.setFilepath(subPath(entity.packages.service, 'spring'))}
${gen.setFilename("Spring" + entity.name.service + ".java")}
package ${subPackage(entity.packages.service, "spring")};

import ${basePackage(entity.packages.controller, 'command')}.${entity.name.entity}EditInfo;
import ${basePackage(entity.packages.controller, 'command')}.${entity.name.entity}QueryInfo;
import ${entity.packages.service}.I${entity.name.service};
import ${entity.packages.dao}.I${entity.name.dao};
import ${entity.packages.entity.full};
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;
import org.springline.SpringlineHelper;
import org.springline.common.CustomException;
import org.springline.common.UserContext;
import org.springline.orm.Page;
import org.springline.web.mvc.AjaxJson;

import javax.transaction.Transactional;
import java.util.Arrays;
import java.util.List;
import java.util.Objects;
import java.util.stream.Collectors;

/**
* ${entity.comment}
*
* @author ${developer.author}
 */
@Service
@Transactional
public class Spring${entity.name.service} implements I${entity.name.service} {
    private final I${entity.name.dao} ${entity.name.dao.firstLower};

    public Spring${entity.name.service}(I${entity.name.dao} ${entity.name.dao.firstLower}) {
        this.${entity.name.dao.firstLower} = ${entity.name.dao.firstLower};
    }

    @Override
    public ${entity.name.entity} select${entity.name.entity}(String id) {
        return ${entity.name.dao.firstLower}.load(${entity.name.entity}.class, id);
    }

    @Override
    public Page<${entity.name.entity}> select${entity.name.entity}Page(${entity.name.entity}QueryInfo queryInfo) {
        return ${entity.name.dao.firstLower}.select${entity.name.entity}Page(queryInfo);
    }

    @Override
    public List<${entity.name.entity}> select${entity.name.entity}List(${entity.name.entity}QueryInfo queryInfo) {
        return ${entity.name.dao.firstLower}.select${entity.name.entity}List(queryInfo);
    }

    @Override
    public ${entity.name.entity} save${entity.name.entity}(${entity.name.entity}EditInfo editInfo) {
        ${entity.name.entity} ${entity.name.entity.firstLower};
        if (StringUtils.hasText(editInfo.get${primary.field.name.firstUpper}())) {
            // 修改，加载数据库数据
${entity.name.entity.firstLower} = ${entity.name.dao.firstLower}.load(${entity.name.entity}.class, editInfo.get${primary.field.name.firstUpper}());
            if (${entity.name.entity.firstLower} == null) {
                throw new CustomException(AjaxJson.StatusCode.FAIL.statusCode, "找不到要修改的资源对象");
            }
        } else {
            // 新增，初始化数据
${entity.name.entity.firstLower} = new ${entity.name.entity}();
${entity.name.entity.firstLower}.setIsValid(SpringlineHelper.YES);
${entity.name.entity.firstLower}.setCreatedMan(UserContext.getUser().getId());
        }

        // 重新赋值，修改为新的数据
        <#list fields as field>
            <#if field.selected && !field.primaryKey && field.name != "isValid" && field.name != "createdMan">
                <#if !((field.name?starts_with("create") || field.name?starts_with("update")) && field.column.name?contains("time")) >
                    ${entity.name.entity.firstLower}.set${field.name.firstUpper}(editInfo.get${field.name.firstUpper}());
                </#if>
            </#if>
        </#list>

        ${entity.name.entity.firstLower} = (${entity.name.entity})${entity.name.dao.firstLower}.save(${entity.name.entity.firstLower});

        return ${entity.name.entity.firstLower};
    }

    @Override
    public String delete${entity.name.entity}(String[] ids) {
        if (ids == null || ids.length == 0) {
            return "";
        }
        final List<${entity.name.entity}> finds = Arrays.stream(ids)
                .map(id -> ${entity.name.dao.firstLower}.load(${entity.name.entity}.class, id))
                .filter(Objects::nonNull)
                .peek(${entity.name.entity.firstLower} -> ${entity.name.entity.firstLower}.setIsValid(SpringlineHelper.NO))
                .collect(Collectors.toList());
${entity.name.dao.firstLower}.saveAll(finds);
        return finds.stream().map(${entity.name.entity}::get${primary.field.name.firstUpper}).collect(Collectors.joining());
    }
}
