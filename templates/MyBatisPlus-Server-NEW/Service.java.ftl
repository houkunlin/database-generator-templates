${gen.setType("service")}
package ${entity.packages.service};

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.conditions.query.LambdaQueryChainWrapper;

import ${entity.packages.entity.full};
import ${entity.packages.form.full};
import ${entity.packages.query.full};
import ${entity.packages.vo.full}Detail;
import java.util.Set;
import java.util.List;

/**
* Service：${entity.comment}
*
* @author ${developer.author}
*/
public interface ${entity.name.service} {
    String CACHE_NAME = "${table.name}";

    /**
     * 获取查询包装器
     *
     * @param page  查询对象
     * @param query 查询对象
     * @return 查询包装器
     */
    LambdaQueryChainWrapper<${entity.name.entity}> getLambdaQuery(IPage<${entity.name.entity}> page, ${entity.name.query} query);

    /**
    * 获取列表数据
    *
    * @param page  查询对象
    * @param query 查询对象
    * @return 列表数据
    */
    List<${entity.name.entity}> listAll(IPage<${entity.name.entity}> page, ${entity.name.query} query);

    /**
    * 获取分页数据
    *
    * @param page  查询对象
    * @param query 查询对象
    * @return 分页数据
    */
    IPage<${entity.name.entity}> listPage(IPage<${entity.name.entity}> page, ${entity.name.query} query);

    /**
     * 获取一个对象
     *
     * @param ${entity.name.firstLower}Id 主键ID
     * @return 数据对象（详情）
     */
    ${entity.name.entity} getById(${primary.field.typeName} ${entity.name.firstLower}Id);

    /**
     * 业务处理：保存一个 <strong>${entity.comment}</strong>
     *
     * @param form ${entity.comment}
     * @return 数据对象
     */
    ${entity.name.entity} saveForm(${entity.name.form} form);

    /**
     * 业务处理：获取一个 <strong>${entity.comment}</strong> 详情对象
     *
     * @param ${entity.name.firstLower}Id 主键ID
     * @return 数据对象（详情）
     */
    ${entity.name.vo}Detail getDetailById(${primary.field.typeName} ${entity.name.firstLower}Id);

    /**
     * 业务处理：删除多个 <strong>${entity.comment}</strong>
     *
     * @param ${entity.name.firstLower}Ids 主键ID列表
     * @return 删除的对象列表
     */
    List<${entity.name.entity}> deleteByIds(Set<${primary.field.typeName}> ${entity.name.firstLower}Ids);
}
