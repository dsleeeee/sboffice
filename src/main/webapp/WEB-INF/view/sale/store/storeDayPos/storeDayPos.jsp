<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="menuCd" value="${sessionScope.sessionInfo.currentMenu.resrceCd}"/>
<c:set var="menuNm" value="${sessionScope.sessionInfo.currentMenu.resrceNm}"/>
<c:set var="orgnFg" value="${sessionScope.sessionInfo.orgnFg}"/>

<div class="subCon" ng-controller="storeDayPosCtrl">
  <div class="searchBar">
    <a href="#" class="open fl">${menuNm}</a>
    <div class="mr15 fr" style="display:block;position: relative;margin-top: 6px;">
      <%-- 조회 --%>
      <button class="btn_blue fr" id="btnSearch" ng-click="_broadcast('storeDayPosCtrl')">
        <s:message code="cmm.search"/>
      </button>
      <c:if test="${sessionInfo.orgnFg == 'HQ'}">
        <%-- 확장조회 --%>
        <button class="btn_blue mr5 fl" id="btnSearchAddShow" ng-click="searchAddShowChange()">
          <s:message code="cmm.search.addShow" />
        </button>
      </c:if>
    </div>
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
          <span class="txtIn"><input id="srchDayStartDate" class="w110px"></span>
          <span class="rg">~</span>
          <span class="txtIn"><input id="srchDayEndDate" class="w110px"></span>
        </div>
      </td>
      <%-- 옵션 --%>
      <th><s:message code="storeDayChannel.option"/></th>
      <td>
        <div class="sb-select">
          <wj-combo-box
                  id="option"
                  ng-model="option"
                  items-source="_getComboData('option')"
                  display-member-path="name"
                  selected-value-path="value"
                  is-editable="false"
                  control="optionCombo"
                  selected-index-changed="changeOption(s)"
                  selected-index="1">
          </wj-combo-box>
        </div>
      </td>
    </tr>
    <c:if test="${sessionInfo.orgnFg == 'HQ'}">
      <tr>
        <%-- 매장브랜드 --%>
        <th><s:message code="dayProd.storeHqBrand"/></th>
        <td>
          <div class="sb-select">
            <wj-combo-box
                    id="srchStoreHqBrandCdCombo"
                    ng-model="storeHqBrandCd"
                    items-source="_getComboData('storeHqBrandCdCombo')"
                    display-member-path="name"
                    selected-value-path="value"
                    is-editable="false"
                    control="srchStoreHqBrandCdCombo">
            </wj-combo-box>
          </div>
        </td>
        <%-- 매장선택 --%>
        <th class="dayStore" style="display: none;"><s:message code="cmm.store.select"/></th>
        <td class="dayStore" style="display: none;">
          <%-- 매장선택 모듈 사용시 include --%>
          <jsp:include page="/WEB-INF/view/common/popup/selectStore.jsp" flush="true">
            <jsp:param name="targetTypeFg" value="M"/>
            <jsp:param name="targetId" value="dayStore"/>
          </jsp:include>
          <%--// 매장선택 모듈 사용시 include --%>
        </td>
      </tr>
    </c:if>
    <c:if test="${sessionInfo.orgnFg == 'STORE'}">
      <input type="hidden" id="dayStoreCd" value="${sessionInfo.storeCd}"/>
    </c:if>
    </tbody>
  </table>
  <c:if test="${sessionInfo.orgnFg == 'HQ'}">
    <table class="searchTbl" id="tblSearchAddShow" style="display: none;">
      <colgroup>
        <col class="w15"/>
        <col class="w35"/>
        <col class="w15"/>
        <col class="w35"/>
      </colgroup>
      <tbody>
      <tr>
          <%-- 팀별 --%>
        <th><s:message code="dayProd.momsTeam"/></th>
        <td>
          <div class="sb-select">
            <wj-combo-box
                    id="srchMomsTeamCombo"
                    ng-model="momsTeam"
                    items-source="_getComboData('momsTeamCombo')"
                    display-member-path="name"
                    selected-value-path="value"
                    is-editable="false"
                    initialized="_initComboBox(s)"
                    control="srchMomsTeamCombo">
            </wj-combo-box>
          </div>
        </td>
          <%-- AC점포별 --%>
        <th><s:message code="dayProd.momsAcShop"/></th>
        <td>
          <div class="sb-select">
            <wj-combo-box
                    id="srchMomsAcShopCombo"
                    ng-model="momsAcShop"
                    items-source="_getComboData('momsAcShopCombo')"
                    display-member-path="name"
                    selected-value-path="value"
                    is-editable="false"
                    initialized="_initComboBox(s)"
                    control="srchMomsAcShopCombo">
            </wj-combo-box>
          </div>
        </td>
      </tr>
      <tr>
          <%-- 지역구분 --%>
        <th><s:message code="dayProd.momsAreaFg"/></th>
        <td>
          <div class="sb-select">
            <wj-combo-box
                    id="srchMomsAreaFgCombo"
                    ng-model="momsAreaFg"
                    items-source="_getComboData('momsAreaFgCombo')"
                    display-member-path="name"
                    selected-value-path="value"
                    is-editable="false"
                    initialized="_initComboBox(s)"
                    control="srchMomsAreaFgCombo">
            </wj-combo-box>
          </div>
        </td>
          <%-- 상권 --%>
        <th><s:message code="dayProd.momsCommercial"/></th>
        <td>
          <div class="sb-select">
            <wj-combo-box
                    id="srchMomsCommercialCombo"
                    ng-model="momsCommercial"
                    items-source="_getComboData('momsCommercialCombo')"
                    display-member-path="name"
                    selected-value-path="value"
                    is-editable="false"
                    initialized="_initComboBox(s)"
                    control="srchMomsCommercialCombo">
            </wj-combo-box>
          </div>
        </td>
      </tr>
      <tr>
          <%-- 점포유형 --%>
        <th><s:message code="dayProd.momsShopType"/></th>
        <td>
          <div class="sb-select">
            <wj-combo-box
                    id="srchMomsShopTypeCombo"
                    ng-model="momsShopType"
                    items-source="_getComboData('momsShopTypeCombo')"
                    display-member-path="name"
                    selected-value-path="value"
                    is-editable="false"
                    initialized="_initComboBox(s)"
                    control="srchMomsShopTypeCombo">
            </wj-combo-box>
          </div>
        </td>
          <%-- 매장관리타입 --%>
        <th><s:message code="dayProd.momsStoreManageType"/></th>
        <td>
          <div class="sb-select">
            <wj-combo-box
                    id="srchMomsStoreManageTypeCombo"
                    ng-model="momsStoreManageType"
                    items-source="_getComboData('momsStoreManageTypeCombo')"
                    display-member-path="name"
                    selected-value-path="value"
                    is-editable="false"
                    initialized="_initComboBox(s)"
                    control="srchMomsStoreManageTypeCombo">
            </wj-combo-box>
          </div>
        </td>
      </tr>
      <c:if test="${sessionInfo.orgnFg == 'HQ'}">
        <tr>
            <%-- 그룹 --%>
          <th><s:message code="dayProd.branchCd"/></th>
          <td>
            <div class="sb-select">
              <wj-combo-box
                      id="srchBranchCdComboo"
                      ng-model="branchCd"
                      items-source="_getComboData('branchCdCombo')"
                      display-member-path="name"
                      selected-value-path="value"
                      is-editable="false"
                      initialized="_initComboBox(s)"
                      control="srchBranchCdComboo">
              </wj-combo-box>
            </div>
          </td>
          <td></td>
          <td></td>
        </tr>
      </c:if>
      </tbody>
    </table>
  </c:if>

  <div class="mt10 oh sb-select dkbr">
    <%-- 엑셀다운로드 --%>
    <button class="btn_skyblue ml5 fr" ng-click="excelDownloadInfo()"><s:message code="cmm.excel.downCondition"/></button>
  </div>

  <div class="w100 mt10">
    <%--위즈모 테이블--%>
    <div class="wj-gridWrap" style="height: 350px; overflow-y: hidden; overflow-x: hidden;">
      <wj-flex-grid
        id="wjGridList"
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
        <wj-flex-grid-column header="<s:message code="storeDayChannel.branchCd"/>" binding="branchCd" width="80" align="center" is-read-only="true"></wj-flex-grid-column>
        <wj-flex-grid-column header="<s:message code="storeDayChannel.branchNm"/>" binding="branchNm" width="100" align="left" is-read-only="true"></wj-flex-grid-column>
        <wj-flex-grid-column header="<s:message code="day.dayTotal.storeCnt"/>" binding="storeCnt" width="80" align="center" is-read-only="true"></wj-flex-grid-column>
        <wj-flex-grid-column header="<s:message code="day.dayTotal.storeCd"/>" binding="storeCd" width="80" align="center" is-read-only="true" visible="false"></wj-flex-grid-column>
        <wj-flex-grid-column header="<s:message code="day.dayTotal.storeNm"/>" binding="storeNm" width="100" align="left" is-read-only="true" visible="false"></wj-flex-grid-column>
        <wj-flex-grid-column header="<s:message code="dayProd.brand"/>" binding="brand" width="100" align="left" is-read-only="true" visible="false" data-map="brandDataMap"></wj-flex-grid-column>
        <wj-flex-grid-column header="<s:message code="dayProd.momsTeam"/>" binding="momsTeam" width="100" align="left" is-read-only="true" visible="false" data-map="momsTeamDataMap"></wj-flex-grid-column>
        <wj-flex-grid-column header="<s:message code="dayProd.momsAcShop"/>" binding="momsAcShop" width="100" align="left" is-read-only="true" visible="false" data-map="momsAcShopDataMap"></wj-flex-grid-column>
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
        <%-- 모바일페이상세 컬럼 생성--%>
        <c:forEach var="mpayCol" items="${mpayColList}">
          <wj-flex-grid-column header="${mpayCol.mpayNm}" binding="mpay${mpayCol.mpayCd}" width="100" align="right" is-read-only="true" aggregate="Sum"></wj-flex-grid-column>
        </c:forEach>
        <wj-flex-grid-column header="<s:message code="day.dayTotal.billCnt"/>" binding="stinBillCnt" width="100" align="right" is-read-only="true" aggregate="Sum"></wj-flex-grid-column>
        <wj-flex-grid-column header="<s:message code="day.dayTotal.billUprc"/>" binding="stinBillUprc" width="100" align="right" is-read-only="true"></wj-flex-grid-column>
        <wj-flex-grid-column header="<s:message code="day.dayTotal.realSaleAmt"/>" binding="stinRealSaleAmt" width="100" align="right" is-read-only="true" aggregate="Sum"></wj-flex-grid-column>
        <wj-flex-grid-column header="<s:message code="storeDayChannel.rate"/>" binding="stinRate" width="80" align="right" is-read-only="true"></wj-flex-grid-column>
        <wj-flex-grid-column header="<s:message code="day.dayTotal.billCnt"/>" binding="dlvrBillCnt" width="100" align="right" is-read-only="true" aggregate="Sum"></wj-flex-grid-column>
        <wj-flex-grid-column header="<s:message code="day.dayTotal.billUprc"/>" binding="dlvrBillUprc" width="100" align="right" is-read-only="true"></wj-flex-grid-column>
        <wj-flex-grid-column header="<s:message code="day.dayTotal.realSaleAmt"/>" binding="dlvrRealSaleAmt" width="100" align="right" is-read-only="true" aggregate="Sum"></wj-flex-grid-column>
        <wj-flex-grid-column header="<s:message code="storeDayChannel.rate"/>" binding="dlvrRate" width="80" align="right" is-read-only="true"></wj-flex-grid-column>
        <wj-flex-grid-column header="<s:message code="day.dayTotal.billCnt"/>" binding="packBillCnt" width="100" align="right" is-read-only="true" aggregate="Sum"></wj-flex-grid-column>
        <wj-flex-grid-column header="<s:message code="day.dayTotal.billUprc"/>" binding="packBillUprc" width="100" align="right" is-read-only="true"></wj-flex-grid-column>
        <wj-flex-grid-column header="<s:message code="day.dayTotal.realSaleAmt"/>" binding="packRealSaleAmt" width="100" align="right" is-read-only="true" aggregate="Sum"></wj-flex-grid-column>
        <wj-flex-grid-column header="<s:message code="storeDayChannel.rate"/>" binding="packRate" width="80" align="right" is-read-only="true"></wj-flex-grid-column>
        <%-- 포스(포스+CID) --%>
        <wj-flex-grid-column header="<s:message code="day.dayTotal.genRealSaleCnt"/>"  binding="genRealSaleCntPos" width="100" align="right" is-read-only="true" aggregate="Sum"></wj-flex-grid-column>
        <wj-flex-grid-column header="<s:message code="day.dayTotal.genRealSaleAmt"/>"  binding="genRealSaleAmtPos" width="100" align="right" is-read-only="true" aggregate="Sum"></wj-flex-grid-column>
        <wj-flex-grid-column header="<s:message code="day.dayTotal.dlvrRealSaleCnt"/>" binding="dlvrRealSaleCntPos" width="100" align="right" is-read-only="true" aggregate="Sum"></wj-flex-grid-column>
        <wj-flex-grid-column header="<s:message code="day.dayTotal.dlvrRealSaleAmt"/>" binding="dlvrRealSaleAmtPos" width="100" align="right" is-read-only="true" aggregate="Sum"></wj-flex-grid-column>
        <wj-flex-grid-column header="<s:message code="day.dayTotal.packRealSaleCnt"/>" binding="packRealSaleCntPos" width="100" align="right" is-read-only="true" aggregate="Sum"></wj-flex-grid-column>
        <wj-flex-grid-column header="<s:message code="day.dayTotal.packRealSaleAmt"/>" binding="packRealSaleAmtPos" width="100" align="right" is-read-only="true" aggregate="Sum"></wj-flex-grid-column>
        <%-- 포스(포스+CID) --%>
        <%-- 포스(채널합) --%>
        <wj-flex-grid-column header="<s:message code="day.dayTotal.genRealSaleCnt"/>"  binding="genRealSaleCntChannel" width="100" align="right" is-read-only="true" aggregate="Sum"></wj-flex-grid-column>
        <wj-flex-grid-column header="<s:message code="day.dayTotal.genRealSaleAmt"/>"  binding="genRealSaleAmtChannel" width="100" align="right" is-read-only="true" aggregate="Sum"></wj-flex-grid-column>
        <wj-flex-grid-column header="<s:message code="day.dayTotal.dlvrRealSaleCnt"/>" binding="dlvrRealSaleCntChannel" width="100" align="right" is-read-only="true" aggregate="Sum"></wj-flex-grid-column>
        <wj-flex-grid-column header="<s:message code="day.dayTotal.dlvrRealSaleAmt"/>" binding="dlvrRealSaleAmtChannel" width="100" align="right" is-read-only="true" aggregate="Sum"></wj-flex-grid-column>
        <wj-flex-grid-column header="<s:message code="day.dayTotal.packRealSaleCnt"/>" binding="packRealSaleCntChannel" width="100" align="right" is-read-only="true" aggregate="Sum"></wj-flex-grid-column>
        <wj-flex-grid-column header="<s:message code="day.dayTotal.packRealSaleAmt"/>" binding="packRealSaleAmtChannel" width="100" align="right" is-read-only="true" aggregate="Sum"></wj-flex-grid-column>
        <%-- 포스(채널합) --%>
        <%-- 포스(키오스크) --%>
        <wj-flex-grid-column header="<s:message code="day.dayTotal.genRealSaleCnt"/>"  binding="genRealSaleCntKiosk" width="100" align="right" is-read-only="true" aggregate="Sum"></wj-flex-grid-column>
        <wj-flex-grid-column header="<s:message code="day.dayTotal.genRealSaleAmt"/>"  binding="genRealSaleAmtKiosk" width="100" align="right" is-read-only="true" aggregate="Sum"></wj-flex-grid-column>
        <wj-flex-grid-column header="<s:message code="day.dayTotal.dlvrRealSaleCnt"/>" binding="dlvrRealSaleCntKiosk" width="100" align="right" is-read-only="true" aggregate="Sum"></wj-flex-grid-column>
        <wj-flex-grid-column header="<s:message code="day.dayTotal.dlvrRealSaleAmt"/>" binding="dlvrRealSaleAmtKiosk" width="100" align="right" is-read-only="true" aggregate="Sum"></wj-flex-grid-column>
        <wj-flex-grid-column header="<s:message code="day.dayTotal.packRealSaleCnt"/>" binding="packRealSaleCntKiosk" width="100" align="right" is-read-only="true" aggregate="Sum"></wj-flex-grid-column>
        <wj-flex-grid-column header="<s:message code="day.dayTotal.packRealSaleAmt"/>" binding="packRealSaleAmtKiosk" width="100" align="right" is-read-only="true" aggregate="Sum"></wj-flex-grid-column>
        <%-- 포스(키오스크) --%>
        <%-- 채널 컬럼 생성--%>
        <c:forEach var="dlvrInFgCol" items="${dlvrInFgColList}">
          <wj-flex-grid-column header="<s:message code="storeDayChannel.saleQty"/>"     binding="saleQty${dlvrInFgCol.dlvrInFg}" width="80" align="right" is-read-only="true" aggregate="Sum"></wj-flex-grid-column>
          <wj-flex-grid-column header="<s:message code="storeDayChannel.realSaleAmt"/>" binding="realSaleAmt${dlvrInFgCol.dlvrInFg}" width="80" align="right" is-read-only="true" aggregate="Sum"></wj-flex-grid-column>
        </c:forEach>
      </wj-flex-grid>
    </div>
    <%--//위즈모 테이블--%>

      <%--위즈모 테이블--%>
      <div class="wj-gridWrap" style="display: none;" ng-controller="storeDayPosExcelCtrl">
        <wj-flex-grid
                id="wjGridExcelList"
                autoGenerateColumns="false"
                selection-mode="Row"
                items-source="data"
                control="excelFlex"
                initialized="initGrid(s,e)"
                is-read-only="true"
                item-formatter="_itemFormatter">

          <!-- define columns -->
          <wj-flex-grid-column header="<s:message code="day.dayTotal.saleDate"/>" binding="saleDate" width="80" align="center" is-read-only="true"></wj-flex-grid-column>
          <wj-flex-grid-column header="<s:message code="day.dayTotal.yoil"/>" binding="yoil" width="60" align="center" is-read-only="true"></wj-flex-grid-column>
          <wj-flex-grid-column header="<s:message code="storeDayChannel.branchCd"/>" binding="branchCd" width="80" align="center" is-read-only="true"></wj-flex-grid-column>
          <wj-flex-grid-column header="<s:message code="storeDayChannel.branchNm"/>" binding="branchNm" width="100" align="left" is-read-only="true"></wj-flex-grid-column>
          <wj-flex-grid-column header="<s:message code="day.dayTotal.storeCnt"/>" binding="storeCnt" width="80" align="center" is-read-only="true"></wj-flex-grid-column>
          <wj-flex-grid-column header="<s:message code="day.dayTotal.storeCd"/>" binding="storeCd" width="80" align="center" is-read-only="true" visible="false"></wj-flex-grid-column>
          <wj-flex-grid-column header="<s:message code="day.dayTotal.storeNm"/>" binding="storeNm" width="100" align="left" is-read-only="true" visible="false"></wj-flex-grid-column>
          <wj-flex-grid-column header="<s:message code="dayProd.brand"/>" binding="brand" width="100" align="left" is-read-only="true" visible="false" data-map="brandDataMap"></wj-flex-grid-column>
          <wj-flex-grid-column header="<s:message code="dayProd.momsTeam"/>" binding="momsTeam" width="100" align="left" is-read-only="true" visible="false" data-map="momsTeamDataMap"></wj-flex-grid-column>
          <wj-flex-grid-column header="<s:message code="dayProd.momsAcShop"/>" binding="momsAcShop" width="100" align="left" is-read-only="true" visible="false" data-map="momsAcShopDataMap"></wj-flex-grid-column>
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
          <%-- 모바일페이상세 컬럼 생성--%>
          <c:forEach var="mpayCol" items="${mpayColList}">
            <wj-flex-grid-column header="${mpayCol.mpayNm}" binding="mpay${mpayCol.mpayCd}" width="100" align="right" is-read-only="true" aggregate="Sum"></wj-flex-grid-column>
          </c:forEach>
          <wj-flex-grid-column header="<s:message code="day.dayTotal.billCnt"/>" binding="stinBillCnt" width="100" align="right" is-read-only="true" aggregate="Sum"></wj-flex-grid-column>
          <wj-flex-grid-column header="<s:message code="day.dayTotal.billUprc"/>" binding="stinBillUprc" width="100" align="right" is-read-only="true"></wj-flex-grid-column>
          <wj-flex-grid-column header="<s:message code="day.dayTotal.realSaleAmt"/>" binding="stinRealSaleAmt" width="100" align="right" is-read-only="true" aggregate="Sum"></wj-flex-grid-column>
          <wj-flex-grid-column header="<s:message code="storeDayChannel.rate"/>" binding="stinRate" width="80" align="right" is-read-only="true"></wj-flex-grid-column>
          <wj-flex-grid-column header="<s:message code="day.dayTotal.billCnt"/>" binding="dlvrBillCnt" width="100" align="right" is-read-only="true" aggregate="Sum"></wj-flex-grid-column>
          <wj-flex-grid-column header="<s:message code="day.dayTotal.billUprc"/>" binding="dlvrBillUprc" width="100" align="right" is-read-only="true"></wj-flex-grid-column>
          <wj-flex-grid-column header="<s:message code="day.dayTotal.realSaleAmt"/>" binding="dlvrRealSaleAmt" width="100" align="right" is-read-only="true" aggregate="Sum"></wj-flex-grid-column>
          <wj-flex-grid-column header="<s:message code="storeDayChannel.rate"/>" binding="dlvrRate" width="80" align="right" is-read-only="true"></wj-flex-grid-column>
          <wj-flex-grid-column header="<s:message code="day.dayTotal.billCnt"/>" binding="packBillCnt" width="100" align="right" is-read-only="true" aggregate="Sum"></wj-flex-grid-column>
          <wj-flex-grid-column header="<s:message code="day.dayTotal.billUprc"/>" binding="packBillUprc" width="100" align="right" is-read-only="true"></wj-flex-grid-column>
          <wj-flex-grid-column header="<s:message code="day.dayTotal.realSaleAmt"/>" binding="packRealSaleAmt" width="100" align="right" is-read-only="true" aggregate="Sum"></wj-flex-grid-column>
          <wj-flex-grid-column header="<s:message code="storeDayChannel.rate"/>" binding="packRate" width="80" align="right" is-read-only="true"></wj-flex-grid-column>
          <%-- 포스(포스+CID) --%>
          <wj-flex-grid-column header="<s:message code="day.dayTotal.genRealSaleCnt"/>"  binding="genRealSaleCntPos" width="100" align="right" is-read-only="true" aggregate="Sum"></wj-flex-grid-column>
          <wj-flex-grid-column header="<s:message code="day.dayTotal.genRealSaleAmt"/>"  binding="genRealSaleAmtPos" width="100" align="right" is-read-only="true" aggregate="Sum"></wj-flex-grid-column>
          <wj-flex-grid-column header="<s:message code="day.dayTotal.dlvrRealSaleCnt"/>" binding="dlvrRealSaleCntPos" width="100" align="right" is-read-only="true" aggregate="Sum"></wj-flex-grid-column>
          <wj-flex-grid-column header="<s:message code="day.dayTotal.dlvrRealSaleAmt"/>" binding="dlvrRealSaleAmtPos" width="100" align="right" is-read-only="true" aggregate="Sum"></wj-flex-grid-column>
          <wj-flex-grid-column header="<s:message code="day.dayTotal.packRealSaleCnt"/>" binding="packRealSaleCntPos" width="100" align="right" is-read-only="true" aggregate="Sum"></wj-flex-grid-column>
          <wj-flex-grid-column header="<s:message code="day.dayTotal.packRealSaleAmt"/>" binding="packRealSaleAmtPos" width="100" align="right" is-read-only="true" aggregate="Sum"></wj-flex-grid-column>
          <%-- 포스(포스+CID) --%>
          <%-- 포스(채널합) --%>
          <wj-flex-grid-column header="<s:message code="day.dayTotal.genRealSaleCnt"/>"  binding="genRealSaleCntChannel" width="100" align="right" is-read-only="true" aggregate="Sum"></wj-flex-grid-column>
          <wj-flex-grid-column header="<s:message code="day.dayTotal.genRealSaleAmt"/>"  binding="genRealSaleAmtChannel" width="100" align="right" is-read-only="true" aggregate="Sum"></wj-flex-grid-column>
          <wj-flex-grid-column header="<s:message code="day.dayTotal.dlvrRealSaleCnt"/>" binding="dlvrRealSaleCntChannel" width="100" align="right" is-read-only="true" aggregate="Sum"></wj-flex-grid-column>
          <wj-flex-grid-column header="<s:message code="day.dayTotal.dlvrRealSaleAmt"/>" binding="dlvrRealSaleAmtChannel" width="100" align="right" is-read-only="true" aggregate="Sum"></wj-flex-grid-column>
          <wj-flex-grid-column header="<s:message code="day.dayTotal.packRealSaleCnt"/>" binding="packRealSaleCntChannel" width="100" align="right" is-read-only="true" aggregate="Sum"></wj-flex-grid-column>
          <wj-flex-grid-column header="<s:message code="day.dayTotal.packRealSaleAmt"/>" binding="packRealSaleAmtChannel" width="100" align="right" is-read-only="true" aggregate="Sum"></wj-flex-grid-column>
          <%-- 포스(채널합) --%>
          <%-- 포스(키오스크) --%>
          <wj-flex-grid-column header="<s:message code="day.dayTotal.genRealSaleCnt"/>"  binding="genRealSaleCntKiosk" width="100" align="right" is-read-only="true" aggregate="Sum"></wj-flex-grid-column>
          <wj-flex-grid-column header="<s:message code="day.dayTotal.genRealSaleAmt"/>"  binding="genRealSaleAmtKiosk" width="100" align="right" is-read-only="true" aggregate="Sum"></wj-flex-grid-column>
          <wj-flex-grid-column header="<s:message code="day.dayTotal.dlvrRealSaleCnt"/>" binding="dlvrRealSaleCntKiosk" width="100" align="right" is-read-only="true" aggregate="Sum"></wj-flex-grid-column>
          <wj-flex-grid-column header="<s:message code="day.dayTotal.dlvrRealSaleAmt"/>" binding="dlvrRealSaleAmtKiosk" width="100" align="right" is-read-only="true" aggregate="Sum"></wj-flex-grid-column>
          <wj-flex-grid-column header="<s:message code="day.dayTotal.packRealSaleCnt"/>" binding="packRealSaleCntKiosk" width="100" align="right" is-read-only="true" aggregate="Sum"></wj-flex-grid-column>
          <wj-flex-grid-column header="<s:message code="day.dayTotal.packRealSaleAmt"/>" binding="packRealSaleAmtKiosk" width="100" align="right" is-read-only="true" aggregate="Sum"></wj-flex-grid-column>
          <%-- 포스(키오스크) --%>
          <%-- 채널 컬럼 생성--%>
          <c:forEach var="dlvrInFgCol" items="${dlvrInFgColList}">
            <wj-flex-grid-column header="<s:message code="storeDayChannel.saleQty"/>"     binding="saleQty${dlvrInFgCol.dlvrInFg}" width="80" align="right" is-read-only="true" aggregate="Sum"></wj-flex-grid-column>
            <wj-flex-grid-column header="<s:message code="storeDayChannel.realSaleAmt"/>" binding="realSaleAmt${dlvrInFgCol.dlvrInFg}" width="80" align="right" is-read-only="true" aggregate="Sum"></wj-flex-grid-column>
          </c:forEach>
        </wj-flex-grid>
      </div>
      <%--//위즈모 테이블--%>
  </div>

  <%-- 페이지 리스트 --%>
  <div class="pageNum mt20">
    <ul id="storeDayPosCtrlPager" data-size="10">
    </ul>
  </div>
  <%--//페이지 리스트--%>
