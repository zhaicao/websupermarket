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

function editpwd(){
	var user = JSON.parse('<%=session.getAttribute("user")%>');
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
		var status = postFun(transformer(window.location.origin) + "?type=selfinfo_editpwd", {original_pwd: original_pwd, new_pwd: new_pwd, user_id: user.user_id});
		if (status == 'success'){
			alert("操作成功！");
			return true;
		}	
		}
	return false;
	}
	  
  
//ajax提交函数
function postFun(posturl, postdata){
	var result = "";
	$.ajax({
		type: "POST",
		url: posturl,
		data: postdata,
        async: false,//由于需要等待后端结果，故使用同步方式
        dataType:'json',
		success: function(data, status){
			result = data.status;
		},
		error: function(XMLHttpRequest, textStatus, errorThrown){
			console.info(errorThrown);
		}
	});
	return result;
}
  
  </script>
  </head>
  <body>
  
<div class="ibox-content col-sm-3 col-sm-offset-4">
                        <div class="row">
                            <div class="col-sm-12">
                                    <div class="form-group">
                                        <label id="nametitle">原始密码</label>
                                        <input type="password" id="original_pwd" name="reg_username" placeholder="请输入原始密码" class="form-control">
                                    </div>
                                    <div class="form-group">
                                        <label>新密码</label>
                                        <input type="password" id="new_pwd" name="reg_realname" placeholder="请输入新密码" class="form-control">
                                    </div>
                                    <div class="form-group">
                                        <label>确认新密码</label>
                                        <input type="password" id="com_pwd" name="reg_departments" placeholder="请再次输入新密码" class="form-control">
                                    </div>
                            </div>
                            <label id="message" class="text-danger" style="text-align: center;width: 100%;"></label>
                        </div>
  </div>  
  </body>
</html>
