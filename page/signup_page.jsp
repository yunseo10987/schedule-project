<%@ page language="java" contentType = "text/html" pageEncoding="utf-8"%>
<%@ page import ="java.util.regex.*"%>
<%@ page import = "java.util.ArrayList" %>
<%

    request.setCharacterEncoding("utf-8"); 
    String ableId = null;
    if(request.getParameter("able_id") != null){
        ableId = "\"" + request.getParameter("able_id") + "\"";
    }
%>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel = "stylesheet" type="text/css" href="../css/signup_page.css">
</head>
<body>
    <main>
       <form action="../action/signup_action.jsp" onsubmit="return checkConstraintsEvent({id:'id_input',duplicatedId:'duplicated_id_button',pw:'pw_input', name:'name_input', telNum:'tel_input'})">
            <div class = "id_box">
                <input id = "id_input" name ="id_value" oninput = "ableButtonEvent()" type="text" placeholder="아이디" >
                <button id = "duplicated_id_button" type= "button" onclick="checkDuplicatedIdEvent(event)">중복 확인</button>
            </div>
            <div class = "constraint">※영어+숫자 각 최소 1개 이상, 8~12자</div>
            <div id = "pw_box">
                <input id = "pw_input" name ="pw_value" type="password" placeholder="비밀번호">
                <button type= "button" id = "eye_button" onclick="expressPwEvent(event,'not_eye_button' ,'pw_input')"></button>
                <button type= "button" id = "not_eye_button" onclick="expressPwEvent(event, 'eye_button', 'pw_input')"></button>
            </div>
            <div class = "constraint">※영어+숫자+특수문자 각 최소 1개 이상, 8~16자</div>
            <input id = "name_input" name ="name_value"type="text" placeholder="이름">
            <div class = "constraint">※최대 12자</div>
            <input id = "tel_input" name ="tel_value" oninput = "insertHipenEvent(event)" type="tel" placeholder="연락처">
            <div class = "constraint">※XXX-XXXX-XXXX 형식</div>
            <input type= "submit" value = "가입하기">
            <div class = "a_box">
                <a href = "login_page.jsp">로그인 페이지로 이동</a>
            </div>
       </form>
       <script src ="../js/check_constraints.js"></script>
       <script src ="../js/insert_hipen.js"></script>
       <script src ="../js/eye_button.js"></script>
       <script>
        function checkDuplicatedIdEvent(e){
            var regId =  /^(?=.*\d)(?=.*[a-z])[0-9a-z]{8,12}$/
            var idInput = document.getElementById("id_input")
            if(!regId.test(idInput.value)){
                alert("아이디를 확인해주세요")
            }
            else{
                location.href = "../action/check_duplicated_id_action.jsp?id_value=" + idInput.value
            }
        }
        function ableButtonEvent(){
            console.log(<%=ableId%>)
            if(document.getElementById("id_input").value != <%=ableId%>){
                document.getElementById("duplicated_id_button").disabled = false
                document.getElementById("duplicated_id_button").style.color = "white"
            }
            else{
                document.getElementById("duplicated_id_button").disabled = true
                document.getElementById("duplicated_id_button").style.color = "#aeaeae"
            }
        }
        function setDefault(){
            var flag = <%=ableId%>
            console.log(<%=ableId%>)
            if(flag){
                document.getElementById("id_input").value = <%=ableId%>
                document.getElementById("duplicated_id_button").disabled = true
                document.getElementById("duplicated_id_button").style.color = "#aeaeae"
            }
        }
        

        setDefault()
       </script>
    </main> 
</body>
</html>