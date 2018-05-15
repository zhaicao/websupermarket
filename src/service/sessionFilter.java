package service;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *登录过滤器
 *判断session失效
 *如果是ajax请求则设置失效
 */
@WebFilter("/sessionFilter")
public class sessionFilter implements Filter {
	
	private String redirectUrl = "/index.jsp";
    private String sessionKey = "user";
    private String[] exceptUrl = {"/goods.jsp","/onsaleGoods.jsp","/goodsDetail.jsp"};

    /**
     * Default constructor. 
     */
    public sessionFilter() {
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see Filter#destroy()
	 */
	public void destroy() {
		// TODO Auto-generated method stub
	}

	/**
	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
	 */
	/* (non-Javadoc)
	 * @see javax.servlet.Filter#doFilter(javax.servlet.ServletRequest, javax.servlet.ServletResponse, javax.servlet.FilterChain)
	 */
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		  	HttpServletRequest req = (HttpServletRequest) request;
	        HttpServletResponse rep = (HttpServletResponse) response;
	        req.setCharacterEncoding("utf-8");  
	        rep.setCharacterEncoding("utf-8"); 
	        rep.setContentType("text/html; charset=utf-8");//设置PrintWriter编码
	        HttpSession session = req.getSession();
	        String url=req.getRequestURI();

	        PrintWriter out=response.getWriter();
	        //获得基础路径
	        String path = req.getContextPath();
	    	String basePath = request.getScheme() + "://"+ request.getServerName() + ":" + request.getServerPort()+ path + "/";
	    	
	    	boolean filter = false;
	    	for( String exceptPath: exceptUrl){
	    		if ( url.indexOf(exceptPath) != -1 )
	    			filter = true;
	    	}
	    	
	        if(url.indexOf(redirectUrl) != -1 || filter){ 
	        	chain.doFilter(request, response);
	        	return;
	        	
	        }else{
	        	if( session.getAttribute(sessionKey) == null ){
	        		out.print("<script language='javascript'>parent.location.href='"+basePath+"index.jsp';alert('会话超时，请重新登录');</script>");    
		        }else
		        	chain.doFilter(request, response);   	
	        }
	    }

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
		    String url = fConfig.getInitParameter("redirectUrl");
	        String key = fConfig.getInitParameter("sessionKey");
	        
	        redirectUrl = url == null? redirectUrl:url;
	        sessionKey = key == null ? sessionKey : key ;
	}

}
