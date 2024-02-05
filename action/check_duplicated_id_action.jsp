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
    String idx = null;
    String id = null;
    
    try{
        String idValue = request.getParameter("id_value");
        id = "\"" + idValue + "\"";
        if(!Pattern.matches("^(?=.*\\d)(?=.*[a-z])[0-9a-z]{8,12}$", idValue)){
            error = true;
        }

        Class.forName("com.mysql.jdbc.Driver"); 
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/schedule_web","stageus","1234"); 
        String sql = "SELECT idx FROM account WHERE id =?"; 
        PreparedStatement query = conn.prepareStatement(sql); 
        query.setString(1, idValue);
    
        ResultSet result = query.executeQuery(); 

        while(result.next()){
            idx = result.getString(1);    
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
    <form id= "data" action = "../page/signup_page.jsp" method = "post">
        <input type ="hidden" value = <%=id%> name = "able_id">
    </form>
    <script>
        var error = <%=error%>
        var id = <%=idx%>
        
        if(!error && !id){
            alert(<%=id%> + "는 사용 가능한 아이디입니다.")
            document.getElementById("data").submit()

        }
        else{
            alert(<%=id%> + "는 사용 불가능한 아이디입니다.")
            window.history.back();
        }
    </script>
</body>