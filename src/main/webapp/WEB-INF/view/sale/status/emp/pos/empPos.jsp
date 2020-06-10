<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix="f" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="menuCd" value="${sessionScope.sessionInfo.currentMenu.resrceCd}"/>
<c:set var="menuNm" value="${sessionScope.sessionInfo.currentMenu.resrceNm}"/>
<c:set var="orgnFg" value="${sessionScope.sessionInfo.orgnFg}" />
<c:set var="orgnCd" value="${sessionScope.sessionInfo.orgnCd}" />
<c:set var="baseUrl" value="/sale/status/emp/month/"/>

<div id="empPosView" class="subCon" style="display: none;" ng-controller="empPosCtrl">
	<div class="searchBar flddUnfld">
		<a href="#" class="open fl"><s:message code="empsale.pos"/></a>
    	<%-- 조회 --%>
    	<button class="btn_blue fr mt5 mr10" id="btnSearch" ng-click="_broadcast('empPosCtrlSrch')">
    		<s:message code="cmm.search"/>
    	</button>
	</div>
    <%-- 조회조건 --%>
    <table class="searchTbl">
		<colgroup>
        	<col class="w13"/>
	        <col class="w37"/>
	        <col class="w13"/>
	        <col class="w37"/>
      	</colgroup>
      	<tbody>
       	<%-- 조회일자 --%>
		<tr>
	    	<th><s:message code="cmm.search.date" /></th>
        	<td colspan="2">
          	<div class="sb-select">
       		    <span class="txtIn"><input id="srchPosStartDate" class="w120px"></span>
                <span class="rg">~</span>
                <span class="txtIn"><input id="srchPosEndDate" class="w120px"></span>
            	<span class="chk ml10">
					<input type="checkbox" ng-model="isChecked" ng-change="isChkDt()" />
	              	<label for="chkDt">
                		<s:message code="cmm.all.day" />
              		</label>
            	</span>
          	</div>
        	</td>
        	<td>
        		<%-- 판매자 전체보기 --%>
            	<span class="chk ml10">
                	<input type="checkbox"  ng-model="isCheckedEmpAll" ng-change="totalEmpPos()" />
                	<label for="totalEmpPos()">판매자 전체보기</label>
            	</span>
        	</td>
        </tr>
        <c:if test="${sessionInfo.orgnFg == 'HQ'}">
        <input type="hidden" id="empPosSelectStoreCd" value=""/>
      	<tr>
           <%-- 매장코드 --%>
         	<th><s:message code="todayBillSaleDtl.store"/></th>
         	<td colspan="3">
           	<jsp:include page="/WEB-INF/view/iostock/cmm/selectStoreS.jsp" flush="true">
           		<jsp:param name="targetId" value="empPosSelectStore"/>
           	</jsp:include>
             	<%--// 매장선택 모듈 멀티 선택 사용시 include --%>
         	</td>
      </tr>
      </c:if>
      	<c:if test="${sessionInfo.orgnFg == 'STORE'}">
        	<input type="hidden" id="empPosSelectStoreCd" value="${sessionInfo.storeCd}"/>
      	</c:if>
		</tbody>
	</table>

	<div class="mt40 oh sb-select dkbr">
	    <%-- 페이지 스케일  --%>
	    <wj-combo-box
	      class="w100px fl"
	      id="empPoslistScaleBox"
	      ng-model="listScale"
	      items-source="_getComboData('empPoslistScaleBox')"
	      display-member-path="name"
	      selected-value-path="value"
	      initialized="_initComboBox(s)"
	      control="listScaleCombo"
          is-editable="true"
          text-changed="_checkValidation(s)">
	    </wj-combo-box>
		<c:if test="${sessionInfo.orgnFg == 'HQ'}">
			<input type="text" id="empPosSelectStoreStoreNum" ng-model="storeNum">
		</c:if>
	    <%-- 엑셀 다운로드 //TODO --%>
	    <button class="btn_skyblue fr" ng-click="excelDownloadEmpPos()"><s:message code="cmm.excel.down" />
	    </button>
	</div>

	<%--위즈모 테이블--%>
    <div class="w100 mt10" id="wjWrapType3">
      <div class="wj-gridWrap">
        <wj-flex-grid
          id="empPosGrid"
          autoGenerateColumns="false"
          control="flex"
          initialized="initGrid(s,e)"
          sticky-headers="true"
          selection-mode="Row"
          items-source="data"
          frozen-columns="5"
          item-formatter="_itemFormatter">

          <!-- define columns -->
          <wj-flex-grid-column header="<s:message code="empday.storeNm"/>" 			binding="storeNm" 			width="120" align="center" is-read-only="true"></wj-flex-grid-column>
          <wj-flex-grid-column header="<s:message code="empday.posNo"/>" 			binding="posNo" 			width="70" align="center" is-read-only="true"></wj-flex-grid-column>
          <wj-flex-grid-column header="<s:message code="empday.storeCnt"/>" 		binding="storeCnt" 			width="70" align="center" is-read-only="true"></wj-flex-grid-column>
          <wj-flex-grid-column header="<s:message code="empday.realSaleAmtTot"/>"	binding="realSaleAmtTot" 	width="100" align="right"  is-read-only="true" aggregate="Sum"></wj-flex-grid-column>
          <wj-flex-grid-column header="<s:message code="empday.totBillCnt"/>" 		binding="totBillCnt" 		width="100" align="center" is-read-only="true" aggregate="Sum"></wj-flex-grid-column>
        </wj-flex-grid>

        <%-- ColumnPicker 사용시 include --%>
        <jsp:include page="/WEB-INF/view/layout/columnPicker.jsp" flush="true">
          <jsp:param name="pickerTarget" value="empPosCtrl"/>
        </jsp:include>
        <%--// ColumnPicker 사용시 include --%>
      </div>
    </div>
    <%--//위즈모 테이블--%>

  <%-- 페이지 리스트 --%>
  <div class="pageNum mt20">
    <%-- id --%>
    <ul id="empPosCtrlPager" data-size="10">
    </ul>
  </div>
  <%--//페이지 리스트--%>
  <%-- 엑셀 리스트 --%>
  <div class="w100 mt10" id="wjWrapType3" style="display:none;" ng-controller="empPosExcelCtrl">
      <div class="wj-gridWrap">
        <wj-flex-grid
          id="empPosExcelGrid"
          autoGenerateColumns="false"
          control="excelFlex"
          initialized="initGrid(s,e)"
          sticky-headers="true"
          selection-mode="Row"
          items-source="data"
          frozen-columns="5"
          item-formatter="_itemFormatter">

          <!-- define columns -->
          <wj-flex-grid-column header="<s:message code="empday.storeNm"/>" 			binding="storeNm" 			width="120" align="center" is-read-only="true"></wj-flex-grid-column>
          <wj-flex-grid-column header="<s:message code="empday.posNo"/>" 			binding="posNo" 			width="70" align="center" is-read-only="true"></wj-flex-grid-column>
          <wj-flex-grid-column header="<s:message code="empday.storeCnt"/>" 		binding="storeCnt" 			width="70" align="center" is-read-only="true"></wj-flex-grid-column>
          <wj-flex-grid-column header="<s:message code="empday.realSaleAmtTot"/>"	binding="realSaleAmtTot" 	width="100" align="right"  is-read-only="true" aggregate="Sum"></wj-flex-grid-column>
          <wj-flex-grid-column header="<s:message code="empday.totBillCnt"/>" 		binding="totBillCnt" 		width="100" align="center" is-read-only="true" aggregate="Sum"></wj-flex-grid-column>
        </wj-flex-grid>
      </div>
  </div>
  <%--//엑셀 리스트 --%>

</div>

<script type="text/javascript" src="/resource/solbipos/js/sale/status/emp/pos/empPos.js?ver=20190125.03" charset="utf-8"></script>

