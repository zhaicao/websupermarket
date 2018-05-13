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
  <title>个人信息</title>
  <script type="text/javascript" src="js/jquery.min.js"></script>
  <script type="text/javascript" src="js/jquery.mini.js"></script>
  <script type="text/javascript" src="js/bootstrap.min.js"></script>
  <script type="text/javascript" src="js/bootstrap-table.min.js"></script>
  <script type="text/javascript" src="js/bootstrap-table-zh-CN.min.js"></script>
  <link rel="stylesheet" type="text/css" href="css/bootstrap.min.css" />
  <link rel="stylesheet" type="text/css" href="css/bootstrap-table.min.css" />

  <script type="text/javascript">
  $(function(){
	  var user = JSON.parse('<%=session.getAttribute("user")%>');
	$.ajax({
    			type: "post",
    			url: transformer(window.location.origin) + "?type=user_getedit&&user_id="+user.user_id,
                dataType:'json',
    			success: function(data, status){
    				$("#reg_username").val(data.user_name).attr("readonly",true);
    				$("#reg_realname").val(data.user_realname);
    				$("#reg_departments").val(data.user_department);
    				$("#reg_phone").val(data.user_phone);
    				$("#reg_email").val(data.user_email);
    			},
    			error: function(XMLHttpRequest, textStatus, errorThrown){
    				console.info(errorThrown);
    			}
    		});
	
	//修改用户信息
	$("#submit").click(function(){
		var user = JSON.parse('<%=session.getAttribute("user")%>');
		var realname = $("#reg_realname").val();
		var department = $("#reg_departments").val();
		var phone = $("#reg_phone").val();
		var email = $("#reg_email").val();
		if(realname == "")
			$("#message").text("请输入真实姓名！");
		else if(phone == "")
			$("#message").text("请输入联系电话！");
		else if(email == "")
			$("#message").text("请输入联系邮箱！");
		else{
			$.ajax({
				type: "post",
				url: transformer(window.location.origin) + "?type=user_edit&&user_id="+user.user_id,
	            dataType:'json',
	            data: {realname:realname, department: department, phone: phone, email: email},
				success: function(data, status){
					alert("操作成功");
					return ;
				},
				error: function(XMLHttpRequest, textStatus, errorThrown){
					console.info(errorThrown);
				}
			});	
			}
		return false;
    });
	
	//修改密码事件
	 $("#editpsw").click(function(){
		 setModalIframe("修改密码", "editpwd.jsp", "修改", "selfinfo_editpwd", "modal-sm");
	 });
})
  </script>
  </head>
  <body>
  <div class="container">
    <h4>用户信息</h4>
<div class="ibox-content col-sm-3 col-sm-offset-4">
                        <div class="row">
                            <div class="col-sm-12">
                                <form role="form" action="#" method="post">
                                    <div class="form-group">
                                        <label id="nametitle">账号</label>
                                        <input type="text" id="reg_username" name="reg_username" placeholder="请输入注册账号" class="form-control">
                                    </div>
                                    <div class="form-group">
                                        <label>姓名</label>
                                        <input type="text" id="reg_realname" name="reg_realname" placeholder="请输入您的姓名" class="form-control">
                                    </div>
                                    <div class="form-group">
                                        <label>学院</label>
                                        <input type="text" id="reg_departments" name="reg_departments" placeholder="如:计算机学院-计算机科学系" class="form-control">
                                    </div>
                                    <div class="form-group">
                                        <label>联系电话</label>
                                        <input type="text" id="reg_phone" name="reg_phone" placeholder="请输入您的联系电话" class="form-control">
                                    </div>
                                    <div class="form-group">
                                        <label>联系邮箱</label>
                                        <input type="text" id="reg_email" name="reg_email" placeholder="请输入您的联系邮箱" class="form-control">
                                    </div>
                                    <div>
                                        <button class="btn btn-sm pull-right btn-info" type="button" id="submit"><strong>修改</strong>
                                        </button>
                                        <label>                                         
                                         <button class="btn btn-sm pull-right btn-info" type="button" id="editpsw"><strong>修改密码</strong>
                                        </button>
                                    </div>
                                </form>
                            </div>
                            <label id="message" class="text-danger" style="text-align: center;width: 100%;"></label>
                        </div>
  </div> 
  </div> 
 <script src="js/custom.js"></script>
 <script>
 
//设置模态框调用的页面
 function setModalIframe(title, path, btn_name, type,size){
 	$("#myModalLabel", parent.document).text(title);
 	if(size != "")
 		$(".modal-dialog", parent.document).addClass(size);
		$("#iframemodal", parent.document).attr("src", path);
		if(btn_name == "") 
			btn_name="确定"
		$("#submit", parent.document).text(btn_name);
		$("#funLink", parent.document).text(type);
		$("#openmodalParent", parent.document).trigger("click");
 }
 
 </script>
  </body>
</html>
