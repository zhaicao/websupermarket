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
  <title>订单详情</title>
  <script type="text/javascript" src="js/jquery.min.js"></script>
  <script type="text/javascript" src="js/bootstrap.min.js"></script>
  <script type="text/javascript" src="js/bootstrap-table.min.js"></script>
  <script type="text/javascript" src="js/bootstrap-table-zh-CN.min.js"></script>
  <link rel="stylesheet" type="text/css" href="css/bootstrap.min.css" />
  <link rel="stylesheet" type="text/css" href="css/bootstrap-table.min.css" />
  
  <script type="text/javascript" src="js/jquery.base64.js"></script>
  <script type="text/javascript" src="js/tableExport.js"></script>
   <script type="text/javascript" src="js/bootstrap-table-export.js"></script>
  
  <script type="text/javascript" src="js/custom.js"></script>
  <script type="text/javascript" src="js/jquery.mini.js"></script>
  </head>
  <body>

    <div class="container">
    <h4>订单管理</h4>
		<table id="tb_signup"></table>
    </div> 
 <script>
 var parms = getUrlParms();	  
 $(function () {
	  
	 //1.初始化Table
	 var oTable = new TableInit();
	 oTable.Init();
  	 
});
	 
	 //Table构造函数
		var TableInit = function () {
		var oTableInit = new Object();
		$("#tb_signup").bootstrapTable('destroy');//销毁table，避免保留上次加载的内容
	 	//初始化Table
	 	oTableInit.Init = function () {
		 	$('#tb_signup').bootstrapTable({
				 url: transformer(window.location.origin),
				 method: 'post', //请求方式（*）
				 contentType: "application/x-www-form-urlencoded",
				 toolbar: '#toolbar', //工具按钮用哪个容器
				 striped: true, //是否显示行间隔色
				 cache: false, //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
				 pagination: true, //是否显示分页（*）
				 sortable: true, //是否启用排序
				 sortOrder: "desc", //排序方式
				 queryParams: oTableInit.queryParams,//传递参数（*）
				 sidePagination: "client", //分页方式：client客户端分页，server服务端分页（*）
				 pageNumber:1, //初始化加载第一页，默认第一页
				 pageSize: 10, //每页的记录行数（*）
				 pageList: [10, 25, 50, 100], //可供选择的每页的行数（*）
				 smartDisplay: false,//智能显示分页按钮
				 paginationPreText: "上一页",
				 paginationNextText: "下一页",			 
				 search: true, //是否显示表格搜索
				 strictSearch: false,//是否全文匹配
				 showColumns: true, //是否显示所有的列
				 showRefresh: true, //是否显示刷新按钮
				 minimumCountColumns: 2, //最少允许的列数
				 clickToSelect: true, //是否启用点击选中行
				 //height: 528,  //行高，如果没有设置height属性，表格自动根据记录条数自动调整表格高度
				 uniqueId: "s_id", //每一行的唯一标识，一般为主键列
				 showToggle:true, //是否显示详细视图和列表视图的切换按钮
				 cardView: false, //是否显示详细视图
				 detailView: false, //是否显示父子表
				 idField : 's_id',
				 columns: [{
				field: 's_gcode',
				title: '货号',
				valign: 'middle',
				align: 'center',
				width: '15%'
				 },{
				 field: 's_gtype',
				 title: '类别',
				 valign: 'middle',
				 align: 'center',
				 width: '10%'
				 }, {
				 field: 's_gname',
				 title: '商品名',
				 align: 'center',
				 valign: 'middle',
				 width: '40%'
				 }, {
				 field: 's_gisonsale',
				 title: '单价',
				 align: 'center',
				 valign: 'middle',
				 width: '10%',
				 formatter: function(value,row,index){
					if( value == 1)	
					 	return row.s_price;
					else
						return row.s_gprice;
				 }
				 }, {
				 field: 's_amount',
				 title: '商品件数(件)',
				 align: 'center',
				 valign: 'middle',
			     width: '10%'
				 }, {
				field: 's_sumprice',
				title: '总价格',
				align: 'center',
				valign: 'middle',
				width: '10%'
				 }]
			});		 	
	 	};
	 
		 //得到查询的参数
		 oTableInit.queryParams = function (params) {
			 var temp = { //这里的键的名字和控制器的变量名必须一直，这边改动，控制器也需要改成一样的
				 type: "ordersDetail",
				 oId: parms.oId
			 };
			 	return temp;
		 };
			return oTableInit;
	};
	

		 
	 	
 
 </script>
  </body>
</html>
