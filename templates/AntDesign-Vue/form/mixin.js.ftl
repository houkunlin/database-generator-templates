${gen.setFilename("mixin.js")}
${gen.setFilepath("${settings.sourcesPath}/ui/${entity.name}/form")}
import PropTypes from 'ant-design-vue/lib/_util/vue-types'

export const props = {
  // 正在编辑的 ${entity.comment} ID
  editInfoId: PropTypes.string.def(undefined)
}

export default {
  props,
  data () {
    return {
      // 表单和确定按钮是否处于加载状态
      loading: false
    }
  },
  computed: {
    /**
     * 计算标题信息
     */
    title () {
      const moduleName = '${entity.comment}'
      if (this.editInfoId == null) {
        return '添加' + moduleName
      }
      return '修改' + moduleName
    }
  },
  methods: {
    /**
     * 处理表单提交事件
     */
    handleSubmit () {
      this.$refs.form.handleSubmit()
    },
    onLoading (loading) {
      this.loading = loading
    },
    handleOK () {
      this.$emit('ok')
    },
    handleCancel () {
      this.$emit('cancel')
    }
  }
}
