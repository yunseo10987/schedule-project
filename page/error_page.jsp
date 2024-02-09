<%@ page language="java" contentType = "text/html" pageEncoding="utf-8"%>

<%  
    request.setCharacterEncoding("utf-8");
    boolean flag = false;
    session = request.getSession();
    String accountIdx = (String)session.getAttribute("idx");
    if(accountIdx == null){
        flag = true;
    }

%>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel = "stylesheet" type="text/css" href="../css/root.css">
    <link rel = "stylesheet" type="text/css" href="../css/error_page.css">
</head>
<body>
    <main>
        <div>예상치 못한 버그 발생</div>
        <a id = "moving_page" href = ""></a>
    </main>
    <script>
        var flag = <%=flag%>
        function setLocation(){
            var a = document.getElementById("moving_page")
            if(flag){
                a.href = "login_page.jsp"
                a.innerHTML = "로그인 페이지로 이동"
            }
            else{
                a.href = "main_page.jsp"
                a.innerHTML = "메인 페이지로 이동"
            }
        }

        setLocation()
    </script>
</body>