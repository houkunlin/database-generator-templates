${gen.setFilename("Description.vue")}
${gen.setFilepath("${settings.sourcesPath}/ui/${entity.name}/")}
<template>
  <a-drawer
          placement="right"
          :closable="false"
          title="${entity.comment}"
          :visible="infoId != null"
          width="80%"
          :bodyStyle="{height: '90%'}"
          @close="$emit('close')"
  >
    <a-spin :spinning="loading">
      <a-descriptions title="${entity.comment}" :bordered="false" :column="5">
        <#list fields as field>
          <#if field.selected>
            <a-descriptions-item label="${field.comment}">{{ entity.${field.name} }}</a-descriptions-item>
          </#if>
        </#list>
      </a-descriptions>
    </a-spin>
  </a-drawer>
</template>

<script>
  import DictText from '@/views/system/DataDictionary/DataDictionaryText'
  import PropTypes from 'ant-design-vue/es/_util/vue-types'
  import { ${entity.name} as defaultEntity } from './model'
  import {detailsFilters} from '@/utils/mixin'
  import { get${entity.name}Info } from './service'

  export default {
    components: {
      DictText
    },
    mixins: [detailsFilters],
    props: {
      infoId: PropTypes.string.def(undefined)
    },
    data() {
      return {
        // 当前模块名称
        moduleName: '${entity.comment}',
        loading: false,
        entity: {...defaultEntity}
      }
    },
    watch: {
      infoId() {
        this.init()
      }
    },
    mounted() {
      this.init()
    },
    methods: {
      init() {
        if (this.infoId == null) {
          this.entity = {...defaultEntity}
          this.loading = false
          return
        }
        this.loadEntity()
      },
      loadEntity() {
        this.loading = true
        get${entity.name}Info(this.infoId)
                .then(res => {
                  this.entity = res.data
                })
                .finally(() => {
                  this.loading = false
                })
      }
    }
  }
</script>

<style scoped>

</style>
