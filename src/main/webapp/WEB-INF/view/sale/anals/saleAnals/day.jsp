<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="menuCd" value="${sessionScope.sessionInfo.currentMenu.resrceCd}"/>
<c:set var="menuNm" value="${sessionScope.sessionInfo.currentMenu.resrceNm}"/>
<c:set var="orgnFg" value="${sessionScope.sessionInfo.orgnFg}"/>

<div id="dayView" name="dayView" class="subCon" ng-controller="dayCtrl" style="padding: 10px 20px 40px;">
  <div class="searchBar">
    <a href="#" class="open fl"><s:message code="saleAnals.day"/></a>
    <%-- 조회 --%>
    <button class="btn_blue fr mt5 mr10" id="btnSearch" ng-click="_broadcast('dayCtrl')">
      <s:message code="cmm.search"/>
    </button>
  </div>
  <table class="searchTbl">
    <colgroup>
      <col class="w15"/>
      <col class="w35"/>
      <col class="w15"/>
      <col class="w35"/>
    </colgroup>
    <tbody>
    <tr>
      <%-- 조회일자 --%>
      <th><s:message code="cmm.search.date"/></th>
      <td colspan="3">
        <div class="sb-select">
          <span class="txtIn"><input id="srchDayStartDate" class="w110px"></span>
          <span class="rg">~</span>
          <span class="txtIn"><input id="srchDayEndDate" class="w110px"></span>
        </div>
      </td>
    </tr>
    <c:if test="${sessionInfo.orgnFg == 'HQ'}">
      <tr>
        <%-- 매장선택 --%>
        <th><s:message code="cmm.store.select"/></th>
        <td colspan="3">
          <%-- 매장선택 모듈 사용시 include --%>
          <jsp:include page="/WEB-INF/view/common/popup/selectStore.jsp" flush="true">
            <jsp:param name="targetTypeFg" value="M"/>
            <jsp:param name="targetId" value="daySelectStore"/>
          </jsp:include>
          <%--// 매장선택 모듈 사용시 include --%>
        </td>
      </tr>
    </c:if>
    <c:if test="${sessionInfo.orgnFg == 'STORE'}">
      <input type="hidden" id="daySelectStoreCd" value="${sessionInfo.storeCd}"/>
    </c:if>
    </tbody>
  </table>
  <div style="clear: both;"></div>

  <div class="mt10 oh sb-select dkbr">
    <%-- 엑셀다운로드 --%>
    <button class="btn_skyblue ml5 fr" ng-click="excelDownloadInfo()"><s:message code="cmm.excel.down"/></button>
  </div>

  <div class="w100 mt10">
    <%--위즈모 테이블--%>
    <div class="wj-gridWrap" style="height: 400px; overflow-y: hidden; overflow-x: hidden;">
      <wj-flex-grid
        autoGenerateColumns="false"
        selection-mode="Row"
        items-source="data"
        control="flex"
        initialized="initGrid(s,e)"
        is-read-only="true"
        item-formatter="_itemFormatter">

        <!-- define columns -->
        <wj-flex-grid-column header="<s:message code="day.dayTotal.saleDate"/>" binding="saleDate" width="80" align="center" is-read-only="true"></wj-flex-grid-column>
        <wj-flex-grid-column header="<s:message code="day.dayTotal.yoil"/>" binding="yoil" width="60" align="center" is-read-only="true"></wj-flex-grid-column>
        <wj-flex-grid-column header="<s:message code="day.dayTotal.storeCd"/>" binding="storeCd" width="80" align="center" is-read-only="true"></wj-flex-grid-column>
        <wj-flex-grid-column header="<s:message code="day.dayTotal.storeNm"/>" binding="storeNm" width="100" align="left" is-read-only="true"></wj-flex-grid-column>
        <wj-flex-grid-column header="<s:message code="day.dayTotal.totSaleAmt"/>" binding="totSaleAmt" width="100" align="right" is-read-only="true" aggregate="Sum"></wj-flex-grid-column>
        <wj-flex-grid-column header="<s:message code="day.dayTotal.totDcAmt"/>" binding="totDcAmt" width="100" align="right" is-read-only="true" aggregate="Sum"></wj-flex-grid-column>
        <wj-flex-grid-column header="<s:message code="day.dayTotal.realSaleAmt"/>" binding="realSaleAmt" width="100" align="right" is-read-only="true" aggregate="Sum"></wj-flex-grid-column>
        <wj-flex-grid-column header="<s:message code="day.dayTotal.billCnt"/>" binding="billCnt" width="70" align="right" is-read-only="true" aggregate="Sum"></wj-flex-grid-column>
        <wj-flex-grid-column header="<s:message code="day.dayTotal.billUprc"/>" binding="billUprc" width="70" align="right" is-read-only="true"></wj-flex-grid-column>
        <wj-flex-grid-column header="<s:message code="day.dayTotal.gaAmt"/>" binding="gaAmt" width="100" align="right" is-read-only="true" aggregate="Sum"></wj-flex-grid-column>
        <wj-flex-grid-column header="<s:message code="day.dayTotal.vatAmt"/>" binding="vatAmt" width="100" align="right" is-read-only="true" aggregate="Sum"></wj-flex-grid-column>
        <wj-flex-grid-column header="<s:message code="day.dayTotal.totTipAmt"/>" binding="totTipAmt" width="70" align="right" is-read-only="true" aggregate="Sum"></wj-flex-grid-column>
        <wj-flex-grid-column header="<s:message code="day.dayTotal.totEtcAmt"/>" binding="totEtcAmt" width="70" align="right" is-read-only="true" aggregate="Sum"></wj-flex-grid-column>
        <wj-flex-grid-column header="<s:message code="day.dayTotal.cupAmt"/>" binding="cupAmt" width="70" align="right" is-read-only="true" aggregate="Sum"></wj-flex-grid-column>
        <wj-flex-grid-column header="<s:message code="day.dayTotal.totPayAmt"/>" binding="totPayAmt" width="100" align="right" is-read-only="true" aggregate="Sum"></wj-flex-grid-column>
        <%-- 결제수단 컬럼 생성--%>
        <c:forEach var="payCol" items="${payColList}">
          <wj-flex-grid-column header="${payCol.payNm}" binding="pay${payCol.payCd}" width="100" align="right" is-read-only="true" aggregate="Sum"></wj-flex-grid-column>
        </c:forEach>
        <wj-flex-grid-column header="<s:message code="day.dayTotal.genRealSaleAmt"/>" binding="genRealSaleAmt" width="100" align="right" is-read-only="true" aggregate="Sum"></wj-flex-grid-column>
        <wj-flex-grid-column header="<s:message code="day.dayTotal.genRealSaleRate"/>" binding="genRealSaleRate" width="100" align="right" is-read-only="true"></wj-flex-grid-column>
        <wj-flex-grid-column header="<s:message code="day.dayTotal.dlvrRealSaleAmt"/>" binding="dlvrRealSaleAmt" width="100" align="right" is-read-only="true" aggregate="Sum"></wj-flex-grid-column>
        <wj-flex-grid-column header="<s:message code="day.dayTotal.dlvrRealSaleRate"/>" binding="dlvrRealSaleRate" width="100" align="right" is-read-only="true"></wj-flex-grid-column>
        <wj-flex-grid-column header="<s:message code="day.dayTotal.packRealSaleAmt"/>" binding="packRealSaleAmt" width="100" align="right" is-read-only="true" aggregate="Sum"></wj-flex-grid-column>
        <wj-flex-grid-column header="<s:message code="day.dayTotal.packRealSaleRate"/>" binding="packRealSaleRate" width="100" align="right" is-read-only="true"></wj-flex-grid-column>

      </wj-flex-grid>
      <%-- ColumnPicker 사용시 include --%>
      <jsp:include page="/WEB-INF/view/layout/columnPicker.jsp" flush="true">
        <jsp:param name="pickerTarget" value="dayCtrl"/>
      </jsp:include>
      <%--// ColumnPicker 사용시 include --%>
    </div>
    <%--//위즈모 테이블--%>
  </div>
</div>

<script>
  var orgnFg = "${orgnFg}";
</script>
<script type="text/javascript" src="/resource/solbipos/js/sale/anals/saleAnals/day.js?ver=20240605.01" charset="utf-8"></script>