<%@ page language="java" contentType = "text/html" pageEncoding="utf-8"%>
<%@ page import="java.sql.DriverManager"%> 
<%@ page import ="java.sql.Connection"%> 
<%@ page import="java.sql.PreparedStatement"%> 
<%@ page import="java.sql.ResultSet" %>
<%@ page import ="java.util.regex.*"%> 
<%@ page import = "java.util.ArrayList" %>

<%
    request.setCharacterEncoding("utf-8"); 
    String nameValue = request.getParameter("name_value");
    String telValue = request.getParameter("tel_value");
    String id = null;
    boolean error = false;

    try{
        if(nameValue.length() > 12){
            error = true;
        }
        if(!Pattern.matches("^\\d{3}-\\d{3,4}-\\d{4}$", telValue)){
            error = true;
        } 

       if(!error){
            Class.forName("com.mysql.jdbc.Driver"); 
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/schedule_web","stageus","1234"); //db 주소 포트번호, 계정

            String sql = "SELECT id FROM account WHERE name =? AND tel_number =?"; 
            PreparedStatement query = conn.prepareStatement(sql); 
            query.setString(1, nameValue);
            query.setString(2, telValue);

            ResultSet result = query.executeQuery(); 
            while(result.next()){
                id = "\"" + result.getString(1) + "\"";
            }
       }
    }
    catch(Exception e){
        response.sendRedirect("error_page.jsp");
    }
    
%>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    <script>
        var data = <%=id%>
        if(!data){
            alert("일치하는 아이디가 없습니다.")
            location.href = "../page/find_id_page.jsp"
        }
        else{
            location.href = "../page/find_id_result_page.jsp?id_value=" + data
        } 
    </script>
</body>