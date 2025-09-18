${gen.setType("transform")}
package ${entity.packages.transform}

import ${entity.packages.entity.full}
import ${entity.packages.form.full}
import ${entity.packages.vo.full}
import ${entity.packages.vo.full}Detail
import ${entity.packages.vo.full}List

import org.mapstruct.Mapper
import org.mapstruct.Mapping
import org.mapstruct.MappingTarget
import org.mapstruct.ReportingPolicy

/**
* 对象转换：${entity.comment}
*
* @author ${developer.author}
*/
@Mapper(componentModel = "spring", unmappedTargetPolicy = ReportingPolicy.IGNORE)
interface ${entity.name.transform} {
    /**
     * 对象转换
     *
     * @param bean 原始对象
     * @return 转换结果
     */
    fun toEntity(bean: ${entity.name.form}?): ${entity.name.entity}?

    /**
     * 对象转换
     *
     * @param bean   原始对象
     * @param target 目标
     */
    @Mapping(target = "id", ignore = true)
    fun toEntity(bean: ${entity.name.form}?, @MappingTarget target: ${entity.name.entity}?)

    /**
     * 对象转换
     *
     * @param bean 原始对象
     * @return 转换结果
     */
    fun toVo(bean: ${entity.name.entity}?): ${entity.name.vo}?

    /**
     * 对象转换
     *
     * @param bean 原始对象
     * @return 转换结果
     */
    fun toVoList(bean: ${entity.name.entity}?): ${entity.name.vo}List?

    /**
     * 对象转换
     *
     * @param bean 原始对象
     * @return 转换结果
     */
    fun toVoDetail(bean: ${entity.name.entity}?): ${entity.name.vo}Detail?

    /**
     * 对象转换
     *
     * @param beans 原始对象
     * @return 转换结果
     */
    fun toVo(beans: MutableList<${entity.name.entity}?>?): MutableList<${entity.name.vo}?>?

    /**
     * 对象转换
     *
     * @param beans 原始对象
     * @return 转换结果
     */
    fun toVoList(beans: MutableList<${entity.name.entity}?>?): MutableList<${entity.name.vo}List?>?

    /**
     * 对象转换
     *
     * @param beans 原始对象
     * @return 转换结果
     */
    fun toVoDetail(beans: MutableList<${entity.name.entity}?>?): MutableList<${entity.name.vo}Detail?>?
}
