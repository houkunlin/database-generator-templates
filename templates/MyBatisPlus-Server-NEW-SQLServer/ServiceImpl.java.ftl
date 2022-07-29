${gen.setFilename("${entity.name.service}Impl.java")}
${gen.setFilepath("${settings.javaPath}/${entity.packages.service}/")}
package ${entity.packages.service};

import ${entity.packages.entity.full};
import ${entity.packages.entity.full}Form;
import ${entity.packages.dao.full};
import ${entity.packages.service.full};
import ${entity.packages.service.full}Transform;

import lombok.AllArgsConstructor;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.cache.annotation.CacheConfig;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.Set;

/**
* Service：${entity.comment}
*
* @author ${developer.author}
*/
@CacheConfig(cacheNames = {${entity.name.service}.CACHE_NAME})
@Transactional(rollbackFor = Exception.class)
@Service
@AllArgsConstructor
public class ${entity.name.serviceImpl} extends ServiceImpl<${entity.name.dao}, ${entity.name.entity}> implements ${entity.name.service} {
    private final ${entity.name}Transform ${entity.name.firstLower}Transform;

    @Override
    public ${entity.name.entity} save${entity.name}(${entity.name.entity}Form form) {
        final ${entity.name.entity} ${entity.name.firstLower} = ${entity.name.firstLower}Transform.toEntity(form);
        saveOrUpdate(${entity.name.firstLower});
        return ${entity.name.firstLower};
    }

    @Override
    public String delete${entity.name}(Set<${primary.field.typeName}> ids) {
        if (ids == null || ids.isEmpty()) {
            return null;
        }
        final List<${entity.name.entity}> list = lambdaQuery().select(${entity.name.entity}::get${primary.field.name.firstUpper}).in(${entity.name.entity}::get${primary.field.name.firstUpper}, ids).list();
        if (!list.isEmpty()) {
            removeByIds(list.stream().map(${entity.name.entity}::get${primary.field.name.firstUpper}).collect(Collectors.toList()));
        }
        return list.stream().map(${entity.name.entity}::get${primary.field.name.firstUpper}).collect(Collectors.joining("、"));
    }
}
