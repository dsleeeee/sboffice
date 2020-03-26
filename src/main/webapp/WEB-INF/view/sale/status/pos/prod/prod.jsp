<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="menuCd" value="${sessionScope.sessionInfo.currentMenu.resrceCd}"/>
<c:set var="menuNm" value="${sessionScope.sessionInfo.currentMenu.resrceNm}"/>
<c:set var="orgnFg" value="${sessionScope.sessionInfo.orgnFg}" />
<c:set var="orgnCd" value="${sessionScope.sessionInfo.orgnCd}" />

<div id="posProdView" class="subCon" style="display: none;" ng-controller="posProdCtrl">
	<div class="searchBar flddUnfld">
		<a href="#" class="open fl"><s:message code="pos.day"/></a>
		<%-- 조회 --%>
		<button class="btn_blue fr mt5 mr10" id="btnPosProdSearch" ng-click="_broadcast('posProdCtrlSrch')">
			<s:message code="cmm.search"/>
		</button>
	</div>
	<table class="searchTbl">
		<colgroup>
			<col class="w15"/>
			<col class="w35"/><col class="w15"/>
        	<col class="w35"/>
       	</colgroup>
       	<tbody>
       		<tr>
       			<th><s:message code="cmm.search.date"/></th>
       			<td>
					<div class="sb-select">
						<span class="txtIn"><input id="srchPosProdStartDate" class="w120px"></span>
						<span class="rg">~</span>
						<span class="txtIn"><input id="srchPosProdEndDate" class="w120px"></span>
						<span class="chk ml10">
							<input type="checkbox" ng-model="isChecked" ng-change="isChkDt()" />
							<label for="chkDt">
								<s:message code="cmm.all.day" />
							</label>
						</span>
					</div>
				</td>

				<c:if test="${sessionInfo.orgnFg == 'HQ'}">
					<input type="hidden" id="posProdSelectStoreCd" value=""/>
					<tr>
						<%-- 매장코드 --%>
						<th><s:message code="todayBillSaleDtl.store"/></th>
						<td>
							<%-- 매장선택 모듈 멀티 선택 사용시 include --%>
