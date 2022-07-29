${gen.setFilename("routes.ts")}
${gen.setFilepath("ui/${entity.name}")}

const uri = '${entity.uri}'

export default [
    {
        path: '${entity.uri}',
        name: '${entity.name.firstLower?replace("([a-z])([A-Z]+)","$1-$2","r")?lower_case}-list',
        icon: 'smile',
        component: './${entity.name}/',
    },
    {
        path: '${entity.uri}/edit',
        name: '${entity.name.firstLower?replace("([a-z])([A-Z]+)","$1-$2","r")?lower_case}-edit',
        icon: 'smile',
        hideInMenu: true,
        component: './${entity.name}/FormPage',
    }
];
