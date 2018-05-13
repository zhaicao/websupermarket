<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>用户详情</title>
    <link rel="shortcut icon" href="favicon.ico"> 
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/font-awesome.css" rel="stylesheet">
    <link href="css/plugins/iCheck/custom.css" rel="stylesheet">
    <link href="css/animate.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">
    <style type="text/css"> 
#uploadPreview {
    width: 300px;
    height: 220px; 
    margin-left: 10px;                         
    background-position: center center;
    background-size: cover;
    border: 4px solid #fff;
    -webkit-box-shadow: 0 0 1px 1px rgba(0, 0, 0, .3);
    display: block;
    }
</style>
    <!-- 全局js -->
    <script src="js/jquery.min.js"></script>
    <script src="js/bootstrap.min.js"></script>

    <!-- iCheck -->
    <script src="js/plugins/iCheck/icheck.min.js"></script>
    <script src="js/custom.js"></script>
    
    <script type="text/javascript">
  //获得url参数，判断页面类型(新增、编辑)
    var parms = getUrlParms();
  //初始化修改数据
	if (parms["type"] == "edit"){
		$.ajax({
			type: "post",
			url: "${pageContext.request.contextPath}/controlServlet?type=user_getedit&&user_id="+parms["user_id"],
            dataType:'json',
			success: function(data, status){
				console.info(data);
				$("#reg_username").val(data.user_uname).attr("readonly",true);
				//$("#reg_pwd").attr("placeholder","不可修改").attr("readonly",true);
				//$("#reg_compwd").attr("placeholder","不可修改").attr("readonly",true);
				$("#reg_pwd").parent().css("display","none");
				$("#reg_compwd").parent().css("display","none");
				$("#reg_realname").val(data.user_realname);
				$("#reg_departments").val(data.user_department);
				$("#reg_phone").val(data.user_phone);
				$("#role").val(data.user_role);
			},
			error: function(XMLHttpRequest, textStatus, errorThrown){
				console.info(errorThrown);
			}
		}); 		
	}
  
   
    //提交的函数，如有提交工作则必须申明此函数，由父页面调用.
    //返回true或false
    function conFunction(){
    	var url = "";
		var username = $("#reg_username").val();
		var pwd = $("#reg_pwd").val();
		var compwd = $("#reg_compwd").val();
		var realname = $("#reg_realname").val();
		var department = $("#reg_departments").val();
		var phone = $("#reg_phone").val();
		var role = $("#role").val();
		$("#message").text("");
		if(username == "")
			$("#message").text("请输入用户名！");
		else if(pwd == "" && parms["user_id"] == null)
			$("#message").text("请输入密码！");
		else if(compwd == "" && parms["user_id"] == null)
			$("#message").text("请输入确认密码！");
		else if(compwd != pwd)
			$("#message").text("两次输入的密码不一致！");
		else if(realname == "")
			$("#message").text("请输入真实姓名！");
		else if(phone == "")
			$("#message").text("请输入联系方式！");
		else if(department == "")
			$("#message").text("请输入院系！"); 	
		else{
			if (parms["type"] == null)
				url = "${pageContext.request.contextPath}/controlServlet?type=register";
			else
				url = "${pageContext.request.contextPath}/controlServlet?type=user_edit&&user_id=" + parms["user_id"];
			var status = postFun(url, {username: username, pwd:pwd, compwd: compwd, realname:realname, department: department, phone: phone, role: role});
			if (status == 'success'){
				$("#message").text("");
				alert("操作成功！");
				return true;
			}
			else
			    $("#message").text("该用户名已存在，请重新输入！");			
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
           <div id="modal-body" class="modal-body">
				<div class="form-group">
                     <label>账号</label>
                     <input type="text" id="reg_username" name="reg_username" placeholder="请输入注册账号" class="form-control">
                </div>
                <div class="form-group" id="reg_pwd_div">
                     <label>密码</label>
                     <input type="password" id="reg_pwd" name="reg_pwd" placeholder="请输入密码" class="form-control">
                </div>
                <div class="form-group" id="reg_compwd_div">
                     <label>确认密码</label>
                     <input type="password" id="reg_compwd" name="reg_compwd" placeholder="请重新输入密码" class="form-control">
                </div>
                <div class="form-group">
                     <label>姓名</label>
                     <input type="text" id="reg_realname" name="reg_realname" placeholder="请输入您的姓名" class="form-control">
                </div>
                <div class="form-group">
                     <label>联系方式</label>
                     <input type="text" id="reg_phone" name="reg_phone" placeholder="请输入联系方式" class="form-control">
                </div>
                <div class="form-group">
                     <label>所在院系</label>
                     <input type="text" id="reg_departments" name="reg_departments" placeholder="如:计算机学院-计算机科学系" class="form-control">
                </div>
                <div class="form-group">
                     <label>角色</label>
                     <select class="form-control" name="role" id="role">
                     <option value='0'>学生</option>
                     <option value='1'>管理员</option>
                     </select>
                </div>
                <label id="message" class="text-danger" style="text-align: center;width: 100%;"></label>
			</div>       
</body>
</html>