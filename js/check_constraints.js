function showPw(){
    var pwBox = document.getElementById("pw_box")
    var pwShowBox = document.getElementById("show_pw_box")
    var pw = document.getElementsByClassName("input_pw")[0]
    var textpw = document.getElementsByClassName("input_pw")[1]
    pwBox.style.display = "none"
    pwShowBox.style.display = "flex"
    textpw.value = pw.value
}

function hidePw(){
    var pwBox = document.getElementById("pw_box")
    var pwShowBox = document.getElementById("show_pw_box")
    var pw = document.getElementsByClassName("input_pw")[0]
    var textpw = document.getElementsByClassName("input_pw")[1]
    pwBox.style.display = "flex"
    pwShowBox.style.display = "none"
    pw.value = textpw.value
}

function checkConstraints(idFlag, pwFlag, nameFlag, phoneFlag){
    //제약조건 유효성 검사
    //아이디의 경우에는 중복 확인 검사 버튼이 있는지 없는 지 확인하고 있으면 disabled 되어야 통과
}