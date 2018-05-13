<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
 <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<link href="css/bootstrap.min.css" rel="stylesheet">
		<style>
			.user-hide:hover .dropdown-toggle{
				color:#777 !important
			}
		</style>
	</head>
	<body>
	
		<div class="modal fade" id="regModal" tabindex="-1" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
						<h4 class="" id="myModalLabel">用户注册</h4>
					</div>
					<div id="modal-body" class="modal-body">
						<div class="form-group">
							<label>用户名</label>
							<input type="text" id="reg_name" name="reg_name" placeholder="请输入用户名" class="form-control">
						</div>
						<div class="form-group">
							<label>姓名</label>
							<input type="text" id="reg_realname" name="reg_realname" placeholder="请输入姓名" class="form-control">
						</div>
						<div class="form-group">
							<label>密码</label>
							<input type="password" id="reg_pwd" name="reg_pwd" placeholder="请输入密码" class="form-control">
						</div>
						<div class="form-group">
							<label>联系方式</label>
							<input type="text" id="reg_phone" name="reg_phone" placeholder="请输入联系方式" class="form-control">
						</div>
						<div class="form-group">
							<label>收货地址</label>
							<input type="text" id="reg_address" name="reg_phone" placeholder="请输入收货地址" class="form-control">
						</div>
						<div class="form-group">
							<label>银行卡信息</label>
							<input type="text" id="reg_card" name="reg_phone" placeholder="请输入支付的银行卡号" class="form-control">
						</div>
					</div>
					<label id="regmessage" class="text-danger" style="text-align: center;width: 100%;"></label>
					<div class="modal-footer">
				        <a href="#" id="cancel" class="btn" data-dismiss="modal">取消</a>
				        <a href="#" id="register" class="btn btn-info">注册</a>	        
				    </div>
				</div>
			</div>
		</div><!-- /注册模态框 -->
	
		<div class="modal fade" id="loginModal" tabindex="-1" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog modal-sm">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
						<h4 class="" id="myModalLabel">登录</h4>
					</div>
					<div id="modal-body" class="modal-body">
						<div class="form-group">
							<label>类型</label>
							<select class="form-control" id="user_role" name="user_role">
								<option value="1">顾客</option>
								<option value="0">管理员</option>
							</select>			
						</div>
						<div class="form-group">
							<label>用户名</label>
							<input type="text" id="user_name" name="user_name" placeholder="请输入用户名" class="form-control">
						</div>
						<div class="form-group">
							<label>密码</label>
							<input type="password" id="user_pwd" name="user_pwd" placeholder="请输入密码" class="form-control">
						</div>
					</div>
					<label id="loginmessage" class="text-danger" style="text-align: center;width: 100%;"></label>
					<div class="modal-footer">
				        <a href="#" id="cancel" class="btn" data-dismiss="modal">取消</a>
				        <a href="#" id="login" class="btn btn-info">登录</a>	        
				    </div>
				</div>
			</div>
		</div><!-- /注册模态框 -->
	
		<!-- 头部 -->
		<nav class="navbar navbar-default navbar-fixed-top header">
		    <div class="container">
		        <div class="collapse navbar-collapse" id="header-navbar-collapse">
		            <ul class="nav navbar-nav">
		            	<li class="">
		                    <a href="index.jsp">首页</a>
		                </li>
		                <li class="">
		                    <a href="goods.jsp">全部商品</a>
		                </li>
		                <li class="">
		                    <a href="onsaleGoods.jsp">特价商品</a>
		                </li>
		                <li class="dropdown user-hide" style="display: none;">
		                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">
		                    个人中心
		                    <span class="caret"></span>                   
		                    </a>
		                    <ul class="dropdown-menu">
		                        <li><a class="" href="myCenter.jsp">个人信息</a></li>
		                        <li><a class="" href="myCart.jsp">我的购物车</a></li>
		                        <li><a class="" href="mySignUp.jsp">已买到的宝贝</a></li>
		                    </ul>
		                </li>
		                
		            </ul>           
		            <div class="navbar-right btns">
		            	<a class="btn btn-default navbar-btn sign-up" style="display: none;">登录</a>
		            	<a class="btn btn-default navbar-btn sign-down" style="display: none;">注册</a>
		                <a class="btn btn-default navbar-btn log-up" href="foreendServlet?type=logout" style="display: none;">退出</a>
		            </div>
		        </div>
		    </div>
		</nav>
		<!--/ 头部 -->
		<script src="js/jquery.min.js"></script>
		<script src="js/bootstrap.min.js"></script>
		<!-- <script src="admin/js/custom.js"></script> -->
		<script src="admin/js/jquery.mini.js"></script>
		
		<script>
			$(function() {
				var jUserInfo = $('.user-hide'),
					jBtns = $('.navbar-right'),
					jSignUp = $('.sign-up'),
					jSignDown = $('.sign-down'),
					jLog = $('.log-up')
			
				var user = JSON.parse('<%=session.getAttribute("user") %>')
				
				_render()
				
				function _render() {
					_initPage()
					_addEvent()
				}
				
				function _initPage() {
					jBtns.show()
					
					if(user) {
						jUserInfo.show()
						jLog.show()
						jSignUp.add(jSignDown).hide()
					}else {
						jUserInfo.hide()
						jLog.hide()
						jSignUp.add(jSignDown).show()
					}
				}
				
				function _addEvent() {
					jSignUp.click(function() {
						// 登录
						$("#loginModal").modal("show")
					})
					
					jSignDown.click(function() {
						$("#regModal").modal("show")
					})
					
					$("#login").click(function() {
						login()
					})
					
					$("#register").click(function() {
						sign()
					})
				}
				
				function login() {
					var user = $("#user_name").val(),
						role = $("#user_role").val(),
						pwd = $("#user_pwd").val(),
						jMess = $("#loginmessage")
						
					if(!user || !pwd) {
						jMess.text('请输入用户名或密码！')
						return false
					}
					
					$.ajax({
						type: 'POST',
						url: window.location.origin + '/websupermarket/controlServlet', //transformer(window.location.origin),
						dataType: 'json',
						data: {type: 'login', username: user, password: pwd, role: role},
						success: function(data, status){
							if(data.status != 'success')
								jMess.text("用户名或密码错误！");
							else
								if(role == 0)
									location.replace("admin/index.jsp");
								else
									location.reload()
						}
					});
					
				}
				
				function sign() {
					var user = $("#reg_name").val(),
						phone = $("#reg_phone").val(),
						real = $("#reg_realname").val(),
						pwd = $("#reg_pwd").val(),
						address = $("#reg_pwd").val(),
						card = $("#reg_pwd").val(),
						jMess = $("#regmessage")
				
					if(!user || !pwd || !phone || !real || !address || !card) {
						jMess.text('请完善信息!')
						return false
					}
					
					$.ajax({
						type: 'POST',
						url: window.location.origin + '/websupermarket/controlServlet',
						dataType: 'json',
						data: {
							type: 'register', 
							username: user, 
							realname: real, 
							pwd: pwd, 
							role: '1', 
							phone: phone,
							address: address,
							card: card
						},
						success: function(data, status){
							if(data.status != 'success')
								jMess.text("该用户名或手机已存在！");
							else {
								alert('注册成功！')
								$('#regModal').modal('toggle')
							}			
								
						}
					});
				}
			})
		</script>
		
	</body>
</html>