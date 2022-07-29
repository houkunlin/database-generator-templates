<#include "/base.ftl">
${gen.setType("service")}
${gen.setFilename("I" + entity.name.service + ".java")}
package ${entity.packages.service};

import ${basePackage(entity.packages.controller, 'command')}.${entity.name.entity}EditInfo;
import ${basePackage(entity.packages.controller, 'command')}.${entity.name.entity}QueryInfo;
import ${entity.packages.entity.full};
import org.springline.orm.Page;

import java.util.List;

/**
* ${entity.comment}
*
* @author ${developer.author}
 */
public interface I${entity.name.service} {
    /**
     * 获取一个 ${entity.comment}
     *
     * @param id 主键
     * @return 结果
     */
    ${entity.name.entity} select${entity.name.entity}(String id);

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

    /**
     * 保存 ${entity.comment}
     *
     * @param editInfo  ${entity.comment}
     * @return 保存结果
     */
    ${entity.name.entity} save${entity.name.entity}(${entity.name.entity}EditInfo editInfo);

    /**
     * 删除 ${entity.comment}
     *
     * @param ids 主键列表
     * @return 删除结果
     */
    String delete${entity.name.entity}(String[] ids);
}