</div>

<script type="text/javascript" src="/resource/solbipos/js/sale/store/storeDayPos/storeDayPos.js?ver=20230329.03" charset="utf-8"></script>

<script type="text/javascript">
  var orgnFg = "${orgnFg}";
  var storeCd = "${storeCd}";

  // List 형식("" 안붙임)
  var momsHqBrandCdComboList = ${momsHqBrandCdComboList};
  var branchCdComboList = ${branchCdComboList};
  var momsTeamComboList = ${momsTeamComboList};
  var momsAcShopComboList = ${momsAcShopComboList};
  var momsAreaFgComboList = ${momsAreaFgComboList};
  var momsCommercialComboList = ${momsCommercialComboList};
  var momsShopTypeComboList = ${momsShopTypeComboList};
  var momsStoreManageTypeComboList = ${momsStoreManageTypeComboList};

  // 결제수단
  var payColList = [];
  <%--javascript에서 사용할 결제수단 json 데이터 생성--%>
  <c:forEach var="payCol" items="${payColList}">
  var payParam       = {};
  payParam.payCd     = "${payCol.payCd}";
  payParam.payMethod = "${payCol.payMethod}";
  payColList.push(payParam);
  </c:forEach>

  var payCol    = '${payCol}';
  var arrPayCol = payCol.split(',');

  // 모바일페이상세
  var mpayColList = [];
  <%--javascript에서 사용할 결제수단 json 데이터 생성--%>
  <c:forEach var="mpayCol" items="${mpayColList}">
  var mpayParam       = {};
  mpayParam.payCd     = "${mpayCol.mpayCd}";
  mpayParam.payMethod = "${mpayCol.mpayMethod}";
  mpayColList.push(mpayParam);
  </c:forEach>

  var mpayCol    = '${mpayCol}';
  var arrMpayCol = mpayCol.split(',');

  // 할인
  var dcColList = [];
  <%--javascript에서 사용할 할인 json 데이터 생성--%>
  <c:forEach var="dcCol" items="${dcColList}">
  var dcParam      = {};
  dcParam.dcCd     = "${dcCol.dcCd}";
  dcParam.dcMethod = "${dcCol.dcMethod}";
  dcColList.push(dcParam);
  </c:forEach>

  var dcCol    = '${dcCol}';
  var arrDcCol = dcCol.split(',');


  // 코너
  var cornerColList = [];
  <%--javascript에서 사용할 코너 json 데이터 생성--%>
  <c:forEach var="cornerCol" items="${cornerColList}">
  var cornerParam      = {};
  cornerParam.storeCornrCd     = "${cornerCol.storeCornrCd}";
  cornerParam.storeNm     = "${cornerCol.storeNm}";
  cornerParam.storeCd     = "${cornerCol.storeCd}";
  cornerParam.cornrNm     = "${cornerCol.cornrNm}";
  cornerColList.push(cornerParam);
  </c:forEach>

  var cornerCol    = '${cornerCol}';
  var arrCornerCol = cornerCol.split(',');


  // 테이블
  var tableColList = [];
  <%--javascript에서 사용할 포스 json 데이터 생성--%>
  <c:forEach var="tableCol" items="${tableColList}">
  var tableParam      = {};
  tableParam.tblCd     = "${tableCol.tblCd}";
  tableParam.tblNm     = "${tableCol.tblNm}";
  tableColList.push(tableParam);
  </c:forEach>

  var tableCol    = '${tableCol}';
  var arrTableCol = tableCol.split(',');


  // 포스
  var posColList = [];
  <%--javascript에서 사용할 포스 json 데이터 생성--%>
  <c:forEach var="posCol" items="${posColList}">
  var posParam      = {};
  posParam.posNo     = "${posCol.posNo}";
  posParam.posNm     = "${posCol.posNm}";
  posParam.storeCd     = "${posCol.storeCd}";
  posParam.storeNm     = "${posCol.storeNm}";
  posParam.storePosNo     = "${posCol.storePosNo}";
  posColList.push(posParam);
  </c:forEach>

  var posCol    = '${posCol}';
  var arrPosCol = posCol.split(',');

  // 상품분류별 - 분류레벨 최대값
  var maxLevel    = '${maxLevel}';

  // 시간대분류
  var timeSlotColList = [];
  <%--javascript에서 사용할 결제수단 json 데이터 생성--%>
  <c:forEach var="timeSlotCol" items="${timeSlotColList}">
  var timeSlotParam   = {};
  timeSlotParam.name  = "${timeSlotCol.name}";
  timeSlotParam.value = "${timeSlotCol.value}";
  timeSlotColList.push(timeSlotParam);
  </c:forEach>

  var timeSlotCol    = '${timeSlotCol}';
  var arrTimeSlotCol = timeSlotCol.split(',');

  //채널
  var dlvrInFgColList = [];

  <%--javascript에서 사용할 주문채널 구분자 json 데이터 생성--%>
  <c:forEach var="dlvrInFgCol" items="${dlvrInFgColList}">
  var param = {};
  param.dlvrInFg = "${dlvrInFgCol.dlvrInFg}";
  param.dlvrInFgNm = "${dlvrInFgCol.dlvrInFgNm}";
  dlvrInFgColList.push(param);
  </c:forEach>

  var dlvrInFgCol = '${dlvrInFgCol}';
  var arrDlvrInFgCol = dlvrInFgCol.split(',');
