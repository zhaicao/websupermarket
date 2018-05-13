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
  <title>咨询问题</title>
  <script type="text/javascript" src="js/jquery.min.js"></script>
  <script type="text/javascript" src="js/bootstrap.min.js"></script>
  <script type="text/javascript" src="js/bootstrap-table.min.js"></script>
  <script type="text/javascript" src="js/bootstrap-table-zh-CN.min.js"></script>
  <link rel="stylesheet" type="text/css" href="css/bootstrap.min.css" />
  <link rel="stylesheet" type="text/css" href="css/bootstrap-table.min.css" />
  
  <script type="text/javascript" src="js/custom.js"></script>
  </head>
  <body>

    <div class="container">
    <h4>咨询问题</h4>
      
		<table id="tb_question"></table>
    </div> 
 <script>
    
 $(function () {
	  
	 //1.初始化Table
	 var oTable = new TableInit();
	 oTable.Init();
 
});
	 
	 //Table构造函数
		var TableInit = function () {
		var oTableInit = new Object();
		$("#tb_question").bootstrapTable('destroy');//销毁table，避免保留上次加载的内容
	 	//初始化Table
	 	oTableInit.Init = function () {
		 	$('#tb_question').bootstrapTable({
				 url: '<%=basePath%>controlServlet',
				 method: 'post', //请求方式（*）
				 contentType: "application/x-www-form-urlencoded",
				 toolbar: '#toolbar', //工具按钮用哪个容器
				 striped: true, //是否显示行间隔色
				 cache: false, //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
				 pagination: true, //是否显示分页（*）
				 sortable: true, //是否启用排序
				 sortOrder: "desc", //排序方式
				 queryParams: oTableInit.queryParams,//传递参数（*）
				 sidePagination: "server", //分页方式：client客户端分页，server服务端分页（*）
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
				 uniqueId: "f_id", //每一行的唯一标识，一般为主键列
				 showToggle:true, //是否显示详细视图和列表视图的切换按钮
				 cardView: false, //是否显示详细视图
				 detailView: false, //是否显示父子表
				 idField : 'f_id',
				 columns: [{
				 field: 'user_realname',
				 title: '姓名',
				 valign: 'middle',
				 align: 'center',
				 width: '10%' //表格宽度
				 }, {
				 field: 'user_phone',
				 title: '联系方式',
				 align: 'center',
				 valign: 'middle',
				 width: '10%' //表格宽度
				 }, {
				 field: 'f_content',
				 title: '咨询内容',
				 align: 'center',
				 valign: 'middle',
				 width: '40%' //表格宽度
				 },{
				 field: 'f_date',
				 title: '咨询时间',
				 align: 'center',
				 valign: 'middle',
				 width: '15%', //表格宽度
				 formatter: function(value,row,index){
					 return value.substring(0,16);
				 }
				 },{
				 field: 'f_reply',
				 title: '回复内容/操作',
				 align: 'center',
				 valign: 'middle',
				 formatter: function(value,row,index){
					 if (row.f_status == "未回复")
						 return '<a href="javascript:reply('+row.f_id+');" class="btn btn-info">回复</a>';
					 else
						 return value;
					 }
				 }
				 ],
			});		 	
	 	};
	 
		 //得到查询的参数
		 oTableInit.queryParams = function (params) {
			 var temp = { //这里的键的名字和控制器的变量名必须一直，这边改动，控制器也需要改成一样的
				 type: "question",
				 limit: params.limit, //页面大小
				 offset: params.offset, //页码
				 search: params.search //查询关键字
			 };
			 	return temp;
		 };
			return oTableInit;
	};
	 

//回复
function reply(f_id){
	setModalIframe({
		 title : "咨询问题回复",  //父模态框标题
		 path : "repQuestion.jsp?f_id=" + f_id,  //父模态框加载的页面
		 btn_name : "回复",  //父模态框确定按钮显示文字
		 size : "", //父模态框大小
		 action : function(){ //绑定事件
			 var status = $("#iframemodal", parent.document)[0].contentWindow.reply();
			 $('#tb_question').bootstrapTable('refresh', {silent: true});
			 if (status)
				 $("#openmodalParent", parent.document).trigger("click");					 
		 }				 
	 });
}
 
 </script>
  </body>
</html>
