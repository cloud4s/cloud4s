function collapseDropDown() {
    var menu = document.getElementById("dropDownMenu");
    if(menu.hasAttribute("hidden")){
        menu.removeAttribute("hidden");
    }
    else{
        menu.setAttribute("hidden","true");
    }

}