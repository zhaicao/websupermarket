<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>我的订单</title>

	<link rel="shortcut icon" href="favicon.ico">
	<link rel="stylesheet" href="css/font-awesome.min.css">
    <link rel="stylesheet" href="css/monokai-sublime.min.css">
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="css/katex.min.css">
    <link rel="stylesheet" href="css/video-js.min.css">
	<link rel="stylesheet" href="css/styles.css">

	<style>
		@font-face {
			font-family: "lantingxihei";
			src: url("fonts/FZLTCXHJW.TTF");
		}

        /* modal 模态框*/
        #invite-user .modal-body {
            overflow: hidden;
        }
		#invite-user .modal-body .form-label {
			margin-bottom: 16px;
			font-size:14px;
		}
		#invite-user .modal-body .form-invite {
			width: 80%;
			padding: 6px 12px;
			background-color: #eeeeee;
			border: 1px solid #cccccc;
			border-radius: 5px;
			float: left;
			margin-right: 10px;
		}
		#invite-user .modal-body .msg-modal-style {
			background-color: #7dd383;
			margin-top: 10px;
			padding: 6px 0;
			text-align: center;
			width: 100%;
		}
		#invite-user .modal-body .modal-flash {
			position: absolute;
			top: 53px;
			right: 74px;
			z-index: 999;
		}
		/* end modal */

        .en-footer {
            padding: 30px;
            text-align: center;
            font-size: 14px;
        }
        .order-detail{
        	text-align: center;
            font-size: 14px;
        }
        .order-price{
    		font-size: 14px;
    		font-family: Verdana,Tahoma,arial;
    		color: #3c3c3c;
    		font-weight: bold;
    		text-align: center;
        }
        .order-sumprice{
        	font-size: 14px;
    	    font-family: Verdana,Tahoma,arial;
    	    color: #ff0000;
    		font-weight: bold;
    		text-align: center;
        }
    </style>
	
<style style="text/css">
.navbar-banner {
    margin-top: 50px;
    background: url("img/homepage-bg.png");
    background-size: cover;
    backgtound-repeat: no-repeat;
}
</style>
</head>
<body>
<!-- 头部 -->
<%@include file="header.jsp"%>
<!--/ 头部 -->

<div class="container layout">
    <div class="row">
        <div class="col-md-12 layout-body">
         <div class="row">
         	<div class="content" style="border:0">
        	 <div class="col-md-2">订单编号</div>
        	 <div class="col-md-1">状态</div>
        	 <div class="col-md-1">商品数量</div>
        	 <div class="col-md-2">商品总价(元)</div>
        	 <div class="col-md-1">收货人</div>
        	 <div class="col-md-1">付款方式</div>
        	 <div class="col-md-2">时间</div>
        	 <div class="col-md-2">操作</div>
        	</div>
         </div>   
<div class="content">
    <div class="tab-content">
        <div role="tabpanel" class="tab-pane active">
						
<ul class="row question-items" id="courses">
  <!-- 课程列表 -->
</ul>			

<nav class="pagination-container">
    <ul class="pagination">
    </ul>
</nav>
	
        </div>
    </div>
</div>

        </div>
    </div>
</div>

<!-- 购买模态框 -->
<div class="modal fade order-detail-modal" tabindex="-1" role="dialog">
    <div class="modal-dialog" role=document>
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title">订单详情</h4>
            </div>
            <div class="modal-body">
            </div>
            
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" data-dismiss="modal">确定</button>
            </div>
        </div>
    </div>
</div>

	<script src="js/lib.js"></script>
    <script src="js/jquery.min.js"></script>
    <script src="js/ace.js"></script>
    <script src="js/aliyun-oss-sdk-4.3.0.min.js"></script>
    <script src="js/highlight.min.js"></script>
    <script src="js/jspdf.min.js"></script>
    <script src="js/plupload.full.min.js"></script>
    <script src="js/ZeroClipboard.min.js"></script>
    <script src="js/video.min.js"></script>
    <script src="js/bootstrap-tour.min.js"></script>
    <script src="js/bootstrap-table.min.js"></script>
    <script src="js/bootstrap-table-zh-CN.min.js"></script>
    <script src="js/bootstrap-table-filter-control.min.js"></script>
    <script src="js/raven.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<script src="js/jquery.mini.js"></script>
	<!-- 分页插件 -->
	<script type="text/javascript" src="js/jqPaginator.js"></script>


<script type="text/javascript">
var user = <%=session.getAttribute("user") %>;
var totalPages = 0; //总分页数
var pageSize = 5;//每页显示条数

