<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>我的购物车</title>
<link rel="stylesheet" href="css/font-awesome.min.css">
<link rel="stylesheet" href="css/monokai-sublime.min.css">
<link rel="stylesheet" href="css/bootstrap.min.css">
<link rel="stylesheet" href="css/katex.min.css">
<link rel="stylesheet" href="css/video-js.min.css">
<link rel="stylesheet" href="css/styles.css">
	<link rel="stylesheet" href="js/myCart/css/reset.css">
	<link rel="stylesheet" href="js/myCart/css/carts.css">

</head>
<body>
<!-- 头部 -->
<%@include file="header.jsp"%>
<!--/ 头部 -->
<div class="container layout layout-margin-top">
<section class="cartMain">
	<div class="cartMain_hd">
		<ul class="order_lists cartTop">
			<li class="list_chk">
				<!--所有商品全选-->
				<input type="checkbox" id="all" class="whole_check">
				<label for="all"></label>
				全选
			</li>
			<li class="list_con">商品名</li>
			<li class="list_info">商品单位</li>
			<li class="list_price">单价</li>
			<li class="list_amount">数量</li>
			<li class="list_sum">金额</li>
			<li class="list_op">操作</li>
		</ul>
	</div>

<!-- 商品list -->
	<div class="cartBox">
		<div class="order_content">
		</div>
	</div>


	<!--底部-->
	<div class="bar-wrapper">
		<div class="bar-right">
			<div class="piece">已选商品<strong class="piece_num">0</strong>件</div>
			<div class="totalMoney">共计: <strong class="total_text">0.00</strong></div>
			<div class="calBtn"><a href="javascript:;">结算</a></div>
		</div>
	</div>
</section>
<section class="model_bg"></section>
<section class="my_model">
	<p class="title">删除宝贝<span class="closeModel">X</span></p>
	<p>您确认要删除该宝贝吗？</p>
	<div class="opBtn"><a href="javascript:;" class="dialog-sure">确定</a><a href="javascript:;" class="dialog-close">关闭</a></div>
</section>
</div>

<!-- 购买模态框 -->
<div class="modal fade payment-modal" tabindex="-1" role="dialog">
    <div class="modal-dialog" role=document>
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title">收货信息</h4>
            </div>
            <div class="modal-body">
						<div class="form-group">
							收货人
							<input type="text" id="receiver" placeholder="请输入收货人姓名" class="form-control">
						</div>
						<div class="form-group">
							电话
							<input type="text" id="receiverPhone" placeholder="请输入收货人电话" class="form-control">
						</div>
						<div class="form-group">
							收货地址
							<input type="text" id="receiverAddress" placeholder="请输入收货地址" class="form-control">
						</div>
						<div class="form-group">
							支付方式
							<select class="form-control" id="payMethod">
								<option value="0">银行付款</option>
								<option value="1">货到付款</option>	
							</select>
						</div>
            </div>
            
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-primary" id="pay-sure">确定</button>
            </div>
        </div>
    </div>
</div>

<script src="js/jquery.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/jquery.mini.js"></script>
<script>
var user = JSON.parse('<%=session.getAttribute("user") %>')
$(function(){
	
	_init();
	
	//删除事件
	$('.dialog-sure').click(function () {
		var cId = $(this).data.cid;
		$.ajax({
			type: "post",
			url: transformer(window.location.origin),
			dataType:'json',
			data: {type: 'delCart', cId: cId},
			success: function(data, status){
				console.info('delCart');
			}
		});
	})
	//结算事件
	$(".calBtn").on('click',function(){
		var checked = $(".mark");
		var ids = $.map(checked, function (row) {
			var jAmount = $(row).parent().nextAll().filter(".list_amount").find(".sum");
			if( jAmount.length != 0 )
				return {cId: $(row).data('cid'), cAmount: Number(jAmount.val())};
         });
		$(".modal.fade.payment-modal").modal('show');
		$("#payMethod").data.goods=ids;
		
	})
	
	//确认订单
	$("#pay-sure").on('click',function(){
		var gList = $(this).data.goods,
			receiver = $("#receiver").val(),
			phone = $("#receiverPhone").val(),
			address = $("#receiverAddress").val(),
			method = $("#payMethod").val(),
			total = $(".total_text").text().substring(1),
			pieceNum = $(".piece_num").text();
		$.ajax({
			type: "post",
			url: transformer(window.location.origin),
			dataType:'json',
			data: {type: 'orderCart', receiver: receiver, phone: phone, address: address, method: method, gList: JSON.stringify(gList), pieceNum: pieceNum, total: total, uId: user.user_id},
			success: function(data, status){
				if( data.status == 'success')
					alert("下单成功");
				location.replace("mySignUp.jsp");
			}
		});
	})
})

function _init(){
	$.ajax({
		type: "post",
		url: transformer(window.location.origin),
		dataType:'json',
		data: {type: 'getCart', uId: user.user_id},
		async: false,
		success: function(data, status){
			$.each(data.goods, function(i,obj){
				var price = obj.g_price;
				if( obj.g_isonsale == 1)
					price = obj.g_onsaleprice;
				console.info(obj);
				$(".order_content").append(
						'<ul class="order_lists">'+
						'<li class="list_chk">'+
						'<input type="checkbox" id="checkbox_'+i+'" class="son_check" >'+
						'<label for="checkbox_'+i+'" data-cid='+obj.c_id+'></label>'+
						'</li>'+
						'<li class="list_con">'+
						'<div class="list_img"><a href="goodsDetail.jsp?g_id='+obj.g_id+'"><img src="upload/'+obj.g_img+'" alt=""></a></div>'+
						'<div class="list_text"><a href="goodsDetail.jsp?g_id='+obj.g_id+'">'+obj.g_name+'</a></div>'+
						'</li>'+
						'<li class="list_info">'+
						'<p>'+obj.g_unit+'</p>'+
						'</li>'+
						'<li class="list_price">'+
						'<p class="price">￥'+price+'</p>'+
						'</li>'+
						'<li class="list_amount">'+
						'<div class="amount_box">'+
						'<a href="javascript:;" class="reduce reSty">-</a>'+
						'<input type="text" value="'+obj.c_gamount+'" class="sum" data-g_amount='+obj.g_amount+'>'+
						'<a href="javascript:;" class="plus">+</a>'+
						'</div>'+
						'</li>'+
						'<li class="list_sum">'+
						'<p class="sum_price">￥'+(obj.c_gamount * price).toFixed(2)+'</p>'+
						'</li>'+
						'<li class="list_op">'+
						'<p class="del"><a href="javascript:;" class="delBtn" data-cid='+obj.c_id+'>移除商品</a></p>'+
						'</li>'+
						'</ul>'
						);
			})
		}
	});
	
	$("#receiver").val(user.user_realname);
	$("#receiverPhone").val(user.user_phone);
	$("#receiverAddress").val(user.user_address);
}
</script>
<!-- 放最后渲染效果 -->
<script src="js/myCart/js/carts.js"></script>
</body>
</html>