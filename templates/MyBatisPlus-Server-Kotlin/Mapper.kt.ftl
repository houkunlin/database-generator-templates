${gen.setType("mapper")}
package ${entity.packages.mapper}

import com.baomidou.mybatisplus.core.mapper.BaseMapper
import org.apache.ibatis.annotations.CacheNamespace
import org.apache.ibatis.annotations.Mapper
import ${entity.packages.entity.full}

/**
* 存储库：${entity.comment}
*
* @author ${developer.author}
*/
@Mapper
@CacheNamespace
interface ${entity.name.mapper} : BaseMapper<${entity.name.entity}>
