<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="f" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
String mobile_url = "";
System.out.println(request.getRequestURL());
if     (request.getRequestURL().indexOf("://192") > 0 || request.getRequestURL().indexOf("://localhost") > 0 )  { mobile_url = "http://192.168.0.85:22001/mobile/login/login_form.jsp"; }
else if(request.getRequestURL().indexOf("://neo.solbipos.com") > 0  )                                           { mobile_url = "http://mob.solbipos.com/mobile/login/login_form.jsp"; }
%>

<div class="loginArea">
  <h2>Welcome Login</h2>

  <f:form class="loginF" modelAttribute="sessionInfo" method="post" action="/mobile/auth/login.sb">

    <%--     <s:eval expression="@env['login.check.id.save']" var="idField"/> --%>

    <c:if test="${userId == '' || userId ne null}">
      <c:set var="cid" value="${userId}" />
    </c:if>
    <c:if test="${userId eq null}">
      <c:set var="cid" value="${cookie.saveid.value}" />
    </c:if>

    <c:if test="${cookie.sb_login_auto_serial.value != '' && cookie.sb_login_auto_serial.value ne null}">
      <c:set var="cAutoLogin" value="${cookie.sb_login_auto_serial.value}" />
    </c:if>

    <div class="writeInfo">
      <div>
        <input class="id" type="text" id="userId" name="userId"
          placeholder="<s:message code="login.userId"/>" value="${cid}" maxlength="20" /><label
          for="userId"></label>
        <f:errors path="userId" id="userIdError" class="errorMsg" />
      </div>
      <div>
        <input class="pw" type="password" id="userPwd" name="userPwd"
          placeholder="<s:message code="login.userPasswd"/>" maxlength="25" /><label
          for="userPwd"></label>
        <f:errors path="userPwd" id="userPwdError" class="errorMsg" />
      </div>
    </div>

    <div class="idsave">
      <span> <input type="checkbox" id="chk" name="chk"
        ${empty cid ? '' : 'checked="checked"' } />
        <label for="chk">
          <s:message code="login.rememberId" />
        </label>
      </span>
      <button class="btn_login">
        <s:message code="login.submit" />
      </button>
    </div>
    <div class="idsave">
      <span> <input type="checkbox" id="chkAutoLogin" name="chkAutoLogin"
        ${empty cAutoLogin ? '' : 'checked="checked"' } />
          <label for="chkAutoLogin">
            <s:message code="login.autoLogin" />
          </label>
        </span>
    </div>
  </f:form>

  <div class="linkArea">
    <span class="find"> <a href="/user/idFind.sb" class="fdId">
        <s:message code="login.find.id" />
      </a> <a href="/user/pwdFind.sb" class="fdPw">
        <s:message code="login.find.pw" />
      </a>
    </span>
    <a href="<%=mobile_url%>" class="btn_mobile_login">
    <s:message code="mobile.login.submit" />
    </a>
    <a href="http://www.solbipos.com" target="_blank" class="distributor">
      <s:message code="login.add.dist" />
    </a>
    <a href="http://www.solbipos.com" target="_blank" class="agency">
      <s:message code="login.add.agency" />
    </a>
  </div>

</div>

<c:import url="/WEB-INF/view/application/layer/alert.jsp">
</c:import>

<c:if test="${type == 'pwChg' || type == 'pwExpire'}">
  <c:import url="/WEB-INF/view/application/layer/pwChgPop.jsp">
    <c:param name="type" value="${type}" />
  </c:import>
</c:if>

<script>
	genEventSingle($("#userId"));
  	genEventSingle($("#userPwd"));
  	<c:if test="${type == 'pwChg' || type == 'pwExpire'}">
  		var id = "${cid}";
  		$("#labelUserId").text(id);
  		$("#pwdUserId").val(id);
  		$("#fullDimmedPw").show();
      	$("#layerpw").show();
	</c:if>
</script>



















