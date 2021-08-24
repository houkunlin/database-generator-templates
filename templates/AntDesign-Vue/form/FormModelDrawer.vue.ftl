${gen.setFilename("FormModelDrawer.vue")}
${gen.setFilepath("${settings.sourcesPath}/ui/${entity.name}/form")}
<template>
  <a-drawer
    :title="title"
    placement="right"
    width="80%"
    :closable="false"
    :visible="editInfoId !== undefined"
    :bodyStyle="{paddingBottom: '60px'}"
    @close="handleCancel">
    <form-model ref="form" v-bind="$props" @ok="handleOK" @loading="onLoading" />
    <div class="drawer-form-bottom">
      <a-button :loading="loading" @click="handleCancel">
        取消
      </a-button>
      <a-button type="primary" :loading="loading" @click="handleSubmit">
        保存信息
      </a-button>
    </div>
  </a-drawer>
</template>

<script>
import FormModel from './FormModel'
import mixin from './mixin'

export default {
  components: {
    FormModel
  },
  mixins: [mixin],
  props: {},
  data () {
    return {}
  },
  computed: {},
  methods: {}
}
</script>
