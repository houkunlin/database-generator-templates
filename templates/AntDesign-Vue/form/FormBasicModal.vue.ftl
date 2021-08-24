${gen.setFilename("FormBasicModal.vue")}
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
    <form-basic ref="form" v-bind="$props" @ok="handleOK" @loading="onLoading" />
  </a-modal>
</template>

<script>
import FormBasic from './FormBasic'
import mixin from './mixin'

export default {
  components: {
    FormBasic
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
