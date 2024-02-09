<%@ page language="java" contentType = "text/html" pageEncoding="utf-8"%>
<%@ page import="java.sql.DriverManager"%> 
<%@ page import ="java.sql.Connection"%> 
<%@ page import="java.sql.PreparedStatement"%> 
<%@ page import="java.sql.ResultSet" %> 
<%@ page import = "java.util.ArrayList" %>
<%@ page import ="java.time.LocalDate" %>
<%@ page import ="java.time.ZoneId" %>

<%  
    String yearValue = null;
    String monthValue = null;
    String defaultYear = null;
    String defaultMonth = null;
    String defaultDay = null;
    String accountIdx = null;
    boolean error = false;
    ArrayList<ArrayList<ArrayList<String>>> data =  new ArrayList<ArrayList<ArrayList<String>>>();

    try{
        request.setCharacterEncoding("utf-8"); 
        session = request.getSession();
        accountIdx = (String)session.getAttribute("idx");
        if(accountIdx == null){
            response.sendRedirect("login_page.jsp");
        }
        yearValue = request.getParameter("yearValue");
        monthValue = request.getParameter("monthValue");
        
        LocalDate now = LocalDate.now(ZoneId.of("Asia/Seoul"));
        defaultYear = String.valueOf(now.getYear());
        defaultMonth = String.valueOf(now.getMonthValue());
        defaultDay = String.valueOf(now.getDayOfMonth());

        if(yearValue == null || yearValue == "null"){        
            yearValue = defaultYear;
        }
        if(monthValue == null || monthValue == "null"){        
            monthValue = defaultMonth;
        }
        
        if(Integer.valueOf(yearValue) > 2199 || Integer.valueOf(yearValue) < 1901){
            error = true;
        }
        if(Integer.valueOf(monthValue) > 12 || Integer.valueOf(monthValue) < 1){
            error = true;
        }

        if(!error){
            for(int i = 1; i <= 31; i++){
                Class.forName("com.mysql.jdbc.Driver"); 
                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/schedule_web","stageus","1234"); 
                ArrayList<ArrayList<String>> elem = new ArrayList<ArrayList<String>>();
                String sql = "SELECT idx, hour, minute, content FROM schedule WHERE year =? AND month =? AND writer =? AND day=? ORDER BY hour,minute"; 
                PreparedStatement query = conn.prepareStatement(sql); 
                query.setString(1, yearValue);
                query.setString(2, monthValue);
                query.setString(3, accountIdx);
                query.setString(4, String.valueOf(i));

                ResultSet result = query.executeQuery(); 
                while(result.next()){
                    String idx = result.getString(1);
                    String hour = result.getString(2);
                    String minute = result.getString(3);
                    String content = result.getString(4);
                    ArrayList<String> list = new ArrayList<String>();
                    
                    list.add("\"" + idx + "\"");
                    list.add("\"" + hour + "\"");
                    list.add("\"" + minute + "\"");
                    list.add("\"" + content + "\"");
                    elem.add(list);
                }
                data.add(elem);
            }
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
    <link rel = "stylesheet" type="text/css" href="../css/root.css">
    <link rel = "stylesheet" type="text/css" href="../css/header.css">
    <link rel = "stylesheet" type="text/css" href="../css/main_page.css">
</head>
<body>
    <header>
        <h1>스케쥴러</h1>
        <div class = "menu">
            <a href = "myinfo_page.jsp">내 정보 보기</a>
            <a href = "revice_myinfo_page.jsp">내 정보 수정</a>
            <a href = "../action/logout_action.jsp">로그아웃</a>
        </div>
    </header>
    <main>
        <div id = "year_box">
        <button id = "last_year_button" onclick = "minusYearEvent()"></button>
        <div id ="year">2024</div>
        <button id = "next_year_button" onclick = "plusYearEvent()"></button>
        </div>
        <div id = "month_box">
        </div>
        <div id = "day_table_box">
        </div>
    </main>
    <div id="modal_background">
        <div id="modal">
            <div id = "modal_top">
                <div id = "date_box"></div>
                <button onclick = "closeModalEvent()">X</button>
            </div>
            <div id = schedule_box>
            </div>
            <form id = "schedule_writing_box" action ="../action/create_schedule_action.jsp" onsubmit = "return checkScheduleInputEvent('hour_select', 'minute_select', 'content_writing_box')">
                <select id = "hour_select" name = "hour_value">
                    <option disabled selected>시</option>
                </select>
                <select id = "minute_select" name = "minute_value" >
                    <option disabled selected>분</option>
                </select>
                <textarea id = "content_writing_box" name = "text_value" placeholder ="텍스트 입력"></textarea>
                <input type = "hidden" name = "year_value">
                <input type = "hidden" name = "month_value">
                <input type = "hidden" name = "day_value">
                <input type = "submit" value = "등록">
            </form>
        </div>
    </div>

    <script src = "../js/check_constraints.js"></script>
    <script src = "../js/create_calendar.js"></script>
    <script>
        var list = <%=data%>
        var year = <%=yearValue%>
        var month = <%=monthValue%>

        var defaultYear = <%=defaultYear%>
        var defaultMonth = <%=defaultMonth%>
        var defaultDay = <%=defaultDay%>
        var maxDay = 0

        

        function setDefault(){
            document.getElementById("year").innerHTML = year
            document.getElementById("month_div" + month).style.borderBottomColor = "#156082"
            if(year == defaultYear && month == defaultMonth){
                document.getElementById("day_button" + defaultDay).style.backgroundColor = "#156082"
            }
            
        }
        
        function createMonthEvent(){
            var lastYearButton = document.getElementById("last_year_button")
            for(var index = 0; index < 12; index++){
                var monthButton = document.getElementById("month_button" + (index+1))
                monthButton.addEventListener('click',(e) =>{
                    var number = e.target.id.replace(/\D/g, "")
                    for(var idx = 0; idx < 12; idx++){
                        var monthDiv = document.getElementById("month_div" + (idx+1))
                        monthDiv.style.borderBottomColor = "#e8e8e8"
                    }
                    month = number
                    location.href = "main_page.jsp?" + "yearValue=" + year + "&monthValue="+ month 
                })
            }
        }
        
        function showModal(){
            for(var index = 0; index < maxDay; index++){
                var dayButton = document.getElementById("day_button" + (index+1))
                dayButton.addEventListener('click',(e) =>{
                    var number = e.target.id.replace(/\D/g, "")
                    document.getElementById("modal_background").style.display = "flex"
                    document.getElementById("date_box").innerHTML = month+"/"+number
                    document.getElementsByName("year_value")[0].value = year
                    document.getElementsByName("month_value")[0].value = month
                    document.getElementsByName("day_value")[0].value = number
                    createModal(list[number-1])
                })

            }
        }

        
        function deleteScheduleEvent(e){
            var number = e.target.id.replace(/\D/g, "")
            var flag = confirm("삭제하시겠습니까?")
            if(flag){
                location.href = "../action/delete_schedule_action.jsp?idx_value=" + document.getElementById("hidden" + number).value +"&yearValue=" + year + "&monthValue=" + month
            }
        }
        function closeModalEvent(){
            document.getElementById("modal_background").style.display = "none"
        }
        

        function minusYearEvent(){
            year = year - 1
            location.href = "main_page.jsp?" + "yearValue=" + year + "&monthValue="+ month 
        }
        function plusYearEvent(){
            year = year + 1
            location.href = "main_page.jsp?" + "yearValue=" + year + "&monthValue="+ month 
        }
        
        function createReviceAreaEvent(e){
            var number = e.target.id.replace(/\D/g, "")
            document.getElementById("schedule_time_box" + number).style.display = "none"
            document.getElementById("schedule_time_box" + number).style.display = "none"
            document.getElementById("schedule_content_box" + number).style.display = "none"
            document.getElementById("revice_button" + number).style.display = "none"
            document.getElementById("delete_button" + number).style.display = "none"
            document.getElementById("revice_hour_select" + number).style.display = "flex"
            document.getElementById("revice_minute_select" + number).style.display = "flex"
            document.getElementById("revice_textarea" + number).style.display = "flex"
            document.getElementById("revice_textarea" + number).value = document.getElementById("schedule_content_box" + number).innerHTML
            document.getElementById("save_button" + number).style.display = "flex"
            document.getElementById("cancel_button" + number).style.display = "flex"          
        }
        function deleteReviceAreaEvent(e){    
            var number = e.target.id.replace(/\D/g, "")
            document.getElementById("schedule_time_box" + number).style.display = "flex"
            document.getElementById("schedule_time_box" + number).style.display = "flex"
            document.getElementById("schedule_content_box" + number).style.display = "flex"
            document.getElementById("revice_button" + number).style.display = "inline-block"
            document.getElementById("delete_button" + number).style.display = "inline-block"
            document.getElementById("revice_hour_select" + number).style.display = "none"
            document.getElementById("revice_minute_select" + number).style.display = "none"
            document.getElementById("revice_textarea" + number).style.display = "none"
            document.getElementById("save_button" + number).style.display = "none"
            document.getElementById("cancel_button" + number).style.display = "none"
        }

        function checkReviceAreaEvent(e){   
            var number = e.target.id.replace(/\D/g, "")
            var reviceHour = document.getElementById("revice_hour_select"+ number)
            var reviceMinute = document.getElementById("revice_minute_select"+ number)
            var reviceText = document.getElementById("revice_textarea" + number)
            if(reviceHour.value == "시" || reviceMinute.value == "분"){
                alert("시간을 확인하세요")
                e.preventDefault()
            }
            if(reviceText.value == ""){
                alert("텍스트를 입력하세요")
                e.preventDefault()
            }
            if(reviceText.value.legth > 100){
                alert("100자 내로 입력하세요")
                e.preventDefault()
            }
        }

        window.onload = function () {
            createCalendar()
            createMonthButton()
            createMonthEvent()
            maxDay = createDayButton(list)
            setDefault()
            showModal()
        }
    </script>
</body>
</html>