</script>

<%-- 팝업 추후 개발 --%>
<%-- 팝업 레이어 시작 --%>
<%--&lt;%&ndash; 매장별 매출현황 팝업 레이어 &ndash;%&gt;--%>
<%--<c:import url="/WEB-INF/view/sale/day/day/dayStoreDtl.jsp">--%>
<%--  <c:param name="menuCd" value="${menuCd}"/>--%>
<%--  <c:param name="menuNm" value="${menuNm}"/>--%>
<%--</c:import>--%>

<%--&lt;%&ndash; 매장별 매출현황 팝업 레이어 &ndash;%&gt;--%>
<%--<c:import url="/WEB-INF/view/sale/day/day/dayProdDtl.jsp">--%>
<%--  <c:param name="menuCd" value="${menuCd}"/>--%>
<%--  <c:param name="menuNm" value="${menuNm}"/>--%>
<%--</c:import>--%>

<%--&lt;%&ndash; 상품매출 상세 팝업 레이어 &ndash;%&gt;--%>
<%--<c:import url="/WEB-INF/view/sale/cmmSalePopup/prodInfo/prodSaleDtl.jsp">--%>
<%--  <c:param name="menuCd" value="${menuCd}"/>--%>
<%--  <c:param name="menuNm" value="${menuNm}"/>--%>
<%--</c:import>--%>

