${gen.setFilename("TableList.vue")}
${gen.setFilepath("ui/${entity.name}/")}
<template>
    <router-view v-if="isChildRoute"></router-view>
    <a-card v-else>
    <search-form v-model="queryParam" @search="refreshTable(true)" />

    <!-- 表格顶部工具栏 -->
    <div class="table-operator">
      <a-button type="primary" icon="plus" @click="editId = null">新建-弹窗</a-button>
        <a-button icon="plus" type="primary" @click="jumpEditPage">新建-路由</a-button>
      <a-button type="dashed" icon="reload" @click="refreshTable" :loading="loading">刷新</a-button>
      <a-button type="danger" icon="delete" @click="handleDelete" :disabled="!isSelectedRows">删除</a-button>
      <a-dropdown v-if="isSelectedRows">
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
        <span slot="col-title" slot-scope="text, record">
          <a @click="jumpEditPage(record)">{{ text }}</a>
        </span>
        <span slot="action" slot-scope="text, record">
          <a @click="showInfoId = record.id">详情</a>
          <a-divider type="vertical" />
          <a @click="editId = record.id">修改-弹窗</a>
          <a @click="jumpEditPage(record)">修改-路由</a>
          <a-divider type="vertical" />
          <a-dropdown>
            <a class="ant-dropdown-link">
              更多 <a-icon type="down" />
            </a>
            <a-menu slot="overlay" @click="event => handleMoreAction({...event, record})">
              <a-menu-item @click="showInfoId = record.id">详情</a-menu-item>
              <a-menu-item @click="editId = record.id">修改</a-menu-item>
              <a-menu-item key="delete">删除</a-menu-item>
            </a-menu>
          </a-dropdown>
        </span>
      </a-table>
    </a-spin>

    <!-- 信息编辑窗口 -->
    <edit-form-model :edit-id.sync="editId" @ok="refreshTable" />
    <description :info-id.sync="showInfoId" />
  </a-card>
</template>

<script>
  import {showError} from '@/utils/util'
  import { FormModelModal as EditFormModel } from './form'
  import Description from './Description'
  import { delete${entity.name}Ids, get${entity.name}} from './service'
  import { columns, defaultPagination } from './model'
  import SearchForm from './SearchForm'
  import { pageParams, paginationData } from '@/utils/data-util'

  export default {
    components: {
      EditFormModel,
      Description,
        SearchForm
    },
    props: {},
    data() {
      return {
          // 判断当前路由是否是子路由；即，当前页面下还有一个页面要展示
        isChildRoute: false,
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
        editId: undefined,
        // 需要显示的 ${entity.comment} ID
        showInfoId: undefined
      }
    },
    watch: {
        '$route' (val, old) {
            this.isChildRoute = val.matched.length > old.matched.length || val.meta.hidden
        }
    },
      computed: {
        isSelectedRows(){
            return this.table.rowSelection.selectedRowKeys.length > 0
        }
      },
    mounted() {
      this.resetData()
      this.refreshTable()
        this.isChildRoute = this.$route.meta.hidden
    },
    methods: {
      refreshTable (jumpFirstPage = false) {
        this.editId = undefined
        this.showInfoId = undefined
        let pagination = this.table.pagination
        if (jumpFirstPage === true) {
          pagination = undefined
        }
        this.onTableChange(pagination)
      },
      onTableChange(pagination = {}, filters = {}, sorter = {}, info = {}) {
        this.table.rowSelection.selectedRows = []
        this.table.rowSelection.selectedRowKeys = []

        // 合并查询参数信息
        const params = pageParams(pagination, sorter, this.queryParam)
        this.loading = true
        get${entity.name}(params).then(res=>{
          const data = res || {list: [], page: 1, total: 0, size: 10}
          this.table.dataSource = [...data.list]
          this.table.pagination = paginationData(pagination, res)
        }).finally(() => {
          this.loading = false
        })
      },
        /**
         * 处理删除数据业务
         * @returns {Promise<unknown>}
         */
        handleDelete(record = null) {
            let deleteObject = record
            if (deleteObject == null || deleteObject instanceof Event) {
                deleteObject = this.table.rowSelection.selectedRowKeys
            }
            this.$confirmDeleteData(delete${entity.name}Ids, deleteObject)
                .then(this.refreshTable)
                .catch(showError)
        },
      handleBatchAction({key, keyPath, item}) {
        switch (key) {
          case 'delete':
            this.handleDelete()
            break
          default:
        }
      },
      handleMoreAction ({ key, keyPath, item, record }) {
        switch (key) {
          case 'delete':
              this.handleDelete(record)
            break
        }
      },
      resetData () {
        this.queryParam = {}
        this.table.dataSource = []
        this.table.pagination = { ...defaultPagination }
        this.table.rowSelection.selectedRows = []
        this.table.rowSelection.selectedRowKeys = []
      },
        jumpEditPage (record = null) {
            let id = null
            if (record != null && !(record instanceof Event)) {
                id = record.${primary.field.name}
            }
            this.$router.push({ name: this.$route.name + '-edit', params: { id } })
        }
    }
  }
</script>

<style scoped>

</style>
