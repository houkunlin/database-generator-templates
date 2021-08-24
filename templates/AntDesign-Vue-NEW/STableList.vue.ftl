${gen.setFilename("STableList.vue")}
${gen.setFilepath("ui/${entity.name}/")}
<template>
    <router-view v-if="isChildRoute"></router-view>
    <a-card v-else>
        <search-form v-model="queryParam" @search="$refs.table.refresh(true)" />

        <!-- 表格顶部工具栏 -->
        <div class="table-operator">
            <a-button type="primary" icon="plus" @click="editId = null">新建（弹窗）</a-button>
            <a-button type="primary" icon="plus" @click="jumpEditPage">新建（路由）</a-button>
            <a-button type="dashed" icon="reload" @click="$refs.table.refresh(false)" :loading="loading">刷新</a-button>
            <a-button type="danger" icon="delete" @click="handleDelete" :disabled="!isSelectedRows">删除</a-button>
            <a-button type="dashed" @click="tableOption">{{ options.alert && '关闭' || '开启' }}多选</a-button>
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
          <a @click="editId = record.id">修改（弹窗）</a>
          <a @click="jumpEditPage(record)">修改（路由）</a>
        </span>
            </s-table>
        </a-spin>

        <!-- 信息编辑窗口 -->
        <edit-form-model
                :edit-id.sync="editId"
                @ok="refreshTable" />
        <description :info-id.sync="showInfoId" />
    </a-card>
</template>

<script>
    import {Ellipsis, STable} from '@/components'
    import {showError} from '@/utils/util'
    import { FormModelModal as EditFormModel } from './form'
    import Description from './Description'
    import {delete${entity.name}Ids, get${entity.name}} from './service'
    import { columns } from './model'
    import SearchForm from './SearchForm'

    export default {
        components: {
            STable,
            Ellipsis,
            EditFormModel,
            Description,
            SearchForm
        },
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
                // 需要编辑的 ${entity.comment} ID信息
                editId: undefined,
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
                            const data = res
                            const result = {
                                pageNo: data.size, // 返回结果中的当前分页数
                                totalCount: data.total, // 返回结果中的总记录数
                                data: [...data.list]
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
        watch: {
            '$route' (val, old) {
                this.isChildRoute = val.matched.length > old.matched.length || val.meta.hidden
            }
        },
        computed: {
            isSelectedRows(){
                return this.selectedRowKeys.length > 0
            }
        },
        mounted () {
            this.isChildRoute = this.$route.meta.hidden
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
                this.editId = undefined
                this.$refs.table.refresh(false)
            },
            /**
             * 处理删除数据业务
             * @returns {Promise<unknown>}
             */
            handleDelete(record = null) {
                let deleteObject = record
                if (deleteObject == null || deleteObject instanceof Event) {
                    deleteObject = this.selectedRowKeys
                }
                this.$confirmDeleteData(delete${entity.name}Ids, deleteObject)
                    .then(this.refreshTable)
                    .catch(showError)
            },
            handleBatchAction ({ key, keyPath, item }) {
                switch (key) {
                    case 'delete':
                        this.handleDelete()
                        break
                    default:
                }
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