<%--&lt;%&ndash; 매장별 할인내역 팝업 레이어 &ndash;%&gt;--%>
<%--<c:import url="/WEB-INF/view/sale/day/day/dayStoreDc.jsp">--%>
<%--  <c:param name="menuCd" value="${menuCd}"/>--%>
<%--  <c:param name="menuNm" value="${menuNm}"/>--%>
<%--</c:import>--%>

<%--&lt;%&ndash; 매장별 영수건수 팝업 레이어 &ndash;%&gt;--%>
<%--<c:import url="/WEB-INF/view/sale/cmmSalePopup/dayBillInfo/dayStoreBill.jsp">--%>
<%--  <c:param name="menuCd" value="${menuCd}"/>--%>
<%--  <c:param name="menuNm" value="${menuNm}"/>--%>
<%--</c:import>--%>
<%--&lt;%&ndash; 매장별 영수건수 팝업 레이어 &ndash;%&gt;--%>
<%--<c:import url="/WEB-INF/view/sale/cmmSalePopup/dayBillInfo/dayStoreBill2.jsp">--%>
<%--  <c:param name="menuCd" value="${menuCd}"/>--%>
<%--  <c:param name="menuNm" value="${menuNm}"/>--%>
<%--</c:import>--%>

<%--&lt;%&ndash; 상품매출 상세내역 팝업 레이어 &ndash;%&gt;--%>
<%--<c:import url="/WEB-INF/view/sale/day/day/dayProdSaleDtl.jsp">--%>
<%--  <c:param name="menuCd" value="${menuCd}"/>--%>
<%--  <c:param name="menuNm" value="${menuNm}"/>--%>
<%--</c:import>--%>

