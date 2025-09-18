${gen.setType("service")}
package ${entity.packages.service}

import com.baomidou.mybatisplus.core.metadata.IPage
import com.baomidou.mybatisplus.extension.kotlin.KtQueryChainWrapper

import ${entity.packages.entity.full}
import ${entity.packages.form.full}
import ${entity.packages.query.full}
import ${entity.packages.vo.full}Detail

/**
* Service：${entity.comment}
*
* @author ${developer.author}
*/
interface ${entity.name.service} {
    /**
     * 获取查询包装器
     *
     * @param page  查询对象
     * @param query 查询对象
     * @return 查询包装器
     */
    fun getKtQuery(
        page: IPage<${entity.name.entity}>,
        query: ${entity.name.query}
    ): KtQueryChainWrapper<${entity.name.entity}>

    /**
     * 获取列表数据
     *
     * @param page  查询对象
     * @param query 查询对象
     * @return 列表数据
     */
    fun listAll(page: IPage<${entity.name.entity}>, query: ${entity.name.query}): MutableList<${entity.name.entity}>

    /**
     * 获取分页数据
     *
     * @param page  查询对象
     * @param query 查询对象
     * @return 分页数据
     */
    fun listPage(page: IPage<${entity.name.entity}>, query: ${entity.name.query}): IPage<${entity.name.entity}>

    /**
     * 获取一个对象
     *
     * @param ${entity.name.firstLower}Id 主键ID
     * @return 数据对象（详情）
     */
    fun getById(${entity.name.firstLower}Id: ${primary.field.typeName}?): ${entity.name.entity}?

    /**
     * 业务处理：保存一个 **${entity.comment}**
     *
     * @param form ${entity.comment}
     * @return 数据对象
     */
    fun saveForm(form: ${entity.name.form}?): ${entity.name.entity}?

    /**
     * 业务处理：获取一个 **${entity.comment}** 详情对象
     *
     * @param ${entity.name.firstLower}Id 主键ID
     * @return 数据对象（详情）
     */
    fun getDetailById(${entity.name.firstLower}Id: ${primary.field.typeName}?): ${entity.name.vo}Detail?

    /**
     * 业务处理：删除多个 **${entity.comment}**
     *
     * @param ${entity.name.firstLower}Ids 主键ID列表
     * @return 删除的对象列表
     */
    fun deleteByIds(${entity.name.firstLower}Ids: MutableSet<${primary.field.typeName}?>): MutableList<${entity.name.entity}>

    companion object {
        const val CACHE_NAME: String = "${table.name}"
    }
}
