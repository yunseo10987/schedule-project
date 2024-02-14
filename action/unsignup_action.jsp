<%@ page language="java" contentType = "text/html" pageEncoding="utf-8"%>
<%@ page import="java.sql.DriverManager"%> 
<%@ page import ="java.sql.Connection"%> 
<%@ page import="java.sql.PreparedStatement"%> 
<%@ page import="java.sql.ResultSet" %> 


<%  
    try{
        request.setCharacterEncoding("utf-8"); 
        session = request.getSession();
        String accountIdx = (String)session.getAttribute("idx");
        if(accountIdx == null){
            response.sendRedirect("../page/login_page.jsp");
        }

        Class.forName("com.mysql.jdbc.Driver"); 
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/schedule_web","stageus","1234"); //db 주소 포트번호, 계정

        String sql = "DELETE FROM account WHERE idx = ?"; 
        PreparedStatement query = conn.prepareStatement(sql); 
        query.setString(1, accountIdx);
        
        query.executeUpdate(); 
        session.invalidate();
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
        alert("회원정보가 삭제되었습니다.")
        location.href= "../page/login_page.jsp"
    </script>
</body>