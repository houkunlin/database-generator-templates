${gen.setType("mapper")}
package ${entity.packages.mapper};

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.CacheNamespace;
import org.springframework.stereotype.Repository;

import ${entity.packages.entity.full};

/**
* 存储库：${entity.comment}
*
* @author ${developer.author}
*/
@Repository
@CacheNamespace
public interface ${entity.name.mapper} extends BaseMapper<${entity.name.entity}> {
}
