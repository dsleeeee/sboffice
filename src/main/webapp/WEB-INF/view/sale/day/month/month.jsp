<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="menuCd" value="${sessionScope.sessionInfo.currentMenu.resrceCd}"/>
<c:set var="menuNm" value="${sessionScope.sessionInfo.currentMenu.resrceNm}"/>

<div class="con" id="monthView">
    <div class="tabType1" ng-controller="monthCtrl" ng-init="init()">
        월별
    </div>
</div>

<script type="text/javascript">

</script>

<script type="text/javascript" src="/resource/solbipos/js/sale/day/month/month.js?ver=20191119" charset="utf-8"></script>