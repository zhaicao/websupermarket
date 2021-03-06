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
import javax.servlet.http.HttpSession;

import dao.CommDAO;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import util.SqlPageSQL;

/**
 * Servlet implementation class foreendServlet
 */
@WebServlet("/foreendServlet")
public class foreendServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public foreendServlet() {
        super();
        // TODO Auto-generated constructor stub
    }
    /**封装请求转发
	 * @param url
	 * @param request
	 * @param response
	 */
	public void go(String url, HttpServletRequest request, HttpServletResponse response) {
		try {
			request.getRequestDispatcher(url).forward(request, response);
		} catch (ServletException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	/**封装请求重定向
	 * @param url
	 * @param request
	 * @param response
	 */
	public void gor(String url, HttpServletRequest request, HttpServletResponse response) {
		try {
			response.sendRedirect(url);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		response.setContentType("json");
		String type = request.getParameter("type");
		JSONObject jsonObject =null;
		HttpSession session = request.getSession();
		CommDAO dao = new CommDAO();
		Map<String,Object> map = new HashMap<String,Object>();	
		
		//主页
		if (type.equals("index")){
			ArrayList<HashMap> allGoods = (ArrayList<HashMap>)dao.select("select * from goods where g_isdel = 0 and g_isonsale = 0 order by g_id DESC limit 10");			
			ArrayList<HashMap> onSaleGoods = (ArrayList<HashMap>)dao.select("select * from goods where g_isdel = 0 and g_isonsale = 1 order by g_id DESC limit 10");         
			map.put("goods", allGoods);
			map.put("onsale", onSaleGoods);	
			jsonObject = JSONObject.fromObject(map);	
			response.getWriter().println(jsonObject.toString());
		}
		//商品信息
		else if(type.equals("goods")){			
			int limit = Integer.parseInt(request.getParameter("pageSize")); //每页显示条数
			int curPage = Integer.parseInt(request.getParameter("curPage")); //当前页
			String isOnSale = request.getParameter("isOnSale");
			String key = request.getParameter("searchKey");
			String cSql="select * from goods where g_isdel = 0";
			if( !isOnSale.isEmpty() )
				cSql += " and g_isonsale = 1";
			if( key != null && !key.equals(""))
				cSql += " and g_name like '%"+key+"%'";
			cSql += " order by g_id DESC";
			ArrayList<HashMap> cList = (ArrayList<HashMap>)dao.select(SqlPageSQL.getPageMySQL(cSql,curPage, limit));
			int total = dao.getInt("SELECT count(*) FROM ("+ cSql+") t");
			map.put("total", total);
			map.put("goods", cList);
			jsonObject = JSONObject.fromObject(map);
			response.getWriter().println(jsonObject.toString());	
			}
		//获得商品详情
		else if(type.equals("goodsDetails")){
			String gId = request.getParameter("gId");
			HashMap gMap = dao.selectmap("select * from goods where g_isdel = 0 and g_id=" + gId);	
			String sql = "select * from tea_estimate te where 1=1 and te.te_teacher_id="+gId+" order by te.te_date";
			ArrayList<HashMap> teList = (ArrayList<HashMap>)dao.select(sql); 
			int teCount = dao.getInt("select count(*) from ("+sql+") t");
			map.put("goods", gMap);
			map.put("estimations", teList);
			map.put("estimationCount", teCount);
			jsonObject = JSONObject.fromObject(map);
			response.getWriter().println(jsonObject.toString());					
			}
		//商品评价
		else if(type.equals("estimation")){
			String t_id = request.getParameter("teacher_id");
			String user_id = request.getParameter("teacher_id");
			String estimation = request.getParameter("estimation");		
			dao.commOper("insert into tea_estimate(te_teacher_id, te_user_id, te_estimation, te_date, isdel)values("+t_id+","+user_id+",'"+estimation+"',now(),0)");
		    HashMap temap = dao.selectmap("select * from tea_estimate te where 1=1 and te.te_id=(select max(te_id) from tea_estimate ) and te.te_teacher_id="+t_id+" and te.te_user_id=" + user_id);
		    int teCount = dao.getInt("select count(*) from tea_estimate te where 1=1 and te.te_teacher_id=" + t_id);
		    map.put("estimation", temap);
		    map.put("estimationCount", teCount);
			jsonObject = JSONObject.fromObject(map);
			response.getWriter().println(jsonObject.toString());				
		    }
		
		//查询购物车数量
		else if(type.equals("getCartCount")){
			String uId = request.getParameter("uId");
			int c_count = dao.getInt("select count(1) from cart where c_isdel = 0 and c_userid = " + uId);
			map.put("cartCount", c_count);
			jsonObject = JSONObject.fromObject(map);	
			response.getWriter().println(jsonObject.toString());
			}
		
		//扫描支付
		else if(type.equals("QRPayment")){
			String gId = request.getParameter("gId");
			String gPrice = request.getParameter("gPrice");
			String gAmount = request.getParameter("gAmount");	
			String gSumPrice = request.getParameter("gSumPrice");
			HashMap gMap = dao.selectmap("select * from goods where g_isdel = 0 and g_id = " + gId);
			if( !gMap.isEmpty() ){
				dao.commOper("insert into sale(s_gid, s_type, s_gcode, s_gtype, s_gunit, s_gprice, s_gisonsale, s_price, s_amount, s_sumprice, s_date) value("+gId+", 1,'"+gMap.get("g_code")+"','"+gMap.get("g_type")+"','"+gMap.get("g_unit")+"',"+gMap.get("g_price")+","+gMap.get("g_isonsale")+","+gPrice+","+gAmount+","+gSumPrice+",now())");
				dao.commOper("update goods set g_amount = g_amount - "+gAmount+" where g_id = " + gId);
				map.put("status", "success");
			}else
				map.put("status", "fail");
			jsonObject = JSONObject.fromObject(map);	
			response.getWriter().println(jsonObject.toString());				
			}
		
		//加入购物车
		else if(type.equals("addCart")){
			String uId = request.getParameter("uId");
			String gId = request.getParameter("gId");
			String gAmount = request.getParameter("gAmount");
			HashMap cMap = dao.selectmap("select * from cart c where c.c_isdel = 0 and c_userid = "+uId+" and c_gid = "+ gId);
			if( cMap.isEmpty() )
				dao.commOper("insert into cart(c_userid,c_gid,c_gamount,c_date) values("+uId+","+gId+","+gAmount+",now())");	
			else
				dao.commOper("update cart set c_gamount = c_gamount + "+gAmount+" where c_id = " + cMap.get("c_id"));
			map.put("status", "success");
			jsonObject = JSONObject.fromObject(map);	
			response.getWriter().println(jsonObject.toString());
		}
		//获得购物车
		else if(type.equals("getCart")){
			String uId = request.getParameter("uId");
			String sql = "select * from cart c left join goods g on c.c_gid = g.g_id where c.c_isdel = 0 and c.c_userid = " + uId;
			ArrayList<HashMap> cList = (ArrayList<HashMap>)dao.select(sql);
			map.put("goods",cList);
			jsonObject = JSONObject.fromObject(map);
			response.getWriter().println(jsonObject.toString());
		}
		//购物车删除商品
		else if(type.equals("delCart")){
			String cId= request.getParameter("cId"); //报名编号
			dao.commOper("update cart set c_isdel = 1 where c_id = " + cId);
			map.put("status", "success");
			jsonObject = JSONObject.fromObject(map);
			response.getWriter().println(jsonObject.toString());
		}
		//购物车下单
		else if (type.equals("orderCart")){
			JSONArray userIdList = JSONArray.fromObject(request.getParameter("gList"));
			JSONObject goods;
			String uId = request.getParameter("uId");
			String receiver = request.getParameter("receiver");
			String phone = request.getParameter("phone");
			String address = request.getParameter("address");
			String method = request.getParameter("method");
			String total = request.getParameter("total");
			String pieceNum = request.getParameter("pieceNum");
			ArrayList<String> sqls = new ArrayList();
			//增加订单
			dao.commOper("insert into orders(o_userid, o_saleid, o_amount, o_sumprice, o_receiver, o_phone, o_address, o_method, o_status, o_date) values("+uId+",0,"+pieceNum+","+total+",'"+receiver+"','"+phone+"','"+address+"',"+method+",0,now())");
			int oId = dao.getInt("select max(o_id) from orders");
			for (int i = 0; i< userIdList.size(); i++){
				goods = JSONObject.fromObject(userIdList.get(i));
				HashMap gMap = dao.selectmap("select * from goods where g_id = (select c_gid from cart where c_id = "+goods.get("cId")+")");
				double sumPrice;
				if( gMap.get("g_isonsale").equals("1"))
					sumPrice = Double.parseDouble(goods.get("cAmount").toString()) * Double.parseDouble(gMap.get("g_onsaleprice").toString());
				else
					sumPrice = Double.parseDouble(goods.get("cAmount").toString()) * Double.parseDouble(gMap.get("g_price").toString());
				//增加销售表
				sqls.add("insert into sale(s_orderid, s_gid, s_type, s_gcode, s_gtype, s_gunit, s_gprice, s_gisonsale, s_price, s_amount, s_sumprice, s_date, s_gname, s_status) value("+oId+","+gMap.get("g_id")+",0,'"+gMap.get("g_code")+"','"+gMap.get("g_type")+"','"+gMap.get("g_unit")+"',"+gMap.get("g_price")+","+gMap.get("g_isonsale")+","+gMap.get("g_onsaleprice")+","+goods.get("cAmount")+","+sumPrice+",now(),'"+gMap.get("g_name")+"',0)");
				sqls.add("update cart set c_isdel = 1 where c_id = " + goods.get("cId"));
				sqls.add("update goods set g_amount = g_amount -"+goods.get("cAmount")+" where g_id = " + gMap.get("g_id"));
			}
			dao.commOperSqls(sqls);
			map.put("status","success");
			jsonObject = JSONObject.fromObject(map);
			response.getWriter().println(jsonObject.toString());
			
		}
		//我的订单
		else if (type.equals("myOrders")){
			String user_id = request.getParameter("user_id");
			int limit = Integer.parseInt(request.getParameter("pageSize")); //每页显示条数
			int curPage = Integer.parseInt(request.getParameter("curPage")); //当前页
			String csql = "select * from orders where o_isdel = 0 and o_userid = "+user_id;
			csql += " order by o_date desc";
			int total = dao.getInt("select count(*) from ("+ csql+") t");
			ArrayList<HashMap> clist = (ArrayList<HashMap>)dao.select(SqlPageSQL.getPageMySQL(csql,curPage, limit));
			map.put("courses",clist);
			map.put("total",total);
			jsonObject = JSONObject.fromObject(map);
			response.getWriter().println(jsonObject.toString());				
		}
		//获得订单销售详情
		else if (type.equals("getOrderSale")){
			String oId = request.getParameter("oId");
			String sql = "select * from sale s where s.s_isdel = 0 and s.s_orderid = "+oId;
			ArrayList<HashMap> list = (ArrayList<HashMap>)dao.select(sql);
			map.put("sales",list);
			jsonObject = JSONObject.fromObject(map);
			response.getWriter().println(jsonObject.toString());				
		}
		//取消订单
		else if (type.equals("cancelOrder")){
			String oId = request.getParameter("oId");
			dao.commOper("update orders set o_status = 2 where o_id = " + oId);
			dao.commOper("update sale set s_status = 2 where s_isdel = 0 and s_orderid = " + oId);
			map.put("status","success");
			jsonObject = JSONObject.fromObject(map);
			response.getWriter().println(jsonObject.toString());				
		}
		//修改密码
		else if(type.equals("editpwd")){
			String user_id = request.getParameter("user_id");
			String user_pwd = request.getParameter("user_pwd");
			dao.commOper("update users set user_pwd='"+user_pwd+"' where user_id=" + user_id);
			HashMap umap = dao.selectmap("select * from users where user_id= " + user_id);
			//更新session中user的内容
			session.setAttribute("user", JSONObject.fromObject(umap).toString());
			map.put("status", "success");
			jsonObject = JSONObject.fromObject(map);			
			response.getWriter().println(jsonObject.toString());				
		}
		//修改用户信息
		else if(type.equals("editSelfinfo")){
			String user_id = request.getParameter("user_id");
			String user_realname = request.getParameter("realname");
			String user_phone = request.getParameter("phone");
			String user_address = request.getParameter("address");
			String user_card = request.getParameter("card");
			dao.commOper("update users set user_realname='"+user_realname+"',user_address='"+user_address+"',user_phone='"+user_phone+"',user_card='"+user_card+"' where user_id=" + user_id);
			HashMap umap = dao.selectmap("select * from users where user_id= " + user_id);
			//更新session中user的内容
			session.setAttribute("user", JSONObject.fromObject(umap).toString());
			map.put("status", "success");
			jsonObject = JSONObject.fromObject(map);			
			response.getWriter().println(jsonObject.toString());				
		}
		//前台退出
		else if(type.equals("logout")){
			session.removeAttribute("user");
			gor("index.jsp", request, response);
		}
		else{
			response.getWriter().println("error");
		}		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
			doGet(request, response);//转到Get
	 }
  }
