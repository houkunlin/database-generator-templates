<#include "/base.ftl">
${gen.setFilepath(subPath(entity.packages.dao, 'hibernate'))}
${gen.setFilename("Hibernate" + entity.name.dao + ".java")}
package ${subPackage(entity.packages.dao, "hibernate")};

import ${basePackage(entity.packages.controller, "command")}.${entity.name.entity}QueryInfo;
import ${entity.packages.dao}.I${entity.name.dao};
import ${entity.packages.entity.full};
import org.springframework.stereotype.Repository;
import org.springline.beans.dataquery.IQueryObject;
import org.springline.beans.dataquery.QueryBuilder;
import org.springline.orm.Page;
import org.springline.orm.dao.support.HibernateCommonDao;

import java.util.List;

/**
* ${entity.comment}
*
* @author ${developer.author}
 */
@Repository
public class Hibernate${entity.name.dao} extends HibernateCommonDao implements I${entity.name.dao} {
    static QueryBuilder queryBuilder = QueryBuilder.getInstance(${entity.name.entity}.class.getName());

    static {
       // queryBuilder
<#list fields as field>
    <#if field.selected>
        // ${field.comment}
       // .addQueryItem("${field.name}", "${field.name}", QueryBuilder.Condition.EQU, "")
    </#if>
</#list>
               // .setOrderbyCause(" createdTime ")
        ;
    }

    @Override
    public Page<${entity.name.entity}> select${entity.name.entity}Page(${entity.name.entity}QueryInfo queryInfo) {
        IQueryObject qo = queryBuilder.build(queryInfo);
        if (queryInfo.getNotPage() != null && queryInfo.getNotPage()) {
            List<${entity.name.entity}> data = super.doQuery(qo.getQueryString(), qo.getParams());
            return super.putDataToPage(data);
        }
        return super.find(qo.getQueryString(), qo.getParams(), queryInfo.getPageNumber(), queryInfo.getPageSize());
    }

    @Override
    public List<${entity.name.entity}> select${entity.name.entity}List(${entity.name.entity}QueryInfo queryInfo) {
        IQueryObject qo = queryBuilder.build(queryInfo);
        return super.doQuery(qo.getQueryString(), qo.getParams());
    }
}
