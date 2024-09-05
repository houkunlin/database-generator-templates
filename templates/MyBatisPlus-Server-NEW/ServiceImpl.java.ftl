${gen.setFilename("${entity.name.service}Impl.java")}
${gen.setFilepath("${settings.javaPath}/${entity.packages.service}/")}
package ${entity.packages.service};

import ${entity.packages.entity.full};
import ${entity.packages.entity.full}Form;
import ${entity.packages.dao.full};
import ${entity.packages.service.full};
import ${entity.packages.service.full}Transform;

import lombok.RequiredArgsConstructor;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.cache.annotation.CacheConfig;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.Collections;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

/**
* Service：${entity.comment}
*
* @author ${developer.author}
*/
@CacheConfig(cacheNames = {${entity.name.service}.CACHE_NAME})
@Transactional(rollbackFor = Exception.class)
@Service
@RequiredArgsConstructor
public class ${entity.name.serviceImpl} extends ServiceImpl<${entity.name.dao}, ${entity.name.entity}> implements ${entity.name.service} {
    private final ${entity.name}Transform ${entity.name.firstLower}Transform;

    @Override
    public ${entity.name.entity} saveForm(${entity.name.entity}Form form) {
        final ${entity.name.entity} ${entity.name.firstLower} = ${entity.name.firstLower}Transform.toEntity(form);
        saveOrUpdate(${entity.name.firstLower});
        return ${entity.name.firstLower};
    }

    @Override
    public ${entity.name.entity}VoDetail getDetailById(${primary.field.typeName} ${entity.name.firstLower}Id){
        ${entity.name.entity} ${entity.name.firstLower} = getById(${entity.name.firstLower}Id);
        return ${entity.name.firstLower}Transform.toVoDetail(${entity.name.firstLower});
    }

    @Override
    public List<${entity.name.entity}> deleteByIds(Set<${primary.field.typeName}> ${entity.name.firstLower}Ids) {
        if (${entity.name.firstLower}Ids == null || ${entity.name.firstLower}Ids.isEmpty()) {
            return Collections.emptyList();
        }
        final List<${entity.name.entity}> list = lambdaQuery().select(${entity.name.entity}::get${primary.field.name.firstUpper}).in(${entity.name.entity}::get${primary.field.name.firstUpper}, ${entity.name.firstLower}Ids).list();
        if (!list.isEmpty()) {
            removeByIds(list.stream().map(${entity.name.entity}::get${primary.field.name.firstUpper}).collect(Collectors.toSet()));
        }
        return list;
    }
}
