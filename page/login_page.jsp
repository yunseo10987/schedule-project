<%@ page language="java" contentType = "text/html" pageEncoding="utf-8"%>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel = "stylesheet" type="text/css" href="../css/login_page.css">
</head>
<body>
    <main>
       <form action="../action/login_action.jsp" onsubmit="return checkConstraintsEvent({id:'id_input', pw:'pw_input'})">
            <input id = "id_input" name ="id_value" type="text" placeholder="아이디">
            <div class = "constraint">※영어+숫자 각 최소 1개 이상, 8~12자</div>
            <input class = "pw_input" name = "id_value" type="password" placeholder="비밀번호">
            <div class = "constraint">※영어+숫자+특수문자 각 최소 1개 이상, 8~16자</div>
            <input type= "submit" value = "로그인">
       </form>
       <div class = "a_box">
            <a href = "find_id_page.jsp">아이디 찾기</a>
            <a href = "find_pw_page.jsp">비밀번호 찾기</a>
        </div>
        <button onclick="location.href='signup_page.jsp'">회원가입</button>
    </main>  
    <script src = "../js/check_constraints.js"></script>
</body>
</html>
