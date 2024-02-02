<%@ page language="java" contentType = "text/html" pageEncoding="utf-8"%>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel = "stylesheet" type="text/css" href="../css/myinfo_page.css">
    <link rel = "stylesheet" type="text/css" href="../css/header.css">
</head>
<body>
    <header>
        <h1>스케쥴러</h1>
        <div class = "menu">
            <a href = "revice_myinfo_page.jsp">내 정보 수정</a>
            <a href = "logout_action.jsp">로그아웃</a>
        </div>
    </header>
    <main>
        <h2>당신의 정보</h2>
        <div class ="result_box">
            <div class = "result">
                ID :
            </div>
            <div class = "result">
                비밀번호 :
            </div>
            <div class = "result">
                이름 :
            </div>
            <div class = "result">
                연락처 :
            </div>
        </div>
        <%-- <%= pw> --%>
        <div class = "a_box">
            <a id = "main_page_a" href = "../jsp/main_page.jsp">메인 페이지로 이동</a>
        </div>
     </main>
</body>
</html>