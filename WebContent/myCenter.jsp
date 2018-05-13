<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>我的信息</title>

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
						
<ul class="row question-items">
  <li class="question-item">
 </li>

   
    <div style="margin:0 auto;width:400px;">
    <div class="form-group">
         <label>账号</label>
         <input type="text" id="username" name="username" class="form-control" readonly="readonly">
    </div>
    <div class="form-group">
         <label>姓名</label>
         <input type="text" id="realname" name="realname" placeholder="请输入姓名" class="form-control">
    </div>
    <div class="form-group">
         <label>联系方式</label>
         <input type="text" id="phone" name="phone" placeholder="请输入联系方式" class="form-control">
    </div>
    <div class="form-group">
         <label>收货地址</label>
         <input type="text" id="address" name="phone" placeholder="请输入收货地址" class="form-control">
    </div>
    <div class="form-group">
         <label>银行卡号</label>
         <input type="text" id="card" name="phone" placeholder="请输入银行卡号" class="form-control">
    </div>
    
       <div class="col-md-6 text-center">
       		<button class="btn btn-success btn-block" id="pwd" data-toggle="modal" data-target="#pwdModal">修改密码</button>
       </div>
       <div class="col-md-6 text-center">
       		<button class="btn btn-success btn-block" id="edit">修改</button>
       </div>
       
    	</div>
   </div>
   <li class="question-item">
 </li>
</ul>			
        </div>
    </div>
</div>

        </div>
    </div>
</div>


<!-- 注册模态框 -->
<div class="modal fade" id="pwdModal" tabindex="-1" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-sm">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
				<h4 class="" id="myModalLabel">修改密码</h4>
			</div>
			<div id="modal-body" class="modal-body">
				<div class="form-group">
                     <label>原始密码</label>
                     <input type="password" id="original_pwd" name="original_pwd" placeholder="请输入原始密码" class="form-control">
                </div>
                <div class="form-group">
                     <label>密码</label>
                     <input type="password" id="new_pwd" name="new_pwd" placeholder="请输入新密码" class="form-control">
                </div>
                <div class="form-group">
                     <label>确认密码</label>
                     <input type="password" id="com_pwd" name="com_pwd" placeholder="请重新输入新密码" class="form-control">
                </div>              
			</div>
			<label id="regmessage" class="text-danger" style="text-align: center;width: 100%;"></label>
			<div class="modal-footer">
		        <a href="#0" id="cancel" class="btn" data-dismiss="modal">取消</a>
		        <a href="#0" id="editpwd" class="btn btn-success">确认</a>	        
		    </div>
		</div>
	</div>
</div><!-- /注册模态框 -->



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
	<script src="js/jquery.mini.js"></script>
	<script type="text/javascript">
	$(function(){
		
		var user = <%=session.getAttribute("user") %>;
		$("#username").val(user.user_uname);
		$("#realname").val(user.user_realname);
		$("#phone").val(user.user_phone);
		$("#address").val(user.user_address);
		$("#card").val(user.user_card);
		
		//初始化修改按钮事件
		$("#edit").click(function(){
			var realname = $("#realname").val(),
				phone = $("#phone").val(),
				address = $("#address").val(),
				card = $("#card").val();
			$.ajax({
				type: "post",
				url: transformer(window.location.origin),
				dataType:'json',
				data: {
					type: 'editSelfinfo', 
					realname: realname, 
					phone: phone, 
					user_id: user.user_id,
					address: address,
					card: card
				},
				success: function(data, status){
					alert("修改成功！");
				}
			});
		});
		
		//初始化修改密码按钮
		$("#editpwd").click(function(){
			var original_pwd = $("#original_pwd").val();
			var new_pwd = $("#new_pwd").val();
			var com_pwd = $("#com_pwd").val();
			
			if (original_pwd == "")
				alert("请输入原始密码！");
			else if (original_pwd != user.user_pwd)
				alert("原始密码输入错误！");
			else if (new_pwd == "")
				alert("请输入新密码！");
			else if (com_pwd == "")
				alert("请再次输入新密码！");
			else if (new_pwd != com_pwd)
				alert("两次输入的新密码不一致！");
			else{
				$.ajax({
					type: "post",
					url: transformer(window.location.origin),
					dataType:'json',
					data: {type: 'editpwd', user_pwd: new_pwd, user_id: user.user_id},
					success: function(data, status){
						alert("修改成功！");
						location.reload();
					}
				});	
				}
			return false;
		});
		
	});
	
	</script>

</body>
</html>