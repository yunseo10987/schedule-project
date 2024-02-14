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
    String pwValue = null;
    String nameValue = null;
    String telValue = null;
    String idxValue = "";

    try{
        idValue = request.getParameter("id_value");
        pwValue = request.getParameter("pw_value");
        nameValue = request.getParameter("name_value");
        telValue = request.getParameter("tel_value");

        if(!Pattern.matches("^(?=.*\\d)(?=.*[a-z])[0-9a-z]{8,12}$", idValue)){
            throw new Exception();
        }
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

        
        String firstSql = "SELECT idx FROM account WHERE id =?"; 
        PreparedStatement firstQuery = conn.prepareStatement(firstSql);
        firstQuery.setString(1, idValue);

        ResultSet firstResult = firstQuery.executeQuery();

        while(firstResult.next()){
            idxValue = firstResult.getString(1);    
        }    
        
        if(idxValue != ""){
            throw new Exception();        
        }
        
        String seconSql = "INSERT INTO account(id, password, name, tel_number) VALUES(?, ?, ?, ?)"; 
        PreparedStatement secondQuery = conn.prepareStatement(seconSql); 
        secondQuery.setString(1, idValue);
        secondQuery.setString(2, pwValue);
        secondQuery.setString(3, nameValue);
        secondQuery.setString(4, telValue);

        secondQuery.executeUpdate(); 
        
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
            alert("<%=idValue%>" + "님의 회원가입이 성공하였습니다")
            location.href= "../page/login_page.jsp"            
        }
        
    </script>
</body>