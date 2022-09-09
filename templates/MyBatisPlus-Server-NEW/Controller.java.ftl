${gen.setType("controller")}
package ${entity.packages.controller};

import ${entity.packages.entity.full};
import ${entity.packages.entity.full}Form;
import ${entity.packages.entity.full}Query;
import ${entity.packages.service.full};

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import lombok.RequiredArgsConstructor;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.ArrayList;
import java.util.Set;

/**
* Controller：${entity.comment}
*
* @author ${developer.author}
 */
@Api(tags = "${entity.comment}")
@RestController
@RequestMapping("${entity.uri?replace("_", '-', 'ri')}")
@RequiredArgsConstructor
public class ${entity.name.controller} {
    private final ${entity.name.service} ${entity.name.service.firstLower};
    private final ${entity.name}Transform ${entity.name.firstLower}Transform;

    /**
     * 获取全部的 <strong>${entity.comment}</strong> 列表
    *
    * @param page 分页参数信息
    * @param query 查询信息
     */
    @ApiOperation("${entity.comment}-列表（不分页）")
    @GetMapping("all")
    public List<${entity.name}Vo> listAll(final IPage<${entity.name.entity}> page, final ${entity.name}Query query) {
        final List<${entity.name.entity}> list = query.query(${entity.name.service.firstLower}, page).list();
        return list.stream().map(${entity.name.firstLower}Transform::toVo).collect(Collectors.toList());
    }

    /**
     * 分页获取 <strong>${entity.comment}</strong> 列表
     *
     * @param page 分页参数信息
     * @param query 查询信息
     */
    @ApiOperation("${entity.comment}-列表（分页）")
    @GetMapping
    public IPage<${entity.name}Vo> list(final IPage<${entity.name.entity}> page, final ${entity.name}Query query) {
        return query.lambdaQuery(${entity.name.service.firstLower}).page(page).convert(${entity.name.firstLower}Transform::toVo);
    }

    /**
     * 获取一个 <strong>${entity.comment}</strong>
     *
     * @param id 主键ID
     */
    @ApiOperation("${entity.comment}-详细信息")
    @ApiImplicitParam(name = "id", value = "主键", required = true, paramType = "path", dataTypeClass = String.class)
    @GetMapping("{id}")
    public ${entity.name.entity}Vo info(@PathVariable final ${primary.field.typeName} id) {
        final ${entity.name.entity} ${entity.name.firstLower} = ${entity.name.service.firstLower}.getById(id);
        return ${entity.name.firstLower}Transform.toVo(${entity.name.firstLower});
    }

    /**
     * 添加一个 <strong>${entity.comment}</strong>
     *
     * @param form ${entity.comment}
     */
    @ApiOperation("${entity.comment}-保存信息")
    @AppLog("#${r'{'}#form.${primary.field.name}?.isEmpty() ? '新增' : '修改'}${entity.comment}：#${r'{'}#form.${primary.field.name}} (ID-#${r'{'}result})")
    @PostMapping
    public ${entity.name.entity} save${entity.name}(@Valid @RequestBody final ${entity.name}Form form) {
        final ${entity.name.entity} ${entity.name.firstLower} = ${entity.name.service.firstLower}.save${entity.name}(form);
        return ${entity.name.firstLower};
    }

    /**
     * 删除多个 <strong>${entity.comment}</strong>
     *
     * @param ids 主键ID列表
     */
    @ApiOperation("${entity.comment}-删除信息")
    @ApiImplicitParam(name = "ids", value = "主键数组", allowMultiple = true, required = true, paramType = "body", dataTypeClass = String[].class)
    @AppLog("删除${entity.comment}：#${r'{'}result}")
    @ResponseStatus(HttpStatus.NO_CONTENT)
    @DeleteMapping
    public String delete${entity.name}(@RequestBody final Set<${primary.field.typeName}> ids) {
        return ${entity.name.service.firstLower}.delete${entity.name}(ids);
    }

}
