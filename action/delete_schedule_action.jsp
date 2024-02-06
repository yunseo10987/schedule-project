<%@ page language="java" contentType = "text/html" pageEncoding="utf-8"%>
<%@ page import="java.sql.DriverManager"%> 
<%@ page import ="java.sql.Connection"%> 
<%@ page import="java.sql.PreparedStatement"%> 
<%@ page import="java.sql.ResultSet" %> 


<%  
    request.setCharacterEncoding("utf-8"); 
    
    String yearValue = null;
    String monthValue = null;
    String idxValue = null;
    boolean error = false;
    

    try{
        session = request.getSession();
        String accountIdx = (String)session.getAttribute("idx");
        if(accountIdx == null){
            response.sendRedirect("../page/login_page.jsp");
        }
        yearValue = request.getParameter("yearValue");
        monthValue =request.getParameter("monthValue");
        idxValue = request.getParameter("idx_value");

        if(Integer.valueOf(yearValue) > 2199 || Integer.valueOf(yearValue) < 1901){
            error = true;
        }
        if(Integer.valueOf(monthValue) > 12 || Integer.valueOf(monthValue) < 1){
            error = true;
        }

        if(!error){
            Class.forName("com.mysql.jdbc.Driver"); 
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/schedule_web","stageus","1234"); 

            String sql = "DELETE FROM schedule WHERE idx = ?"; 
            PreparedStatement query = conn.prepareStatement(sql); 
            query.setString(1, idxValue);
            
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
        console.log(<%=idxValue%>)
        if(!error){
            location.href= "../page/main_page.jsp?" + "yearValue=" + <%=yearValue%> + "&monthValue=" + <%=monthValue%>
        }
        else{
            alert("삭제 실패하였습니다")
            location.href= "../page/main_page.jsp"
        }
    </script>
</body>