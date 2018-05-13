<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>咨询问题回复</title>

<link rel="shortcut icon" href="favicon.ico"> <link href="css/bootstrap.min.css?v=3.3.6" rel="stylesheet">
    <link href="css/font-awesome.css?v=4.4.0" rel="stylesheet">
    <link href="css/plugins/iCheck/custom.css" rel="stylesheet">
    <link href="css/animate.css" rel="stylesheet">
    <link href="css/style.css?v=4.1.0" rel="stylesheet">
    
        <!-- å¨å±js -->
    <script src="js/jquery.min.js?v=2.1.4"></script>
    <script src="js/jquery.mini.js"></script>
    <script src="js/bootstrap.min.js?v=3.3.6"></script>

    <!-- iCheck -->
    <script src="js/plugins/iCheck/icheck.min.js"></script>
    <script src="js/custom.js"></script>
    
<script>
var parms = getUrlParms();
function reply(){
	console.info(parms["f_id"]);
	var reply = $("#question_reply").val();
	if(reply == "")
		alert("请输入回复内容");
	else{
		var status = postFun(transformer(window.location.origin) + "?type=reply", {f_id: parms["f_id"], question_reply: reply});
		if(status = true){
			alert("回复成功");
			return true;
		}		
	}
	return false;
}

//ajax提交函数
function postFun(posturl, postdata){
	var result = "";
	$.ajax({
		type: 'POST',
		url: posturl,
		dataType: 'json',
		async: false,
		data: postdata,
		success: function(data, status){
			result = data.status;
			}							
	});
	return result;
}
</script>
</head>
<body>
<div class="modal-body">
                <div class="form-group">
                     <textarea id="question_reply" name="question_reply" placeholder="请输入回复内容" class="form-control" rows="6"></textarea>
                </div>            
</div>
</body>
</html>