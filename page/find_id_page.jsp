<%@ page language="java" contentType = "text/html" pageEncoding="utf-8"%>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel = "stylesheet" type="text/css" href="../css/root.css">
    <link rel = "stylesheet" type="text/css" href="../css/find_id_page.css">
</head>
<body>
    <main>
        <h1>아이디 찾기</h1>
        <form action="../action/find_id_action.jsp" onsubmit="return checkConstraintsEvent({id:false, pw:false,name:'name_input',telNum:'tel_input'})">
            <input id = "name_input" name = "name_value" type="text" placeholder="이름">
            <div class = "constraint">※최대 12자</div>
            <input id = "tel_input" name = "tel_value" type="tel" oninput = "insertHipenEvent(event)" placeholder="연락처">
            <div class = "constraint">※XXX-XXXX-XXXX 형식</div>
            <input type= "submit" value = "아이디 찾기">
            <div class = "a_box">
                <a href = "login_page.jsp">로그인 페이지로 이동</a>
            </div>
        </form>
     </main>
     <script src = "../js/check_constraints.js"></script>
     <script src = "../js/insert_hipen.js"></script>
</body>
</html>