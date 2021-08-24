${gen.setFilename("FormModelModal.vue")}
${gen.setFilepath("ui/${entity.name}/form")}
<template>
  <a-modal
    :title="title"
    :width="640"
    :visible="editId !== undefined"
    :confirmLoading="loading"
    :centered="true"
    @ok="handleSubmit"
    @cancel="handleCancel">
    <form-model ref="form" v-bind="$props" @ok="handleOK" :loading.sync="loading" />
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
