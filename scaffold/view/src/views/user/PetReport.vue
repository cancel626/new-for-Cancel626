<template>
  <div class="report-container">
    <div class="charts-wrapper">
      <div id="bar-chart-container" style="width: 600px; height: 400px;"></div>
      <div id="pie-chart-container" style="width: 600px; height: 400px;"></div>
    </div>
  </div>
</template>

<script>
import * as echarts from 'echarts';

export default {
  name: 'PetReport',
  data() {
    return {
      barChart: null,
      pieChart: null,
      xAxisData1: [],    // 存储 x 轴标签
      seriesData1: [],  // 存储 y 轴值
      xAxisData2: [],    // 存储 x 轴标签
      seriesData2: [],    // 存储 y 轴值
    }
  },
  async mounted() {
    await this.fetchTypeReportData();
    this.initChart();
  },
  methods: {
    initChart() {
      // 初始化柱状图
      const barChartDom = document.getElementById('bar-chart-container');
      this.barChart = echarts.init(barChartDom);

      const barOption = {
        title: {
          text: '各类宠物详细数量图'
        },
        tooltip: {
          trigger: 'axis',
          formatter: '{b}: {c}'
        },
        color: ['#5470c6', '#91cc75', '#fac858'],
        xAxis: {
          type: 'category',
          data: this.xAxisData1
        },
        yAxis: {
          type: 'value'
        },
        series: [{
          data: this.seriesData1,
          type: 'bar'
        }]
      };

      this.barChart.setOption(barOption);

      // 初始化饼状图
      const pieChartDom = document.getElementById('pie-chart-container');
      this.pieChart = echarts.init(pieChartDom);

      // 准备饼状图数据
      const pieData = this.xAxisData2.map((name, index) => ({
        name: name,
        value: this.seriesData2[index]
      }));

      const pieOption = {
        title: {
          text: '宠物分布比例图'
        },
        tooltip: {
          trigger: 'item',
          formatter: '{a} <br/>{b}: {c} ({d}%)'
        },
         color: ['#ff6b6b', '#4ecdc4', '#45b7d1', '#96ceb4', '#feca57'], 
        series: [{
          name: '宠物分布',
          type: 'pie',
          radius: '50%',
          data: pieData
        }]
      };

      this.pieChart.setOption(pieOption);
    },
    async fetchTypeReportData() {
      try {
        // 调用后端 API 获取数据
        const response = await this.$axios.get('/pet-report/type-count');
        const response2 = await this.$axios.get('/pet-report/post-count');
        this.xAxisData1 = response.data.xaxis;
        this.seriesData1 = response.data.series;
        this.xAxisData2 = response2.data.xaxis;
        this.seriesData2 = response2.data.series;
        console.log('Full response:', response);
      } catch (error) {
        console.error('Failed to fetch report data:', error);
      }
    }
  },
  beforeDestroy() {
    if (this.barChart) {
      this.barChart.dispose();
    }
    if (this.pieChart) {
      this.pieChart.dispose();
    }
  }
}
</script>

<style scoped>
.report-container {
  padding: 20px;
}

.charts-wrapper {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(600px, 1fr));
  justify-items: center;
  gap: 20px;
}
</style>