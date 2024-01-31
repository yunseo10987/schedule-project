<%@ page language="java" contentType = "text/html" pageEncoding="utf-8"%>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel = "stylesheet" type="text/css" href="../css/signup_page.css">
</head>
<body>
    <main>
       <form action="signup_action.jsp" onsubmit="return checkConstraintsEvent({id:true, pw:true, name:true, telNum:true})">
            <div class = "id_box">
                <input id = "id_input" onchange = "ableButtonEvent()" type="text" placeholder="아이디">
                <button id = "duplicated_id_button" type= "button" onclick="checkDuplicatedIdEvent(event)">중복 확인</button>
            </div>
            <div class = "constraint">※영어+숫자 각 최소 1개 이상, 8~12자</div>
            <div id = "pw_box">
                <input class = "pw_input" type="password" placeholder="비밀번호">
                <button type= "button" id = "eye_button" onclick="showPwEvent()"></button>
            </div>
            <div id = "shown_pw_box">
                <input class = "pw_input" type="text" placeholder="비밀번호">
                <button type= "button" id = "not_eye_button" onclick="hidePwEvent()"></button>
            </div>
            <div class = "constraint">※영어+숫자+특수문자 각 최소 1개 이상, 8~16자</div>
            <input id = "name_input" type="text" placeholder="이름">
            <div class = "constraint">※최대 12자</div>
            <input id = "tel_input" type="tel" placeholder="연락처">
            <div class = "constraint">※XXX-XXXX-XXXX 형식</div>
            <input type= "submit" value = "가입하기">
       </form>
       <script src ="../js/check_constraints.js"></script>
       <script src ="../js/eye_button.js"></script>
       <script>
        function checkDuplicatedIdEvent(e){
            //location.href = "check_duplicated_id_action.jsp"
            //var request = check_duplicated_id_action.js에서 받는 거
            //if(request){
            //    e.disabled = "true"
            //}
            e.target.disabled = true
            
        }
        function ableButtonEvent(){
            document.getElementById("duplicated_id_button").disabled = false
        }

       </script>
    </main> 
</body>
</html>