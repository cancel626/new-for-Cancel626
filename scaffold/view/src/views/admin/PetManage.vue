<template>
  <div class="container">
    <div class="top-healder">
      <div class="nav-left">
        <Tab :buttons="[
          { label: '全部', value: 'null' },
          { label: '未推荐', value: '0 ' },
          { label: '已推荐', value: '1' }
        ]" initialActive="null" @change="handleChange" />
      </div>
      <div class="nav-right">
        <div>
          <AutoInput placeholder="搜索宠物" @listener="listener" />
        </div>
        <div class="primary-bt" @click="dialogVisible = true">
          <i class="el-icon-plus"></i>
          新增宠物
        </div>
      </div>
    </div>
    <!-- 表格及分页信息 -->
    <div>
      <el-table :data="apiResult.data">
        <el-table-column prop="name" label="基本信息">
          <template #default="scope">
            <div style="gap:10px;display: flex;justify-content: left;align-items: center;">
              <div class="cover-block">
                <img width="90px" height="60px" style="border-radius: 5px;" :src="scope.row.cover" alt="">
                <span class="pet-type">{{ scope.row.petTypeName }}</span>
              </div>
              <div>
                <div style="font-size: 18px;">
                  {{ scope.row.name }}
                </div>
                <div>
                  <el-tag size="mini" info="success">宠物所在地-{{ scope.row.address }}</el-tag>
                </div>
              </div>
            </div>
          </template>
        </el-table-column>
        <el-table-column prop="status" width="250" label="宠物状态">
          <template #default="scope">
            <div>接种疫苗状态:{{ scope.row.isVaccine ? '已接种' : '未接种' }}</div>
            <div>是否推荐:{{ scope.row.isRecommend ? '已推荐' : '未推荐' }}</div>
            <div>是否领养:{{ scope.row.isVaccine ? '已领养' : '未领养' }}</div>
          </template>
        </el-table-column>
        <el-table-column prop="birthday" :sortable="true" width="150" label="属性">
          <template #default="scope">
            <span>年龄： {{ scope.row.age }}个月</span>
            <div>性别：{{ scope.row.gender === 0 ? '公' : '母' }}</div>
          </template>
        </el-table-column>
        <el-table-column width="200" label="" align="center">
          <template #default="scope">
            <div class="operate-buttons">
              <el-dropdown trigger="click" placement="bottom-end">
                <span class="el-dropdown-link">
                  <i class="el-icon-more"></i>
                </span>
                <el-dropdown-menu slot="dropdown">
                  <el-dropdown-item @click.native="handleEdit(scope.row)" icon="el-icon-edit">
                    修改信息
                  </el-dropdown-item>
                  <el-dropdown-item @click.native="handleDelete(scope.row)"
                    icon="el-icon-delete">删除宠物</el-dropdown-item>
                </el-dropdown-menu>
              </el-dropdown>
            </div>
          </template>
        </el-table-column>
      </el-table>
      <!-- 分页组件区域 -->
      <div class="pager">
        <el-pagination @size-change="handleSizeChange" @current-change="handleCurrentChange"
          :current-page="petQueryDto.current" :page-sizes="[10, 20]" :page-size="petQueryDto.size"
          layout="total, sizes, prev, pager, next, jumper" :total="apiResult.total"></el-pagination>
      </div>
    </div>

    <!-- 宠物信息操作弹窗 -->
    <el-dialog :title="dialogControlOperation ? '新增宠物信息' : '修改宠物信息'" :show-close="false" :visible.sync="dialogVisible"
      :closeOnClickModal="false" width="45%">
      <el-tabs v-model="tabActiveName" :tab-position="tabPosition" style="min-height: 460px;">
        <el-tab-pane label="宠物基本信息" name="first">
          <div>
            <div class="user-avatar">
              <p>点击📷处即可上传封面</p>
              <img v-if="cover" style="width:160px;height:90px;border-radius:5px" :src="cover || ''" alt="">
              <el-upload class="cover" action="/api/v1.0/pet-adopt-api/admin/common/upload" :show-file-list="false"
                :on-success="handleImageSuccess">
                <i class="el-icon-camera-solid"></i>
              </el-upload>
            </div>
            <div>
              <p>*宠物名称</p>
              <el-input placeholder="输入名称" v-model="apiParam.name" clearable>
              </el-input>
            </div>
            <div>
              <p>*宠物所在地</p>
              <el-input placeholder="输入所在地" v-model="apiParam.address" clearable>
              </el-input>
            </div>
            <div>
              <p>*宠物类别</p>
              <el-select v-model="apiParam.petTypeId" placeholder="请选择宠物类别" style="width: 100%;">
                <el-option v-for="item in petTypeList" :key="item.id" :label="item.name" :value="item.id">
                </el-option>
              </el-select>
            </div>
            <div>
              <p>*宠物年龄</p>
              <el-slider v-model="apiParam.age" style="padding-inline: 20px;"></el-slider>
            </div>
          </div>
        </el-tab-pane>
        <el-tab-pane label="基本信息" name="second">
          <div>
            <div>
              <p>*宠物是否接种疫苗</p>
              <Tab :buttons="[
                { label: '未接种', value: '0' },
                { label: '已接种', value: '1' }
              ]" :initialActive="String(apiParam.isVaccine)" @change="handleVaccineChange" />
            </div>
            <div>
              <p>*宠物是否推荐</p>
              <Tab :buttons="[
                { label: '未推荐', value: '0' },
                { label: '已推荐', value: '1' }
              ]" :initialActive="String(apiParam.isRecommend)" @change="handleRecommendChange" />
            </div>
            <div>
              <p>宠物性别</p>
              <Tab :buttons="[
                { label: '公', value: '0' },
                { label: '母', value: '1' }
              ]" :initialActive="String(apiParam.gender)" @change="handleGenderChange" />
            </div>
            <div v-if="!dialogControlOperation">
              <p>宠物领养状态</p>
              <Tab :buttons="[
                { label: '未领养', value: '0' },
                { label: '已领养', value: '1' }
              ]" :initialActive="String(apiParam.isAdopt)" @change="handleAdoptChange" />
            </div>
          </div>
        </el-tab-pane>
        <el-tab-pane label="宠物描述信息" name="third">
          <Editor :key="editorKey" ref="editorRef" :receviceContent="detail" @on-listener="onListener"
            api="/api/v1.0/pet-adopt-api/admin/common/upload" />
        </el-tab-pane>
      </el-tabs>

      <span slot="footer" class="dialog-footer">
        <span class="primary-bt" @click="cancelOperation">取消</span>
        <span class="info-bt" @click="handleConfirm">
          {{ dialogControlOperation ? '确定新增' : '确定修改' }}
        </span>
      </span>
    </el-dialog>

    <!-- 删除确认弹窗 -->
    <el-dialog title="删除宠物" :show-close="false" :visible.sync="dialogDeletedVisible" width="20%">
      <span>确定删除宠物数据？</span>
      <span slot="footer" class="dialog-footer">
        <el-button size="mini" @click="dialogDeletedVisible = false">取消</el-button>
        <el-button size="mini" type="primary" @click="confirmDeleted">确定</el-button>
      </span>
    </el-dialog>
  </div>
