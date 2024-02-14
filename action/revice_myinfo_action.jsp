<%@ page language="java" contentType = "text/html" pageEncoding="utf-8"%>
<%@ page import="java.sql.DriverManager"%> 
<%@ page import ="java.sql.Connection"%> 
<%@ page import="java.sql.PreparedStatement"%> 
<%@ page import="java.sql.ResultSet" %> 
<%@ page import ="java.util.regex.*"%>
<%@ page import = "java.util.ArrayList" %>

<%
    request.setCharacterEncoding("utf-8");

    String pwValue = null;
    String nameValue = null;
    String telValue = null;
    try{
        session = request.getSession();
        String accountIdx = (String)session.getAttribute("idx");
        if(accountIdx == null){
            response.sendRedirect("../page/login_page.jsp");
        }

        pwValue = request.getParameter("pw_value");
        nameValue = request.getParameter("name_value");
        telValue = request.getParameter("tel_value");
        if(!Pattern.matches("^(?=.*[a-zA-z])(?=.*[0-9])(?=.*[$`~!@[$]!%*#^?&\\(\\)-_=+]).{8,16}$", pwValue)){
            throw new Exception();
        }
        if(nameValue.length() > 12 || nameValue.length() < 1){
            throw new Exception();
        }
        if(!Pattern.matches("^\\d{3}-\\d{3,4}-\\d{4}$", telValue)){
            throw new Exception();
        }
       
        Class.forName("com.mysql.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/schedule_web","stageus","1234"); 

        
        String sql = "UPDATE account SET password=?, name=?, tel_number=? WHERE idx =?"; 
        PreparedStatement query = conn.prepareStatement(sql); 
    
        query.setString(1, pwValue);
        query.setString(2, nameValue);
        query.setString(3, telValue);
        query.setString(4, accountIdx);
    
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
            alert("회원정보가 수정되었습니다.")
            location.href= "../page/myinfo_page.jsp"
        }        
    </script>
</body>