/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

var menus_show_properties_type_callDocumentReady_called = false;

$(document).ready(function () {
    if (!menus_show_properties_type_callDocumentReady_called)
    {
        menus_show_properties_type_callDocumentReady_called = true;
        if ($("#as_window").text() == "true")
        {
//  alert("it is a window");
        } else
        {
            menus_show_properties_type_callDocumentReady();
        }
    }
});
    
function menus_show_properties_type_callDocumentReady()
{
    
}