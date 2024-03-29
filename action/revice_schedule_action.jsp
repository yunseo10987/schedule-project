<%@ page language="java" contentType = "text/html" pageEncoding="utf-8"%>
<%@ page import="java.sql.DriverManager"%> 
<%@ page import ="java.sql.Connection"%> 
<%@ page import="java.sql.PreparedStatement"%> 
<%@ page import="java.sql.ResultSet" %> 
<%@ page import ="java.util.regex.*"%>
<%@ page import = "java.util.ArrayList" %>

<%
    request.setCharacterEncoding("utf-8");

    String idxValue = null;
    String yearValue = null;
    String monthValue = null;
    String hourValue = null;
    String minuteValue = null;
    String textValue = null;

    try{
        session = request.getSession();
        String accountIdx = (String)session.getAttribute("idx");
        if(accountIdx == null){
            response.sendRedirect("../page/login_page.jsp");
        }
        yearValue = request.getParameter("year_value");
        monthValue = request.getParameter("month_value");
        idxValue = request.getParameter("idx_value");
        hourValue = request.getParameter("hour_value");
        minuteValue = request.getParameter("minute_value");
        textValue = request.getParameter("text_value");

        if(Integer.valueOf(hourValue) > 24 || Integer.valueOf(hourValue) < 0){
            throw new Exception();
        }
        if(Integer.valueOf(minuteValue) >59 || Integer.valueOf(minuteValue) < 0){
            throw new Exception();
        }
        if(textValue.length() < 0 || textValue.length() > 100){
            throw new Exception();
        }

        
        Class.forName("com.mysql.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/schedule_web","stageus","1234"); 

        
        String sql = "UPDATE schedule SET hour=?, minute=?, content=? WHERE idx =?"; 
        PreparedStatement query = conn.prepareStatement(sql); 
    
        query.setString(1, hourValue);
        query.setString(2, minuteValue);
        query.setString(3, textValue);
        query.setString(4, idxValue);
    
        query.executeUpdate(); 
        
    }
    catch(Exception e){
        response.sendRedirect("../page/error_page.jsp");
    }   
%>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    <script>
        window.onload = function () {            
            location.href= "../page/main_page.jsp?" + "yearValue=" + <%=yearValue%> + "&monthValue=" + <%=monthValue%>
        }        
    </script>
</body>