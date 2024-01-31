function checkConstraintsEvent(option){
    var regId =  /^(?=.*\d)(?=.*[a-z])[0-9a-z]{8,12}$/
    var regPw = /^(?=.*[a-zA-z])(?=.*[0-9])(?=.*[$`~!@$!%*#^?&\\(\\)\-_=+]).{8,16}$/
    var regTelNum = /^\d{3}-\d{3,4}-\d{4}$/
    

    if(option.id == true){
        var idInput = document.getElementById("id_input")
        var duplicatedIdButton = document.getElementById("duplicated_id_button")
        if(!regId.test(idInput.value)){
            alert("아이디를 확인해주세요")
            return false
        }
        if(duplicatedIdButton){
            if(duplicatedIdButton.disabled == false){
                alert("아이디 중복을 확인해주세요")
                return false
            }
        }    
    }
    if(option.pw == true){
        var pwBox = document.getElementById("pw_box")
        var pwInput = document.getElementsByClassName("pw_input")[0]
        var shownPwInput = document.getElementsByClassName("pw_input")[1]
        if(!shownPwInput || window.getComputedStyle(pwBox).display == "flex"){
            if(!regPw.test(pwInput.value)){
                alert("비밀번호를 확인해주세요")
                return false
            }
        }
        else{
            if(!regPw.test(shownPwInput.value)){
                alert("비밀번호를 확인해주세요")
                return false
            }
        }
    }
    if(option.name == true){
        var nameInput = document.getElementById("name_input")
        if(nameInput.value.length > 12 || nameInput.value.length < 1){
            alert("이름을 확인해주세요")
            return false
        }
    }
    if(option.telNum == true){
        var telInput = document.getElementById("tel_input")
        if(!regTelNum.test(telInput.value)){
            alert("연락처를 확인해주세요")
            return false
        }
    }
}

function checkScheduleInputEvent(){
    var writingBox = document.getElementById("content_writing_box")
    var hourBox = document.getElementById("hour_select")
    var minuteBox = document.getElementById("minute_select")
    if(writingBox.value.length == 0){
        alert("텍스트를 입력하세요")
        return false
    }
    if(writingBox.value.length >100){
        alert("100자 내외로 작성하세요")
        return false
    }
    if(hourBox.value == "" || minuteBox.value == ""){
        alert("시간을 입력하세요")
        return false
    }
    return true
}