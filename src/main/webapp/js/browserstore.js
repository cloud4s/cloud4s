/**
 * Created by Chanu MR on 12/30/2014.
 */

function get_value(){

    var value = $.jStorage.get("${pageContext.request.userPrincipal.name}");

    alert(value);

    return value;
}


function insert_value(){

    var row = new Element("tr"),
        key = $('inputName').value,
        val = $('inputKey').value;
    if (!key) {
        $('inputName').focus();
        return;
    }
    $.jStorage.set(key, val);
}





