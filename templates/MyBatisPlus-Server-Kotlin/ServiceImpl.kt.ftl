${gen.setType("serviceImpl")}
package ${entity.packages.serviceImpl}

import ${entity.packages.entity.full}
import ${entity.packages.form.full}
import ${entity.packages.mapper.full}
import ${entity.packages.repository.full}
import ${entity.packages.service.full}
import ${entity.packages.transform.full}
import ${entity.packages.query.full}
import ${entity.packages.vo.full}Detail
import ${entity.packages.vo.full}List

import com.baomidou.mybatisplus.core.metadata.IPage
import com.baomidou.mybatisplus.extension.kotlin.KtQueryChainWrapper
import com.saas.extend.deleteByIds
import org.springframework.cache.annotation.CacheConfig
import org.springframework.stereotype.Service
import org.springframework.transaction.annotation.Transactional

/**
* Service：${entity.comment}
*
* @author ${developer.author}
*/
@CacheConfig(cacheNames = [${entity.name.service}.CACHE_NAME])
@Transactional(rollbackFor = [Exception::class])
@Service
class ${entity.name.serviceImpl}(
    private val ${entity.name.repository.firstLower}: ${entity.name.repository},
    private val ${entity.name.transform.firstLower}: ${entity.name.transform}
) : ${entity.name.service} {

    override fun getKtQuery(
        page: IPage<${entity.name.entity}>,
        query: ${entity.name.query}
    ): KtQueryChainWrapper<${entity.name.entity}> {
        return query.ktQuery(${entity.name.repository.firstLower}, page)
    }

    override fun listAll(
        page: IPage<${entity.name.entity}>,
        query: ${entity.name.query}
    ): MutableList<${entity.name.entity}> {
        return query.ktQuery(${entity.name.repository.firstLower}, page).list()
    }

    override fun listPage(page: IPage<${entity.name.entity}>, query: ${entity.name.query}): IPage<${entity.name.entity}> {
        return query.ktQueryPage(${entity.name.repository.firstLower}, page)
    }

    override fun getById(${entity.name.firstLower}Id: ${primary.field.typeName}?): ${entity.name.entity}? {
        return ${entity.name.repository.firstLower}.getById(${entity.name.firstLower}Id)
    }

    override fun saveForm(form: ${entity.name.form}?): ${entity.name.entity}? {
        val ${entity.name.firstLower} = ${entity.name.transform.firstLower}.toEntity(form) ?: return null
        ${entity.name.repository.firstLower}.saveOrUpdate(${entity.name.firstLower})
        return ${entity.name.firstLower}
    }

    override fun getDetailById(${entity.name.firstLower}Id: ${primary.field.typeName}?): ${entity.name.vo}Detail? {
        val ${entity.name.firstLower} = ${entity.name.repository.firstLower}.getById(${entity.name.firstLower}Id)
        return ${entity.name.transform.firstLower}.toVoDetail(${entity.name.firstLower})
    }

    override fun deleteByIds(${entity.name.firstLower}Ids: MutableSet<${primary.field.typeName}?>): MutableList<${entity.name.entity}> {
        if (${entity.name.firstLower}Ids.isEmpty()) {
            return mutableListOf()
        }
        val list =
            ${entity.name.repository.firstLower}.ktQuery().select(${entity.name.entity}::${primary.field.name.firstLower})
                .orderByAsc(${entity.name.entity}::${primary.field.name.firstLower})
                .`in`(${entity.name.entity}::${primary.field.name.firstLower}, ${entity.name.firstLower}Ids).list()
        if (!list.isEmpty()) {
            val ids = list.map(${entity.name.entity}::${primary.field.name.firstLower}).toSet()
            ${entity.name.repository.firstLower}.deleteByIds(
                ids,
                ${entity.name.entity}::${primary.field.name.firstLower},
                ${entity.name.entity}::deleted,
                ${entity.name.entity}::deletedBy,
                ${entity.name.entity}::deletedTime,
                ${entity.name.entity}::updatedBy,
                ${entity.name.entity}::updatedTime
            )
        }
        return list
    }
}