<%--&lt;%&ndash; 상품분류 팝업 &ndash;%&gt;--%>
<%--<c:import url="/WEB-INF/view/application/layer/searchProdClassCd.jsp">--%>
<%--</c:import>--%>
<%--&lt;%&ndash; //팝업 레이어 &ndash;%&gt;--%>

<%--&lt;%&ndash; 결제수단 팝업 레이어 시작 &ndash;%&gt;--%>
<%--&lt;%&ndash; 신용카드 상세 레이어 &ndash;%&gt;--%>
<%--<c:import url="/WEB-INF/view/sale/cmmSalePopup/dayPayInfo/dayCard.jsp">--%>
<%--  <c:param name="menuCd" value="${menuCd}"/>--%>
<%--  <c:param name="menuNm" value="${menuNm}"/>--%>
<%--</c:import>--%>

<%--&lt;%&ndash; 현금 상세 레이어 &ndash;%&gt;--%>
<%--<c:import url="/WEB-INF/view/sale/cmmSalePopup/dayPayInfo/dayCash.jsp">--%>
<%--  <c:param name="menuCd" value="${menuCd}"/>--%>
<%--  <c:param name="menuNm" value="${menuNm}"/>--%>
<%--</c:import>--%>

<%--&lt;%&ndash; PAYCO 상세 레이어 &ndash;%&gt;--%>
<%--<c:import url="/WEB-INF/view/sale/cmmSalePopup/dayPayInfo/dayPayco.jsp">--%>
<%--  <c:param name="menuCd" value="${menuCd}"/>--%>
<%--  <c:param name="menuNm" value="${menuNm}"/>--%>
<%--</c:import>--%>

