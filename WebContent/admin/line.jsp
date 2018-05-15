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
  <title>销售趋势</title>
  <script type="text/javascript" src="js/jquery.min.js"></script>
  <script type="text/javascript" src="js/bootstrap.min.js"></script>
  <script type="text/javascript" src="js/bootstrap-table.min.js"></script>
  <script type="text/javascript" src="js/bootstrap-table-zh-CN.min.js"></script>
  <link rel="stylesheet" type="text/css" href="css/bootstrap.min.css" />
  <link rel="stylesheet" type="text/css" href="css/bootstrap-table.min.css" />
  
  <script type="text/javascript" src="js/custom.js"></script>
  <script type="text/javascript" src="js/plugins/echarts/echarts.min.js"></script>
  <script type="text/javascript" src="js/jquery.mini.js"></script>
  <script src="js/plugins/jedate/jedate.js"></script>
  </head>
  <body style="background-color: #F0F0F0;">

    <div class="container">
    	<h4></h4>
		<div class="select-item" style="margin-top: 20px;">
			<label>类型</label>
			<select id="typeList" style="width: 20%;"></select>
			<label>时间</label>
			<input type="datetime" id="startTime" name="startTime" placeholder="请输入开始时间" />----
			<input type="datetime" id="endTime" name="endTime" placeholder="请输入结束时间" />
			<a href="#" class="btn btn-info btn-refresh">查询</a>
		</div>
		<div id="chart" style="height: 400px; margin-top: 30px;"></div>
    </div> 
 <script>
    
 $(function () {
	 var myChart = echarts.init(document.getElementById('chart'));
	 
	 _initDate()
	 _initChart()
	 _addEvent()
	  
	 function getCurrentMonthFirst(){
		 var date=new Date();
		 date.setDate(1);
		 return date;
	}
	
	 function getCurrentMonthLast(){
		 var date=new Date();
		 var currentMonth=date.getMonth();
		 var nextMonth=++currentMonth;
		 var nextMonthFirstDay=new Date(date.getFullYear(),nextMonth,1);
		 var oneDay=1000*60*60*24;
		 return new Date(nextMonthFirstDay-oneDay);
	}
	 
	 function _addEvent() {
		 $(".btn-refresh").click(function() {
			 _initChart()
		 })
	 }
	 
	 function _initDate () {
		 var first = getCurrentMonthFirst(),
		 	end = getCurrentMonthLast()
		 
		 jeDate({
			dateCell:"#startTime",//isinitVal:true,
			format:"YYYY-MM-DD",
			isTime:false //isClear:false
		})
		jeDate({
			dateCell:"#endTime",//isinitVal:true,
			format:"YYYY-MM-DD",
			isTime:false //isClear:false
		})
		
		$("#startTime").val(new Date(first).Format('yyyy-MM-dd'))
		$("#endTime").val(new Date(end).Format('yyyy-MM-dd'))
		
		 $.ajax({
	 		type: "post",
	 		url: transformer(window.location.origin),
	 		dataType:'json',
	 		data: {
	 			type: 'getAllType'
	 		},
	 		async: false,
	 		success: function(data){
	 			$.each(data, function(i, obj){
	 				$("#typeList").append("<option value='"+obj.s_gtype+"'>"+obj.s_gtype+"</option>");
	 			})
	 		}
	 	})
	 }
	 
	 function _initChart() {
		 $.ajax({
	 		type: "post",
	 		url: transformer(window.location.origin),
	 		dataType:'json',
	 		data: {
	 			type: 'saleLine',
	 			gType: $("#typeList").val(),
	 			startDate: $('#startTime').val(),
	 			endDate: $('#endTime').val()
	 		},
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
			        text: '营业额统计'
			    },
			    tooltip: {
			        trigger: 'axis'
			    },
			    legend: {
			        data:['营业额']
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
			            name:'营业额',
			            type:'line',
			            data: oData.y
			        }
			    ]
			};
			myChart.setOption(option, true)
	 }
	 
	 function _parseData(data) {
			var oReturn = {
				x: [],
				y: [],	// 报名数
			}
			
			data.forEach(function(o) {
				oReturn.x.push(o.date)
				oReturn.y.push(o.total.toFixed(2))
			})
			
			return oReturn
		}
 });
	 
	 
 
 </script>
  </body>
</html>