</template>

<script>

import AutoInput from "@/components/AutoInput.vue"; // 导入封装好的输入框组件
import Tab from "@/components/Tab" // 导入封装好的Tab组件
import Editor from "@/components/Editor";
import { template } from "lodash-es";
export default {
  components: { AutoInput, Tab, Editor }, // 注册组件
  data() {
    return {
      tabActiveName: 'first', // 操作弹窗初始tab页选中第一项
      tabPosition: 'right', // 操作弹窗排布靠右
      id: null, // 页面即将删除的数据ID
      apiResult: { // 后端返回的查询数据的响应数据
        data: [], // 数据项
        total: 0, // 符合条件的数据总想 - 初始赋值为0
      },
      petQueryDto: { // 搜索条件
        current: 1, // 当前页 - 初始是第一页
        size: 10, // 页面显示大小 - 初始是10条
        isRecommend: null, // 宠物是否推荐
        name: null, // 宠物名
      },
      dialogDeletedVisible: false, // 删除弹窗控制开关变量 - 初始是关（false）
      dialogVisible: false, // 操作弹窗控制开关变量 - 初始是关（false）
      dialogControlOperation: true, // 弹窗当前操作标识 - true：新增；false：修改
      editorKey: 0,
      apiParam: {
        isVaccine: 0,
        isRecommend: 0,
        gender: 0,
      }, // 传送进后端的数据 - 用于新增与修改场景
      cover: '', // 宠物封面
      petTypeList: [],// 宠物类型列表
      detail: '',// 宠物具体详情
    };
  },
  created() {
    this.fetchFreshData(); // 页面创建时，先去加载宠物数据
    this.fetchPetTypedata();// 先去加载宠物类型数据
  },
  methods: {
    //宠物详情监听
    onListener(content) {
      this.apiParam.detail = content;
    },

    //查询宠物类型
    async fetchPetTypedata() {
      try {
        const { data } = await this.$axios.post('/pet-type/query', {});
        this.petTypeList = data;
      } catch (error) {
        console.error('查询宠物类型异常:', error.message);
      }
    },

    handleConfirm() {
      // 判断行为类型 - 判断是新增操作还是修改操作
      this.dialogControlOperation ? this.savePetOperation() : this.updatePetOperation();
    },
    // 账号状态切换
    handleIsLoginChange(obj) {
      this.apiParam.isLogin = Number(obj.value);
    },
    // 禁言状态切换
    handleIsWordChange(obj) {
      this.apiParam.isWord = Number(obj.value);
    },
    // 疫苗状态切换
    handleVaccineChange(obj) {
      this.apiParam.isVaccine = Number(obj.value);
    },
    // 推荐状态切换
    handleRecommendChange(obj) {
      this.apiParam.isRecommend = Number(obj.value);
    },
    // 性别选择切换
    handleGenderChange(obj) {
      this.apiParam.gender = Number(obj.value);
    },
    // 领养状态切换
    handleAdoptChange(obj) {
      this.apiParam.isAdopt = Number(obj.value);
    },
    // 修改宠物信息操作
    async updatePetOperation() {
      try {
        this.apiParam.cover = this.cover; // 头像赋值处理
        const { message } = await this.$axios.put('/pet/update', this.apiParam);
        this.cancelOperation(); // 状态置位
        this.$message.success(message); // 消息提示
        this.fetchFreshData(); // 重新加载列表数据
      } catch (error) {
        this.$message.warning(error.message);
      }
    },
    // 保存宠物信息操作
    async savePetOperation() {
      try {
        this.apiParam.cover = this.cover;
        const { message } = await this.$axios.post('/pet/save', this.apiParam);
        this.cancelOperation(); // 状态置位
        this.$message.success(message); // 消息提示
        this.fetchFreshData(); // 重新加载列表数据
      } catch (error) {
        this.$message.warning(error.message);
      }
    },
    // 取消处理
    cancelOperation() {
      this.apiParam = {}; // 将参数对象清置
      this.cover = ''; // 宠物头像清置
      this.detail = '';// 宠物详情清空
      this.password = '';// 密码信息清空
      this.tabActiveName = 'first'; // 操作列表恢复默认选中第一项
      this.dialogVisible = false; // 关闭宠物新增弹窗
      this.dialogControlOperation = true; // 操作标识变量设置为最初的状态，即true，为新增
      // 强制刷新Editor组件
      this.editorKey += 1;
    },
    // 封面上传响应
    handleImageSuccess(res, file) {
      // 通知提示
      this.$notify({
        title: '头像上传',
        type: res.code === 200 ? 'success' : 'error',
        message: res.code === 200 ? '上传成功' : res.data,
        position: 'buttom-right',
        suration: 1000,
      })
      if (res.code === 200) {
        this.cover = res.message; // 响应里面的data，即后端返回的上传后的图片链接
      }
    },
    // 宠物角色状态选中事件
    handleChange(obj) {
      this.petQueryDto.isRecommend = Number(obj.value); // 转成数值类型，再赋值
      this.fetchFreshData(); // 重新加载宠物数据
    },
    // 输入框组件输入回传
    listener(text) {
      this.petQueryDto.name = text; // 赋值查询条件的内容
      this.fetchFreshData(); // 重新加载数据
    },
    // 查询宠物数据
    async fetchFreshData() {
      try {
        const { data, total } = await this.$axios.post('/pet/list', this.petQueryDto);
        this.apiResult.data = data;
        this.apiResult.total = total;
      } catch (error) {
        console.error('查询宠物信息异常:', error);
      }
    },
    // 分页 - 处理页面页数切换
    handleSizeChange(size) {
      this.petQueryDto.size = size; // 当前页面大小重置
      this.petQueryDto.currrent = 1; // 当前页设置为第一页
      this.fetchFreshData(); // 重新加载页面数据
    },
    // 分页 - 处理页面当前页切换
    handleCurrentChange(current) {
      this.petQueryDto.current = current; // 当前页选中
      this.fetchFreshData(); // 重新加载页面数据
    },
    // 表格点击修改宠物
    async handleEdit(row) {
      try {
        const { data } = await this.$axios.get(`/pet/${row.id}`);
        this.cancelOperation();
        this.apiParam = { ...data }; // 当前操作宠物信息
        this.dialogControlOperation = false; // 标识为修改操作
        this.dialogVisible = true; // 打开操作面板
        this.cover = data.cover; // 头像手动赋值
        this.detail = data.detail;
        this.apiParam.isVaccine = Number(this.apiParam.isVaccine);
        this.apiParam.isRecommend = Number(this.apiParam.isRecommend);
        this.apiParam.isAdopt = Number(this.apiParam.isAdopt);
      } catch (error) {
        console.log("宠物修改：", error);
        this.$message.error(error.message);
      }

    },
    // 表格点击删除宠物
    handleDelete(row) {
      this.dialogDeletedVisible = true; // 开启删除弹窗确认
      this.id = row.id;
    },
    // 宠物删除
    async confirmDeleted() {
      try {
        const { code } = await this.$axios.delete(`/pet/${this.id}`);
        if (code === 200) {
          this.$notify.success({
            title: '宠物删除',
            message: '删除成功',
            position: 'buttom-right',
            suration: 1000,
          });
          this.dialogDeletedVisible = false; // 关闭删除确认弹窗
          this.id = null; // 将标识ID置位
          this.fetchFreshData(); // 删除宠物数据之后，重新加载宠物数据
        }
      } catch (error) {
        console.log("删除宠物数据异常：", error);
      }
    }
  },
};
</script>
<style scoped lang="scss">
.cover-block {
  // 父相子绝
  position: relative;

  .pet-type {
    position: absolute;
    top: 0;
    left: 0;
    color: rgb(255, 255, 255);
    font-size: 10px;
    padding: 0 4px;
    border-top-left-radius: 5px;
    background-color: rgba(9, 164, 48, 0.4)
  }
}

.pager {
  margin-block: 20px;
}

/* 默认隐藏操作按钮 */
.operate-buttons {
  opacity: 0;
  transition: opacity 0.3s;
  /* 添加过渡效果 */
  cursor: pointer;

  i {
    padding: 8px;
    border-radius: 6px;
    transition: all .5s ease;

    &:hover {
      background-color: rgb(236, 237, 238);
    }
  }

}

/* 行悬停时显示操作按钮 */
.el-table__body tr:hover .operate-buttons {
  opacity: 1;
}

.container {
  margin: 10px 20px;
}

.top-healder {
  margin-block: 10px;
  padding-inline: 10px;
  border-radius: 5px;
  display: flex;
  justify-content: space-between;
  align-items: center;

  .nav-left,
  .nav-right {
    display: flex;
    justify-content: left;
    align-items: center;
    gap: 10px;
  }

  .nav-left {
    display: flex;
  }

}
</style>