<%--&lt;%&ndash; VMEM 포인트 상세 레이어 &ndash;%&gt;--%>
<%--<c:import url="/WEB-INF/view/sale/cmmSalePopup/dayPayInfo/dayVpoint.jsp">--%>
<%--  <c:param name="menuCd" value="${menuCd}"/>--%>
<%--  <c:param name="menuNm" value="${menuNm}"/>--%>
<%--</c:import>--%>

<%--&lt;%&ndash; VMEM 전자상품권 상세 레이어 &ndash;%&gt;--%>
<%--<c:import url="/WEB-INF/view/sale/cmmSalePopup/dayPayInfo/dayVcharge.jsp">--%>
<%--  <c:param name="menuCd" value="${menuCd}"/>--%>
<%--  <c:param name="menuNm" value="${menuNm}"/>--%>
<%--</c:import>--%>

<%--&lt;%&ndash; 모바일페이 상세 레이어 &ndash;%&gt;--%>
<%--<c:import url="/WEB-INF/view/sale/cmmSalePopup/dayPayInfo/dayMpay.jsp">--%>
<%--  <c:param name="menuCd" value="${menuCd}"/>--%>
<%--  <c:param name="menuNm" value="${menuNm}"/>--%>
<%--</c:import>--%>

<%--&lt;%&ndash; 모바일쿠폰 상세 레이어 &ndash;%&gt;--%>
<%--<c:import url="/WEB-INF/view/sale/cmmSalePopup/dayPayInfo/dayMcoupn.jsp">--%>
<%--  <c:param name="menuCd" value="${menuCd}"/>--%>
<%--  <c:param name="menuNm" value="${menuNm}"/>--%>
<%--</c:import>--%>

