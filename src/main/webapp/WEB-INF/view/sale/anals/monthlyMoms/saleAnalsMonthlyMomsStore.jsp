<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="menuCd" value="${sessionScope.sessionInfo.currentMenu.resrceCd}"/>
<c:set var="menuNm" value="${sessionScope.sessionInfo.currentMenu.resrceNm}"/>
<c:set var="orgnFg" value="${sessionScope.sessionInfo.orgnFg}" />
<c:set var="baseUrl" value="/sale/anals/monthly/monthlyPop/"/>

<wj-popup id="monthlyMomsStoreLayer" control="monthlyMomsStoreLayer" show-trigger="Click" hide-trigger="Click" style="display:none;width:800px;">
  <div id="cardLayer" class="wj-dialog wj-dialog-columns" ng-controller="saleAnalsMonthlyMomsStoreCtrl">
    <div class="wj-dialog-header wj-dialog-header-font">
      <span id="spanTitle"></span>
      <a href="#" class="wj-hide btn_close"></a>
    </div>
    <div class="wj-dialog-body sc2" style="height: 400px;">

      <div class="w100 mt10">
        <%--위즈모 테이블--%>
	    <div class="w100 mt10">
	      <div class="wj-gridWrap" style="height: 340px; overflow-x: hidden; overflow-y: hidden;">
	        <wj-flex-grid
	          autoGenerateColumns="false"
	          control="flex"
	          initialized="initGrid(s,e)"
	          sticky-headers="true"
	          selection-mode="Row"
	          items-source="data"
	          is-read-only="true"
	          item-formatter="_itemFormatter">

	          <!-- define columns -->
	          <wj-flex-grid-column header="<s:message code="saleAnalsMonthly.storeCd"/>" 		binding="storeCd" 		width="100" align="center"></wj-flex-grid-column>
	          <wj-flex-grid-column header="<s:message code="saleAnalsMonthly.storeNm"/>" 		binding="storeNm" 		width="160" align="left"></wj-flex-grid-column>
	          <wj-flex-grid-column header="<s:message code="saleAnalsMonthly.saleDate"/>" 		binding="saleDate" 		width="100" align="center"></wj-flex-grid-column>
	          <wj-flex-grid-column header="<s:message code="saleAnalsMonthly.billCnt"/>" 		binding="billCnt" 		width="100" align="center" aggregate="Sum"></wj-flex-grid-column>
          	  <wj-flex-grid-column header="<s:message code="saleAnalsMonthly.realSaleAmt"/>"	binding="realSaleAmt" 	width="130" align="right" aggregate="Sum"></wj-flex-grid-column>
			</wj-flex-grid>
	      </div>
	      <%-- ColumnPicker 사용시 include --%>
          <jsp:include page="/WEB-INF/view/layout/columnPicker.jsp" flush="true">
            <jsp:param name="pickerTarget" value="saleAnalsMonthlyMomsStoreCtrl"/>
          </jsp:include>
          <%--// ColumnPicker 사용시 include --%>
	    </div>
	    <%--//위즈모 테이블--%>
      </div>
    </div>
  </div>
</wj-popup>

<script type="text/javascript" src="/resource/solbipos/js/sale/anals/monthlyMoms/saleAnalsMonthlyMomsStore.js?ver=20250106.01" charset="utf-8"></script>

<%-- 영수증 팝업 상세 레이어 --%>
<%-- <c:import url="/WEB-INF/view/sale/com/popup/billSalePop.jsp">--%>
<%--   <c:param name="menuCd" value="${menuCd}"/>--%>
<%--   <c:param name="menuNm" value="${menuNm}"/>--%>
<%-- </c:import>--%>

<c:import url="/WEB-INF/view/sale/anals/monthlyMoms/saleAnalsMonthlyMomsStoreDtl.jsp">
	<c:param name="menuCd" value="${menuCd}"/>
	<c:param name="menuNm" value="${menuNm}"/>
</c:import>