${gen.setFilename("FormModelModal.vue")}
${gen.setFilepath("${settings.sourcesPath}/ui/${entity.name}/form")}
<template>
  <a-modal
    :title="title"
    :width="640"
    :visible="editInfoId !== undefined"
    :confirmLoading="loading"
    :centered="true"
    @ok="handleSubmit"
    @cancel="handleCancel">
    <form-model ref="form" v-bind="$props" @ok="handleOK" @loading="onLoading" />
  </a-modal>
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
