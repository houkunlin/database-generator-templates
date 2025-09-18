${gen.setType("controller")}
${gen.setFilename("${entity.name.controller}Ext.java")}
package ${entity.packages.controller};

import ${entity.packages.entity.full};
import ${entity.packages.form.full};
import ${entity.packages.mapper.full};
import ${entity.packages.repository.full};
import ${entity.packages.service.full};
import ${entity.packages.transform.full};
import ${entity.packages.query.full};
import ${entity.packages.vo.full};
import ${entity.packages.vo.full}Detail;
import ${entity.packages.vo.full}List;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.enums.ParameterIn;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springdoc.core.annotations.ParameterObject;
import lombok.RequiredArgsConstructor;
import com.baomidou.mybatisplus.core.metadata.IPage;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import jakarta.validation.Valid;

import java.util.List;
import java.util.ArrayList;
import java.util.Set;
import java.util.stream.Collectors;

/**
* Controller：${entity.comment}
*
* @author ${developer.author}
 */
@Tag(name = "${entity.comment}")
@RestController
@RequestMapping("${entity.uri?replace("_", '-', 'ri')}/{xxxId}")
@RequiredArgsConstructor
public class ${entity.name.controller}Ext {
    private final ${entity.name.service} ${entity.name.service.firstLower};
    private final ${entity.name.transform} ${entity.name.transform.firstLower};

    /**
     * 获取全部的 <strong>${entity.comment}</strong> 列表
    *
    * @param page 分页参数信息
    * @param query 查询信息
    * @param xxxId 路径主键
    * @return 全部列表信息
     */
    @Operation(summary = "${entity.comment}-列表（不分页）")
    @GetMapping("all")
    public List<${entity.name.vo}List> listAll(final IPage<${entity.name.entity}> page, @ParameterObject final ${entity.name.query} query, @PathVariable final Long xxxId) {
        final List<${entity.name.entity}> list = ${entity.name.service.firstLower}.listAll(page, query);
        return list.stream().map(${entity.name.transform.firstLower}::toVoList).toList();
    }

    /**
     * 分页获取 <strong>${entity.comment}</strong> 列表
     *
     * @param page 分页参数信息
     * @param query 查询信息
     * @param xxxId 路径主键
     * @return 分页列表信息
     */
    @Operation(summary = "${entity.comment}-列表（分页）")
    @GetMapping("page")
    public IPage<${entity.name.vo}List> listPage(final IPage<${entity.name.entity}> page, @ParameterObject final ${entity.name.query} query, @PathVariable final Long xxxId) {
        return ${entity.name.service.firstLower}.listPage(page, query).convert(${entity.name.transform.firstLower}::toVoList);
    }

    /**
     * 获取一个 <strong>${entity.comment}</strong>
     *
     * @param ${entity.name.firstLower}Id 主键ID
     * @param xxxId 路径主键
     * @return 基本信息
     */
    @Operation(summary = "${entity.comment}-详细信息")
    @Parameter(name = "${entity.name.firstLower}Id", description = "主键", required = true, in = ParameterIn.QUERY)
    @GetMapping("info")
    public ${entity.name.vo} info(@RequestParam final ${primary.field.typeName} ${entity.name.firstLower}Id, @PathVariable final Long xxxId) {
        final ${entity.name.entity} ${entity.name.firstLower} = ${entity.name.service.firstLower}.getById(${entity.name.firstLower}Id);
        return ${entity.name.transform.firstLower}.toVo(${entity.name.firstLower});
    }

    /**
     * 获取一个 <strong>${entity.comment}</strong>
     *
     * @param ${entity.name.firstLower}Id 主键ID
     * @param xxxId 路径主键
     * @return 详情信息
     */
    @Operation(summary = "${entity.comment}-详细信息")
    @Parameter(name = "${entity.name.firstLower}Id", description = "主键", required = true, in = ParameterIn.QUERY)
    @GetMapping("info/detail")
    public ${entity.name.vo}Detail infoDetail(@RequestParam final ${primary.field.typeName} ${entity.name.firstLower}Id, @PathVariable final Long xxxId) {
        return ${entity.name.service.firstLower}.getDetailById(${entity.name.firstLower}Id);
    }

    /**
     * 获取一个 <strong>${entity.comment}</strong>
     *
     * @param ${entity.name.firstLower}Id 主键ID
     * @param xxxId 路径主键
     * @return 基本信息
     */
    @Operation(summary = "${entity.comment}-详细信息")
    @Parameter(name = "${entity.name.firstLower}Id", description = "主键", required = true, in = ParameterIn.PATH)
    @GetMapping("{${entity.name.firstLower}Id}")
    public ${entity.name.vo} infoPath(@PathVariable final ${primary.field.typeName} ${entity.name.firstLower}Id, @PathVariable final Long xxxId) {
        final ${entity.name.entity} ${entity.name.firstLower} = ${entity.name.service.firstLower}.getById(${entity.name.firstLower}Id);
        return ${entity.name.transform.firstLower}.toVo(${entity.name.firstLower});
    }

    /**
     * 获取一个 <strong>${entity.comment}</strong>
     *
     * @param ${entity.name.firstLower}Id 主键ID
     * @param xxxId 路径主键
     * @return 详情信息
     */
    @Operation(summary = "${entity.comment}-详细信息")
    @Parameter(name = "${entity.name.firstLower}Id", description = "主键", required = true, in = ParameterIn.PATH)
    @GetMapping("{${entity.name.firstLower}Id}/detail")
    public ${entity.name.vo}Detail infoPathDetail(@PathVariable final ${primary.field.typeName} ${entity.name.firstLower}Id, @PathVariable final Long xxxId) {
        return ${entity.name.service.firstLower}.getDetailById(${entity.name.firstLower}Id);
    }

    /**
     * 添加一个 <strong>${entity.comment}</strong>
     *
     * @param form ${entity.comment}
     * @param xxxId 路径主键
     * @return 保存结果
     */
    @Operation(summary = "${entity.comment}-保存信息")
    @PostMapping("edit")
    public ${entity.name.vo} saveForm(@Valid @RequestBody final ${entity.name.form} form, @PathVariable final Long xxxId) {
        final ${entity.name.entity} ${entity.name.firstLower} = ${entity.name.service.firstLower}.saveForm(form);
        return ${entity.name.transform.firstLower}.toVo(${entity.name.firstLower});
    }

    /**
     * 删除多个 <strong>${entity.comment}</strong>
     *
     * @param ${entity.name.firstLower}Ids 主键ID列表
     * @param xxxId 路径主键
     * @return 删除结果
     */
    @Operation(summary = "${entity.comment}-删除信息")
    @RequestMapping(value = "delete", method = {RequestMethod.POST, RequestMethod.DELETE})
    public String deleteByIds(@RequestBody final Set<${primary.field.typeName}> ${entity.name.firstLower}Ids, @PathVariable final Long xxxId) {
        List<${entity.name.entity}> list =  ${entity.name.service.firstLower}.deleteByIds(${entity.name.firstLower}Ids);
        return list.stream().map(${entity.name.entity}::get${primary.field.name.firstUpper}).map(String::valueOf).collect(Collectors.joining("、"));
    }

}
