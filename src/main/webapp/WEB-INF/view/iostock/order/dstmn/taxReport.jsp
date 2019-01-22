<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="menuCd" value="${sessionScope.sessionInfo.currentMenu.resrceCd}"/>
<c:set var="menuNm" value="${sessionScope.sessionInfo.currentMenu.resrceNm}"/>
<c:set var="baseUrl" value="/iostock/order/dstmn/taxReport/"/>

<wj-popup id="wjTaxReportLayer" control="wjTaxReportLayer" show-trigger="Click" hide-trigger="Click" style="display:none;width:900px;">
  <div id="taxReportLayer" class="wj-dialog wj-dialog-columns" ng-controller="taxReportCtrl">
    <div class="wj-dialog-header wj-dialog-header-font">
      <a href="#" class="wj-hide btn_close"></a>
    </div>
    <div class="wj-dialog-body sc2" style="height: 600px;">
      <div class="mt5 mb10 tr">
        <%-- 인쇄 --%>
        <button type="button" class="btn_skyblue ml5" id="btnPrint" ng-click="print()">
          <s:message code="cmm.print"/></button>
      </div>

      <div class="taxReport reportPrint w100" id="taxReport">
      </div>

    </div>
  </div>
</wj-popup>

<script type="text/javascript" src="/resource/solbipos/js/iostock/order/dstmn/taxReport.js?ver=20190116.01" charset="utf-8"></script>
