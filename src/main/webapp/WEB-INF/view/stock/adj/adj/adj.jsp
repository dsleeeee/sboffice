<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="menuCd" value="${sessionScope.sessionInfo.currentMenu.resrceCd}"/>
<c:set var="menuNm" value="${sessionScope.sessionInfo.currentMenu.resrceNm}"/>
<c:set var="baseUrl" value="/stock/adj/adj/adj/"/>

<div class="subCon" ng-controller="adjCtrl">
  <div class="searchBar flddUnfld">
    <a href="#" class="open">${menuNm}</a>
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
      <%-- 조정일자 --%>
      <th><s:message code="adj.adjDate"/></th>
      <td colspan="3">
        <div class="sb-select">
          <span class="txtIn"><input id="srchStartDate" class="w150px"></span>
          <span class="rg">~</span>
          <span class="txtIn"><input id="srchEndDate" class="w150px"></span>
        </div>
      </td>
    </tr>
    <tr>
      <%-- 진행 --%>
      <th><s:message code="adj.procFg"/></th>
      <td colspan="3">
        <div class="sb-select">
          <span class="txtIn w150px">
            <wj-combo-box
              id="srchProcFg"
              ng-model="procFg"
              items-source="_getComboData('srchProcFg')"
              display-member-path="name"
              selected-value-path="value"
              is-editable="false"
              initialized="_initComboBox(s)">
            </wj-combo-box>
          </span>
        </div>
      </td>
    </tr>
    <tr>
      <%-- 조정등록 --%>
      <th><s:message code="adj.adjRegist"/></th>
      <td colspan="3">
        <div class="sb-select fl mr10">
          <span class="txtIn"><input id="adjDate" class="w120px" ng-model="adjDate"></span>
        </div>
        <a href="#" class="btn_grayS" ng-click="newAdj()"><s:message code="adj.adjRegist"/></a>
      </td>
    </tr>
    </tbody>
  </table>

  <div class="mt10 pdb20 oh bb">
    <%-- 조회 --%>
    <button class="btn_blue fr" id="btnSearch" ng-click="_pageView('adjCtrl', 1)">
      <s:message code="cmm.search"/></button>
  </div>

  <div class="mt20 tr">
    <%-- 삭제 --%>
    <button type="button" class="btn_skyblue ml5" id="btnDelete" ng-click="deleteAdj()">
      <s:message code="cmm.delete"/></button>
  </div>

  <div class="w100 mt10">
    <%--위즈모 테이블--%>
    <div class="wj-gridWrap" style="height: 350px; overflow-x: hidden; overflow-y: hidden;">
      <wj-flex-grid
        autoGenerateColumns="false"
        selection-mode="Row"
        items-source="data"
        control="flex"
        initialized="initGrid(s,e)"
        is-read-only="false"
        item-formatter="_itemFormatter">

        <!-- define columns -->
        <wj-flex-grid-column header="<s:message code="cmm.chk"/>" binding="gChk" width="40" align="center" is-read-only="false"></wj-flex-grid-column>
        <wj-flex-grid-column header="<s:message code="adj.adjDate"/>" binding="adjDate" width="90" align="center" is-read-only="true" format="date"></wj-flex-grid-column>
        <wj-flex-grid-column header="<s:message code="adj.seqNo"/>" binding="seqNo" width="40" align="center" is-read-only="true"></wj-flex-grid-column>
        <wj-flex-grid-column header="<s:message code="adj.procFg"/>" binding="procFg" width="50" align="center" is-read-only="true" data-map="procFgMap"></wj-flex-grid-column>
        <wj-flex-grid-column header="<s:message code="adj.adjTitle"/>" binding="adjTitle" width="*" align="left" is-read-only="true"></wj-flex-grid-column>
        <wj-flex-grid-column header="<s:message code="adj.dtlCnt"/>" binding="dtlCnt" width="50" align="right" is-read-only="true" data-type="Number" format="n0"></wj-flex-grid-column>
        <wj-flex-grid-column header="<s:message code="adj.regDate"/>" binding="regDate" width="90" align="center" is-read-only="true" format="date"></wj-flex-grid-column>
        <wj-flex-grid-column header="<s:message code="adj.confmDate"/>" binding="confmDate" width="90" align="center" is-read-only="true" format="date"></wj-flex-grid-column>
        <wj-flex-grid-column header="<s:message code="adj.adjStorageCd"/>" binding="adjStorageCd" width="0" align="center" is-read-only="true" format="date"></wj-flex-grid-column>

      </wj-flex-grid>
      <%-- ColumnPicker 사용시 include --%>
      <jsp:include page="/WEB-INF/view/layout/columnPicker.jsp" flush="true">
        <jsp:param name="pickerTarget" value="adjCtrl"/>
      </jsp:include>
      <%--// ColumnPicker 사용시 include --%>
    </div>
    <%--//위즈모 테이블--%>
  </div>
  <%-- 페이지 리스트 --%>
  <div class="pageNum mt20">
    <%-- id --%>
    <ul id="adjCtrlPager" data-size="10">
    </ul>
  </div>
  <%--//페이지 리스트--%>

</div>

<script type="text/javascript" src="/resource/solbipos/js/stock/adj/adj/adj.js?ver=20200904.01" charset="utf-8"></script>

<%-- 조정 상세 레이어 --%>
<c:import url="/WEB-INF/view/stock/adj/adj/adjDtl.jsp">
  <c:param name="menuCd" value="${menuCd}"/>
  <c:param name="menuNm" value="${menuNm}"/>
</c:import>

<%-- 조정 등록 레이어 --%>
<c:import url="/WEB-INF/view/stock/adj/adj/adjRegist.jsp">
  <c:param name="menuCd" value="${menuCd}"/>
  <c:param name="menuNm" value="${menuNm}"/>
</c:import>
