$(function(){
window.onload = function() {
    console.log('window.onloadé¿çs');
    alert('window.onloadé¿çs');
    setDispInit();
};
function setDispInit() {
    var elem = document.getElementById("cusManageList");
    elem.setAttribute("_fixedhead", "rows:1; cols:1");
    
    FixedMidashi.create();
}
});