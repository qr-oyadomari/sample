window.onload = function() {
    console.log('window.onload実行');
    alert('window.onload実行');
    setDispInit();
};
function setDispInit() {
    var elem = document.getElementById("cusManageList");
    elem.setAttribute("_fixedhead", "rows:1; cols:1");
    
    FixedMidashi.create();
}
