<%@ page language="java" contentType = "text/html" pageEncoding="utf-8"%>
<%@ page import="java.sql.DriverManager"%> 
<%@ page import ="java.sql.Connection"%> 
<%@ page import="java.sql.PreparedStatement"%> 

<%
    request.setCharacterEncoding("utf-8"); 
    
    String yearValue = null;
    String monthValue = null;
    String dayValue = null;
    String hourValue = null;
    String minuteValue = null;
    String textValue = null;
    boolean error = false;

    try{
        session = request.getSession();
        String accountIdx = (String)session.getAttribute("idx");
        if(accountIdx == null){
            response.sendRedirect("login_page.jsp");
        }  
        yearValue = request.getParameter("year_value");
        monthValue = request.getParameter("month_value");
        dayValue = request.getParameter("day_value");
        hourValue = request.getParameter("hour_value");
        minuteValue = request.getParameter("minute_value");
        textValue = request.getParameter("text_value");
        if(Integer.valueOf(yearValue) > 2199 || Integer.valueOf(yearValue) < 1901){
            error = true;
        }
        if(Integer.valueOf(monthValue) > 12 || Integer.valueOf(monthValue) < 1){
            error = true;
        }
        if(Integer.valueOf(dayValue) < 1 || Integer.valueOf(dayValue) >31){
            error = true;
        }
        if(Integer.valueOf(hourValue) > 24 || Integer.valueOf(hourValue) < 0){
            error = true;
        }
        if(Integer.valueOf(minuteValue) >59 || Integer.valueOf(minuteValue) < 0){
            error = true;
        }
        if(textValue.length() < 0 || textValue.length() > 100){
            error = true;
        }

        if(!error){
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/schedule_web","stageus","1234"); 

            
            String sql = "INSERT INTO schedule(year, month, day, hour, minute, content, writer) VALUES(?, ?, ?,?, ?, ?,?)"; 
            PreparedStatement query = conn.prepareStatement(sql); 
            
            query.setString(1, yearValue);
            query.setString(2, monthValue);
            query.setString(3, dayValue);
            query.setString(4, hourValue);
            query.setString(5, minuteValue);
            query.setString(6, textValue);
            query.setString(7, accountIdx);
                
            query.executeUpdate();

        }
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
        var error = <%=error%>
        if(!error){
            location.href= "../page/main_page.jsp?yearValue=<%=yearValue%>&monthValue=<%=monthValue%>"
        }
        else{
            alert("작성 실패하였습니다")
            location.href= "../page/main_page.jsp?yearValue=<%=yearValue%>&monthValue=<%=monthValue%>"
        }
        
    </script>
</body>