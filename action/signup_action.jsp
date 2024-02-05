<%@ page language="java" contentType = "text/html" pageEncoding="utf-8"%>
<%@ page import="java.sql.DriverManager"%> 
<%@ page import ="java.sql.Connection"%> 
<%@ page import="java.sql.PreparedStatement"%> 
<%@ page import="java.sql.ResultSet" %> 
<%@ page import ="java.util.regex.*"%>
<%@ page import = "java.util.ArrayList" %>

 
 
 <% 
    request.setCharacterEncoding("utf-8"); 
    boolean error = false;
    String idValue = request.getParameter("id_value");
    String pwValue = request.getParameter("pw_value");
    String nameValue = request.getParameter("name_value");
    String telValue = request.getParameter("tel_value");

    try{

        if(!Pattern.matches("^(?=.*\\d)(?=.*[a-z])[0-9a-z]{8,12}$", idValue)){
            error = true;
        }
        if(!Pattern.matches("^(?=.*[a-zA-z])(?=.*[0-9])(?=.*[$`~!@[$]!%*#^?&\\(\\)-_=+]).{8,16}$", pwValue)){
            error = true;
        }
        if(nameValue.length() > 12){
            error = true;
        }
        if(!Pattern.matches("^\\d{3}-\\d{3,4}-\\d{4}$", telValue)){
            error = true;

        }   


        if(!error){
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/schedule_web","stageus","1234");

            
            String sql = "INSERT INTO account(id, password, name, tel_number) VALUES(?, ?, ?, ?)"; 
            PreparedStatement query = conn.prepareStatement(sql); 
            query.setString(1, idValue);
            query.setString(2, pwValue);
            query.setString(3, nameValue);
            query.setString(4, telValue);

            query.executeUpdate(); 
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
        var error = <%=error%>
        if(!error){
            alert("<%=idValue%>" + "님의 회원가입이 성공하였습니다")
            location.href= "../page/login_page.jsp"
        }
        else{
            alert("<%=idValue%>" + "님의 회원가입이 실패하였습니다")
            location.href = "../page/signup_page.jsp"
        }
        
    </script>
</body>