function createCalendar(){
    var parentDiv = document.getElementById("day_table_box")
    var newTable = document.createElement("table")
    for(var firstIndex = 0; firstIndex < 5; firstIndex++){
        var newTr = document.createElement("tr")
        for(var secondIndex = 0; secondIndex < 7; secondIndex++){
            var newTd = document.createElement("td")
            newTd.id = "td" + (firstIndex * 7 + (secondIndex + 1))
            newTr.appendChild(newTd)
        }
        newTable.appendChild(newTr)
    }
    parentDiv.appendChild(newTable)
}

function createMonthButton(){
    var parentDiv = document.getElementById("month_box")
    for(var index = 0; index < 12; index++){
        var newMonthButton = document.createElement("button")
        var newDiv = document.createElement("div")
        newDiv.id = "month_div" + (index + 1)
        newMonthButton.innerHTML = index + 1
        newMonthButton.id = "month_button" + (index + 1)
        newDiv.appendChild(newMonthButton)
        parentDiv.appendChild(newDiv)
        if(month == index + 1){
            newDiv.style.borderBottomColor = "#156082"
        }
    }
}

function createDayButton(list){
    var maxDay = 0;
    if(month == 4 || month == 6 || month == 9 || month == 11){
        maxDay = 30
    }
    else if(month == 2 && year%4 == 0){
        maxDay = 29
    }
    else if(month == 2){
        maxDay = 28
    }
    else{
        maxDay = 31
    }
    for(var index = 0; index < maxDay; index++){
        var parentTd = document.getElementById("td" + (index + 1))
        var newDayButton = document.createElement("button")
        newDayButton.innerHTML = index + 1
        if(list[index].length != 0){
            var newDiv = document.createElement("div")
            newDiv.innerHTML = "일정 " + list[index].length + "개"
            newDiv.id = index + 1
            newDayButton.appendChild(newDiv)
        }

        newDayButton.id = "day_button" + (index + 1)
        parentTd.appendChild(newDayButton) 
    }
    
    return maxDay
}

function createModal(list){
    var scheduleNum = list.length
    var scheduleBox = document.getElementById("schedule_box")
    var textarea = document.getElementById("content_writing_box")
    createTimeOption("hour_select", "minute_select", null)
    textarea.value = ""
    scheduleBox.innerHTML = ""

    for(var index = 0; index < scheduleNum; index++){
        var schedule = document.createElement("form")
        schedule.className = "schedule"
        schedule.id = "schedule" + index
        schedule.action = "../action/revice_schedule_action.jsp"
        var timeBox = document.createElement("div")
        timeBox.className = "schedule_time_box"
        timeBox.id = "schedule_time_box" + index
        if(list[index][1] < 10 && list[index][2] < 10){
            timeBox.innerHTML = "0" + list[index][1] + " : 0" + list[index][2]
        }
        else if(list[index][1] < 10){
            timeBox.innerHTML = "0" + list[index][1] + " : " + list[index][2]
        }
        else if(list[index][2] < 10){
            timeBox.innerHTML = list[index][1] + " : 0" + list[index][2]
        }
        else{
            timeBox.innerHTML = list[index][1] + " : " + list[index][2]
        }
        var hiddenIdx = document.createElement("input")
        hiddenIdx.type = "hidden"
        hiddenIdx.name = "idx_value"
        hiddenIdx.value = list[index][0]


        var contentBox = document.createElement("div")
        contentBox.className = "schedule_content_box"
        contentBox.id = "schedule_content_box" + index
        contentBox.innerHTML = list[index][3]

        var buttonBox = document.createElement("div")
        var reviceButton = document.createElement("input")
        reviceButton.type = "button"
        reviceButton.className = "revice_button"
        reviceButton.id = "revice_button" + index
        reviceButton.addEventListener('click', createReviceAreaEvent)

        var deleteButton = document.createElement("input")
        deleteButton.type = "button"
        deleteButton.className = "delete_button"
        deleteButton.id = "delete_button" + index
        deleteButton.onclick = deleteScheduleEvent

        var hourSelect = document.createElement("select")
        hourSelect.id = "revice_hour_select" + index
        hourSelect.name = "hour_value"
        hourSelect.style.display = "none"
        var minuteSelect = document.createElement("select")
        minuteSelect.id = "revice_minute_select" + index
        minuteSelect.name = "minute_value"
        minuteSelect.style.display = "none"
        var reviceTextArea = document.createElement("textarea")
        reviceTextArea.id = "revice_textarea" + index
        reviceTextArea.name = "text_value"
        reviceTextArea.style.display = "none"


        var saveButton = document.createElement("button")
        saveButton.innerHTML = "저장"
        saveButton.id = "save_button" + index
        saveButton.className = "save_button"
        saveButton.style.display = "none"
        saveButton.addEventListener('click', checkReviceAreaEvent)

        var cancelButton = document.createElement("button") 
        cancelButton.type = "button"   
        cancelButton.innerHTML = "취소"
        cancelButton.id = "cancel_button" + index
        cancelButton.className = "cancel_button"
        cancelButton.style.display = "none"
        cancelButton.addEventListener('click', deleteReviceAreaEvent)

        schedule.appendChild(hiddenIdx)
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
        createTimeOption("revice_hour_select" + index, "revice_minute_select" + index)
        if(timeBox.innerHTML.slice(0, 2) < 10){
            hourSelect.value = timeBox.innerHTML.slice(1, 2)
        }
        else{
            hourSelect.value = timeBox.innerHTML.slice(0, 2)
        }
        if(timeBox.innerHTML.slice(-2) < 10){
            minuteSelect.value = timeBox.innerHTML.slice(-1)
        }
        else{
            minuteSelect.value = timeBox.innerHTML.slice(-2)
        }
        
    }
}

function createTimeOption(hourId, minuteId, num){
    var hour = document.getElementById(hourId)
    var minute = document.getElementById(minuteId)
    hour.innerHTML =""
    minute.innerHTML =""
    var hourOption = document.createElement("option")
    hourOption.innerHTML = "시"
    hourOption.style.disabled = "true"
    hourOption.style.selected = "true"
    hourOption.style.display = "none"
    var minuteOption = document.createElement("option")
    minuteOption.innerHTML = "분"
    minuteOption.style.disabled = "true"
    minuteOption.style.selected = "true"
    minuteOption.style.display = "none"
    hour.appendChild(hourOption)
    minute.appendChild(minuteOption)
    for(var index = 0; index < 24; index++){
        var newOption = document.createElement("option")
        newOption.value = index
        if(index < 10){
            newOption.innerHTML = "0"+index
        }
        else{
            newOption.innerHTML = index
        }
        hour.appendChild(newOption)
    }
    for(var index = 0; index <= 59; index++){
        var newOption = document.createElement("option")
        newOption.value = index
        if(index < 10){
            newOption.innerHTML = "0"+index
        }
        else{
            newOption.innerHTML = index
        }
        minute.appendChild(newOption)
    }
}

