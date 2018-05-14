// Decompiled by Jad v1.5.7g. Copyright 2000 Pavel Kouznetsov.
// Jad home page: http://www.geocities.com/SiliconValley/Bridge/8617/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi 
// Source File Name:   MD5.java

package util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.regex.Matcher;
import java.util.regex.Pattern;


public class StrUtil {
	private static int idSequence=10000;
	
	public static String checkStr(Object obj) {
		if(obj==null){
			return "";
		}else{
			return obj.toString();
		}		
	}
	
	public synchronized static String generalSrid() {
		StringBuffer ret = new StringBuffer(20);		
		ret.append(StrUtil.getFormatDate("yyyyMMddHHmmss"));		
		idSequence++;
		if(idSequence>20000)
		  idSequence-=10000;
		ret.append(String.valueOf(idSequence).substring(1));
		//System.out.println("生成ID="+ret);
		return ret.toString();
	}
	public static String generalFileName(String srcFileName) {
		try{
		   int index=srcFileName.lastIndexOf(".");
		   return StrUtil.generalSrid()+srcFileName.substring(index).toLowerCase();
		}catch(Exception e){
			return StrUtil.generalSrid();
		}
	}
	public static String parseOS(String agent) {
		
		String system="Other";
		if(agent.indexOf("Windows NT 5.2")!=-1) 
			system="Win2003";
		else if(agent.indexOf("Windows NT 5.1")!=-1) 
			system="WinXP";
		else if(agent.indexOf("Windows NT 5.0")!=-1) 
			system="Win2000";
		else if(agent.indexOf("Windows NT")!=-1) 
			system="WinNT";
		else if(agent.indexOf("Windows 9")!=-1) 
			system="Win9x";
		else if(agent.indexOf("unix")!=-1) 
			system="unix";
		else if(agent.indexOf("SunOS")!=-1) 
			system="SunOS";
		else if(agent.indexOf("BSD")!=-1) 
			system="BSD";
		else if(agent.indexOf("linux")!=-1) 
			system="linux";
		else if(agent.indexOf("Mac")!=-1) 
			system="Mac";
		else
			system = "Other";		
	    return system;
	}
	
	/**
	 * 得到当前日期的格式化字符串
	 * 
	 * @param formatString
	 * 如：yyyy(年)-MM(月)-dd(日)-HH(时)-mm(分)-ss(秒)-SSS(毫秒)
	
	 * @return 格式化过的当前日期字符串
	 */
	public static String getFormatDate(String formatString) {
		Date now =new Date(System.currentTimeMillis());
		SimpleDateFormat sdf=new SimpleDateFormat(formatString);
		String ret=sdf.format(now);
		return ret;
	}	
	/**
	 * @param 无
	 * @return 当前日期
	 */
	public static Date getCurrentDate() {
		Date now =new Date(System.currentTimeMillis());
		return now;
	}
	/**
	 * 将格式化的日期字符串转换为日期。
	 * 
	 * @param formatString
	 * 如：yyyy(年)-MM(月)-dd(日)-HH(时)-mm(分)-ss(秒)-SSS(毫秒)
	
	 * @return 字符串转换后的日期。
	 */
	public static Date formatDate(String dateString) {
		try {
			SimpleDateFormat sdf=new SimpleDateFormat();	
			Date date=sdf.parse(dateString);
			return date;
		} catch (ParseException e) {			
			return new Date();
		}		
	}
	public static String nowdate(){
		 SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");//设置日期格式
	      return df.format(new Date());// new Date()为获取当前系统时间
	}
	
	public static int parseInt(String numberStr) {
		//Pattern pattern=Pattern.compile("[0-9]*");
		//Pattern pattern=Pattern.compile("^[\\-\\d][0-9]*[\\.]{0,1}[0-9]+$");
		if(numberStr==null)
			return 0;
		Pattern pattern=Pattern.compile("^[\\-]{0,1}[0-9]+$");
		Matcher matcher = pattern.matcher(numberStr);
		if(matcher.find()){
			return Integer.parseInt(numberStr);
		}else{
			return 0;
		}			
	}
	
	 /** 计算两个日期（yyyy-MM-dd）之间间隔天数
     * @param smdate date
     * @param bdate date
     * @return 返回天数
     * @throws ParseException
     */
    public static int daysBetween(Date smdate,Date bdate) throws ParseException    
    {    
        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");  
        smdate=sdf.parse(sdf.format(smdate));  
        bdate=sdf.parse(sdf.format(bdate));  
        Calendar cal = Calendar.getInstance();    
        cal.setTime(smdate);    
        long time1 = cal.getTimeInMillis();                 
        cal.setTime(bdate);    
        long time2 = cal.getTimeInMillis();
        long between_days;
        if( time1 <= time2)
        	between_days=(time2-time1)/(1000*3600*24); 
        else
        	between_days=(time1-time2)/(1000*3600*24);          
       return Integer.parseInt(String.valueOf(between_days));           
    }
    
    /** 计算两个时间(yyyy-MM-dd HH:mm:ss)之间间隔天数
     * @param smdate date
     * @param bdate date
     * @return 返回天数
     * @throws ParseException
     */
    public static int dateBetween(Date smdate,Date bdate) throws ParseException    
    {    
        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");  
        smdate=sdf.parse(sdf.format(smdate));  
        bdate=sdf.parse(sdf.format(bdate));  
        Calendar cal = Calendar.getInstance();    
        cal.setTime(smdate);    
        long time1 = cal.getTimeInMillis();                 
        cal.setTime(bdate);    
        long time2 = cal.getTimeInMillis();
        double between_days;
        if( time1 <= time2)
        	between_days=((time2-time1)/(double)(1000*3600*24)); 
        else
        	between_days=((time1-time2)/(double)(1000*3600*24)); 
       return (int) Math.ceil(between_days);           
    }
    
    
    /**生成日历
     * @param fDate 字符串日期
     * @param sDate 字符串日期
     * @return 返回日期格式的List
     */
    public static ArrayList<String> genCalendar(String fDate, String sDate){
    	ArrayList<String>  calendarList = new ArrayList<String> ();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");  
        try {
			Date fTime = sdf.parse(fDate);
			Date sTime = sdf.parse(sDate);
			int interval = daysBetween(fTime, sTime);
			Calendar calendar = new GregorianCalendar();
			//判断哪个时间最小，以最小的时间做日历起点
			fTime = (fTime.before(sTime) ? fTime : sTime);
			calendarList.add(sdf.format(fTime));
			calendar.setTime(fTime); //将日期转化为日历       
            for( int i = 0; i < interval; i++ ){
            	calendar.add(Calendar.DAY_OF_MONTH, 1);//获得当前日期后一天日期
                fTime = calendar.getTime();
                calendarList.add(sdf.format(fTime));
            }          
		} catch (ParseException e) {
			e.printStackTrace();
		}  //将字符串转化为指定的日期格式 
        return calendarList;
    }
   
}
