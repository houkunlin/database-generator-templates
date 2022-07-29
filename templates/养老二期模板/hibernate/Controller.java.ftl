<#include "/base.ftl">
${gen.setType("controller")}
package ${entity.packages.controller};

import com.portal.annotations.WebLog;
import ${basePackage(entity.packages.controller, 'command')}.${entity.name.entity}Helper;
import ${basePackage(entity.packages.controller, 'command')}.${entity.name.entity}EditInfo;
import ${basePackage(entity.packages.controller, 'command')}.${entity.name.entity}QueryInfo;
import ${entity.packages.service}.I${entity.name.service};
import ${entity.packages.entity.full};
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiOperation;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.*;
import org.springline.web.mvc.AjaxJson;

import javax.validation.Valid;

/**
 * ${entity.comment}
*
* @author ${developer.author}
 */
@RestController
@RequestMapping(value = "/api-${entity.uri}")
@Api(tags = "${entity.comment}")
public class ${entity.name.controller} {
    private static final Logger logger = LoggerFactory.getLogger(${entity.name.controller}.class);
    private static final String JSON_KEY = "${entity.name.entity.firstLower}";
    private final I${entity.name.service} ${entity.name.service.firstLower};

    public ${entity.name.controller}(I${entity.name.service} ${entity.name.service.firstLower}) {
        this.${entity.name.service.firstLower} = ${entity.name.service.firstLower};
    }

    @ApiOperation("${entity.comment}-不分页列表")
    @GetMapping("/list")
    public AjaxJson ${entity.name.entity.firstLower}List(${entity.name.entity}QueryInfo queryInfo) {
        AjaxJson json = new AjaxJson();
        json.put(JSON_KEY, ${entity.name.service.firstLower}.select${entity.name.entity}List(queryInfo));
        return json;
    }

    @ApiOperation("${entity.comment}-分页列表")
    @GetMapping("/")
    public AjaxJson ${entity.name.entity.firstLower}Page(${entity.name.entity}QueryInfo queryInfo) {
        AjaxJson json = new AjaxJson();
        json.put(JSON_KEY, ${entity.name.service.firstLower}.select${entity.name.entity}Page(queryInfo));
        return json;
    }

    @ApiOperation("${entity.comment}-详细信息")
    @ApiImplicitParam(name = "id", value = "主键", required = true, paramType = "path", dataTypeClass = String.class)
    @GetMapping("/{id}")
    public AjaxJson ${entity.name.entity.firstLower}Info(@PathVariable String id) {
        ${entity.name.entity} ${entity.name.entity.firstLower} = ${entity.name.service.firstLower}.select${entity.name.entity}(id);
        if (${entity.name.entity.firstLower} == null) {
            ${entity.name.entity.firstLower} = new ${entity.name.entity}();
        }
        AjaxJson json = new AjaxJson();
        json.put(JSON_KEY, ${entity.name.entity.firstLower});
        return json;
    }

    @ApiOperation("${entity.comment}-保存信息")
    @PostMapping(value = "/save")
    @WebLog(type = ${entity.name.entity}.LOG_TYPE, value = "编辑信息-${r'#'}{result.body.${entity.name.entity.firstLower}.${primary.field.name}}")
    public AjaxJson ${entity.name.entity.firstLower}Save(@Valid @RequestBody ${entity.name.entity}EditInfo editInfo) {
        ${entity.name.entity} ${entity.name.entity.firstLower} = ${entity.name.service.firstLower}.save${entity.name.entity}(editInfo);
        AjaxJson json = new AjaxJson();
        json.put(JSON_KEY, ${entity.name.entity.firstLower});
        return json;
    }

    @ApiOperation("${entity.comment}-删除信息")
    @ApiImplicitParam(name = "ids", value = "主键数组", allowMultiple = true, required = true, paramType = "body", dataTypeClass = String[].class)
    @PostMapping(value = "/delete")
    @WebLog(type = ${entity.name.entity}.LOG_TYPE, value = "删除信息[${r'#'}{result.body.deleteNames}]")
    public AjaxJson ${entity.name.entity.firstLower}Delete(@RequestBody String[] ids) {
        AjaxJson result = new AjaxJson();
        String deleteNames = ${entity.name.service.firstLower}.delete${entity.name.entity}(ids);
        result.put("deleteNames", deleteNames);
        return result;
    }
}
