<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>增加修改菜品</title>
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
    $(function(){  	
    	//初始化修改数据
    	if (parms["type"] == "edit"){
    		$.ajax({
    			type: "post",
    			url: "${pageContext.request.contextPath}/controlServlet?type=getGoods&&goodsId="+parms["goodsId"],
                dataType:'json',
    			success: function(data, status){
    				console.info(data);
    				$("#type").val(data.g_type);
    	    		$("#name").val(data.g_name);
    	    		$("#code").val(data.g_code);
    	    		$("#unit").val(data.g_unit);
    	    		$("#amount").val(data.g_amount);
    	    		$("#summary").val(data.g_summary);
    	    		$("#price").val(data.g_price);
    	    		if( data.g_isonsale == 1){
    	    			$("#onSale").attr('checked',true);
        	    		$("#onsaleprice").val(data.g_onsaleprice).show();
    	    		}
    	    		$("#defImg").remove();
    	    		$("#uploadPreview").css("background-image", "url(../upload/"+data.g_img+")"); 
    			},
    			error: function(XMLHttpRequest, textStatus, errorThrown){
    				console.info(errorThrown);
    			}
    		}); 		
    	}
    	
    	//绑定图片点击div事件
    	$("#uploadPreview").on("click", function(){
    		$("#uploadImage").click();
    	});
    	
    	//绑定选择图片事件
    	$("#uploadImage").on("change", function(){
    	    var files = !!this.files ? this.files : [];
    	    if (!files.length || !window.FileReader) return;
    	    if (/^image/.test( files[0].type)){
    	        var reader = new FileReader();
    	        reader.readAsDataURL(files[0]);
    	        reader.onloadend = function(){
    	       $("#defImg").remove();
    	       $("#uploadPreview").css("background-image", "url("+this.result+")");   	        
    	        } 	 
    	    }
    	 
    	});	
    	
    	//特价切换
    	$("#onSale").change(function(){
    		if($("#onSale").prop('checked')) {
				  $("#onsaleprice").show()
			  }else {
				  $("#onsaleprice").hide()
			  }
    	})
    })
    
    
    //提交的函数，如有提交工作则必须申明此函数，由父页面调用.
    //返回true或false
    function conFunction(){
    	var url = "";
    	//定义参数json
    	jsonParms = {
    			gId : parms["goodsId"],
    			type : $("#type").val(),
    			name : $("#name").val(),
    			code : $("#code").val(),
    			unit : $("#unit").val(),
    			amount : $("#amount").val(),
    			summary : $("#summary").val(),
    			price : $("#price").val(),
    			isonsale: $("#onSale").prop('checked') ? 1 : 0,
    			onsaleprice : $("#onsaleprice").val() ? $("#onsaleprice").val() : 0,
    			foodimage : $("#uploadImage").val()
    	};
    	if( !jsonParms.type || !jsonParms.name || !jsonParms.code || !jsonParms.unit || !jsonParms.amount || !jsonParms.summary || !jsonParms.price){
    		alert("信息请填写完整!");
    		return false;
    	}
    	else if( $("#onSale").prop('checked') && !jsonParms.onsaleprice ){
    		alert("信息请填写完整!");
    		return false;
    	}
    	else if($("#defImg").attr("src") == "img/add_img.png"){
    		alert("请选择图片");
    		return false;
    	}else{
    		if (parms["type"] == "edit")//判断是否编辑
    			//图片值需要转码，否则报错
    			url = "${pageContext.request.contextPath}/uploadServlet?reqType=updateGoods&&params="+encodeURI(JSON.stringify(jsonParms));
    		else
    			url = "${pageContext.request.contextPath}/uploadServlet?reqType=addGoods&&params="+encodeURI(JSON.stringify(jsonParms));
    		var re = postFun(url);
    		if ( re.resCode == 0){
    			alert("操作成功");
    			return true;
    		}else
				alert(re.resData);
    		return false; 
    	} 	
    }
    //ajax提交函数
    function postFun(posturl){
    	var result = "";
    	var imgForm = new FormData(document.getElementById('upload'));
		$.ajax({
			type: "POST",
			url: posturl,
			data: imgForm,
			cache: false,
			processData: false,
            contentType: false,
            async: false,//由于需要等待后端结果，故使用同步方式
            dataType:'json',
			success: function(data, status){
				result = data;
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
<form id="upload">
           <div >					
           							<div class = "form-group">
                                        <label>货号</label>
                                        <input type=text id="code" placeholder="请输入货号" class="form-control" autocomplete="off">
                                    </div>
                                	<div class = "form-group">
                                	<label>类别</label>
                                	<input type=text id="type" placeholder="请输入商品类别" class="form-control" autocomplete="off">
                                    </div>
                                    <div class = "form-group">
                                        <label>名称</label>
                                        <input type=text id="name" placeholder="请输入商品名" class="form-control" autocomplete="off">
                                    </div>
                                    
                                    <div class = "form-group">
                                        <label>单位</label>
                                        <input type=text id="unit"  placeholder="请输入单位" class="form-control" autocomplete="off">
                                    </div>
                                    <div class = "form-group">
                                        <label>库存</label>
                                        <input type="text" id="amount" placeholder="请输入库存数量" class="form-control" autocomplete="off">
                                    </div>
                                    <div class = "form-group">
                                        <label id="nametitle">介绍</label>
                                        <input type=text id="summary" placeholder="请输入介绍" class="form-control" autocomplete="off">
                                    </div>
                                    <div class = "form-group">
                                        <label>价格(元)</label>
                                        <input type="text" id="price" placeholder="请输入售价" class="form-control" autocomplete="off">
                                    </div>
                                    <div class = "form-group">
                                    	<input type="checkbox" id="onSale">
                                        <label>特价(元)</label>
                                        <input type="text" id="onsaleprice" placeholder="请输入售价" class="form-control" autocomplete="off" style="display:none">
                                    </div>
                                    
                                    <div class = "form-group">
                                        <label>图片</label>
                                        	<div id="uploadPreview" title="点击选择图片">
												<img src="img/add_img.png" id="defImg" style="display:block;width:100%;height:100%"/>
											</div>
											
												<input id="uploadImage" type="file" name="foodimage" class="fimg1" style="display:none;"/>

                                    </div>
                            </div>
                            </form>
                            <label id="message" class="col-sm-offset-4 text-danger"></label>   
</body>
</html>