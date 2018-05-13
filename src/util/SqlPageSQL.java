package util;

public class SqlPageSQL {
	/**
	 *@param sql sql语句
	 *@param curPage 当前页
	 *@param rowsPerPage 每页显示 
	 
	// SqlServer分页
	public static String getPageSQLServer(String sql,int curPage,int rowsPerPage){
		String afterFrom = sql.toLowerCase().substring(sql.indexOf("from"));
		String pageSql = null;
		if(afterFrom.indexOf("where")==-1)
			 pageSql = "select top "+ rowsPerPage + " * "+afterFrom
			+" where id not in(select top "+rowsPerPage*(curPage-1)+" id "
			+afterFrom+" order by id desc)"+"order by id desc";
		else
			pageSql = "select top "+ rowsPerPage + " * "+afterFrom
			+" and id not in(select top "+rowsPerPage*(curPage-1)+" id "
			+afterFrom+" order by id desc)"+"order by id desc";
		
		return pageSql;
	}
	*/
	//Sqlserver分页
	/** 分页查询sqlserver
	 * @param sql sql语句
	 * @param offset 开始数
	 * @param limit 每页限制条数
	 * @return
	 */
	public static String getPageSQLServer(String sql,int offset,int limit){
		String pageSql = null;
		pageSql = "select * from (select row_number()over(order by tempcolumn) temprownumber, * from (select top "
		+ (offset + limit) +" tempcolumn=0, * from ("+ sql +")as t1) t2) t3 where temprownumber > "
		+ offset;
		return pageSql;
	}
	
	//MySql分页
	public static String getPageMySQL(String sql,int curPage,int rowsPerPage){
		String pageSql = sql+" limit "+ (curPage - 1)*rowsPerPage+","+rowsPerPage;
		return pageSql;
	}
	
	//Oracle分页
	/** Oracle分页
	 * @param sql ��ѯ��SQL���
	 * @param curPage ��ǰҳ
	 * @param rowsPerPage ÿҳ��ʾ�ļ�¼����
	 * @return ���ز�ѯSQL
	 */
	public static String getPageOracle(String sql,int curPage,int rowsPerPage){
		int begin = (curPage-1)*rowsPerPage;
		int end = begin + rowsPerPage;
		StringBuffer pagingSelect = new StringBuffer(200);
		pagingSelect.append("select * from ( select row_.*, rownum rownum_ from ( ");
		pagingSelect.append(sql);
		pagingSelect.append(" ) row_ where rownum <= "+end+") where rownum_ > "+begin);
		return pagingSelect.toString();
	}
	public static void main(String[] args){
		String sql = getPageOracle("select * from diary where user_id=1",1,10);
		System.out.print(sql);
	}
}