<%-- 							<jsp:include page="/WEB-INF/view/sale/status/pos/cmm/selectStoreM.jsp" flush="true"> --%>
							<jsp:include page="/WEB-INF/view/iostock/cmm/selectStoreS.jsp" flush="true">
								<jsp:param name="targetId" value="posProdSelectStore"/>
								<jsp:param name="targetPosId" value="posProdSelectPos"/>
								<jsp:param name="closeFunc" value="getPosNmList"/>
							</jsp:include>
							<%--// 매장선택 모듈 멀티 선택 사용시 include --%>
						</td>
					</tr>
				</c:if>
				<c:if test="${sessionInfo.orgnFg == 'STORE'}">
					<input type="hidden" id="posProdSelectStoreCd" value="${sessionInfo.storeCd}"/>
				</c:if>

				<input type="hidden" id="posProdSelectPosCd" value=""/>
				<input type="hidden" id="posProdSelectPosName" value=""/>
				<input type="hidden" id="posProdSelectHqOfficeCd" value="${sessionInfo.hqOfficeCd}"/>
				<tr>
					<%-- 포스선택 --%>
					<th><s:message code="pos.pos" /></th>
					<td>
						<%-- 포스선택 모듈 멀티 선택 사용시 include --%>
						<jsp:include page="/WEB-INF/view/sale/status/pos/cmm/selectPosM.jsp" flush="true">
							<jsp:param name="targetId" value="posProdSelectPos"/>
							<jsp:param name="targetStoreId" value="posProdSelectStore"/>
							<jsp:param name="closeFunc" value="getPosNmList"/>
						</jsp:include>
						<%--// 매장선택 모듈 멀티 선택 사용시 include --%>
					</td>
				</tr>

			</tr>
		</tbody>
	</table>
	<div style="clear: both;"></div>

	<div class="mt20 oh sb-select dkbr">
		<%-- 페이지 스케일  --%>
		<wj-combo-box
			class="w100px fl"
			id="posProdListScaleBox"
			ng-model="posProdListScale"
			items-source="_getComboData('posProdListScaleBox')"
			display-member-path="name"
			selected-value-path="value"
			is-editable="false"
			initialized="initComboBox(s)">
		</wj-combo-box>

		<%-- 엑셀 다운로드 //TODO --%>
		<button class="btn_skyblue fr" ng-click="excelDownloadDay()">
			<s:message code="cmm.excel.down" />
		</button>
	</div>

	<%--위즈모 테이블--%>
    <div class="w100 mt10" id="wjWrapType3">
      <div class="wj-gridWrap">
			<wj-flex-grid
				id="posProdGrid"
				autoGenerateColumns="false"
				selection-mode="Row"
				items-source="data"
				control="flex"
				initialized="initGrid(s,e)"
				loaded-rows="loadedRows(s,e)"
				is-read-only="true"
				frozen-columns="10"
				item-formatter="_itemFormatter">
				<!-- define columns -->
				<wj-flex-grid-column header="<s:message code="prodrank.prodClassLNm"/>" binding="lv1Nm" 	width="150" align="center" is-read-only="true"></wj-flex-grid-column>
          		<wj-flex-grid-column header="<s:message code="prodrank.prodClassMNm"/>" binding="lv2Nm" 	width="200" align="center" is-read-only="true"></wj-flex-grid-column>
          		<wj-flex-grid-column header="<s:message code="prodrank.prodClassSNm"/>" binding="lv3Nm" 	width="200" align="center" is-read-only="true"></wj-flex-grid-column>
          		<wj-flex-grid-column header="<s:message code="day.prodClass.prodCd"/>"	binding="prodCd" width="100" align="center" visible="false" is-read-only="true" format="d"></wj-flex-grid-column>
				<wj-flex-grid-column header="<s:message code="pos.prodNm"/>"			binding="prodNm" width="200" align="center" is-read-only="true" ></wj-flex-grid-column>
				<wj-flex-grid-column header="<s:message code="pos.saleStore"/>"			binding="saleStoreCnt" width="100" align="center" is-read-only="true" ></wj-flex-grid-column>
				<wj-flex-grid-column header="<s:message code="pos.totSaleAmt"/>"		binding="totSaleAmt" width="100" align="right" is-read-only="true" aggregate="Sum"></wj-flex-grid-column>
				<wj-flex-grid-column header="<s:message code="pos.totDcAmt"/>"			binding="totDcAmt" width="100" align="right" is-read-only="true" aggregate="Sum"></wj-flex-grid-column>
				<wj-flex-grid-column header="<s:message code="pos.totRealSaleAmt"/>"	binding="totRealSaleAmt" width="100" align="right" is-read-only="true" aggregate="Sum"></wj-flex-grid-column>
				<wj-flex-grid-column header="<s:message code="pos.totSaleQty"/>"		binding="totSaleCnt" width="100" align="right" is-read-only="true" aggregate="Sum"></wj-flex-grid-column>
			</wj-flex-grid>
			<%-- ColumnPicker 사용시 include --%>
			<jsp:include page="/WEB-INF/view/layout/columnPicker.jsp" flush="true">
				<jsp:param name="pickerTarget" value="posProdCtrl"/>
			</jsp:include>
			<%--// ColumnPicker 사용시 include --%>
		</div>
		<%--//위즈모 테이블--%>
	</div>

	<%-- 페이지 리스트 --%>
	<div class="pageNum mt20">
	<%-- id --%>
		<ul id="posProdCtrlPager" data-size="10">
		</ul>
	</div>
	<%--//페이지 리스트--%>
</div>

<script type="text/javascript">
</script>
<script type="text/javascript" src="/resource/solbipos/js/sale/status/pos/prod/prod.js?ver=20190125.02" charset="utf-8"></script>
