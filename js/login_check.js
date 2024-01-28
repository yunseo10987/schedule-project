function checkLogin(){
    var idValue = document.getElementById("input_id").value
    var pwValue = document.getElementById("input_pw").value 
    var regId = /^(?=.*\d)(?=.*[a-z])[0-9a-z]{8,12}$/
    var regPw = /^(?=.*[a-zA-z])(?=.*[0-9])(?=.*[$`~!@$!%*#^?&\\(\\)\-_=+]).{8,16}$/
    if(!regId.test(idValue)){
        alert("아이디를 확인해주세요")
        return false
    }
    if(!regPw.test(pwValue)){
        alert("비밀번호를 확인해주세요")
        return false
    }
    return true
}