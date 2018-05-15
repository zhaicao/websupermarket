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
  <title>考勤管理</title>
  <script type="text/javascript" src="js/jquery.min.js"></script>
  <script type="text/javascript" src="js/jquery.mini.js"></script>
  <script type="text/javascript" src="js/bootstrap.min.js"></script>
  <script type="text/javascript" src="js/bootstrap-table.min.js"></script>
  <script type="text/javascript" src="js/bootstrap-table-zh-CN.min.js"></script>
  <link rel="stylesheet" type="text/css" href="css/bootstrap.min.css" />
  <link rel="stylesheet" type="text/css" href="css/bootstrap-table.min.css" />

  <script type="text/javascript" src="js/custom.js"></script>
  </head>
  <body style="background-color: #F0F0F0;">

    <div class="container">
    <h4>公告管理</h4>
    <!-- 查询框 -->
    <div class="row form-horizontal">  
    		<div class="form-group">
    				<div class="col-sm-2"></div>
					<div class="col-sm-6">
						<textarea rows="5" cols="20" class="form-control"></textarea>
                    </div>
                    <div class="col-sm-2">
                         <span class="input-group-btn"> 
                         <button type="button" class="btn btn-primary">修改</button>
                         </span>
                    </div>
        	</div>
     </div>
     <!-- /查询框 -->
   <!-- toolbar -->   

    </div> 
 <script>
 $(function () {
	 $.ajax({
			type: "post",
			url: "${pageContext.request.contextPath}/controlServlet",
            dataType:'json',
            data: {type: 'getNotice'},
			success: function(data, status){
				$(".form-control").val(data.n_content);
	    		
			}
		});
	 $(".btn-primary").on('click',function(){
		 $.ajax({
				type: "post",
				url: "${pageContext.request.contextPath}/controlServlet",
	            dataType:'json',
	            data: {type: 'updateNotice', notice: $(".form-control").val()},
				success: function(data, status){
					alert('修改成功');
				}
			});
		 
	 })
	 
});

 </script>
  </body>
</html>
