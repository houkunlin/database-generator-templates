${gen.setFilename("FormModelPage.vue")}
${gen.setFilepath("ui/${entity.name}/form")}
<template>
  <a-card :title="title">
    <form-model ref="form" :edit-id.sync="editId" :loading.sync="loading" @ok="handleGoBack" />
    <edit-page-footer>
      <a-button icon="save" type="primary" @click="handleSubmit" :loading="loading">保存</a-button>
      <a-button icon="rollback" @click="handleGoBack" :loading="loading">返回</a-button>
    </edit-page-footer>
  </a-card>
</template>

<script>
import FormModel from './FormModel'
import EditPageFooter from '@/components/EditPageFooter'

export default {
  components: {
    FormModel,
    EditPageFooter
  },
  props: {},
  data () {
    return {
      editId: undefined,
      loading: false
    }
  },
  computed: {
    /**
     * 计算标题信息
     */
    title () {
      const moduleName = '${entity.comment}'
      if (this.editId == null) {
        return '添加' + moduleName
      }
      return '修改' + moduleName
    }
  },
  watch: {},
  mounted () {
    this.editId = this.$route.params.id
  },
  methods: {
    handleSubmit () {
      this.$refs.form.handleSubmit()
    },
      handleGoBack () {
          history.go(-1)
      }
  }
}
</script>
