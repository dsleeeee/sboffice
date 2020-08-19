<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="menuCd" value="${sessionScope.sessionInfo.currentMenu.resrceCd}"/>
<c:set var="menuNm" value="${sessionScope.sessionInfo.currentMenu.resrceNm}"/>
<c:set var="baseUrl" value="/base/store/empStore"/>

<div class="con">
    <div class="tabType1" ng-controller="empStoreCtrl" ng-init="init()">
        <ul>
            <%-- 사원별 탭 --%>
            <li>
                <a id="empStoreEmpTab" href="#" class="on" ng-click="empStoreEmpShow()"><s:message code="empStore.emp"/></a>
            </li>
            <%-- 매장별 탭 --%>
            <li>
                <a id="empStoreStoreTab" href="#" ng-click="empStoreStoreShow()"><s:message code="empStore.store"/></a>
            </li>
        </ul>
    </div>
</div>

<script type="text/javascript" src="/resource/solbipos/js/base/store/empStore/empStore.js?ver=20200513.04" charset="utf-8"></script>

<%-- 탭페이지 레이어 시작 --%>
<%-- 사원별 레이어 --%>
<c:import url="/WEB-INF/view/base/store/empStore/emp.jsp">
    <c:param name="menuCd" value="${menuCd}"/>
    <c:param name="menuNm" value="${menuNm}"/>
</c:import>

<%-- 매장별 레이어 --%>
<c:import url="/WEB-INF/view/base/store/empStore/store.jsp">
    <c:param name="menuCd" value="${menuCd}"/>
    <c:param name="menuNm" value="${menuNm}"/>
</c:import>
<%-- 탭페이지 레이어 끝 --%>