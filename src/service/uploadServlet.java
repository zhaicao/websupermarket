package service;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.CommDAO;
import net.sf.json.JSONObject;

/**
 * Servlet implementation class uploadServlet
 */
@WebServlet("/uploadServlet")
public class uploadServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public uploadServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//下载方法
		CommDAO dao = new CommDAO();
		String fileName = request.getParameter("fileName");
		dao.download("/upload", fileName, 1024*1024, request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
				request.setCharacterEncoding("utf-8");
				response.setCharacterEncoding("utf-8");
				String type = request.getParameter("reqType");
				Map<String,Object> map = new HashMap<String,Object>();
				JSONObject jsonObject =null;
				CommDAO dao = new CommDAO();
				//增加汇报
				if (type.equals("addGoods")){				
					//获得json参数并转JSONObject对象
					String params = request.getParameter("params");
					JSONObject jsonParams = JSONObject.fromObject(params);
					HashMap gMap = dao.selectmap("select * from goods where g_isdel = 0 and g_code = '"+jsonParams.getString("code")+"'");
					if( gMap.isEmpty() ){
						String filename = dao.uploadImg("/upload", 1024*1024, request);//上传文件
						dao.commOper("insert into goods(g_type, g_name, g_code, g_unit, g_summary, g_amount, g_price, g_isonsale, g_onsaleprice, g_img) values('"+jsonParams.getString("type")+"','"+jsonParams.getString("name")+"','"+jsonParams.getString("code")+"','"+jsonParams.getString("unit")+"','"+jsonParams.getString("summary")+"',"+jsonParams.getString("amount")+","+jsonParams.getString("price")+","+jsonParams.getString("isonsale")+","+jsonParams.getString("onsaleprice")+",'"+filename+"')");
						map.put("resCode", "0");
						map.put("resData", "操作成功");
					}else{
						map.put("resCode", "1");
						map.put("resData", "该货号已存在");
					}
					jsonObject = JSONObject.fromObject(map);
					response.getWriter().println(jsonObject.toString());
				}
				//修改工作汇报
				else if(type.equals("updateGoods")){		
					//获得json参数并转JSONObject对象
					String params = request.getParameter("params"); 
					JSONObject jsonParams = JSONObject.fromObject(params);
					HashMap gMap = dao.selectmap("select * from goods where g_isdel = 0 and g_id != "+jsonParams.getString("gId")+" and g_code = '"+jsonParams.getString("code")+"'");
					String filename = dao.getStr("select g_img from goods where g_id = " + jsonParams.getString("gId"));
					String file = "";
					if( gMap.isEmpty() ){
						file = dao.uploadImg("/upload", 1024*1024, request);//上传文件
						if( !file.equals("fail"))
							filename = file;
						dao.commOper("update goods set g_type = '"+jsonParams.getString("type")+"',g_name = '"+jsonParams.getString("name")+"', g_unit = '"+jsonParams.getString("unit")+"',g_summary = '"+jsonParams.getString("summary")+"',g_amount = "+jsonParams.getString("amount")+",g_price = "+jsonParams.getString("price")+",g_isonsale = "+jsonParams.getString("isonsale")+",g_onsaleprice = "+jsonParams.getString("onsaleprice")+",g_img = '"+filename+"' where g_id = " + jsonParams.getString("gId"));
						map.put("resCode", "0");
						map.put("resData", "操作成功");
					}
					else{
						map.put("resCode", "1");
						map.put("resData", "该货号已存在");
					}	
					jsonObject = JSONObject.fromObject(map);
					response.getWriter().println(jsonObject.toString());			
				}
				else
					doGet(request, response);//转到Get
	}

}
