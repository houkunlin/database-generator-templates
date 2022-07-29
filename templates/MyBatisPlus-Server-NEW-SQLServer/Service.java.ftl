${gen.setType("service")}
package ${entity.packages.service};

import com.baomidou.mybatisplus.extension.service.IService;

import ${entity.packages.entity.full};
import ${entity.packages.entity.full}Form;
import java.util.Set;

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
     */
    ${entity.name.entity} save${entity.name}(${entity.name.entity}Form form);

    /**
     * 业务处理：删除多个 <strong>${entity.comment}</strong>
     *
     * @param ids 主键ID列表
     */
    String delete${entity.name}(Set<${primary.field.typeName}> ids);
}
