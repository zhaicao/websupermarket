/**
 * 
 */
//获得url参数
    function getUrlParms(){
    	var parms = new Object();
    	var pairs = location.search.substring(1).split("&");//获得url后的参数，按&分割成数组
    	for (var i =0; i <  pairs.length; i++){
    		var pos = pairs[i].indexOf('=');
    		if (pos == -1) continue;
    		//组成key：value形式
    		parms[pairs[i].substring(0, pos)] = unescape(pairs[i].substring(pos + 1));
    	}
    	return parms;
    }
    
    
  //设置模态框调用的页面
    function setModalIframeNew(parms){
   	 var defaults = {
   				title : parms.title ? parms.title : "模态框",
   				path : parms.url ? parms.url : "index.html",
   				btnName : parms.btnName ? parms.btnName : "确定",
   				size : parms.size ? parms.size : "",
   				initCallback : parms.initEvent ? parms.initEvent : function(){console.info("Null")},
   				fnCallback : parms.subEvent ? parms.subEvent : function(){console.info("Null")},
   	};
   	  
   	var _parent = window.parent;
   	var _iframe = _parent.$("#iframemodal")
   	
   	_parent.$("#myModalLabel").text(defaults.title);
   	_iframe.attr("src", defaults.path);
   	_parent.$("#submit").text(defaults.btnName);
   	_parent.$('.modal-dialog').attr("class", "modal-dialog " + defaults.size);
   	_parent.$('#myModal').modal('toggle');
   	
   	//iframe加载完毕初始化
   	_iframe.unbind('load').load(function(){
   		defaults.initCallback && defaults.initCallback(_iframe[0].contentWindow, _iframe.contents());
   	})
   	//绑定确定按钮点击事件
   	_parent.$("#submit").unbind('click').click(function(){
   		defaults.fnCallback && defaults.fnCallback(_parent.$('#myModal'), _iframe[0].contentWindow, _iframe.contents());
     });
   }
    
    function setModalIframe(parms){
    	var defaults = {
    			title : parms.title ? parms.title : "模态框",
    			path : parms.path ? parms.path : "index.html",
    			btn_name : parms.btn_name ? parms.btn_name : "确定",
    			type : parms.type ? parms.type : "add",
    			size : parms.size ? parms.size : "",
    			action : parms.action ? parms.action : function(){console.info("Null")},
    	};
    	$("#myModalLabel", parent.document).text(defaults.title);
    	$(".modal-dialog", parent.document).attr("class", "modal-dialog " + defaults.size);
    	$("#iframemodal", parent.document).attr("src", defaults.path);
    	$("#submit", parent.document).text(defaults.btn_name);
    	$("#openmodalParent", parent.document).trigger("click");
    	$("#submit", parent.document).unbind("click");//清空点击绑定事件
    	$("#submit", parent.document).bind("click", defaults.action);//绑定事件	
    	//$('#myModal', parent.document).modal('toggle');
    }
    
    // 对Date的扩展，将 Date 转化为指定格式的String   
    // 月(M)、日(d)、小时(h)、分(m)、秒(s)、季度(q) 可以用 1-2 个占位符，   
    // 年(y)可以用 1-4 个占位符，毫秒(S)只能用 1 个占位符(是 1-3 位的数字)   
    // 例子：   
    // (new Date()).Format("yyyy-MM-dd hh:mm:ss.S") ==> 2006-07-02 08:09:04.423   
    // (new Date()).Format("yyyy-M-d h:m:s.S")      ==> 2006-7-2 8:9:4.18   
    Date.prototype.Format = function(fmt)   
    { //author: meizz   
      var o = {   
        "M+" : this.getMonth()+1,                 //月份   
        "d+" : this.getDate(),                    //日   
        "h+" : this.getHours(),                   //小时   
        "m+" : this.getMinutes(),                 //分   
        "s+" : this.getSeconds(),                 //秒   
        "q+" : Math.floor((this.getMonth()+3)/3), //季度   
        "S"  : this.getMilliseconds()             //毫秒   
      };   
      if(/(y+)/.test(fmt))   
        fmt=fmt.replace(RegExp.$1, (this.getFullYear()+"").substr(4 - RegExp.$1.length));   
      for(var k in o)   
        if(new RegExp("("+ k +")").test(fmt))   
      fmt = fmt.replace(RegExp.$1, (RegExp.$1.length==1) ? (o[k]) : (("00"+ o[k]).substr((""+ o[k]).length)));   
      return fmt;   
    }  