function showPwEvent(){
    var pwBox = document.getElementById("pw_box")
    var pwShowBox = document.getElementById("shown_pw_box")
    var pw = document.getElementsByClassName("pw_input")[0]
    var textpw = document.getElementsByClassName("pw_input")[1]
    pwBox.style.display = "none"
    pwShowBox.style.display = "flex"
    textpw.value = pw.value
}

function hidePwEvent(){
    var pwBox = document.getElementById("pw_box")
    var pwShowBox = document.getElementById("shown_pw_box")
    var pw = document.getElementsByClassName("pw_input")[0]
    var textpw = document.getElementsByClassName("pw_input")[1]
    pwBox.style.display = "flex"
    pwShowBox.style.display = "none"
    pw.value = textpw.value
}