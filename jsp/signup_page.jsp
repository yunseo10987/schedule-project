<%@ page language="java" contentType = "text/html" pageEncoding="utf-8"%>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel = "stylesheet" type="text/css" href="../css/signup_page.css">
</head>
<body>
    <main>
       <form action="signup_action.jsp" onsubmit="return checkConstraints(true,true,true,true)">
            <div class = "id_box">
                <input id = "input_id" type="text" placeholder="아이디">
                <button id = "duplicated_id_button" type= "button" onclick="checkDuplicatedId()">중복 확인</button>
            </div>
            <div class = "constraint">※영어+숫자 각 최소 1개 이상, 8~12자</div>
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
       <script>
        function checkDuplicatedId(e){
            location.href = "check_duplicated_id_action.jsp"
            //var request = check_duplicated_id_action.js에서 받는 거
            if(request){
                e.style.disabled = "true"
            }
            
        }
        function ableButton(){
            document.getElementById("duplicated_id_button").style.disabled = "false"
        }

       </script>
    </main> 
</body>
</html>