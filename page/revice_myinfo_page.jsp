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
    <link rel = "stylesheet" type="text/css" href="../css/signup_page.css">
    <link rel = "stylesheet" type="text/css" href="../css/header.css">
</head>
<body>
    <header>
            <h1>스케쥴러</h1>
            <div class = "menu">
                <a href = "myinfo_page.jsp">내 정보 보기</a>
                <a href = "../action/logout_action.jsp">로그아웃</a>
            </div>
    </header>
    <main>
        <h2>당신의 정보 수정</h2>
       <form action="revice_myinfo_action.jsp" onsubmit="return checkConstraintsEvent({id:false, pw:true, name:true, telNum:true})">
           <div id = "pw_box">
                <input id = "pw_input" type="password" placeholder="비밀번호">
                <button type= "button" id = "eye_button" onclick="expressPwEvent(event,'not_eye_button' ,'pw_input')"></button>
                <button type= "button" id = "not_eye_button" onclick="expressPwEvent(event, 'eye_button', 'pw_input')"></button>
            </div>
            <div class = "constraint">※영어+숫자+특수문자 각 최소 1개 이상, 8~16자</div>
            <input id = "name_input" type="text" placeholder="이름">
            <div class = "constraint">※최대 12자</div>
            <input id = "tel_input" type="tel" placeholder="연락처">
            <div class = "constraint">※XXX-XXXX-XXXX 형식</div>
            <input type= "submit" value = "가입하기">
            <input id = "unsignup_button" onclick = "checkUnsignup()" type = "button" value = "회원 탈퇴">
            <div class = "a_box">
                <a id = "main_page_a" href = "../page/main_page.jsp">메인 페이지로 이동</a>
            </div>
       </form>
       <script src ="../js/check_constraints.js"></script>
       <script src ="../js/eye_button.js"></script>
       
    </main> 
</body>
</html>