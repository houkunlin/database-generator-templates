${gen.setType("controller")}
package ${entity.packages.controller}

import ${entity.packages.entity.full}
import ${entity.packages.form.full}
import ${entity.packages.mapper.full}
import ${entity.packages.repository.full}
import ${entity.packages.service.full}
import ${entity.packages.transform.full}
import ${entity.packages.query.full}
import ${entity.packages.vo.full}
import ${entity.packages.vo.full}Detail
import ${entity.packages.vo.full}List

import com.baomidou.mybatisplus.core.metadata.IPage
import io.swagger.v3.oas.annotations.Operation
import io.swagger.v3.oas.annotations.Parameter
import io.swagger.v3.oas.annotations.enums.ParameterIn
import io.swagger.v3.oas.annotations.tags.Tag
import jakarta.validation.Valid
import org.springdoc.core.annotations.ParameterObject
import org.springframework.web.bind.annotation.*

/**
* Controller：${entity.comment}
*
* @author ${developer.author}
*/
@Tag(name = "${entity.comment}")
@RestController
@RequestMapping("${entity.uri?replace("_", '-', 'ri')}")
class ${entity.name.controller}(
    private val ${entity.name.service.firstLower}: ${entity.name.service},
    private val ${entity.name.transform.firstLower}: ${entity.name.transform}
) {

    /**
     * 获取全部的 **${entity.comment}** 列表
     *
     * @param page  分页参数信息
     * @param query 查询信息
     * @return 全部列表信息
     */
    @Operation(summary = "${entity.comment}-列表（不分页）")
    @GetMapping("all")
    fun listAll(
        page: IPage<${entity.name.entity}>,
        @ParameterObject query: ${entity.name.query}
    ): List<${entity.name.vo}List?> {
        return ${entity.name.service.firstLower}.listAll(page, query).map(${entity.name.transform.firstLower}::toVoList)
    }

    /**
     * 分页获取 **${entity.comment}** 列表
     *
     * @param page  分页参数信息
     * @param query 查询信息
     * @return 分页列表信息
     */
    @Operation(summary = "${entity.comment}-列表（分页）")
    @GetMapping("page")
    fun listPage(
        page: IPage<${entity.name.entity}>,
        @ParameterObject query: ${entity.name.query}
    ): IPage<${entity.name.vo}List> {
        return ${entity.name.service.firstLower}.listPage(page, query).convert(${entity.name.transform.firstLower}::toVoList)
    }

    /**
     * 获取一个 **${entity.comment}**
     *
     * @param ${entity.name.firstLower}Id 主键ID
     * @return 基本信息
     */
    @Operation(summary = "${entity.comment}-详细信息")
    @Parameter(name = "${entity.name.firstLower}Id", description = "主键", required = true, `in` = ParameterIn.QUERY)
    @GetMapping("info")
    fun info(@RequestParam ${entity.name.firstLower}Id: ${primary.field.typeName}): ${entity.name.vo}? {
        val ${entity.name.firstLower} = ${entity.name.service.firstLower}.getById(${entity.name.firstLower}Id)
        return ${entity.name.transform.firstLower}.toVo(${entity.name.firstLower})
    }

    /**
     * 获取一个 **${entity.comment}**
     *
     * @param ${entity.name.firstLower}Id 主键ID
     * @return 详情信息
     */
    @Operation(summary = "${entity.comment}-详细信息")
    @Parameter(name = "${entity.name.firstLower}Id", description = "主键", required = true, `in` = ParameterIn.QUERY)
    @GetMapping("info/detail")
    fun infoDetail(@RequestParam ${entity.name.firstLower}Id: ${primary.field.typeName}): ${entity.name.vo}Detail? {
        return ${entity.name.service.firstLower}.getDetailById(${entity.name.firstLower}Id)
    }

    /**
     * 获取一个 **${entity.comment}**
     *
     * @param ${entity.name.firstLower}Id 主键ID
     * @return 基本信息
     */
    @Operation(summary = "${entity.comment}-详细信息")
    @Parameter(name = "${entity.name.firstLower}Id", description = "主键", required = true, `in` = ParameterIn.PATH)
    @GetMapping("{${entity.name.firstLower}Id}")
    fun infoPath(@PathVariable ${entity.name.firstLower}Id: ${primary.field.typeName}): ${entity.name.vo}? {
        val ${entity.name.firstLower} = ${entity.name.service.firstLower}.getById(${entity.name.firstLower}Id)
        return ${entity.name.transform.firstLower}.toVo(${entity.name.firstLower})
    }

    /**
     * 获取一个 **${entity.comment}**
     *
     * @param ${entity.name.firstLower}Id 主键ID
     * @return 详情信息
     */
    @Operation(summary = "${entity.comment}-详细信息")
    @Parameter(name = "${entity.name.firstLower}Id", description = "主键", required = true, `in` = ParameterIn.PATH)
    @GetMapping("{${entity.name.firstLower}Id}/detail")
    fun infoPathDetail(@PathVariable ${entity.name.firstLower}Id: ${primary.field.typeName}): ${entity.name.vo}Detail? {
        return ${entity.name.service.firstLower}.getDetailById(${entity.name.firstLower}Id)
    }

    /**
     * 添加一个 **${entity.comment}**
     *
     * @param form ${entity.comment}
     * @return 保存结果
     */
    @Operation(summary = "${entity.comment}-保存信息")
    @PostMapping("edit")
    fun saveForm(@Valid @RequestBody form: ${entity.name.form}): ${entity.name.vo}? {
        val ${entity.name.firstLower} = ${entity.name.service.firstLower}.saveForm(form)
        return ${entity.name.transform.firstLower}.toVo(${entity.name.firstLower})
    }

    /**
     * 删除多个 **${entity.comment}**
     *
     * @param ${entity.name.firstLower}Ids 主键ID列表
     * @return 删除结果
     */
    @Operation(summary = "${entity.comment}-删除信息")
    @RequestMapping(value = ["delete"], method = [RequestMethod.DELETE, RequestMethod.POST])
    fun deleteByIds(@RequestBody ${entity.name.firstLower}Ids: MutableSet<${primary.field.typeName}?>): Boolean {
        val list = ${entity.name.service.firstLower}.deleteByIds(${entity.name.firstLower}Ids)
        return list.isNotEmpty()
    }
}
