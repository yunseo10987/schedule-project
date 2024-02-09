<%@ page language="java" contentType = "text/html" pageEncoding="utf-8"%>
<%@ page import="java.sql.DriverManager"%> 
<%@ page import ="java.sql.Connection"%> 
<%@ page import="java.sql.PreparedStatement"%> 
<%@ page import="java.sql.ResultSet" %>
<%@ page import ="java.util.regex.*"%> 
<%@ page import = "java.util.ArrayList" %>

<%
    String id = null;
    String pw = null;
    String name = null;
    String telNum = null;

    try{
        request.setCharacterEncoding("utf-8"); 
        session = request.getSession();
        String accountIdx = (String)session.getAttribute("idx");
        if(accountIdx == null){
            response.sendRedirect("login_page.jsp");
        }

        Class.forName("com.mysql.jdbc.Driver"); 
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/schedule_web","stageus","1234"); 

        String sql = "SELECT id, password, name, tel_number FROM account WHERE idx = ?"; 
        PreparedStatement query = conn.prepareStatement(sql); 
        query.setString(1, accountIdx);

        ResultSet result = query.executeQuery(); 
        while(result.next()){
            id = result.getString(1);
            pw = result.getString(2);
            name = result.getString(3);
            telNum = result.getString(4);
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
    <link rel = "stylesheet" type="text/css" href="../css/root.css">
    <link rel = "stylesheet" type="text/css" href="../css/myinfo_page.css">
    <link rel = "stylesheet" type="text/css" href="../css/header.css">
</head>
<body>
    <header>
        <h1>스케쥴러</h1>
        <div class = "menu">
            <a href = "revice_myinfo_page.jsp">내 정보 수정</a>
            <a href = "../action/logout_action.jsp">로그아웃</a>
        </div>
    </header>
    <main>
        <h2>당신의 정보</h2>
        <div class ="result_box">
            <div class = "result">
                ID : <%=id%>
            </div>
            <div id="pw_result" class = "result">
            </div>
            <div class = "result">
                이름 : <%=name%>
            </div>
            <div class = "result">
                연락처 : <%=telNum%>
            </div> 
        </div>
        <div class = "a_box">
            <a id = "main_page_a" href = "../page/main_page.jsp">메인 페이지로 이동</a>
        </div>
     </main>
     <script>
        function insertPw(){
            var hiddenPw = ""
            var pw = <%= "\"" + pw + "\""%>
            for(var index =0; index < pw.length; index++){
                hiddenPw += "*"
            }
            document.getElementById("pw_result").innerHTML = "비밀번호 : " + hiddenPw 
        }
        insertPw()
     </script>
</body>
</html>