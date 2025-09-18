${gen.setType("transform")}
package ${entity.packages.transform};

import ${entity.packages.entity.full};
import ${entity.packages.form.full};
import ${entity.packages.vo.full};
import ${entity.packages.vo.full}Detail;
import ${entity.packages.vo.full}List;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.MappingTarget;
import org.mapstruct.ReportingPolicy;

import java.util.List;

/**
* 对象转换：${entity.comment}
*
* @author ${developer.author}
*/
@Mapper(componentModel = "spring", unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface ${entity.name.transform} {
    /**
    * 对象转换
    *
    * @param bean 原始对象
    * @return 转换结果
    */
    ${entity.name.entity} toEntity(${entity.name.form} bean);

    /**
    * 对象转换
    *
    * @param bean 原始对象
    * @param target 目标
    */
    @Mapping(target = "id", ignore = true)
    void toEntity(${entity.name.form} bean, @MappingTarget ${entity.name.entity} target);

    /**
    * 对象转换
    *
    * @param bean 原始对象
    * @return 转换结果
    */
    ${entity.name.vo} toVo(${entity.name.entity} bean);

    /**
    * 对象转换
    *
    * @param bean 原始对象
    * @return 转换结果
    */
    ${entity.name.vo}List toVoList(${entity.name.entity} bean);

    /**
    * 对象转换
    *
    * @param bean 原始对象
    * @return 转换结果
    */
    ${entity.name.vo}Detail toVoDetail(${entity.name.entity} bean);

    /**
    * 对象转换
    *
    * @param beans 原始对象
    * @return 转换结果
    */
    List<${entity.name.vo}> toVo(List<${entity.name.entity}> beans);

    /**
    * 对象转换
    *
    * @param beans 原始对象
    * @return 转换结果
    */
    List<${entity.name.vo}List> toVoList(List<${entity.name.entity}> beans);

    /**
    * 对象转换
    *
    * @param beans 原始对象
    * @return 转换结果
    */
    List<${entity.name.vo}Detail> toVoDetail(List<${entity.name.entity}> beans);
}
