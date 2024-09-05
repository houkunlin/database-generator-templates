${gen.setType("service")}
package ${entity.packages.service};

import com.baomidou.mybatisplus.extension.service.IService;

import ${entity.packages.entity.full};
import ${entity.packages.entity.full}Form;
import java.util.Set;
import java.util.List;

/**
* Service：${entity.comment}
*
* @author ${developer.author}
*/
public interface ${entity.name.service} extends IService<${entity.name.entity}> {
    String CACHE_NAME = "${table.name}";

    /**
     * 业务处理：保存一个 <strong>${entity.comment}</strong>
     *
     * @param form ${entity.comment}
     * @return 数据对象
     */
    ${entity.name.entity} saveForm(${entity.name.entity}Form form);

    /**
     * 业务处理：获取一个 <strong>${entity.comment}</strong> 详情对象
     *
     * @param ${entity.name.firstLower}Id 主键ID
     * @return 数据对象（详情）
     */
    ${entity.name.entity}VoDetail getDetailById(${primary.field.typeName} ${entity.name.firstLower}Id);

    /**
     * 业务处理：删除多个 <strong>${entity.comment}</strong>
     *
     * @param ${entity.name.firstLower}Ids 主键ID列表
     * @return 删除的对象列表
     */
    List<${entity.name.entity}> deleteByIds(Set<${primary.field.typeName}> ${entity.name.firstLower}Ids);
}
