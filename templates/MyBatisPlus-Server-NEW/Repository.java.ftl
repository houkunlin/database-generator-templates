${gen.setType("repository")}
package ${entity.packages.repository};

import com.baomidou.mybatisplus.extension.repository.CrudRepository;
import org.springframework.stereotype.Component;

import ${entity.packages.entity.full};
import ${entity.packages.mapper.full};

/**
* 存储库：${entity.comment}
*
* @author ${developer.author}
*/
@Component
public class ${entity.name.repository} extends CrudRepository<${entity.name.mapper}, ${entity.name.entity}> {
}
