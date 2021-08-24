${gen.setFilename("TableList.vue")}
${gen.setFilepath("${settings.sourcesPath}/ui/${entity.name}/")}
<template>
  <a-card>
    <table-list-search-form v-model="queryParam" @search="refreshTable(true)" />

    <!-- 表格顶部工具栏 -->
    <div class="table-operator">
      <a-button type="primary" icon="plus" @click="editInfoId = null">新建</a-button>
      <a-button type="dashed" icon="reload" @click="refreshTable">刷新</a-button>
      <a-dropdown v-if="table.rowSelection.selectedRowKeys.length > 0">
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
      <a-table
        ref="table"
        rowKey="${primary.field.name}"
        v-bind="table"
        @change="onTableChange">
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
          <a-divider type="vertical" />
          <a-dropdown>
            <a class="ant-dropdown-link">
              更多 <a-icon type="down" />
            </a>
            <a-menu slot="overlay" @click="event => handleMoreAction({...event, record})">
              <a-menu-item @click="showInfoId = record.id">详情</a-menu-item>
              <a-menu-item @click="editInfoId = record.id">修改</a-menu-item>
              <a-menu-item key="delete">删除</a-menu-item>
            </a-menu>
          </a-dropdown>
        </span>
      </a-table>
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
  import {showError} from '@/utils/util'
  import { FormModelModal as EditFormModel } from './form'
  import Description from './Description'
  import {delete${entity.name}, delete${entity.name}Ids, get${entity.name}} from './service'
  import { columns, defaultPagination } from './model'
  import TableListSearchForm from './TableListSearchForm'

  export default {
    components: {
      EditFormModel,
      Description,
      TableListSearchForm
    },
    props: {},
    data() {
      return {
        // PageView 页面内容
        pageMeta: {
          description: '${entity.comment}管理'
        },
        // 标记是否正在加载
        loading: false,
        // 查询表单的查询字段参数
        queryParam: {},
        // 数据展示表格的表头信息
        table: {
          // 数据展示表格的表头信息
          columns: [...columns],
          dataSource: [],
          pagination: { ...defaultPagination },
          rowSelection: {
            // 数据表格选中的 行
            selectedRows: [],
            // 数据表格选中的 键
            selectedRowKeys: [],
            // 数据表格多选框选中信息更改时触发事件
            onChange: (selectedRowKeys, selectedRows) => {
              this.table.rowSelection.selectedRowKeys = selectedRowKeys
              this.table.rowSelection.selectedRows = selectedRows
            }
          }
        },
        // 需要编辑的 ${entity.comment} ID
        editInfoId: undefined,
        // 需要显示的 ${entity.comment} ID
        showInfoId: undefined
      }
    },
    watch: {},
    mounted() {
      this.resetData()
      this.refreshTable()
    },
    methods: {
      hasMoreSearchInput () {
        return this.$refs.advancedRef && this.$refs.advancedRef.children.length > 0
      },
      refreshTable (jumpFirstPage = false) {
        this.editInfoId = undefined
        this.showInfoId = undefined
        let pagination = this.table.pagination
        if (jumpFirstPage === true) {
          pagination = undefined
        }
        this.onTableChange(pagination)
      },
      onTableChange(pagination = {}, filters = {}, sorter = {}, info = {}) {
        console.log('onTableChange', pagination, filters, sorter, info)
        this.table.rowSelection.selectedRows = []
        this.table.rowSelection.selectedRowKeys = []

        // 合并查询参数信息
        const params = Object.assign({
          page: pagination.current || 1,
          size: pagination.pageSize || 10
        }, {
          sort: sorter.field && sorter.order && sorter.field + ',' + sorter.order.replace('end', '') || undefined
        }, this.queryParam)
        this.loading = true
        get${entity.name}(params).then(res=>{
          const data = res.data || {records: [], current: 1, total: 0}
          this.table.dataSource = [...data.records]
          this.table.pagination.current = data.current
          this.table.pagination.total = data.total
          this.table.pagination.pageSize = pagination.pageSize || 10
        }).finally(() => {
          this.loading = false
        })
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
          .then(this.refreshTable)
          // 请求失败则提示错误信息
          .catch(showError)
          .finally(() => {
            this.loading = false
          })
      },
      /**
       * 处理删除数据业务
       * @returns {Promise<unknown>}
       */
      handleBatchAction({key, keyPath, item}) {
        const {table:{rowSelection: {selectedRowKeys}}} = this
        switch (key) {
          case 'delete':
            this.$confirmDeleteData(delete${entity.name}Ids, selectedRowKeys)
              .then(this.refreshTable)
              .catch(showError)
            break
          default:
        }
      },
      handleMoreAction ({ key, keyPath, item, record }) {
        switch (key) {
          case 'delete':
            this.$confirmDeleteData(delete${entity.name}, record)
              .then(this.refreshTable)
              .catch(showError)
            break
        }
      },
      resetData () {
        this.queryParam = {}
        this.table.dataSource = []
        this.table.pagination = { ...defaultPagination }
        this.table.rowSelection.selectedRows = []
        this.table.rowSelection.selectedRowKeys = []
      }
    }
  }
</script>

<style scoped>

</style>
