<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <title>网络超市商品管理系统</title>
	<link rel="shortcut icon" href="favicon.ico">
    <link rel="stylesheet" href="css/monokai-sublime.min.css">
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="css/katex.min.css">
    <link rel="stylesheet" href="css/video-js.min.css">
	<link rel="stylesheet" href="css/styles.css">

	<style>
	body {
		height: calc(100% - 50px);
		height: -webkit-calc(100% - 50px);
		background: #fff;
	}

        /* modal æ¨¡ææ¡*/
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
        .introduce-img img {
        	width: 260px;
        	height: 140px;
        }
        .btns {
        	display: none;
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

<%@include file="header.jsp"%>

<div class="navbar-banner layout-no-margin-top">
  
</div>

<div class="line-and-laboratory">
	<div class="container">
        <div class="clearfix text-center item-header">
            <span class="line"></span>
            <div class="text-center item-title">最新商品</div>
            <span class="line"></span>
        </div>
		<div class="clearfix courses" id="latestGoods">   
		<!-- æ¨èæå¸ -->  
		</div>
        <div class="clearfix item-footer">
            <div class="pull-right watch-all">
                <a href="goods.jsp">查看更多 ></a>
            </div>
        </div>
	</div>
</div>


<div class="line-and-laboratory">
	<div class="container">
        <div class="clearfix text-center item-header">
            <span class="line"></span>
            <div class="text-center item-title">特价商品</div>
            <span class="line"></span>
        </div>
		<div class="clearfix courses" id="onSaleGoods">
		<!-- æ¨èæå¸ -->  
		</div>
        <div class="clearfix item-footer">
            <div class="pull-right watch-all">
                <a href="onsaleGoods.jsp">查看更多 ></a>
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
	<!-- <script src="js/index.js"></script> -->
	<script src="js/custom.js"></script>
	<script src="js/jquery.mini.js"></script>
	<script type="text/javascript">
		
		$(function() {
		
			_init()

			function _init() {
			
				//初始化最新商品
				$.ajax({
					type: "post",
					url: transformer(window.location.origin),
					dataType:'json',
					data: {type: 'index'},
					success: function(data, status){
						$.each(data.goods, function(i, obj){
							var onsale = '<span class="pull-left">'+
				            			 '<i class="fa fa-users"></i>￥'+obj.g_price+
							             '</span>';
							if( obj.g_isonsale == 1 )
								onsale = '<span class="pull-left">'+
					            		 '<i class="fa fa-users"></i><strong style="color:#DC143C">￥'+ obj.g_onsaleprice+'</strong>'+
										 '</span>'+ 
										 '<span class="pull-left" style="text-decoration:line-through;margin-left:5px">'+
					            		 '<i class="fa fa-users"></i>￥'+obj.g_price+
										 '</span>'; 
							$("#latestGoods").append('<div class="col-md-3 col-sm-6  course">'+
									'<a class="course-box" href="goodsDetail.jsp?g_id='+obj.g_id+'">'+
						        	'<div class="sign-box">'+
						         	'<i class="fa fa-star-o course-follow pull-right" style="display:none"></i>'+          
						        	'</div>'+
						        	'<div class="course-img">'+     
						        	'<img alt="'+obj.g_name+'" src="upload/'+obj.g_img+'">'+    
						        	'</div>'+
						        	'<div class="course-body">'+
						        	'<span class="course-title" data-toggle="tooltip" data-placement="bottom" title="'+obj.g_name+'">'+obj.g_name+'</span>'+
						        	'</div>'+
						        	'<div class="course-footer">'+onsale+
						        	'</div>'+
						    		'</a>'+
									'</div>'
									);
						})
						
					}
				});
				
				//初始化特价商品
				$.ajax({
					type: "post",
					url: transformer(window.location.origin),
					dataType:'json',
					data: {type: 'index'},
					success: function(data, status){
						$.each(data.onsale, function(i, obj){
							var onsale = '<span class="pull-left">'+
	            			 			 '<i class="fa fa-users"></i>￥'+obj.g_price+
				             			 '</span>';
							if( obj.g_isonsale == 1 )
								onsale = '<span class="pull-left">'+
		            		 	'<i class="fa fa-users"></i><strong style="color:#DC143C">￥'+ obj.g_onsaleprice+'</strong>'+
							 	'</span>'+ 
							 	'<span class="pull-left" style="text-decoration:line-through;margin-left:5px">'+
		            		 	'<i class="fa fa-users"></i>￥'+obj.g_price+
							 	'</span>';
							$("#onSaleGoods").append('<div class="col-md-3 col-sm-6  course">'+
									'<a class="course-box" href="goodsDetail.jsp?g_id='+obj.g_id+'">'+
						        	'<div class="sign-box">'+
						         	'<i class="fa fa-star-o course-follow pull-right" style="display:none"></i>'+          
						        	'</div>'+
						        	'<div class="course-img">'+     
						        	'<img alt="'+obj.g_name+'" src="upload/'+obj.g_img+'">'+     
						        	'</div>'+
						        	'<div class="course-body">'+
						        	'<span class="course-title" data-toggle="tooltip" data-placement="bottom" title="'+obj.g_name+'">'+obj.g_name+'</span>'+
						        	'</div>'+
						        	'<div class="course-footer">'+onsale+ 
						        	'</div>'+
						    		'</a>'+
									'</div>'
									);
						})
						
					}
				});
			}
		})	
	</script>	
</body>
</html>
