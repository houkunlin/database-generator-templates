${gen.setFilename("routes.ts")}
${gen.setFilepath("ui/${entity.name}")}
export default {
    path: '${entity.uri}',
    name: '${entity.name}',
    icon: 'smile',
    component: './${entity.name}',
    hideChildrenInMenu: true,
    routes: [
      {
        path: 'edit',
        name: 'edit',
        component: './${entity.name}/FormPage',
      },
    ],
  };
