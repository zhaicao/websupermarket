$(function(){
    //菜单点击
    J_iframe
    $(".J_menuItem").on('click',function(){
        var url = $(this).attr('href');
        $("#J_iframe").attr('src',url);
        return false;
    });
    
  //根据iframe中的body，model自适应大小
  //绑定默认事件，模态框默认大小
	$("#myModal").on("hidden.bs.modal", function(){
		$("#modal-body").removeAttr("style");   		
		});
	//绑定自适应的高度事件，根据iframe高度自动调节模态框
	$("#myModal").on("shown.bs.modal", function(){
		var iframeDoc = $("#iframemodal").prop("contentWindow").document;
		var height = $(iframeDoc).height()+50
		if (height > 205)
			$("#modal-body").animate({height, height}, 600);//动态效果增加体验    		
		});
});