<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>商品列表</title>

<link rel="shortcut icon" href="favicon.ico">
<link rel="stylesheet" href="css/font-awesome.min.css">
<link rel="stylesheet" href="css/monokai-sublime.min.css">
<link rel="stylesheet" href="css/bootstrap.min.css">
<link rel="stylesheet" href="css/katex.min.css">
<link rel="stylesheet" href="css/video-js.min.css">
<link rel="stylesheet" href="css/styles.css">

	<style>

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
        .btns {
        	display: none;
        }
    </style>

	
    
</head>

<body>

<!-- 头部 -->
<%@include file="header.jsp"%>
<!--/ 头部 -->

<div class="container layout layout-margin-top">
       
    <div class="row">
        <div class="col-md-9 layout-body">
            
    <div class="content">
        <div class="discovery-list">
            <div class="discovery-title">
                <div class="pull-left discovery-title-text">
                    <strong>特价商品</strong><span></span>
                </div>
            </div>
            <div class="row" id="teacherList">
            
            <!-- 商品列表 -->
            </div>   


                      

<nav class="pagination-container">
<!-- 分页 -->
<ul class="pagination" id="pagination"></ul>
</nav>


            
        </div>
    </div>

        </div>
        <div class="col-md-3 layout-side">
            
    
<form class="side-search-input">
    <div class="input-group">
        <input class="form-control" type="text" name="keyword" id="keyword" placeholder="活动名称">
        <span class="input-group-btn">
            <button class="btn btn-default" id="search">搜索</button>
        </span>
    </div>
</form>
<div class="sidebox recommend-courses">
        <div class="sidebox-header recommend-courses-header">
            <h4 class="sidebox-title">特价商品</h4>
        </div>
        
        <div class="sidebox-body recommend-courses-content" id="recTeacher">
		<!-- 推荐教师 -->
        </div>
    </div>

<div class="sidebox recommend-courses">
        <div class="sidebox-header recommend-courses-header">
            <h4 class="sidebox-title">公告</h4>
        </div>
        
        <div class="sidebox-body recommend-courses-content" id="notice" style="height:200px">
		<!-- 公告 -->
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
    <script src="js/bootstrap.min.js"></script>
    <script src="js/bootstrap-tour.min.js"></script>
    <script src="js/bootstrap-table.min.js"></script>
    <script src="js/bootstrap-table-zh-CN.min.js"></script>
    <script src="js/bootstrap-table-filter-control.min.js"></script>
    <script src="js/raven.min.js"></script>
    <script src="js/custom.js"></script>
	<script src="js/jquery.mini.js"></script>
	
	
	<!-- 分页插件 -->
<script type="text/javascript" src="js/jqPaginator.js"></script>


<script type="text/javascript">
var totalPages = 0; //总分页数
var pageSize = 15;//每页显示条数
var keyword = "";

var jUserInfo = $('.user-hide'),
	jBtns = $('.navbar-right'),
	jSignUp = $('.sign-up'),
	jSignDown = $('.sign-down'),
	jLog = $('.log-up')

function getTotalPages(keyword){
//初始记录条数
$.ajax({
		type: "post",
		url: "foreendServlet",
		dataType:'json',
		data: {type: 'goods', curPage: 1, pageSize: pageSize, searchKey: keyword, isOnSale: ""},
		async: false,
		success: function(data, status){			
			totalPages  = Math.ceil(data.total/pageSize);//计算出总共页数
			}
		})
}
 //加载数据及分页插件
 $(function(){	
	 
	 $.ajax({
			type: "post",
			url: "${pageContext.request.contextPath}/controlServlet",
      dataType:'json',
      data: {type: 'getNotice'},
			success: function(data, status){
				$("#notice").text(data.n_content);
	    		
			}
		});
		//初始化分页控件及教师数据
		search("");
		//初始化查询
		//initCourse();
		$("#search").click(function(){
			var key = $("#keyword").val();
			search(key);
			return false;
		   });
		
		//初始化推荐教师
		$.ajax({
			type: "post",
			url: "foreendServlet",
			dataType:'json',
			data: {type: 'index'},
			success: function(data, status){
				$.each(data.onsale, function(i, obj){
					$("#recTeacher").append('<a href="goodsDetail.jsp?g_id='+obj.g_id+'">'+obj.g_name+'</a>');
				});		
			}
		});
	});
		
		//查询事件
		function search(keyword){
			getTotalPages(keyword);
			paginator(totalPages, pageSize, keyword);
		}


		//分页函数
		function paginator(totalPages, pageSize, keyword){
		$.jqPaginator('#pagination', {
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
	        	$.ajax({
		   			type: "post",
		   			url: "foreendServlet",
		   			dataType:'json',
		   			data: {type: 'goods', curPage: num, pageSize: pageSize, searchKey: keyword, isOnSale: 1},
		   			success: function(data, status){
		   				totalPages  = Math.ceil(data.total/pageSize);//计算出总共页数
		   				$("#teacherList").empty();
		   				$.each(data.goods, function(i, obj){
		   					$("#teacherList").append(
			   						'<div class="col-md-4" >'+
	    							'<a class="community-item" href="goodsDetail.jsp?g_id='+obj.g_id+'">'+
	        						'<div class="media">'+
	           	 					'<div class="media-left community-item-left">'+
	                				'<div class="community-item-img">'+
	                    			'<img class="media-object" src="upload/'+obj.g_img+'">'+
	                				'</div>'+
	            					'</div>'+
	            					'<div class="media-body community-item-body" style="vertical-align:middle">'+
	                				'<h4 class="media-heading community-item-name">'+obj.g_name+'</h4>'+
	                				'<div class="community-item-info">'+
	                    			'<div class="community-item-sum">货号：'+obj.g_code+'</div>'+
	                    			'<div class="community-item-sum"><strong style="color:#DC143C">特价：￥'+obj.g_onsaleprice+'</strong></div>'+
               					    '<div class="community-item-sum" style="text-decoration:line-through;">价格：￥'+obj.g_price+'</div>'+
	                				'</div>'+
	            					'</div>'+
	        						'</div>'+
	    							'</a>'+
									'</div>'
		   							);
		   				})
		   				
		   			}
		   		});
	       
	           
	        }
	    });
	   }
	</script>
	
</body>
</html>