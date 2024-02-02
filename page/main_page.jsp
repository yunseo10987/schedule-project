<%@ page language="java" contentType = "text/html" pageEncoding="utf-8"%>
<%@ page import="java.sql.DriverManager"%> 
<%@ page import ="java.sql.Connection"%> 
<%@ page import="java.sql.PreparedStatement"%> 
<%@ page import="java.sql.ResultSet" %> 
<%@ page import = "java.util.ArrayList" %>
<%  
    request.setCharacterEncoding("utf-8"); 
    

    String yearValue = request.getParameter("yearValue");
    String monthValue = request.getParameter("monthValue");
    if(yearValue == null){
        yearValue = "2024";
    }
    if(monthValue == null){
        monthValue = "1";
    }
%>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel = "stylesheet" type="text/css" href="../css/header.css">
    <link rel = "stylesheet" type="text/css" href="../css/main_page.css">
</head>
<body>
    <header>
        <h1>스케쥴러</h1>
        <div class = "menu">
            <a href = "myinfo_page.jsp">내 정보 보기</a>
            <a href = "revice_myinfo_page.jsp">내 정보 수정</a>
            <a href = "logout_action.jsp">로그아웃</a>
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
            <form id = "schedule_writing_box" action ="" onsubmit = "return checkScheduleInputEvent()">
                <select id = "hour_select">
                    <option value = "" disabled selected>시</option>
                </select>
                <select id = "minute_select" >
                    <option value = "" disabled selected>분</option>
                </select>
                <textarea id = "content_writing_box" placeholder ="텍스트 입력"></textarea>
                <input type = "submit" value = "등록">
            </form>
        </div>
    </div>

    <script src = "../js/check_constraints.js"></script>
    <script src = "../js/create_calendar.js"></script>
    <script>
        var year = <%=yearValue%>
        var month = <%=monthValue%>
        var maxDay = 0
        createCalendar()
        createMonthButton()
        createEvent()
        maxDay = createDayButton()
        setDefault()
        showModal()

        function setDefault(){
            document.getElementById("year").innerHTML = year
            document.getElementById("month_div" + month).style.borderBottomColor = "#156082"
        }
        
        function createEvent(){
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
                    createModal()
                })

            }
        }
        function createModal(){
            var scheduleNum = 3
            var scheduleBox = document.getElementById("schedule_box")
            var textarea = document.getElementById("content_writing_box")
            createTimeOption()
            textarea.value = ""
            scheduleBox.innerHTML = ""
            for(var index = 0; index < scheduleNum; index++){
                var schedule = document.createElement("div")
                schedule.className = "schedule"
                schedule.id = "schedule" + index
                var timeBox = document.createElement("div")
                timeBox.className = "schedule_time_box"
                timeBox.id = "schedule_time_box" + index
                timeBox.innerHTML = "시간"
                var contentBox = document.createElement("div")
                contentBox.className = "schedule_content_box"
                contentBox.id = "schedule_content_box" + index
                contentBox.innerHTML = "일정"
                var buttonBox = document.createElement("div")
                var reviceButton = document.createElement("input")
                reviceButton.type = "button"
                reviceButton.className = "revice_button"
                reviceButton.id = "revice_button" + index
                var deleteButton = document.createElement("input")
                deleteButton.type = "button"
                deleteButton.className = "delete_button"
                deleteButton.id = "delete_button" + index
                deleteButton.onclick = deleteScheduleEvent

                var hourSelect = document.createElement("select")
                hourSelect.id = "revice_hour_select" + index
                hourSelect.style.display = "none"
                var minuteSelect = document.createElement("select")
                minuteSelect.id = "revice_minute_select" + index
                minuteSelect.style.display = "none"
                var reviceTextArea = document.createElement("textarea")
                reviceTextArea.id = "revice_textarea" + index
                reviceTextArea.style.display = "none"
                var saveButton = document.createElement("button")
                saveButton.innerHTML = "저장"
                saveButton.id = "save_button" + index
                saveButton.className = "save_button"
                saveButton.style.display = "none"
                var cancelButton = document.createElement("button")
            
                cancelButton.innerHTML = "취소"
                cancelButton.id = "cancel_button" + index
                cancelButton.className = "cancel_button"
                cancelButton.style.display = "none"
                //cancelButton.addEventListener('click' 함수 이름)

                schedule.appendChild(hourSelect)
                schedule.appendChild(minuteSelect)
                schedule.appendChild(reviceTextArea)
                schedule.appendChild(saveButton)
                schedule.appendChild(cancelButton)

                schedule.appendChild(timeBox)
                schedule.appendChild(contentBox)
                schedule.appendChild(buttonBox)
                buttonBox.appendChild(reviceButton)
                buttonBox.appendChild(deleteButton)
                schedule_box.appendChild(schedule)
                createReviceTimeOption(index)
            }


            createReviceArea(scheduleNum)
            deleteReviceArea(scheduleNum)
            checkReviceArea(scheduleNum)
        }
        
        function deleteScheduleEvent(){
            var flag = confirm("삭제하시겠습니까?")
            if(flag){
                //location.href = delete_schedule_action.jsp
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
        function createReviceArea(num){
            for(var index =0; index < num; index++){
                var reviceButton = document.getElementById("revice_button" + index)
                reviceButton.addEventListener('click' , (e) =>{
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
                    
                })
            }
        }
        function deleteReviceArea(num){
            for(var index =0; index < num; index++){
                var cancelButton = document.getElementById("cancel_button" + index)
                cancelButton.addEventListener('click' , (e) =>{
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
                    
                })
            }
        }

        function checkReviceArea(num){
            for(var index = 0; index < num; index++){
                var saveButton = document.getElementById("save_button" + index)
                saveButton.addEventListener('click', (e) =>{
                    var number = e.target.id.replace(/\D/g, "")
                    var reviceHour = document.getElementById("revice_hour_select"+ number)
                    var reviceMinute = document.getElementById("revice_minute_select"+ number)
                    var reviceText = document.getElementById("revice_textarea" + number)
                    if(reviceHour.value == "" || reviceMinute.value == ""){
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
                })
            }
        }
    </script>
</body>
</html>