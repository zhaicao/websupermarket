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
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="renderer" content="">
    <meta http-equiv="Content-Type" content="text/html"; charset="utf-8" />   

    <title>网上超市商品管理系统</title>

    <meta name="keywords" content="">
    <meta name="description" content="">

    <!--[if lt IE 9]>
    <meta http-equiv="refresh" content="0;ie.html" />
    <![endif]-->

    <link rel="shortcut icon" href="favicon.ico"> <link href="css/bootstrap.min.css?v=3.3.6" rel="stylesheet">
    <link href="css/font-awesome.min.css?v=4.4.0" rel="stylesheet">
    <link href="css/animate.css" rel="stylesheet">
    <link href="css/style.css?v=4.1.0" rel="stylesheet">
    <link rel="stylesheet" type="text/css" src="js/bootstrap-table.min.css" />
    
    <!-- 全局js -->
    <script src="js/jquery.min.js?v=2.1.4"></script>
    <script src="js/bootstrap.min.js?v=3.3.6"></script>
    <script src="js/plugins/metisMenu/jquery.metisMenu.js"></script>
    <script src="js/plugins/slimscroll/jquery.slimscroll.min.js"></script>
    <script src="js/plugins/layer/layer.min.js"></script>
    
    <script type="text/javascript" src="js/bootstrap-table.min.js"></script>
    <script type="text/javascript" src="js/bootstrap-table-zh-CN.min.js"></script>

    <!-- 自定义js -->
    <script type="text/javascript" src="js/admin.js"></script>
    <script type="text/javascript" src="js/index.js"></script>
    <script type="text/javascript">
    
    $(function(){
    	//初始化菜单权限
    	var user = JSON.parse('<%=session.getAttribute("user")%>');
    })
    </script>

</head>

<body class="fixed-sidebar full-height-layout gray-bg" style="overflow:hidden">
<!-- ä¸»é¡µæ¨¡ææ¡ -->
<div class="modal fade" id="myModal" tabindex="-1" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
				<h4 class="modal-title" id="myModalLabel">模态框标题</h4>
			</div>
			<div id="modal-body" class="modal-body">
				<iframe id="iframemodal" src="#" width="100%" height="100%" frameborder="0" seamless></iframe>
			</div>
			<div class="modal-footer">
		        <a href="#" id="cancel" class="btn" data-dismiss="modal">取消</a>
		        <a href="#" id="submit" class="btn btn-primary">确定</a>
		       	<span id="funLink" style="display:none"></span>		        
		    </div>
			
		</div>
	</div>
</div><!-- 模态框 -->

    <div id="wrapper">
        <!--左侧导航开始-->
        <nav class="navbar-default navbar-static-side" role="navigation">
            <div class="nav-close"><i class="fa fa-times-circle"></i>
            </div>
            <div class="sidebar-collapse">
                <ul class="nav" id="side-menu">
                    <li class="nav-header">
                        <div class="dropdown profile-element">
                            <a data-toggle="dropdown" class="dropdown-toggle" href="#">
                                <span class="clear">
                                    <span class="block m-t-xs" style="font-size:16px;">
                                        <strong class="font-bold">网上超市商品管理系统</strong>
                                    </span>
                                </span>
                            </a>
                        </div>
                        <div class="logo-element">Admin
                        </div>
                    </li>
                    <li id="usermenu">
                    <!-- 添加J_menuItem样式，折叠时候点击菜单不会自动展开 -->
                        <a class="J_menuItem" href="user.jsp">
                            <i class="fa fa-home"></i>
                            <span class="nav-label">用户管理</span>
                        </a>
                    </li>
                    <li>
                        <a class="J_menuItem" href="goods.jsp">
                            <i class="fa fa fa-bar-chart-o"></i>
                            <span class="nav-label">商品管理</span>
                        </a>
                    </li>                  
                    
                    <li>
                        <a class="J_menuItem" href="orders.jsp">
                        <i class="fa fa-desktop"></i> 
                        <span class="nav-label">订单管理</span>
                        </a>
                    </li>
                    
                    <li>
                        <a class="J_menuItem" href="sale.jsp">
                        <i class="fa fa-edit"></i>
                        <span class="nav-label">销售管理</span>
                        </a>
                    </li>
                    
                    <li class="user-manage" >
                        <a href="#">
                            <i class="fa fa fa-bar-chart-o"></i>
                            <span class="nav-label">销售统计</span>
                            <span class="fa arrow"></span>
                        </a>
                        <ul class="nav nav-second-level">
                            <li>
                                <a class="J_menuItem user-manage-1" href="pie.jsp" >销售比</a>
                                <a class="J_menuItem user-manage-2" href="line.jsp" >销售趋势</a>
                            </li>
                        </ul>
                    </li>
      
                    <li>
                        <a class="J_menuItem" href="javascript:parent.location.href='../controlServlet?type=logout'">
                        <i class="fa fa-flask"></i> 
                        <span class="nav-label">退出</span>
                        </a>
                    </li>
                    </ul>
            </div>
        </nav>
        <!--å·¦ä¾§å¯¼èªç»æ-->
        <!--å³ä¾§é¨åå¼å§-->
        <div id="page-wrapper" class="gray-bg dashbard-1">
            <div class="row border-bottom">
                <nav class="navbar navbar-static-top" role="navigation" style="margin-bottom: 0">
                    <div class="navbar-header">
                    <a class="navbar-minimalize minimalize-styl-2 btn btn-info " href="#"><i class="fa fa-bars"></i> </a>		 			   
                    </div>
                    <ul class="nav navbar-top-links navbar-right">
                        <li class="dropdown">
                        <!--  
                            <a class="dropdown-toggle count-info" data-toggle="dropdown" href="#">
                                <i class="fa fa-envelope"></i> <span class="label label-warning">16</span>
                            </a>
                                       
                         -->              
                        <li class="dropdown">
                        <!--  
                            <a class="dropdown-toggle count-info" data-toggle="dropdown" href="#">
                                <i class="fa fa-bell"></i> 
                            </a>
                        -->    
                        </li>
                    </ul>
                </nav>
            </div>
            <div class="row J_mainContent" id="content-main">
                <iframe id="J_iframe" width="100%" height="100%" src="user.jsp" frameborder="0" seamless></iframe>
            </div>
        </div>
        <!--å³ä¾§é¨åç»æ-->
    </div>
  <!-- 模态框触发 -->
<input type="hidden" id="openmodalParent" data-toggle="modal" data-target="#myModal"> 
    
    
</body>

</html>
