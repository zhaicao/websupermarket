<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>我的活动</title>

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
	<!-- <script src="js/index.js"></script> -->
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
				data: {type: 'mycourses', user_id: user.user_id,  curPage: 1, pageSize: pageSize},
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
		    			data: {type: 'mycourses', user_id: user.user_id, curPage: num, pageSize: pageSize},
		    			async: false,
		    			success: function(data, status){   				
		    				$("#courses").empty();
		    				$.each(data.courses, function(i, obj){
		    					var score,sHandle;
		    					if(obj.s_status == 0) {	
		    						sHandle = '<div class="col-md-3">'
					   					 +'<button class="btn btn-info confirm-active" data-id="'+obj.s_id+'" style="margin-right: 20px">签到</button>'
					   					 +'<button class="btn btn-default cancel-active" data-id="'+obj.s_id+'">取消</button>'
					   					 +'</div>'
		    					}else if(obj.s_status == 1) {
		    						sHandle = '签到成功'
		    					}else if(obj.s_status == 2) {
		    						sHandle = '已取消'
		    					}
		    						
		    					$("#courses").append('<li class="question-item">'+
		    						    			 '<div class="col-md-4">'+
		    					        			 '<h4>'+obj.t_name+'</h4>'+
		    					        			 '<div class="question-item-summary">'+
		    										 '<span class="question-item-date">票号：'+obj.s_score+'</span>'+
		    					    				 '</div>'+
		    					   					 '</div>'+
		    					   					 '<div class="col-md-3">'+
		    					   					 '</div>'+ 
		    					   					 sHandle+
		    					 					 '</li>');
		    				})
		    				totalPages  = Math.ceil(data.total/pageSize);//计算出总共页数
		    				}
		    			});
		    }
		});
	}
	
	function _addEvent() {
		$(".container").on('click', '.confirm-active', function(jEvent) {
			var jTarget = $(jEvent.target),
				sId = jTarget.data('id')
			if(confirm("确定要签到该活动？")){
				$.ajax({
					type: "post",
					url: "controlServlet",
					dataType:'json',
					data: {type: 'confirmsignup', s_id: sId},
					async: false,
					success: function(data, status){
						if( data.status == 'success')
							alert('签到成功');
						_init()
					}
				});
			}
			
		})
		
		$(".container").on('click', '.cancel-active', function(jEvent) {
			var jTarget = $(jEvent.target),
				sId = jTarget.data('id')
			if(confirm("确定要取消该活动？")){
				$.ajax({
					type: "post",
					url: "foreendServlet",
					dataType:'json',
					data: {type: 'cancelSignup', s_id: sId},
					async: false,
					success: function(data, status){
						if( data.status == 'success')
							alert('取消成功');
						_init()
					}
				});
			}
		})
	}
})

</script>
</body>
</html>