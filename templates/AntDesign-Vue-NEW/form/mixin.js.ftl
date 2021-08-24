${gen.setFilename("mixin.js")}
${gen.setFilepath("ui/${entity.name}/form")}
import PropTypes from 'ant-design-vue/lib/_util/vue-types'

export const props = {
  // 正在编辑的 ${entity.comment} ID
editId: PropTypes.string.def(undefined)
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
      if (this.editId == null) {
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
    handleOK () {
      this.$emit('ok')
        this.$emit('update:editId', undefined)
    },
    handleCancel () {
      this.$emit('cancel')
        this.$emit('update:editId', undefined)
    }
  }
}
