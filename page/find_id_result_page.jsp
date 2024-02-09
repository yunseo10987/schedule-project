<%@ page language="java" contentType = "text/html" pageEncoding="utf-8"%>

<%
    request.setCharacterEncoding("utf-8"); 
    String id = null;
    if(request.getParameter("id_value") != null){
        id = request.getParameter("id_value");
    }
    else{
        response.sendRedirect("login_page.jsp");
    }
%>


<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel = "stylesheet" type="text/css" href="../css/root.css">
    <link rel = "stylesheet" type="text/css" href="../css/find_id_result_page.css">
</head>
<body>
    <main>
        <h1>당신의,</h1>
        <div class ="result_box">ID : <%=id%></div>
        
        <div class = "a_box">
            <a href = "login_page.jsp">로그인 페이지로 이동</a>
        </div>
     </main>
</body>
</html>