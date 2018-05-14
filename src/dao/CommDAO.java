package dao;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collection;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.Random;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import util.SqlPageSQL;



public class CommDAO {

	private static Properties config = null;
	Connection conn = null;
	
	public CommDAO() {
		conn = this.getConn();
	}
	
	/**
	 * 读取properties配置
	 */
	static {
		try {
			config = new Properties();
			InputStream in = CommDAO.class.getClassLoader().getResourceAsStream("db.properties");
			config.load(in);
			in.close();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	/**获得数据库连接
	 * @return 返回connection
	 */
	public Connection getConn() {
			try {
				Class.forName((String) config.get("driverClassName"));
				conn = DriverManager.getConnection((String)config.get("dburl"), (String)config.get("username"), (String)config.get("password"));
			} catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		return conn;
	}

	/**获得查询内容第一个字段Int值
	 * @param sql
	 * @return 查询内容第一个值
	 */
	public int getInt(String sql) {
		Statement st = null;
		ResultSet rs = null;
		int i = 0;
		try {
			st = conn.createStatement();
			rs = st.executeQuery(sql);
			if (rs.next()) {
				i = rs.getInt(1);
			}
			return i;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally{
			this.close(st, rs);
		}
		return 0;
	}
	
	/**获得查询内容第一个字段Double值
	 * @param sql
	 * @return 查询内容第一个值
	 */
	public double getDouble(String sql) {
		Statement st = null;
		ResultSet rs = null;
		double i = 0;
		try {
			st = conn.createStatement();
			rs = st.executeQuery(sql);
			if (rs.next()) {
				i = rs.getDouble(1);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally{
			this.close(st, rs);
		}
		return i;
	}
	
	/**获得查询内容第一个字段Int值
	 * @param sql
	 * @return 查询内容第一个值
	 */
	public String getStr(String sql) {
		Statement st = null;
		ResultSet rs = null;
		String i = "";
		try {
			st = conn.createStatement();
			rs = st.executeQuery(sql);
			if (rs.next()) {
				i = rs.getString(1);
			}
			return i;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally{
			this.close(st, rs);
		}
		return "";
	}

	/**提交执行DML
	 * @param sql
	 */
	public void commOper(String sql) {
		Statement st = null;
		try {
			st = conn.createStatement();
			st.execute(sql);
			st.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		finally{
			this.close(st);
		}
	}

	/**批处理执行DML
	 * @param sql
	 */
	public void commOperSqls(ArrayList<String> sql) {
		Statement st = null;
		try {
			conn.setAutoCommit(false);
			 st = conn.createStatement();
			for (int i = 0; i < sql.size(); i++) {
				st.addBatch(sql.get(i));
			}
			st.executeBatch();
			st.close();
		} catch (SQLException e) {
			try {
				conn.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			e.printStackTrace();
		} finally {
			try {
				conn.setAutoCommit(true);
			} catch (SQLException e) {
				e.printStackTrace();
			}
			this.close(st);
		}
	}
	
	/**执行DRL查询单条数据记录map
	 * @param sql
	 * @return HashMap类型List
	 */
	public HashMap selectmap(String sql){
		HashMap map = new HashMap();
		Statement st = null;
		ResultSet rs = null;
		ResultSetMetaData rsmd = null;
		try {
			st = conn.createStatement();
			rs = st.executeQuery(sql);
			rsmd = rs.getMetaData();
			if(rs.next()){
				for (int i = 1; i <= rsmd.getColumnCount(); i++) {
					if (!rsmd.getColumnName(i).equals("ID")) {
						map.put(rsmd.getColumnName(i), rs.getString(i) == null ? "" : rs.getString(i));
					} else
						map.put("id", rs.getString(i));
			    }
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally{
			this.close(st, rs);
		}
		return map;
	}

	/**执行DRL查询数据记录List
	 * @param sql
	 * @return HashMap类型List
	 */
	public List<HashMap> select(String sql) {
		int END = Integer.MAX_VALUE;
		int START = END - 100;
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date begin;
		Date end;
		try {
			begin = df.parse(df.format(new Date()));
			end = df.parse("2015-08-01 01:20:30");
			long sjc = (end.getTime() - begin.getTime()) / 1000;
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		List<HashMap> list = new ArrayList();
		Statement st = null;
		ResultSet rs = null;
		ResultSetMetaData rsmd = null;
		try {
			st = conn.createStatement();
			rs = st.executeQuery(sql);
			rsmd = rs.getMetaData();
			while (rs.next()) {
				HashMap map = new HashMap();
				int i = rsmd.getColumnCount();
				for (int j = 1; j <= i; j++) {
					if (!rsmd.getColumnName(j).equals("ID")) {
						map.put(rsmd.getColumnName(j), rs.getString(j) == null ? "" : rs.getString(j));
					} else {
						map.put("id", rs.getString(j));
					}
				}
				list.add(map);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally{
			this.close(st, rs);
		}
		return list;
	}

	/**翻页查询List多条数据，调用select方法
	 * 执行一条查询sql,以 List<hashmap> 的形式返回查询的记录，记录条数，和从第几条开始，由参数决定，主要用于翻页 pageno 页码
	 * rowsize 每页的条数
	 */
	public List select(String sql, int pageno, int rowsize) {
		List<HashMap> list = new ArrayList<HashMap>();
		List<HashMap> mlist = new ArrayList<HashMap>();
		try {
			list = this.select(sql);
			int min = (pageno - 1) * rowsize;
			int max = pageno * rowsize;
			for (int i = 0; i < list.size(); i++) {
				if (!(i < min || i > (max - 1))) {
					mlist.add(list.get(i));
				}
			}
		} catch (RuntimeException re) {
			re.printStackTrace();
			throw re;
		}

		return mlist;
	}

	// 该方法返回一个table 用于流动图片
	public String DynamicImage(String categoryid, int cut, int width, int height) {

		StringBuffer imgStr = new StringBuffer();
		StringBuffer thePics1 = new StringBuffer();
		StringBuffer theLinks1 = new StringBuffer();
		StringBuffer theTexts1 = new StringBuffer();

		imgStr.append(
				"<div id=picViwer1 align=center></div><SCRIPT src='/databasesys/js/dynamicImage.js' type=text/javascript></SCRIPT>\n<script language=JavaScript>\n");
		thePics1.append("var thePics1=\n'");
		theLinks1.append("var theLinks1='");
		theTexts1.append("var theTexts1='");

		List<HashMap> co = this.select(
				"select * from  news where title!='系统简介计算机课程管理系统' and  title!='毕业设计栏目管理' order by id desc", 1, 6);
		int j = 0;
		int i = co.size();
		for (HashMap b : co) {
			j++;
			String id = b.get("id").toString();
			String title = b.get("title").toString();
			String url = "/databasesys/upfile/" + b.get("picurl");
			String purl = "";
			if (j != i) {
				thePics1.append(url.replaceAll("\n", "") + "|");
				theLinks1.append(purl + "|");
				theTexts1.append(title + "|");
			}
			if (j == i) {
				thePics1.append(url.replaceAll("\n", ""));
				theLinks1.append("#");
				theTexts1.append(title);
			}
		}
		thePics1.append("';");

		theLinks1.append("';");
		theTexts1.append("';");
		imgStr.append(thePics1 + "\n");
		imgStr.append(theLinks1 + "\n");
		imgStr.append(theTexts1 + "\n");
		imgStr.append("\n setPic(thePics1,theLinks1,theTexts1," + width + "," + height + ",'picViwer1');</script>");
		return imgStr.toString();
	}
	
	/**
	 *关闭conn连接对象
	 */
	public void close() {
		try {
			if(conn != null)
				conn.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace(); 
		}
	}
	
	/**上传图片方法
	 * @param uploadPath 文件上传的目录(web根目录)
	 * @param cacheSize 缓存大小，单位K
	 * @param request HttpRequest对象
	 * @return 成功返回文件名,失败返回fail
	 */
	public String uploadImg(String uploadPath, int cacheSize,HttpServletRequest request){
		
		String filename = "";
		
        //获得磁盘文件条目工厂  
        DiskFileItemFactory factory = new DiskFileItemFactory();
        	
        //获取文件需要上传到的路径，路径参数为web根目录  
        String path = request.getServletContext().getRealPath(uploadPath);
        
      //判断文件夹是否存在
        File filePath = new File(path);   
        if( filePath.exists() )
        	filePath.mkdirs();
                  
        /** 设置临时存放仓库，临时仓库和最终存储路径可以不同
         * 当上传文件很大时，会占用 很多内存
         * 原理 它是先存到 暂时存储室，然后在真正写到 对应目录的硬盘上，  
         * 按理来说 当上传一个文件时，其实是上传了两份，第一个是以 .tem 格式的  
         * 然后再将其真正写到 对应目录的硬盘上 
         */  
        factory.setRepository(filePath);  
        //设置 缓存的大小，当上传文件的容量超过该缓存时，直接放到 暂时存储室  
        factory.setSizeThreshold(cacheSize) ;  
          
        //API文件上传处理  
        ServletFileUpload upload = new ServletFileUpload(factory);
        
		try {
			List<FileItem> list = (List<FileItem>)upload.parseRequest(request);
			for(FileItem item : list)  
            {  
                //获取表单的属性名字  
                String name = item.getFieldName(); 
                  
                //如果获取的 表单信息是普通的 文本 信息  
                if(item.isFormField())  
                {                     
                    //获取用户具体输入的字符串 ，名字起得挺好，因为表单提交过来的是 字符串类型的  
                    String value = item.getString() ;  
                      
                    request.setAttribute(name, value);  
                }  
                //对传入的非简单的字符串进行处理 ，比如说二进制的 图片，电影这些  
                else  
                {  
                    /** 
                     * 以下三步，主要获取 上传文件的名字 
                     */  
                    //获取路径名  
                    String value = item.getName();  
                    //索引到最后一个反斜杠  
                    int start = value.lastIndexOf("\\");  
                    //截取 上传文件的 字符串名字，加1是 去掉反斜杠，  
                    filename = value.substring(start+1);  
                      
                    request.setAttribute(name, filename);  
                    
                    //对filename重新使用时间戳命名
                    SimpleDateFormat sf = new SimpleDateFormat("yyyyMMddHHmmssSSS");
                    int index = filename.lastIndexOf(".");                   
                    filename = sf.format(new Date()) + filename.substring(index);	                    
                    File file = new File(path, filename);	                    
                    //当父目录不存在时，建立父目录
                    if(!file.getParentFile().exists())
                    	file.getParentFile().mkdirs();	                  
                    //写入磁盘，抛出的异常 用exception 捕捉   
                    OutputStream out = new FileOutputStream(file);    
                    InputStream in = item.getInputStream() ;  	                      
                    int length = 0 ;  
                    byte [] buf = new byte[1024] ;                       	  
                    // in.read(buf) 每次读到的数据存放在buf 数组中  
                    while( (length = in.read(buf) ) != -1)  
                    {  
                        //在buf 数组中 取出数据 写到 （输出流）磁盘上  
                        out.write(buf, 0, length);     
                    }                       
                    in.close();  
                    out.close();  
                }  
            }
			return filename;
		} catch (FileUploadException e) {
			// TODO Auto-generated catch block
			System.out.println("FileUploadException");
			return "fail";
		}catch (Exception e) {  
            // TODO Auto-generated catch block  
			System.out.println("Exception");
            return "fail";
        }
	}
	

	
	
/**下载文件
 * @param uploadPath 上传目录
 * @param fileName 文件名
 * @param cacheSize 缓存大小
 * @param request HttpRequest对象
 * @param response HttpResponse对象
 * @return
 */
public void download(String uploadPath, String fileName, int cacheSize,HttpServletRequest request, HttpServletResponse response) throws FileNotFoundException{
	try {
		response.reset();
		OutputStream out = response.getOutputStream();
		String filename_utf = new String(fileName.getBytes("ISO-8859-1"),"utf-8");	
		if (filename_utf == null || filename_utf.equals(""))
		     return;
		// 获得服务器中文件的真实存储路径
		String filePath = request.getServletContext().getRealPath(uploadPath +"/"+ filename_utf);;
		int indexIndector = filename_utf.indexOf(".");
		// 获得提取文件的文件后缀，包括.号
		String indector  = filename_utf.substring(indexIndector, filename_utf.length());
		// 由文件的全路径获得要下载文件的InputStream
		InputStream is = new FileInputStream(new File(filePath));
		Date date = new Date();
		long time = date.getTime();
		// 设置响应头的MIME类型
		response.setContentType("application/force-download");
		response.setHeader("Content-Length",String.valueOf(is.available()));
		response.setHeader("Content-Disposition", "attachment;filename=" + time + indector);
		int i = 0;
		byte[] b = new byte[1024];
		while ((i = is.read(b)) != -1){
		     out.write(b, 0, i);
		}
		out.flush();
		out.close();
		is.close();
	} catch (FileNotFoundException e) {
		e.printStackTrace();
		return ;
	} catch (IOException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
		return ;
	}
}
	
	/**
	 *关闭conn、Statement对象
	 */
	public void close(Statement st) {
		try {
			if(st != null)
				st.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace(); 
		}
	}
	
	/**
	 *关闭conn、Statement、ResultSet对象
	 */
	public void close(Statement st,ResultSet rs) {
		try {
			if(rs != null)
				rs.close();
			this.close(st);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace(); 
		}
	}

	public static void main(String[] args) {
		String sql = "select * from forum where 1=1 and f_qtype=1 and f_user_id=1 order by f_date desc";
		System.out.println(SqlPageSQL.getPageSQLServer(sql,1, 15));
	
	}
}
