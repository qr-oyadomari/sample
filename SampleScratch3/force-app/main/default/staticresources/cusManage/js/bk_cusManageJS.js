$(function(){
window.onload = function() {
    console.log('window.onload���s');
    alert('window.onload���s');
    setDispInit();
};
function setDispInit() {
    var elem = document.getElementById("cusManageList");
    elem.setAttribute("_fixedhead", "rows:1; cols:1");
    
    FixedMidashi.create();
}
});