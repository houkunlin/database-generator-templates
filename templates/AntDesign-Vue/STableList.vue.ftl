${gen.setFilename("STableList.vue")}
${gen.setFilepath("${settings.sourcesPath}/ui/${entity.name}/")}
<template>
  <a-card>
    <table-list-search-form v-model="queryParam" @search="$refs.table.refresh(true)" />

    <!-- 表格顶部工具栏 -->
    <div class="table-operator">
      <a-button type="primary" icon="plus" @click="editInfoId = null">新建</a-button>
      <a-button type="dashed" icon="reload" @click="$refs.table.refresh(false)">刷新</a-button>
      <a-button type="dashed" @click="tableOption">{{ options.alert && '关闭' || '开启' }}多选</a-button>
      <a-dropdown v-if="selectedRowKeys.length > 0">
        <a-menu slot="overlay" @click="handleBatchAction">
          <a-menu-item key="delete">
            <a-icon type="delete" />
            删除
          </a-menu-item>
        </a-menu>
        <a-button style="margin-left: 8px">
          批量操作
          <a-icon type="down" />
        </a-button>
      </a-dropdown>
    </div>

    <a-spin :spinning="loading">
      <!-- 表格数据展示 -->
      <s-table
        ref="table"
        size="default"
        rowKey="${primary.field.name}"
        :columns="columns"
        :data="loadData"
        :alert="options.alert"
        :rowSelection="options.rowSelection"
        showPagination="auto">
        <span slot="action" slot-scope="text, record">
          <a @click="showInfoId = record.id">详情</a>
          <a-divider type="vertical" />
          <a @click="editInfoId = record.id">修改</a>
          <a-divider type="vertical" />
          <a-popconfirm
            title="确定要删除该记录吗？"
            placement="topRight"
            okType="danger"
            okText="确定"
            cancelText="取消"
            @confirm="handleDelete(record)">
            <a>删除</a>
          </a-popconfirm>
        </span>
      </s-table>
    </a-spin>

    <!-- 信息编辑窗口 -->
    <edit-form-model
      :edit-info-id="editInfoId"
      @cancel="editInfoId = undefined"
      @ok="refreshTable" />
    <description :info-id="showInfoId" @close="showInfoId = undefined" />
  </a-card>
</template>

<script>
  import {Ellipsis, STable} from '@/components'
  import {showError} from '@/utils/util'
  import { FormModelModal as EditFormModel } from './form'
  import Description from './Description'
  import {delete${entity.name}, delete${entity.name}Ids, get${entity.name}} from './service'
  import { columns } from './model'
  import TableListSearchForm from './TableListSearchForm'

  export default {
    components: {
      STable,
      Ellipsis,
      EditFormModel,
      Description,
      TableListSearchForm
    },
    data() {
      return {
        // PageView 页面内容
        pageMeta: {
          description: '${entity.comment}管理'
      },
        // 标记是否正在加载
        loading: false,
        // 需要编辑的 ${entity.comment} ID信息
        editInfoId: undefined,
        // 需要显示的 ${entity.comment} ID信息
        showInfoId: undefined,
        // 查询表单的查询字段参数
        queryParam: {},
        // 数据展示表格的表头信息
        columns: [ ...columns ],
      // 数据展示表格加载数据方法 必须为 Promise 对象
      loadData: parameter => {
        console.log('数据表格加载参数', parameter)

        // 处理排序信息
        const sort = {}
        if (parameter.sortField && parameter.sortOrder) {
          sort['sort'] = `${r'${parameter.sortField}'},${r"${parameter.sortOrder.replace('end', '')}"}`
        }

        // 合并查询参数信息
        const params = Object.assign({ page: parameter.pageNo, size: parameter.pageSize }, sort, this.queryParam)

        // 执行数据获取方法
        return get${entity.name}(params)
          .then(res => {
            const data = res.data
            const result = {
              pageNo: data.current, // 返回结果中的当前分页数
              totalCount: data.total, // 返回结果中的总记录数
              data: [...data.records]
            }
            console.log('数据表格返回数据信息', res, result)
            return result
          })
      },
      // 数据表格选中的 键
      selectedRowKeys: [],
      // 数据表格选中的 行
      selectedRows: [],

      // custom table alert & rowSelection
      options: {
        alert: {
          show: true,
          clear: () => {
            this.selectedRowKeys = []
          }
        },
        rowSelection: {
          selectedRowKeys: this.selectedRowKeys,
          // 数据表格多选框选中信息更改时触发事件
          onChange: this.onSelectChange
        }
      }
    }
  },
  watch: {},
  mounted () {
  },
  methods: {
    /**
     * 切换展示数据表格的多选项和提示选中数量信息
     */
    tableOption () {
      if (!this.options.alert) {
        this.options = {
          alert: {
            show: true,
            clear: () => {
              this.selectedRowKeys = []
            }
          },
          rowSelection: {
            selectedRowKeys: this.selectedRowKeys,
            // 数据表格多选框选中信息更改时触发事件
            onChange: this.onSelectChange
          }
        }
      } else {
        this.options = {
          alert: false,
          rowSelection: null
        }
      }
      console.log(this.options)
    },
    /**
     * 数据表格多选框选中信息更改时触发事件
     * @param selectedRowKeys 新的选中 键
     * @param selectedRows 新的选中 行
     */
    onSelectChange(selectedRowKeys, selectedRows) {
      this.selectedRowKeys = selectedRowKeys
      this.selectedRows = selectedRows
    },
    refreshTable() {
      this.editInfoId = undefined
      this.$refs.table.refresh(false)
    },
    /**
     * 处理删除数据业务
     * @param record
     * @returns {Promise<unknown>}
     */
    handleDelete(record) {
      this.loading = true
      return delete${entity.name}(record.id)
        // 删除成功则刷新表格
        .then(res => this.$refs.table.refresh(false))
        // 请求失败则提示错误信息
        .catch(err => showError(err))
        .finally(() => {
          this.loading = false
        })
    },
    /**
     * 处理删除数据业务
     * @returns {Promise<unknown>}
     */
    handleBatchAction ({ key, keyPath, item }) {
      const { selectedRowKeys } = this
      switch (key) {
        case 'delete':
          this.$confirmDeleteData(delete${entity.name}Ids, selectedRowKeys)
            .then(() => this.$refs.table.refresh(true))
            .catch(err => showError(err))
          break
        default:
      }
    }
  }
}
</script>

<style scoped>

</style>
