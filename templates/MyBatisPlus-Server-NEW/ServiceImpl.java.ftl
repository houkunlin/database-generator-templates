${gen.setType("serviceImpl")}
package ${entity.packages.serviceImpl};

import ${entity.packages.entity.full};
import ${entity.packages.form.full};
import ${entity.packages.mapper.full};
import ${entity.packages.repository.full};
import ${entity.packages.service.full};
import ${entity.packages.transform.full};
import ${entity.packages.query.full};
import ${entity.packages.vo.full}Detail;
import ${entity.packages.vo.full}List;

import lombok.RequiredArgsConstructor;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.conditions.query.LambdaQueryChainWrapper;
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
public class ${entity.name.serviceImpl} implements ${entity.name.service} {
    private final ${entity.name.repository} ${entity.name.repository.firstLower};
    private final ${entity.name.transform} ${entity.name.transform.firstLower};

    @Override
    public LambdaQueryChainWrapper<${entity.name.entity}> getLambdaQuery(IPage<${entity.name.entity}> page, ${entity.name.query} query) {
        return query.lambdaQuery(${entity.name.repository.firstLower}, page);
    }

    @Override
    public List<${entity.name.entity}> listAll(IPage<${entity.name.entity}> page, ${entity.name.query} query) {
        return query.lambdaQuery(${entity.name.repository.firstLower}, page).list();
    }

    @Override
    public IPage<${entity.name.entity}> listPage(IPage<${entity.name.entity}> page, ${entity.name.query} query) {
        return query.lambdaQueryPage(${entity.name.repository.firstLower}, page);
    }

    @Override
    public ${entity.name.entity} getById(${primary.field.typeName} ${entity.name.firstLower}Id){
        return ${entity.name.repository.firstLower}.getById(${entity.name.firstLower}Id);
    }

    @Override
    public ${entity.name.entity} saveForm(${entity.name.form} form) {
        final ${entity.name.entity} ${entity.name.firstLower} = ${entity.name.transform.firstLower}.toEntity(form);
        ${entity.name.repository.firstLower}.saveOrUpdate(${entity.name.firstLower});
        return ${entity.name.firstLower};
    }

    @Override
    public ${entity.name.vo}Detail getDetailById(${primary.field.typeName} ${entity.name.firstLower}Id){
        ${entity.name.entity} ${entity.name.firstLower} = ${entity.name.repository.firstLower}.getById(${entity.name.firstLower}Id);
        return ${entity.name.transform.firstLower}.toVoDetail(${entity.name.firstLower});
    }

    @Override
    public List<${entity.name.entity}> deleteByIds(Set<${primary.field.typeName}> ${entity.name.firstLower}Ids) {
        if (${entity.name.firstLower}Ids == null || ${entity.name.firstLower}Ids.isEmpty()) {
            return Collections.emptyList();
        }
        final List<${entity.name.entity}> list = ${entity.name.repository.firstLower}.lambdaQuery().select(${entity.name.entity}::get${primary.field.name.firstUpper}).in(${entity.name.entity}::get${primary.field.name.firstUpper}, ${entity.name.firstLower}Ids).list();
        if (!list.isEmpty()) {
            ${entity.name.repository.firstLower}.removeByIds(list.stream().map(${entity.name.entity}::get${primary.field.name.firstUpper}).collect(Collectors.toSet()));
        }
        return list;
    }
}
