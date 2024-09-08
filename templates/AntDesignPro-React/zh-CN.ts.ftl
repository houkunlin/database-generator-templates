${gen.setFilename("zh-CN.ts")}
${gen.setFilepath("ui/${entity.name}/")}
export default {
  'menu.${entity.name.firstLower?replace("([a-z])([A-Z]+)","$1-$2","r")?lower_case}-list': '${entity.comment}',
  'menu.${entity.name.firstLower?replace("([a-z])([A-Z]+)","$1-$2","r")?lower_case}-edit': '编辑${entity.comment}',
};
