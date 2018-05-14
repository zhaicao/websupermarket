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
  <title>商品管理</title>
  <script type="text/javascript" src="js/jquery.min.js"></script>
  <script type="text/javascript" src="js/bootstrap.min.js"></script>
  <script type="text/javascript" src="js/bootstrap-table.min.js"></script>
  <script type="text/javascript" src="js/bootstrap-table-zh-CN.min.js"></script>
  <script type="text/javascript" src="js/custom.js"></script>
    <script type="text/javascript" src="js/jquery.mini.js"></script>
  <link rel="stylesheet" type="text/css" href="css/bootstrap.min.css" />
  <link rel="stylesheet" type="text/css" href="css/bootstrap-table.min.css" />

  </head>
  <body>

    <div class="container">
      <h4>商品管理</h4>
      
   <!-- toolbar -->   
       <div id="toolbar" class="btn-group">
		 <button id="btn_add" type="button" class="btn btn-default">
		 <span class="glyphicon glyphicon-plus" aria-hidden="true"></span>新增
		 </button>
		 <button id="btn_edit" type="button" class="btn btn-default">
		 <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>修改
		 </button>
		 <button id="btn_delete" type="button" class="btn btn-default">
		 <span class="glyphicon glyphicon-remove" aria-hidden="true"></span>删除
		 </button>
		 </div>

<!-- bootstrap table -->

		<table id="tb_menu"></table>
    </div> 
 <script>
    
 $(function () {
	  
	 //1.初始化Table
	 var oTable = new TableInit();
	 oTable.Init();
	 
	 //2.初始化Button的点击事件
	 var oButtonInit = new ButtonInit();
	 oButtonInit.Init();
	 
});
	 
	 //Table构造函数
		var TableInit = function () {
		var oTableInit = new Object();
		$("#tb_menu").bootstrapTable('destroy');//销毁table，避免保留上次加载的内容
	 	//初始化Table
	 	oTableInit.Init = function () {
		 	$('#tb_menu').bootstrapTable({
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
				 pageList: [5, 10, 25, 50, 100], //可供选择的每页的行数（*）
				 smartDisplay: false,//智能显示分页按钮
				 paginationPreText: "上一页",
				 paginationNextText: "下一页",			 
				 search: true, //是否显示表格搜索
				 strictSearch: false,//是否全文匹配
				 searchOnEnterKey: false,//是否回车触发搜索
				 showColumns: true, //是否显示所有的列
				 showRefresh: true, //是否显示刷新按钮
				 minimumCountColumns: 2, //最少允许的列数
				 clickToSelect: true, //是否启用点击选中行
				 //height: 528,  //行高，如果没有设置height属性，表格自动根据记录条数自动调整表格高度
				 uniqueId: "g_id", //每一行的唯一标识，一般为主键列
				 showToggle:true, //是否显示详细视图和列表视图的切换按钮
				 cardView: false, //是否显示详细视图
				 detailView: false, //是否显示父子表
				 idField : 'g_id',
				 columns: [{
				 checkbox: true
				 },{
					 field: 'g_code',
					 title: '货号',
					 valign: 'middle'
					 },{
				 field: 'g_img',
				 title: '图片',
				 align: 'center',
				 width: '210px', //表格宽度
				 formatter: function(value,row,index){
                     return '<img  src="' + ('<%=basePath%>'+ 'upload/' + value) + '" height="150px" width="200px" class="img-rounded" >';
                 }
				 }, {
				 field: 'g_name',
				 title: '名称',
				 valign: 'middle'
				 }, {
				 field: 'g_type',
				 title: '类别',
				 valign: 'middle'
				 },{
				 field: 'g_unit',
				 title: '单位',
				 valign: 'middle'
				 }, {
				 field: 'g_price',
				 title: '售价',
				 valign: 'middle'
				 },{
				 field: 'g_summary',
				 title: '介绍',
				 valign: 'middle'
				 },{
				 field: 'g_isonsale',
				 title: '特价',
				 valign: 'middle',
				 formatter: function(value,row,index){
					 if (value == 0)
						 return '-';
					 else
						 return row.g_onsaleprice;
                 }
				 },{
				 field: 'g_amount',
				 title: '库存',
				 valign: 'middle'
				 },{
				field: 'g_isonsale',
				title: '状态',
				valign: 'middle',
				 formatter: function(value,row,index){
					 if (value == 1)
						 return '特价';
					 else
						 return '正常';
                 }
				}],
			});		 	
	 	};
	 
		 //得到查询的参数
		 oTableInit.queryParams = function (params) {
			 var temp = { //这里的键的名字和控制器的变量名必须一直，这边改动，控制器也需要改成一样的
				 type: "goods"
			 };
			 	return temp;
		 };
			return oTableInit;
	};
	 
//初始化页面上面的按钮事件
var ButtonInit = function () {
	var oInit = new Object();
	var postdata = {};
	oInit.Init = function () {
	 //增加
		 $("#btn_add").click(function(){
			 setModalIframe({
				 title : "增加商品",  //父模态框标题
				 path : "goodsDetail.jsp",  //父模态框加载的页面
				 btn_name : "增加",  //父模态框确定按钮显示文字
				 size : "", //父模态框大小
				 action : function(){ //绑定事件
					 var status = $("#iframemodal", parent.document)[0].contentWindow.conFunction();
					 $('#tb_menu').bootstrapTable('refresh', {silent: true});
					 if (status)
						 $("#openmodalParent", parent.document).trigger("click");					 
				 }				 
			 });
		 });
	 
	 //编辑事件
		 $("#btn_edit").click(function(){
			 var idField = $('#tb_menu').bootstrapTable("getOptions").idField;
			 //获取选中的所有行
			 var sss = $('#tb_menu').bootstrapTable('getSelections');
			 if(sss.length!=1){
				 alert("请选择一条数据！");
				 return ;
			 }
			 $.each(sss, function(i, obj){
				 setModalIframe({
						title: '修改商品',
						path: "goodsDetail.jsp?type=edit&&goodsId=" + obj[idField],
						btn_name: '修改',
						size: '',//默认modal-dialog,modal-lg,modal-sm
						action : function(){ //绑定事件
							 var status = $("#iframemodal", parent.document)[0].contentWindow.conFunction();
							 $('#tb_menu').bootstrapTable('refresh', {silent: true});
							 if (status)
								 $("#openmodalParent", parent.document).trigger("click");					 
						 }
					});
			 });
		 });
	 
	 //删除事件
		 $("#btn_delete").click(function(){
			 	var idField = $('#tb_menu').bootstrapTable("getOptions").idField;
			 	var sss = $('#tb_menu').bootstrapTable('getSelections');
			 	if(sss.length==0){
				 	alert("请选择一条或多条数据！");
				 	return ;
			 	}
			 	if(!confirm("确定要删除吗？")) return;
			 	$.each(sss, function(i, obj){
				 	//页面端删除（隐藏）
				 	$('#tb_menu').bootstrapTable('hideRow', {uniqueId:obj[idField]});
				 	$.ajax({
		    			type: "get",
		    			url: "${pageContext.request.contextPath}/controlServlet?type=menu_del&&foodid="+obj[idField],
		    			success: function(status){
		    				console.info(status);
		    			},
		    			error: function(XMLHttpRequest, textStatus, errorThrown){
		    				console.info(errorThrown);
		    			}
		    		}); 
			 });
		   
		 });
	};
	return oInit;
};
    //刷新数据
    function refreshFun(){
    	$('#tb_menu').bootstrapTable('refresh', {silent: true});
    }
 
 </script>
  </body>
</html>
