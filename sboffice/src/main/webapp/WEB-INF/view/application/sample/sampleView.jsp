<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix="f" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

sampleView-View 


<br>
<br>
1
<br>


${sessionScope.sessionInfo.fixMenu[0].activation}
<br>

<br>
1
<br>
<br>


<button id="registBtn" type="button" class="btn btn_dark btn_md w_lg" onclick="popOpen();">
  팝업
</button>

<br>

<a href="exRedis.sb">레디스 이동</a>
<br>

<a href="sample3.sb">이동</a>
<br>
<a href="sample2.sb">샘플 2 이동</a>
<br>
<button id="registBtn" type="button" class="btn btn_dark btn_md w_lg" onclick="ajaxTest();">
  Ajax
</button>

<script>

function popOpen() {
	$.open("samplepop.sb", { method:'get', width:'800px', height:'390px' } );	
}


function ajaxTest() {
	var paramStr = "";
	
	$.postJSON( "/samplejson.sb", paramStr, function( result ){
		var s = "result : " + result.status + ", dataSize : " + result.data.length;
		alert(s);
	})
	// 오류발생 시 
	.fail(function(){
		alert("Ajax Fail");
	});
}



</script>





