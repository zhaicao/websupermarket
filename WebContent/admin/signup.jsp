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
  
  <script type="text/javascript" src="js/jquery.base64.js"></script>
  <script type="text/javascript" src="js/tableExport.js"></script>
   <script type="text/javascript" src="js/bootstrap-table-export.js"></script>
  
  <script type="text/javascript" src="js/custom.js"></script>
  <script type="text/javascript" src="js/jquery.mini.js"></script>
  </head>
  <body>

    <div class="container">
    <h4>报名管理</h4>
		<div>
			<label>活动列表</label>
			<select id="ac_list" class="form-control" style="width: 300px;"></select>
		</div>
		<table id="tb_signup"></table>
    </div> 
 <script>
    
 $(function () {
	 
	 _initActiv()
	 
	 
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
				 showExport: true, //是否显示导出
				 exportDataType: true, //导出所有数据
				 exportTypes: ['excel'],
				 columns: [{
					 field: 't_name',
					 title: '活动名',
					 valign: 'middle',
					 align: 'center',
					 width: '15%'
				 },{
				 field: 'user_realname',
				 title: '姓名',
				 valign: 'middle',
				 align: 'center',
				 width: '15%' //表格宽度
				 }, {
				 field: 'user_phone',
				 title: '联系方式',
				 align: 'center',
				 valign: 'middle',
				 width: '15%' //表格宽度
				 }, {
				 field: 's_score',
				 title: '票号',
				 align: 'center',
				 valign: 'middle',
				 width: '25%' //表格宽度
				 }, {
				 field: 's_date',
				 title: '报名时间',
				 align: 'center',
				 valign: 'middle',
				 formatter: function(value,row,index){
					return value.substring(0,16);
		                 }
				 },{
				 field: 's_status',
				 title: '操作',
				 align: 'center',
				 valign: 'middle',
				 formatter: function(value,row,index){
					if (value == 0)
						 return '<a href="javascript:confirmsignup('+row.s_id+');" class="btn btn-info">验票</a>';
					 /* else if(value == 1)
						 return '<a href="javascript:publish('+row.s_id+');" class="btn btn-success">发布成绩</a>'; */
					else if( value == 2)
						return '已取消'
					 else
						 return '已验证'
					 }
				 
				 }],
			});		 	
	 	};
	 
		 //得到查询的参数
		 oTableInit.queryParams = function (params) {
			 var temp = { //这里的键的名字和控制器的变量名必须一直，这边改动，控制器也需要改成一样的
				 type: "signup",
				 a_id: $("#ac_list").val()
			 };
			 	return temp;
		 };
			return oTableInit;
	};
	
	$("#ac_list").change(function() {
		$('#tb_signup').bootstrapTable('refresh', {silent: true});
	})
	
	// 初始化活动
	function _initActiv() {
		$.ajax({
	 		type: "post",
	 		url: transformer(window.location.origin),
	 		dataType:'json',
	 		data: {type: 'teacher'},
	 		async: false,
	 		success: function(data){
	 			var sHtml = ''
	 			data.forEach(function(o) {
	 				sHtml += '<option value="'+o.t_id+'">'+o.t_name+'</option>'
	 			})
	 			$("#ac_list").html(sHtml)
	 		},
	 		error: function(XMLHttpRequest, textStatus, errorThrown){
	 			console.info(errorThrown);
	 		}
	 	});
	}
	
	//确认报名
	 function confirmsignup(s_id){
	 	$.ajax({
	 		type: "post",
	 		url: transformer(window.location.origin),
	 		dataType:'json',
	 		data: {type: 'confirmsignup', s_id: s_id},
	 		success: function(status){
	 			$('#tb_signup').bootstrapTable('refresh', {silent: true});
	 			alert("操作成功！");
	 		},
	 		error: function(XMLHttpRequest, textStatus, errorThrown){
	 			console.info(errorThrown);
	 		}
	 	});
	 };
	 
	 //发布成绩
	 function publish(s_id, realname, course){
		 var score = prompt("请输入该学生本课程的成绩:","");
		 if(score == ""){
			 alert("请输入成绩!");
			 score = prompt("请输入该学生本课程的成绩:","");
		 }else if(!/^-?\d+\.?\d{0,2}$/.test(score)){
			 alert("请输入数字！");
			 score = prompt("请输入该学生本课程的成绩:","");
		 }else{
			 $.ajax({
			 		type: "post",
			 		url: transformer(window.location.origin),
			 		dataType:'json',
			 		data: {type: 'publishscore', score: score, s_id: s_id},
			 		success: function(status){
			 			$('#tb_signup').bootstrapTable('refresh', {silent: true});
			 			alert("操作成功！");
			 		},
			 		error: function(XMLHttpRequest, textStatus, errorThrown){
			 			console.info(errorThrown);
			 		}
			 	}); 
		 }
	 	
	 };
 
 </script>
  </body>
</html>
