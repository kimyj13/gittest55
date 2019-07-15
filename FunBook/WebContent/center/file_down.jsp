<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.File"%>
<%@ page import="java.io.*"%>
<%@ page import="com.oreilly.servlet.ServletUtils"%>


<%
	request.setCharacterEncoding("utf-8");

    String fileName = request.getParameter( "file_name" );
	 System.out.println(fileName);
     String savePath = "upload";
     ServletContext context = getServletContext();
     String sDownloadPath = context.getRealPath(savePath);
     String sFilePath = sDownloadPath + "\\" + fileName; // 물리적인 경로\\파일이름

   byte b[] = new byte[4096];
   File oFile = new File(sFilePath);//자바내장API// 파일 제어
  


   FileInputStream in = new FileInputStream(oFile); //파일 읽어옴

   String sMimeType = getServletContext().getMimeType(sFilePath);
	System.out.println("sMimeType>>>"+sMimeType );

   // octet-stream은  8비트로 된 일련의 데이터를 뜻합니다. 지정되지 않은 파일 형식을 의미합니다.
 
   if(sMimeType == null) sMimeType = "application/octet-stream";  //모르는 타입이면 타입을 변경함



   response.setContentType(sMimeType);

   //-----한글처리-----
   String userAgent = request.getHeader("User-Agent");
   boolean ie = (userAgent.indexOf("MSIE") > -1)|| (userAgent.indexOf("Trident") > -1); //익스플로, 크롬 등 판별
   String sEncoding=null;
   if(ie) {
	  sEncoding = URLEncoder.encode(fileName, "utf-8").replaceAll("\\+", "%20");
	  System.out.println(sEncoding);
   }else{
	  sEncoding = new String(fileName.getBytes("utf-8"),"8859_1");
	  System.out.println(sEncoding);
  }
   
  
   //한글 업로드 (이 부분이 한글 파일명이 깨지는 것을 방지해 줍니다.)
//    String sEncoding = new String(fileName.getBytes("utf-8"),"8859_1");
 //  System.out.println(sEncoding);

   response.setHeader("Content-Disposition", "attachment; filename= " + sEncoding);//무조건 첨부파일 다운 받게끔 설정
   
   ServletOutputStream out2 = response.getOutputStream(); //읽어온거 출력???? 화면상에 뿌려준다고함-_-롸?
   int numRead;

   // 바이트 배열b의 0번 부터 numRead번 까지 브라우저로 출력
   while((numRead = in.read(b, 0, b.length)) != -1) {
    out2.write(b, 0, numRead);
   }
   out2.flush(); 
   out2.close();
   in.close();

   out.clear();
	out = pageContext.pushBody();
 //  ServletUtils.returnFile( PdsMisc.UPLOAD_DIRECTORY + File.separator + StringMisc.uniToEuc( fileName ), response.getOutputStream() );
%>
