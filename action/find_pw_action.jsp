<%@ page language="java" contentType = "text/html" pageEncoding="utf-8"%>
<%@ page import="java.sql.DriverManager"%> 
<%@ page import ="java.sql.Connection"%> 
<%@ page import="java.sql.PreparedStatement"%> 
<%@ page import="java.sql.ResultSet" %>
<%@ page import ="java.util.regex.*"%> 
<%@ page import = "java.util.ArrayList" %>

<%
    request.setCharacterEncoding("utf-8"); 
    String idValue = null;
    String telValue = null;
    String pw = null;
    boolean error = false;

    try{
        idValue = request.getParameter("id_value");
        telValue = request.getParameter("tel_value");

        if(!Pattern.matches("^(?=.*\\d)(?=.*[a-z])[0-9a-z]{8,12}$", idValue)){
            error = true;
        }
        if(!Pattern.matches("^\\d{3}-\\d{3,4}-\\d{4}$", telValue)){
            error = true;
        } 

       if(!error){
            Class.forName("com.mysql.jdbc.Driver"); 
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/schedule_web","stageus","1234"); //db 주소 포트번호, 계정

            String sql = "SELECT password FROM account WHERE id =? AND tel_number =?"; 
            PreparedStatement query = conn.prepareStatement(sql); 
            query.setString(1, idValue);
            query.setString(2, telValue);

            ResultSet result = query.executeQuery(); 
            while(result.next()){
                pw = "\"" + result.getString(1) + "\"";
            }
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
        var data = <%=pw%>
        if(!data){
            alert("일치하는 비밀번호가 없습니다.")
            location.href = "../page/find_pw_page.jsp"
        }
        else{
            location.href = "../page/find_pw_result_page.jsp?pw_value=" + data
        } 
    </script>
</body>