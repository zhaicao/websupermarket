<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>报名管理</title>
  <script type="text/javascript" src="js/jquery.min.js"></script>
  <script type="text/javascript" src="js/bootstrap.min.js"></script>
  <script type="text/javascript" src="js/bootstrap-table.min.js"></script>
  <script type="text/javascript" src="js/bootstrap-table-zh-CN.min.js"></script>
  <link rel="stylesheet" type="text/css" href="css/bootstrap.min.css" />
  <link rel="stylesheet" type="text/css" href="css/bootstrap-table.min.css" />
  
  <script type="text/javascript" src="js/custom.js"></script>
  <script type="text/javascript" src="js/plugins/echarts/echarts.min.js"></script>
  <script type="text/javascript" src="js/jquery.mini.js"></script>
  </head>
  <body>

    <div class="container">
    	<h4>活动统计管理</h4>
		
		<div id="chart" style="height: 400px; margin-top: 30px;"></div>
    </div> 
 <script>
    
 $(function () {
	 var myChart = echarts.init(document.getElementById('chart'));
	 
	 _initChart()
	 
	 function _initChart() {
		 $.ajax({
	 		type: "post",
	 		url: transformer(window.location.origin),
	 		dataType:'json',
	 		data: {type: 'activityStatistics'},
	 		async: false,
	 		success: function(data){
	 			_createChart(data)
	 		},
	 		error: function(XMLHttpRequest, textStatus, errorThrown){
	 			console.info(errorThrown);
	 		}
	 	})
		
	}
	 
	 function _createChart(data) {
		 var oData = _parseData(data)
			if(!oData.x.length) {
					alert('暂无数据');
				}
				
				// 绘制图形。
				var option = {
			    title: {
			        text: '统计'
			    },
			    tooltip: {
			        trigger: 'axis'
			    },
			    legend: {
			        data:['报名数','签到数']
			    },
			    grid: {
			        left: '3%',
			        right: '4%',
			        bottom: '3%',
			        containLabel: true
			    },
			    toolbox: {
			        feature: {
			            saveAsImage: {}
			        }
			    },
			    xAxis: {
			        type: 'category',
			        boundaryGap: false,
			        data: oData.x
			    },
			    yAxis: {
			        type: 'value'
			    },
			    series: [
			        {
			            name:'报名数',
			            type:'line',
			            data: oData.income
			        },
			        {
			            name:'签到数',
			            type:'line',
			            data:oData.cost
			        }
			    ]
			};
			myChart.setOption(option, true)
	 }
	 
	 function _parseData(data) {
			var oReturn = {
				x: [],
				income: [],	// 报名数
				cost: [],	// 签到数
			}
			
			data.forEach(function(o) {
				oReturn.x.push(o.t_name)
				oReturn.income.push(parseFloat(o.signup))
				oReturn.cost.push(parseFloat(o.attend))
			})
			
			return oReturn
		}
 });
	 
	 
 
 </script>
  </body>
</html>
