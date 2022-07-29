<#include "/base.ftl">
${gen.setType("dao")}
${gen.setFilename("I" + entity.name.dao + ".java")}
package ${entity.packages.dao};

import ${basePackage(entity.packages.controller, "command")}.${entity.name.entity}QueryInfo;
import ${entity.packages.entity.full};
import org.springline.orm.Page;
import org.springline.orm.dao.ICommonDao;

import java.util.List;

/**
* ${entity.comment}
*
* @author ${developer.author}
 */
public interface I${entity.name.dao} extends ICommonDao {

    /**
     * 分页获取 ${entity.comment}
     *
     * @param queryInfo 查询条件
     * @return 分页列表
     */
    Page<${entity.name.entity}> select${entity.name.entity}Page(${entity.name.entity}QueryInfo queryInfo);

    /**
     * 不分页获取 ${entity.comment}
     *
     * @param queryInfo 查询条件
     * @return 不分页列表
     */
    List<${entity.name.entity}> select${entity.name.entity}List(${entity.name.entity}QueryInfo queryInfo);
}
