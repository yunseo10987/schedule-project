<%@ page language="java" contentType = "text/html" pageEncoding="utf-8"%>
<%@ page import="java.sql.DriverManager"%> 
<%@ page import ="java.sql.Connection"%> 
<%@ page import="java.sql.PreparedStatement"%> 
<%@ page import="java.sql.ResultSet" %>
<%@ page import ="java.util.regex.*"%> 
<%@ page import = "java.util.ArrayList" %>


<%
    request.setCharacterEncoding("utf-8"); 
    String idValue = request.getParameter("id_value");
    String pwValue = request.getParameter("pw_value");
    String idx = null;
    boolean error = false;

    try{
        if(!Pattern.matches("^(?=.*\\d)(?=.*[a-z])[0-9a-z]{8,12}$", idValue)){
            error = true;
        }
        if(!Pattern.matches("^(?=.*[a-zA-z])(?=.*[0-9])(?=.*[$`~!@[$]!%*#^?&\\(\\)-_=+]).{8,16}$", pwValue)){
            error = true;
        }

        if(!error){
            Class.forName("com.mysql.jdbc.Driver"); 
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/schedule_web","stageus","1234"); 

            String sql = "SELECT idx FROM account WHERE id =? AND password =?"; 
            PreparedStatement query = conn.prepareStatement(sql); 
            query.setString(1, idValue);
            query.setString(2, pwValue);

            ResultSet result = query.executeQuery(); 
            while(result.next()){
                idx = result.getString(1); 
            }
            if(idx != null){
                session.setAttribute("idx", idx);
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
        var error = <%=error%>
        var data = <%=idx%>
        if(error){
            alert("로그인에 실패하였습니다.")
            location.href = "../page/login_page.jsp"
        }
        if(!data){
            alert("아이디/비밀번호가 일치하지 않습니다. 다시 확인해주세요.")
            location.href = "../page/login_page.jsp"
        }
        else{
            location.href = "../page/main_page.jsp"
        } 
    </script>
</body>