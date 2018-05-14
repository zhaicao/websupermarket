<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>商品详情</title>

<link rel="shortcut icon" href="favicon.ico">
<link rel="stylesheet" href="css/font-awesome.min.css">
<link rel="stylesheet" href="css/monokai-sublime.min.css">
<link rel="stylesheet" href="css/bootstrap.min.css">
<link rel="stylesheet" href="css/katex.min.css">
<link rel="stylesheet" href="css/video-js.min.css">
<link rel="stylesheet" href="css/styles.css">
<link rel="stylesheet" type="text/css" href="js/cart/css/base.css" />

	<style>
		@font-face {
			font-family: "lantingxihei";
			src: url("../fonts/FZLTCXHJW.TTF");
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


	
    
</head>

<body>
	
<!-- 头部 -->
<%@include file="header.jsp"%>
<!--/ 头部 -->        
<div id="flyItem" class="fly_item"><img id="cartImg" src="js/cart/images/item-pic.jpg" width="40" height="40"></div>  
<div class="container layout layout-margin-top">
 
<ol class="breadcrumb">
    <li><a href="goods.jsp">全部商品</a></li>
    
    <li class="goods">
        <a href="#0" id="goodsTitleName"></a>
    </li>
</ol>

    <div class="row">
    <div class="col-md-9 layout-body">
    <div class="content course-infobox">
    <div style="display:inline;float:left;">
    <img src="#" id="goodsImg" class="img-thumbnail" width="150px" height="150px">
    </div>
    <div style="margin-left: 20px;display:inline;">
        <div class="clearfix course-infobox-header">
            <h4 class="pull-left course-infobox-title">
                <span id="goodsName"></span>              
            </h4>
        </div>
        
        <div class="clearfix course-infobox-body">
            <div class="course-infobox-content">
            	<p id="goodsPrice">价格：</p> 
            	数量:&nbsp;&nbsp;<span class="community-item-sum"><input type="text" id = "goodsAmount" size="3">&nbsp;&nbsp;&nbsp;&nbsp;<span id="goodsStockAmount">库存</span></span>                                   
            </div>
            <div class="course-infobox-content">               
            	<a class="btn btn-success" id="ask">购买</a>            
            	<a href="javascript:;" class="btn btn-success btnCart" style="display:none">加入购物车</a>       	          
            </div>             
        </div>
    </div>         
</div>              
    <div class="content">
        <ul class="nav nav-tabs" role="tablist">
            
            <li role="presentation" class="active">
                <a href="#courses" aria-controls="charge-course-detail" role="tab" data-toggle="tab">商品详情</a>
            </li>
                       
            <li role="presentation">
                <a href="#estimation" class="stat-event" aria-controls="comments" role="tab" data-stat="course_comment" data-toggle="tab">评价()</a>
            </li>          
        </ul>

   <div class="tab-content">          
          
          <div role="tabpanel" class="tab-pane active markdown-box" id="courses">
            	<!-- 课程列表 -->
          </div>
           
 
                      
  <!-- labs -->          
        <div role="tabpanel" class="tab-pane course-comment" id="estimation">
               <div class="comment-box">
               <div class="comment-title">最新评论</div>
				<!-- 老师评价内容 -->
			   </div> 
                <div class="comment-form">
                    <textarea  rows="8" style="width:100%" placeholder="商品评价" id="estimationContent"></textarea>
                    <div class="row">
                    <div class="col-md-10">
                    </div>
                    <div class="col-md-2">
                    <a href='#0' class="btn btn-success" id="subEstimation">评价</a>
                    </div>
                    
                    </div>                                   
                    </div>
             </div>            
   <!-- /labs -->              
        </div>
    </div>
</div>

       
<div class="col-md-3 layout-side">       
 <!-- 推荐教师 -->  
    <div class="sidebox recommend-courses">
        <div class="sidebox-header recommend-courses-header">
            <h4 class="sidebox-title">特价商品</h4>
        </div>
        
        <div class="sidebox-body recommend-courses-content" id="recTeacher">
		<!-- 推荐教师 -->
        </div>
    </div>
 <!-- /推荐教师 -->  
 
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

<!-- 购买模态框 -->
<div class="modal fade payment-modal" tabindex="-1" role="dialog">
    <div class="modal-dialog modal-sm" role=document>
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title">请扫描支付</h4>
            </div>
            <div class="modal-body" style="text-align:center;">
               <img class="media-object" src="img/QR-code.png" width="100%" height="100%">
               <span id="payPrice">￥108.00</span>
            </div>
            
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-primary" id="payment">支付完成</button>
            </div>
        </div>
    </div>
</div>

<!-- 侧边栏 -->
<div class="mui-mbar-tabs" style="display:none">
	<div class="quick_link_mian">
		<div class="quick_links_panel">
			<div id="quick_links" class="quick_links">
				<li id="shopCart">
					<a href="myCart.jsp" class="message_list" ><i class="message"></i><div class="span">购物车</div><span class="cart_num">0</span></a>
				</li>
			</div>
		</div>
		<div id="quick_links_pop" class="quick_links_pop hide"></div>
	</div>
</div>

<!-- /购买模态框 --> 
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
<script src="js/bootstrap.min.js"></script>
<script src="js/bootstrap-table-zh-CN.min.js"></script>
<script src="js/bootstrap-table-filter-control.min.js"></script>
<script src="js/raven.min.js"></script>
<!-- <script src="js/index.js"></script> --> 
<script src="js/custom.js"></script> 
<script src="js/jquery.mini.js"></script>
<script type="text/javascript" src="js/cart/js/parabola.js"></script>
<script type="text/javascript" src="js/cart/js/common.js"></script>
<script type="text/javascript">
var user = JSON.parse('<%=session.getAttribute("user") %>')
var parms = getUrlParms();
//初始化教师基本信息
$(function(){
	if( user ){
		$("#ask").hide();
		$(".mui-mbar-tabs").show();
		$(".btn.btn-success.btnCart").show();
	}
	
	$.ajax({
		type: "post",
		url: "${pageContext.request.contextPath}/controlServlet",
     dataType:'json',
     data: {type: 'getNotice'},
		success: function(data, status){
			$("#notice").text(data.n_content);
    		
		}
	});
	
	
	
	_init("");
	_addEvent();
	
	function _addEvent() {
		//购买
		$("#ask").click(function() {
			var amount = $("#goodsAmount").val(),
				stockAmount = $(this).data.g_samount;
			if( !amount || amount == 0){
				alert("数量请输入正确");
				return;
			}
			if( Number(amount) > Number(stockAmount)){
				alert("购买数量不能大于库存数量!");
				return;
			}
			var sumPrice = ($(this).data.g_price * amount).toFixed(2);
			$("#payPrice").text('￥'+sumPrice).data.g_sumprice = sumPrice;
			$(".modal.fade.payment-modal").modal('show');
		})
		
		//扫码付款购买
		$("#payment").click(function(){
			var gId = $("#ask").data.g_id,
				gAmount = $("#goodsAmount").val(),
				gPrice = $("#ask").data.g_price;
				gSumPrice = $("#payPrice").data.g_sumprice;
			$.ajax({
					type: "post",
					url: transformer(window.location.origin),
					dataType:'json',
					data: {type: 'QRPayment', gId: gId, gAmount: gAmount, gSumPrice: gSumPrice, gPrice: gPrice},
					success: function(data, status){
						if( data.status == 'success'){
							alert("支付成功");
							_init("update");
							$(".modal.fade.payment-modal").modal('hide');
						}else
							alert("支付失败");
							
					}
				});
		});
	}	
	
//初始化页面数据
function _init(type){
	
	$.ajax({
			type: "post",
			url: transformer(window.location.origin),
			dataType:'json',
			data: {type: 'goodsDetails', gId: parms["g_id"]},
			success: function(data, status){
				$("#goodsImg").attr("src","upload/"+data.goods.g_img);
				$("#cartImg").attr("src","upload/"+data.goods.g_img);
				$("#goodsTitleName").text(data.goods.g_name);
				$("#goodsName").text(data.goods.g_name);
				if( data.goods.g_isonsale == 1 ){
					$("#goodsPrice").text("价格:"+data.goods.g_onsaleprice);
					$("#ask").data.g_price = data.goods.g_onsaleprice;
				}
				else{
					$("#goodsPrice").text("价格:"+data.goods.g_price);
					$("#ask").data.g_price = data.goods.g_price;
				}
				$("#goodsAmount").val(1);	
				$("#goodsStockAmount").text("库存"+data.goods.g_amount+data.goods.g_unit);
				$("#goodsAmount").data.g_samount = data.goods.g_amount;
				$(".btn.btn-primary.charge-course-confirm").data.g_id = data.goods.g_id;
				//直接购买的参数
				$("#ask").data.g_samount = data.goods.g_amount;
				$("#ask").data.g_id = data.goods.g_id;
				//加入购物车的参数
				$("#addCart").data.g_samount = data.goods.g_amount;
				$("#addCart").data.g_id = data.goods.g_id;
				
				//赋值评价数
				$(".stat-event").text("评价("+data.estimationCount+")");
				
				if( !type ){
				// 初始化商品详情。	
				$("#courses").append('<div class="lab-item">' +
	    					 '<div class="lab-item-title" data-toggle="tooltip" data-placement="bottom">'+data.goods.g_summary+'</div>' +
       					 '</div>'
       				);
				//初始化商品评价
				$.each(data.estimations, function(i, obj){
					$(".comment-box").append('<div>'+
				   					'<div class="">'+obj.te_estimation+'</div>'+
				   					'<div class="col-md-9"></div>'+
				   					'<div class="col-md-3">'+
	                        		'<span class="create-time">'+obj.te_date.substring(0,19)+'</span>'+
	                        		'</div>'+
	                        		'<hr/>'+
	               					'</div>');
				})
			  }
			}
	});
	
	
	//限制数量输入框
	$("#goodsAmount").on('keyup',function(){
		if(Number($(this).val())>Number($(this).data.g_samount)){
			$(this).val(1);
		}
	});
	
	if( user )
		//初始化购物车
		_initCart(user.user_id);
	
};


	//初始化特价
	$.ajax({
		type: "post",
		url: transformer(window.location.origin),
		dataType:'json',
		data: {type: 'index'},
		success: function(data, status){
			$.each(data.onsale, function(i, obj){
				$("#recTeacher").append('<a href="goodsDetail.jsp?g_id='+obj.g_id+'">'+obj.g_name+'</a>');
			});		
		}
	});
	//绑定评价按钮事件
	$("#subEstimation").click(function(){
		if(!user) {
			alert('请先登录')
			return
		}
		var estimation = $("#estimationContent").val();
		if(estimation == ""){
			alert("请输入评价内容");
			return;
		}
		$.ajax({
			type: "post",
			url: transformer(window.location.origin),
			dataType:'json',
			data: {type: 'estimation', teacher_id: $(".btn.btn-primary.charge-course-confirm").data.g_id, user_id: user.user_id, estimation: estimation},
			success: function(data, status){
				$(".stat-event").text("评价("+data.estimationCount+")");
				$(".comment-box").append('<div>'+
	   					'<div class="">'+data.estimation.te_estimation+'</div>'+
	   					'<div class="col-md-9"></div>'+
	   					'<div class="col-md-3">'+
                		'<span class="create-time">'+data.estimation.te_date.substring(0,19)+'</span>'+
                		'</div>'+
                		'<hr/>'+
       					'</div>');
				$("#estimationContent").val("");
				alert("操作成功");
				
			}
		});
	})
})


//初始化加入购物车
function _initAddCart(initCount){
	// 元素以及其他一些变量
	var eleFlyElement = document.querySelector("#flyItem"), 
		eleShopCart = document.querySelector("#shopCart"),
		eleSpan = eleShopCart.querySelector("span"),
	    numberItem = initCount;
	eleSpan.innerHTML = numberItem;
	// 抛物线运动
	var myParabola = funParabola(eleFlyElement, eleShopCart, {
		speed: 400, //抛物线速度
		curvature: 0.0008, //控制抛物线弧度
		complete: function() { //加入购物车回调函数
			add();
			//隐藏抛物图片
			eleFlyElement.style.visibility = "hidden";
			//购物车数量加1
			eleSpan.innerHTML = ++numberItem;
		}
	});

	// 绑定点击事件
	if (eleFlyElement && eleShopCart) {
		[].slice.call(document.getElementsByClassName("btnCart")).forEach(function(button) {
			button.addEventListener("click", function(event) {
				// 滚动大小
				var scrollLeft = document.documentElement.scrollLeft || document.body.scrollLeft || 0,
				    scrollTop = document.documentElement.scrollTop || document.body.scrollTop || 0;
				eleFlyElement.style.left = event.clientX + scrollLeft + "px";
				eleFlyElement.style.top = event.clientY + scrollTop + "px";
				eleFlyElement.style.visibility = "visible";
				// 需要重定位
				myParabola.position().move();			
			});
		});
	}
  }
  
  
 //初始化购物车数量
function _initCart(){
	$.ajax({
		type: "post",
		url: transformer(window.location.origin),
		dataType:'json',
		data: {type: 'getCartCount', uId: user.user_id},
		success: function(data, status){
			_initAddCart(Number(data.cartCount));
		}
	});
 }
 
//加入购物车
function add(){
	var gId = $("#addCart").data.g_id,	
		gSAMount = $("#addCart").data.g_samount,
		gAmount = $("#goodsAmount").val();
	if ( gAmount > gSAMount ){
		alert("购买数量不能大于库存数量!");
		return;
	}
	$.ajax({
		type: "post",
		url: transformer(window.location.origin),
		dataType:'json',
		data: {type: 'addCart', uId: user.user_id, gId: gId, gAmount: gAmount},
		success: function(data, status){
			if ( data.status != 'success' )
				alert('加入购物车失败');
		}
	});
}

</script>            	
</body>
</html>