<%--&lt;%&ndash; 포인트 상세 레이어 &ndash;%&gt;--%>
<%--<c:import url="/WEB-INF/view/sale/cmmSalePopup/dayPayInfo/dayPoint.jsp">--%>
<%--  <c:param name="menuCd" value="${menuCd}"/>--%>
<%--  <c:param name="menuNm" value="${menuNm}"/>--%>
<%--</c:import>--%>

<%--&lt;%&ndash; 회원선불 상세 레이어 &ndash;%&gt;--%>
<%--<c:import url="/WEB-INF/view/sale/cmmSalePopup/dayPayInfo/dayPrepaid.jsp">--%>
<%--  <c:param name="menuCd" value="${menuCd}"/>--%>
<%--  <c:param name="menuNm" value="${menuNm}"/>--%>
<%--</c:import>--%>

<%--&lt;%&ndash; 회원후불 상세 레이어 &ndash;%&gt;--%>
<%--<c:import url="/WEB-INF/view/sale/cmmSalePopup/dayPayInfo/dayPostpaid.jsp">--%>
<%--  <c:param name="menuCd" value="${menuCd}"/>--%>
<%--  <c:param name="menuNm" value="${menuNm}"/>--%>
<%--</c:import>--%>

<%--&lt;%&ndash; 상품권 상세 레이어 &ndash;%&gt;--%>
<%--<c:import url="/WEB-INF/view/sale/cmmSalePopup/dayPayInfo/dayGift.jsp">--%>
<%--  <c:param name="menuCd" value="${menuCd}"/>--%>
<%--  <c:param name="menuNm" value="${menuNm}"/>--%>
<%--</c:import>--%>

