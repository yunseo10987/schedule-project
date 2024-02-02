<%@ page language="java" contentType = "text/html" pageEncoding="utf-8"%>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel = "stylesheet" type="text/css" href="../css/find_id_page.css">
</head>
<body>
    <main>
        <h1>비밀번호 찾기</h1>
        <form action="find_pw_action.jsp" onsubmit="return checkConstraintsEvent({id:true, pw:false,name:false,telNum:true})">
             <input id = "id_input" type="text" placeholder="아이디">
             <div class = "constraint">※영어+숫자 각 최소 1개 이상, 8~12자</div>
             <input id = "tel_input" type="tel" placeholder="연락처">
             <div class = "constraint">※XXX-XXXX-XXXX 형식</div>
             <input type= "submit" value = "비밀번호 찾기">
        </form>
     </main>
     <script src = "../js/check_constraints.js"></script>
</body>
</html>