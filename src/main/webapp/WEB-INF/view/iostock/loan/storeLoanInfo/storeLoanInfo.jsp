<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix="f" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="menuCd" value="${sessionScope.sessionInfo.currentMenu.resrceCd}"/>
<c:set var="menuNm" value="${sessionScope.sessionInfo.currentMenu.resrceNm}"/>
<c:set var="baseUrl" value="/iostock/loan/storeLoanInfo/storeLoanInfo/"/>

<div class="subCon" ng-controller="storeLoanInfoCtrl">
  <div class="searchBar">
    <a href="#" class="open fl">${menuNm}</a>
    <%-- 조회 --%>
    <button class="btn_blue fr mt5 mr10" id="btnSearch" ng-click="searchStoreLoanInfo()"><s:message code="cmm.search"/></button>
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
      <td>
        <div class="sb-select">
          <span class="txtIn"><input id="srchStartDate" class="w110px"></span>
          <span class="rg">~</span>
          <span class="txtIn"><input id="srchEndDate" class="w110px"></span>
        </div>
      </td>
      <%-- 매장선택 --%>
      <th><s:message code="cmm.store.select"/></th>
      <td>
        <%-- 매장선택 모듈 사용시 include --%>
        <jsp:include page="/WEB-INF/view/common/popup/selectStore.jsp" flush="true">
          <jsp:param name="targetTypeFg" value="M"/>
          <jsp:param name="targetId" value="storeLoanInfoSelectStore"/>
        </jsp:include>
        <%--// 매장선택 모듈 사용시 include --%>
      </td>
    </tr>
    </tbody>
  </table>

<%--  <div class="mt10 oh sb-select dkbr">--%>
<%--    &lt;%&ndash; 엑셀 다운로드 &ndash;%&gt;--%>
<%--    &lt;%&ndash;<button id="btnExcel" class="btn_skyblue fr" ng-click="excelDown()"><s:message code="cmm.excel.down"/></button>&ndash;%&gt;--%>
<%--  </div>--%>

    <div class="mt10 oh sb-select dkbr">
        <%-- 엑셀다운로드 --%>
        <button class="btn_skyblue ml5 fr" ng-click="excelDownloadInfo()"><s:message code="cmm.excel.down"/></button>
    </div>

  <div class="w100 mt10">
    <%--위즈모 테이블--%>
    <div class="wj-gridWrap" style="height: 450px; overflow-x: hidden; overflow-y: hidden; ">
      <wj-flex-grid
        autoGenerateColumns="false"
        selection-mode="Row"
        items-source="data"
        control="flex"
        initialized="initGrid(s,e)"
        is-read-only="true"
        item-formatter="_itemFormatter"
        ime-enabled="true"
        id="wjGridStoreLoanInfoCtrl">

        <!-- define columns -->
        <wj-flex-grid-column header="<s:message code="storeLoanInfo.storeCd"/>" binding="storeCd" width="70" align="center" is-read-only="true"></wj-flex-grid-column>
        <wj-flex-grid-column header="<s:message code="storeLoanInfo.storeNm"/>" binding="storeNm" width="150" align="left" is-read-only="true"></wj-flex-grid-column>
        <wj-flex-grid-column header="<s:message code="storeLoanInfo.loanDate"/>" binding="loanDate" width="80" align="center" is-read-only="true" format="date"></wj-flex-grid-column>
        <wj-flex-grid-column header="<s:message code="storeLoanInfo.outAmt"/>" binding="outAmt" width="70" align="right" is-read-only="true" data-type="Number" format="n0"></wj-flex-grid-column>
        <wj-flex-grid-column header="<s:message code="storeLoanInfo.inAmt"/>" binding="inAmt" width="70" align="right" is-read-only="true" data-type="Number" format="n0"></wj-flex-grid-column>
        <wj-flex-grid-column header="<s:message code="storeLoanInfo.limitLoanAmt"/>" binding="limitLoanAmt" width="70" align="right" is-read-only="true" data-type="Number" format="n0" visible="false"></wj-flex-grid-column>
        <wj-flex-grid-column header="<s:message code="storeLoanInfo.currLoanAmt"/>" binding="currLoanAmt" width="70" align="right" is-read-only="true" data-type="Number" format="n0"></wj-flex-grid-column>
        <wj-flex-grid-column header="<s:message code="storeLoanInfo.remark"/>" binding="remark" width="*" align="left" is-read-only="true"></wj-flex-grid-column>

      </wj-flex-grid>
      <%-- ColumnPicker 사용시 include --%>
      <jsp:include page="/WEB-INF/view/layout/columnPicker.jsp" flush="true">
        <jsp:param name="pickerTarget" value="storeLoanInfoCtrl"/>
      </jsp:include>
      <%--// ColumnPicker 사용시 include --%>
    </div>
    <%--//위즈모 테이블--%>
  </div>
</div>

<script type="text/javascript" src="/resource/solbipos/js/iostock/loan/storeLoanInfo/storeLoanInfo.js?ver=20240627.01" charset="utf-8"></script>