<%--&lt;%&ndash; 식권 상세 레이어 &ndash;%&gt;--%>
<%--<c:import url="/WEB-INF/view/sale/cmmSalePopup/dayPayInfo/dayFstmp.jsp">--%>
<%--  <c:param name="menuCd" value="${menuCd}"/>--%>
<%--  <c:param name="menuNm" value="${menuNm}"/>--%>
<%--</c:import>--%>

<%--&lt;%&ndash; 제휴카드 상세 레이어 &ndash;%&gt;--%>
<%--<c:import url="/WEB-INF/view/sale/cmmSalePopup/dayPayInfo/dayPartner.jsp">--%>
<%--  <c:param name="menuCd" value="${menuCd}"/>--%>
<%--  <c:param name="menuNm" value="${menuNm}"/>--%>
<%--</c:import>--%>

<%--&lt;%&ndash; 사원카드 상세 레이어 &ndash;%&gt;--%>
<%--<c:import url="/WEB-INF/view/sale/cmmSalePopup/dayPayInfo/dayEmpCard.jsp">--%>
<%--  <c:param name="menuCd" value="${menuCd}"/>--%>
<%--  <c:param name="menuNm" value="${menuNm}"/>--%>
<%--</c:import>--%>

<%--&lt;%&ndash; 가승인 상세 레이어 &ndash;%&gt;--%>
<%--<c:import url="/WEB-INF/view/sale/cmmSalePopup/dayPayInfo/dayTemporary.jsp">--%>
<%--  <c:param name="menuCd" value="${menuCd}"/>--%>
<%--  <c:param name="menuNm" value="${menuNm}"/>--%>
<%--</c:import>--%>

<%--&lt;%&ndash; 스마트오더 상세 레이어 &ndash;%&gt;--%>
<%--<c:import url="/WEB-INF/view/sale/cmmSalePopup/dayPayInfo/dayVorder.jsp">--%>
<%--  <c:param name="menuCd" value="${menuCd}"/>--%>
<%--  <c:param name="menuNm" value="${menuNm}"/>--%>
<%--</c:import>--%>
<%--&lt;%&ndash; //결제수단 팝업 레이어 &ndash;%&gt;--%>