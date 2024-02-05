function insertHipenEvent(e){
    if(e.target.value.length < 14){
        e.target.value =  e.target.value.replace(/[^0-9]/g, '').replace(/^(\d{0,3})(\d{0,4})(\d{0,4})$/g, "$1-$2-$3").replace(/(\-{1,2})$/g, "")
    }
    else{
        e.target.value = e.target.value.substr(0, 13)
    }
}