$(function() {
	_render()
	
	function _render() {
		_init()
		_addEvent()
	}
	
	function _init() {
		//初始化记录总数
		$.ajax({
				type: "post",
				url: "foreendServlet",
				dataType:'json',
				data: {type: 'myOrders', user_id: user.user_id,  curPage: 1, pageSize: pageSize},
				async: false,
				success: function(data, status){			
					totalPages  = Math.ceil(data.total/pageSize);//计算出总共页数
					}
				});
		//初始化分页咨询列表
		$.jqPaginator('.pagination', {
			totalPages: totalPages || 1,//总页数
		    visiblePages: 5,//显示页码数
		    currentPage: 1,//当前页面
		    first: '<li class="first"><a href="javascript:;">首页</a></li>',
		    prev: '<li class="prev"><a href="javascript:;">上一页</a></li>',
		    next: '<li class="next"><a href="javascript:;">下一页</a></li>',
		    last: '<li class="last"><a href="javascript:;">末页</a></li>',
		    page: '<li class="page"><a href="javascript:;">{{page}}</a></li>',
		    //换页事件
		    onPageChange: function (num, type) {
		    	//初始化记录总数
		    	$.ajax({
		    			type: "post",
		    			url: transformer(window.location.origin),
		    			dataType:'json',
		    			data: {type: 'myOrders', user_id: user.user_id, curPage: num, pageSize: pageSize},
		    			async: false,
		    			success: function(data, status){   				
		    				$("#courses").empty();
		    				$.each(data.courses, function(i, obj){
		    					var status,sHandle,method;
		    					if(obj.o_status == 1){
		    						status = '已发货';
		    						sHandle = '-';
		    					}	
		    					else if(obj.o_status == 2){
		    					     status = '已取消';
		    					     sHandle = '-';
		    					}else{
		    						status = '未发货';
		    						sHandle = '<button class="btn btn-info cancel" data-oid='+obj.o_id+' style="margin-right: 20px">取消</button>';
		    					}
		    					if( obj.o_method == 1)
		    						method = '货到付款';
		    					else
		    						method = '银行付款';
		    					$("#courses").append('<li class="question-item">'+
		    						    			 '<div class="col-md-2"><a href="#" class="order-details" data-oid='+obj.o_id+'>'+obj.o_id+'</a></div>'+
		    					   					 '<div class="col-md-1">'+status+'</div>'+ 
		    					   					 '<div class="col-md-1">'+obj.o_amount+'件</div>'+ 
		    					   					 '<div class="col-md-2">'+obj.o_sumprice+'</div>'+
		    					   					 '<div class="col-md-1">'+obj.o_receiver+'</div>'+
		    					   					 '<div class="col-md-1">'+method+'</div>'+
		    					   					 '<div class="col-md-2">'+obj.o_date.substring(0,19)+'</div>'+
		    					   					 '<div class="col-md-2">'+sHandle+
		    					   					 '</div>'+
		    					 					 '</li>');
		    				})
		    				totalPages  = Math.ceil(data.total/pageSize);//计算出总共页数
		    				}
		    			});
		    }
		});
	}
	
	function _addEvent() {
		$(".container").on('click', '.order-details', function(jEvent) {
			var jTarget = $(jEvent.target),
				oId = jTarget.data('oid'),
				jContent = $('.modal-body');
			jContent.empty();
				$.ajax({
					type: "post",
					url: "foreendServlet",
					dataType:'json',
					data: {type: 'getOrderSale', oId: oId},
					async: false,
					success: function(data, status){
						var height;
						$.each(data.sales, function(i, obj){
							var price;
							if( obj.s_gisonsale == 1)
								price = obj.s_price;
							else
								price = obj.s_gprice;
							jContent.append('<div class="form-group">'+
											'<div class="col-md-2 order-detail">'+obj.s_gcode+'</div>'+
											'<div class="col-md-4 order-detail">'+obj.s_gname+'</div>'+
											'<div class="col-md-2 order-price">￥'+price+'</div>'+
											'<div class="col-md-2 order-detail">'+obj.s_amount+'件</div>'+
											'<div class="col-md-2 order-sumprice">￥'+obj.s_sumprice+'</div>'+
								    		'</div>');
							height = i;
						})
						height = 40 + (height+1) * 10;
						jContent.animate({height,height}, 600);
						$('.modal.fade.order-detail-modal').modal('show');
					}
				});
			
		})
		
		$(".container").on('click', '.cancel', function(jEvent) {
			var jTarget = $(jEvent.target),
				oId = jTarget.data('oid');
			if(confirm("确定要取消该笔订单？")){
				$.ajax({
					type: "post",
					url: "foreendServlet",
					dataType:'json',
					data: {type: 'cancelOrder', oId: oId},
					async: false,
					success: function(data, status){
						if( data.status == 'success'){
							_init();
							alert('取消成功');
						}
					}
				});
			}
		})
	}
})

</script>
</body>
</html>