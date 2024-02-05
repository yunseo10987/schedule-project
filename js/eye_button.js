function expressPwEvent(e, anotherButtonId ,pwId){
    var pwInput = document.getElementById(pwId)
    if(pwInput.type == "password"){
        pwInput.type = "text"
        e.target.style.display = "none"
        document.getElementById(anotherButtonId).style.display = "inline-block"
    }
    else{
        pwInput.type = "password"
        e.target.style.display = "none"
        document.getElementById(anotherButtonId).style.display = "inline-block"
    }
}
