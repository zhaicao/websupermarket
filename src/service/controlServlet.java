package service;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
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
 * Servlet implementation class cpServlet
 */
@WebServlet("/controlServlet")
public class controlServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public controlServlet() {
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
		HttpSession session = request.getSession();
		
		//客户退出
		if(type.equals("logout")){
			session.removeAttribute("user");
			session.removeAttribute("admin");
			gor("../index.jsp", request, response);
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
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		response.setContentType("json");
		String type = request.getParameter("type");
		JSONObject jsonObject =null;
		HttpSession session = request.getSession();
		CommDAO dao = new CommDAO();
		Map<String,Object> map = new HashMap<String,Object>();	

		//注册
		if(type.equals("register")){
			String username = request.getParameter("username");
			String pwd = request.getParameter("pwd");
			String realname = request.getParameter("realname");
			String phone = request.getParameter("phone");
			String role = request.getParameter("role");
			String address = request.getParameter("address");
			String card = request.getParameter("card");
			HashMap umap = dao.selectmap("select * from users where isdel = 0 and user_uname= '" + username + "' or user_phone = '"+ phone+"'");	
			if( umap.isEmpty() ){
				dao.commOper("insert into users(user_uname, user_pwd, user_realname, user_department, user_phone, user_role, isdel,user_address,user_card) values('"+username+"','"+pwd+"','"+realname+"', null, '"+phone+"','"+role+"',0,'"+address+"','"+card+"')");
				map.put("status", "success");				
			}else
				map.put("status", "exsit");
			jsonObject = JSONObject.fromObject(map);
			response.getWriter().println(jsonObject.toString());
		}
		//登录
		else if(type.equals("login")){
			String username = request.getParameter("username");
			String pwd = request.getParameter("password");
			String role = request.getParameter("role");
			HashMap umap = dao.selectmap("select * from users where 1=1 and isdel = 0 and user_uname= '" + username +"' and user_role= " + role);
			if( umap.get("user_id") == null)
				map.put("status", "notexsit");
			else if( !umap.get("user_pwd").equals(pwd))
				map.put("status", "fail");
			else{
				map.put("status", "success");
				if (role.equals("1"))
					session.setAttribute("user", JSONObject.fromObject(umap).toString());
				else
					session.setAttribute("admin", JSONObject.fromObject(umap).toString());
			}	
			jsonObject = JSONObject.fromObject(map);
			response.getWriter().println(JSONObject.fromObject(map).toString());
	    }
		//用户管理
		else if (type.equals("user")){
			String sql = "select * from users where isdel=0";	
			ArrayList<HashMap> list = (ArrayList<HashMap>)dao.select(sql);
			response.getWriter().println(JSONArray.fromObject(list).toString());
		}
		//用户编辑-获得用户信息
		else if(type.equals("user_getedit")){
			String user_id = request.getParameter("user_id");
			map = dao.selectmap("select * from users where 1=1 and isdel = 0 and user_id = "+user_id);
			jsonObject = JSONObject.fromObject(map);	
			response.getWriter().println(jsonObject.toString());	
		}
		//用户编辑-更新用户信息
		else if(type.equals("user_edit")){
			String user_id = request.getParameter("user_id");
			String realname = request.getParameter("realname");
			String phone = request.getParameter("phone");
			String role = request.getParameter("role");
			String address = request.getParameter("address");
			String card = request.getParameter("card");
			dao.commOper("update users set user_realname='"+realname+"',user_phone='"+phone+"',user_role="+role+",user_address='"+address+"',user_card='"+card+"' where user_id=" + user_id);
			map.put("status", "success");
			jsonObject = JSONObject.fromObject(map);	
			response.getWriter().println(jsonObject.toString());	
		}
		//删除用户
		else if(type.equals("user_del")){
			String user_id = request.getParameter("user_id");
			dao.commOper("update users set isdel = 1 where user_id = " + user_id);
			map.put("status", "success");
			jsonObject = JSONObject.fromObject(map);	
			response.getWriter().println(jsonObject.toString());
			
		}
		//初始用户密码
		else if(type.equals("user_resetpwd")){
			String user_id = request.getParameter("user_id");
			dao.commOper("update users set user_pwd = '123456' where user_id = " + user_id);
			map.put("status", "success");
			jsonObject = JSONObject.fromObject(map);	
			response.getWriter().println(jsonObject.toString());
					
		}
		//商品管理
		else if (type.equals("goods")){
			String sql = "select * from goods where g_isdel = 0";
			ArrayList<HashMap> list = (ArrayList<HashMap>)dao.select(sql);
			response.getWriter().println(JSONArray.fromObject(list));
		}
		//获得单个商品
		else if (type.equals("getGoods")){
			String goodsId = request.getParameter("goodsId");
			String sql = "select * from goods where g_isdel = 0 and g_id = " + goodsId;
			map = dao.selectmap(sql);
			response.getWriter().println(JSONObject.fromObject(map).toString());
		}
		//增加活动
		else if (type.equals("addTeacher")){
			String tea_name = request.getParameter("tea_name");
			String tea_course_type = request.getParameter("tea_course_type");
			String tea_summary = request.getParameter("tea_summary");
			String tea_address = request.getParameter("tea_address");
			String tea_date = request.getParameter("tea_date");
			String tea_department = request.getParameter("tea_department");
			String tea_specify = request.getParameter("tea_specify");
			String tea_peoples = request.getParameter("tea_peoples");
			JSONArray peopleList = JSONArray.fromObject(request.getParameter("tea_peoList"));
			//插入活动
			dao.commOper("insert into teacher(t_name, t_summary, t_date, t_address, t_department, t_specifying,t_persons, t_course_type, t_course_id, isdel) values ('"+tea_name+"','"+ tea_summary+"','"+ tea_date+"','"+ tea_address+"','"+ tea_department+"',"+ tea_specify+","+ tea_peoples+",'"+ tea_course_type+"', 0, 0)");
			//获得活动Id
			String activityId = dao.getStr("select max(t_id) from teacher");
			ArrayList<String> sqlList = new ArrayList<String>();
			//判断是否指定参与人
			if( tea_specify.equals("1") && peopleList.size() > 0){
				for(int i=0;i<peopleList.size();i++){
					sqlList.add("insert into specify(s_userid, s_activityid, s_status, s_date, s_isdel) values("+ peopleList.getInt(i)+","+ activityId+", 0, now(), 0)");
				}
				//根据指定的人数插入指定表
				dao.commOper("update teacher set t_persons = "+ peopleList.size()+" where t_id = " + activityId);
				//更新活动的人数
				dao.commOperSqls(sqlList);
			}
			map.put("status", "success");
			jsonObject = JSONObject.fromObject(map);	
			response.getWriter().println(jsonObject.toString());
		}
		//活动详情
		else if (type.equals("teacher_detail")){
			String teacher_id =  request.getParameter("teacher_id");		
			map = dao.selectmap("select * from teacher t where t.isdel=0 and t.t_id=" + teacher_id);
			ArrayList<HashMap> list = (ArrayList<HashMap>) dao.select("select s.*,u.user_realname, u.user_phone from specify s LEFT JOIN users u on s.s_userid = u.user_id where s.s_isdel = 0 and u.isdel = 0 and s.s_activityid = " + teacher_id);
			map.put("specifyList", list);
			jsonObject = JSONObject.fromObject(map);
			response.getWriter().println(jsonObject.toString());
		}
		//修改活动
		else if (type.equals("editTeacher")){
			String tea_id = request.getParameter("tea_id");
			String tea_name = request.getParameter("tea_name");
			String tea_course_type = request.getParameter("tea_course_type");
			String tea_summary = request.getParameter("tea_summary");
			String tea_address = request.getParameter("tea_address");
			String tea_date = request.getParameter("tea_date");
			String tea_department = request.getParameter("tea_department");
			String tea_specify = request.getParameter("tea_specify");
			String tea_peoples = request.getParameter("tea_peoples");
			JSONArray peopleList = JSONArray.fromObject(request.getParameter("tea_peoList"));
			dao.commOper("update teacher set t_name = '"+ tea_name+"', t_summary = '"+ tea_summary+"', t_date = '"+ tea_date+"', t_address = '"+ tea_address+"', t_department = '"+ tea_department+"', t_specifying = "+ tea_specify+", t_persons = "+ tea_peoples+", t_course_type = '"+ tea_course_type+"' where t_id = " + tea_id);
			dao.commOper("update specify set s_isdel = 1 where s_activityid = " + tea_id);
			ArrayList<String> sqlList = new ArrayList<String>();
			//判断是否指定参与人
			if( tea_specify.equals("1") && peopleList.size() > 0){
				for(int i=0;i<peopleList.size();i++){
					sqlList.add("insert into specify(s_userid, s_activityid, s_status, s_date, s_isdel) values("+ peopleList.getInt(i)+","+ tea_id+", 0, now(), 0)");
				}
				//根据指定的人数插入指定表
				dao.commOper("update teacher set t_persons = "+ peopleList.size()+" where t_id = " + tea_id);
				//更新活动的人数
				dao.commOperSqls(sqlList);
			}
			map.put("status", "success");
			jsonObject = JSONObject.fromObject(map);	
			response.getWriter().println(jsonObject.toString());
		}
		//删除活动
		else if (type.equals("delTeacher")){
			String teacher_id =  request.getParameter("teacher_id");			
			dao.commOper("update teacher set isdel= 1 where t_id=" + teacher_id);
			dao.commOper("update specify set s_isdel= 1 where s_activityid=" + teacher_id);
			map.put("status", "success");
			jsonObject = JSONObject.fromObject(map);	
			response.getWriter().println(jsonObject.toString());
		}
		//推荐课程或教师
		else if (type.equals("recommend")){
			String recType = request.getParameter("recType");
			String id =  request.getParameter("id");
			if (recType.equals("course"))
				dao.commOper("update course set isrec= 1 where c_id=" + id);
			else
				dao.commOper("update teacher set isrec= 1 where t_id=" + id);
			map.put("status", "success");
			jsonObject = JSONObject.fromObject(map);	
			response.getWriter().println(jsonObject.toString());
		}
		//取消推荐课程或教师
		else if (type.equals("cancel")){
			String recType = request.getParameter("recType");
			String id =  request.getParameter("id");
			if (recType.equals("course"))
				dao.commOper("update course set isrec= 0 where c_id=" + id);
			else
				dao.commOper("update teacher set isrec= 0 where t_id=" + id);
			map.put("status", "success");
			jsonObject = JSONObject.fromObject(map);	
			response.getWriter().println(jsonObject.toString());
		}
		//报名管理
		else if (type.equals("signup")){
			String aId = request.getParameter("a_id");
			String sql = "select s.*,u.user_realname,u.user_phone,u.user_department,t.t_name from signup s LEFT JOIN users u on s.s_user_id=u.user_id LEFT JOIN teacher t on s.s_course_id = t.t_id where s.isdel=0 and u.isdel = 0 and t.isdel = 0";
			if( aId != null )
				sql += " and s.s_course_id = " + aId;
			ArrayList<HashMap> list = (ArrayList<HashMap>)dao.select(sql);			
			response.getWriter().println(JSONArray.fromObject(list));
		}
		//验票
		else if (type.equals("confirmsignup")){
			String s_id = request.getParameter("s_id"); //报名编号
			dao.commOper("update signup set s_status=1,s_attenddate=now() where s_id=" + s_id);
			map.put("status", "success");
			jsonObject = JSONObject.fromObject(map);
			response.getWriter().println(jsonObject.toString());
		}
		//参会管理
		else if (type.equals("attended")){
			String aId = request.getParameter("a_id");
			String sql = "select s.*,u.user_realname,u.user_phone,u.user_department,t.t_name from signup s LEFT JOIN users u on s.s_user_id=u.user_id LEFT JOIN teacher t on s.s_course_id = t.t_id where s.isdel=0 and u.isdel = 0 and t.isdel = 0 and s.s_status = 1";
			if( aId != null )
				sql += " and s.s_course_id = " + aId;
			ArrayList<HashMap> list = (ArrayList<HashMap>)dao.select(sql);			
			response.getWriter().println(JSONArray.fromObject(list));
		}
		//活动统计
		else if (type.equals("activityStatistics")){
			String sql = "select t.t_id, t.t_name, IFNULL(s.s_course_id,0) as s_course_id, IFNULL(s.signup,0) as signup, IFNULL(s.attend,0) as attend from teacher t left join ( select s_course_id, count(1) as signup,sum(case when s_status = 1 then 1 else 0 end) as attend from signup where isdel = 0 GROUP BY s_course_id ) as s ON t.t_id = s.s_course_id where t.isdel = 0";
			ArrayList<HashMap> list = (ArrayList<HashMap>)dao.select(sql);			
			response.getWriter().println(JSONArray.fromObject(list));
		}
//		//发布成绩
//		else if (type.equals("publishscore")){
//			String s_id = request.getParameter("s_id"); //报名编号
//			String score = request.getParameter("score"); //报名编号
//			dao.commOper("update signup set s_status=2,s_score="+score+" where s_id=" + s_id);
//			map.put("status", "success");
//			jsonObject = JSONObject.fromObject(map);
//			response.getWriter().println(jsonObject.toString());
//		}
		//咨询问题
		else if (type.equals("question")){
			int limit = Integer.parseInt(request.getParameter("limit")); //每页显示条数
			int offset = Integer.parseInt(request.getParameter("offset")); //开始数
			String search =  request.getParameter("search");
			if (search == null) search = ""; //判断是否为空
			String sql = "select f.*,u.user_realname,u.user_phone from forum f LEFT JOIN users u on f.f_user_id=u.user_id where 1=1 and f.f_qtype=1 and f.isdel=0 and f_content like '%"+search+"%'";
			ArrayList<HashMap> list = (ArrayList<HashMap>)dao.select(SqlPageSQL.getPageMySQL(sql,offset + 1, limit));			
			int total = dao.getInt("select count(*) from forum f LEFT JOIN users u on f.f_user_id=u.user_id where 1=1 and f.f_qtype=1 and f.isdel=0 and f_content like '%"+search+"%'");
			map.put("total", total);
			map.put("rows", list);
			jsonObject = JSONObject.fromObject(map);
			response.getWriter().println(jsonObject.toString());
		}
		//咨询问题回复
		else if (type.equals("reply")){
			String f_id = request.getParameter("f_id"); //每页显示条数
			String reply = request.getParameter("question_reply"); //每页显示条数
			dao.commOper("update forum set f_status='已回复',f_reply='"+reply+"',f_reply_date=now() where f_id=" + f_id);
			map.put("status", "success");
			jsonObject = JSONObject.fromObject(map);
			response.getWriter().println(jsonObject.toString());
		}
		else
			doGet(request, response);//转到Get
	 }
  }

