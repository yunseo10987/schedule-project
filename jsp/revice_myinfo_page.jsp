<%@ page language="java" contentType = "text/html" pageEncoding="utf-8"%>

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
                <a href = "logout_action.jsp">로그아웃</a>
            </div>
    </header>
    <main>
        <h2>당신의 정보 수정</h2>
       <form action="revice_myinfo_action.jsp" onsubmit="return checkConstraints(true,true,true,true)">

            <div id = "pw_box">
                <input class = "input_pw" onchange = "ableButton()" type="password" placeholder="비밀번호">
                <button type= "button" id = "button_eye" onclick="showPw()"></button>
            </div>
            <div id = "show_pw_box">
                <input class = "input_pw" type="text" placeholder="비밀번호">
                <button type= "button" id = "button_not_eye" onclick="hidePw()"></button>
            </div>
            <div class = "constraint">※영어+숫자+특수문자 각 최소 1개 이상, 8~16자</div>
            <input type="text" placeholder="이름">
            <div class = "constraint">※최대 12자</div>
            <input type="tel" placeholder="연락처">
            <div class = "constraint">※XXX-XXXX-XXXX 형식</div>
            <input type= "submit" value = "가입하기">
       </form>
       <script src ="../js/check_constraints.js"></script>
       
    </main> 
</body>
</html>