${gen.setFilename("${entity.name}Transform.java")}
${gen.setFilepath("${settings.javaPath}/${entity.packages.service}/")}
package ${entity.packages.service};

import ${entity.packages.entity.full};
import ${entity.packages.entity.full}Form;
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
public interface ${entity.name}Transform {
    /**
    * 对象转换
    *
    * @param bean 原始对象
    * @return 转换结果
    */
    ${entity.name.entity} toEntity(${entity.name}Form bean);

    /**
    * 对象转换
    *
    * @param bean 原始对象
    * @param target 目标
    */
    @Mapping(target = "id", ignore = true)
    void toEntity(${entity.name}Form bean, @MappingTarget ${entity.name} target);

    /**
    * 对象转换
    *
    * @param bean 原始对象
    * @return 转换结果
    */
    ${entity.name.entity}Vo toVo(${entity.name.entity} bean);

    /**
    * 对象转换
    *
    * @param bean 原始对象
    * @return 转换结果
    */
    ${entity.name.entity}VoList toVoList(${entity.name.entity} bean);

    /**
    * 对象转换
    *
    * @param bean 原始对象
    * @return 转换结果
    */
    ${entity.name.entity}VoDetail toVoDetail(${entity.name.entity} bean);

    /**
    * 对象转换
    *
    * @param beans 原始对象
    * @return 转换结果
    */
    List<${entity.name.entity}Vo> toVo(List<${entity.name.entity}> beans);

    /**
    * 对象转换
    *
    * @param beans 原始对象
    * @return 转换结果
    */
    List<${entity.name.entity}VoList> toVoList(List<${entity.name.entity}> beans);

    /**
    * 对象转换
    *
    * @param beans 原始对象
    * @return 转换结果
    */
    List<${entity.name.entity}VoDetail> toVoDetail(List<${entity.name.entity}> beans);
}
