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

function createDayButton(){
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
        newDayButton.id = "day_button" + (index + 1)
        parentTd.appendChild(newDayButton) 
    }
    return maxDay
}
function createTimeOption(){
    var hour = document.getElementById("hour_select")
    var minute = document.getElementById("minute_select")
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
    for(var index = 0; index <= 24; index++){
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
function createReviceTimeOption(num){
    var hour = document.getElementById("revice_hour_select" + num)
    var minute = document.getElementById("revice_minute_select" + num)
    hour.innerHTML =""
    minute.innerHTML =""
    var hourOption = document.createElement("option")
    hourOption.innerHTML = "시"
    hourOption.value = ""
    hourOption.style.disabled = "true"
    hourOption.style.selected = "true"
    hourOption.style.display = "none"
    var minuteOption = document.createElement("option")
    minuteOption.innerHTML = "분"
    minuteOption.value =""
    minuteOption.style.disabled = "true"
    minuteOption.style.selected = "true"
    minuteOption.style.display = "none"
    hour.appendChild(hourOption)
    minute.appendChild(minuteOption)
    for(var index = 0; index <= 24; index++){
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