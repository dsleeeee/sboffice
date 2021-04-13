<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="f" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var="menuCd" value="${sessionScope.sessionInfo.currentMenu.resrceCd}"/>
<c:set var="menuNm" value="${sessionScope.sessionInfo.currentMenu.resrceNm}"/>
<c:set var="orgnFg" value="${sessionScope.sessionInfo.orgnFg}" />
<c:set var="orgnCd" value="${sessionScope.sessionInfo.orgnCd}" />

<div class="subCon" ng-controller="todaySaleCtrl">

    <div class="searchBar">
        <a href="#" class="fl"><s:message code="mobile.todaySale"/></a>
        <%-- 조회 --%>
        <button class="btn_blue fr mt5 mr10" id="btnSearch" ng-click="_broadcast('todaySaleCtrl', 1)">
            <s:message code="cmm.search"/>
        </button>
    </div>
    <table class="searchTbl">
        <colgroup>
            <col class="w20"/>
            <col class="w80"/>
        </colgroup>
        <tbody>
        <tr>
            <%-- 조회일자 --%>
            <th><s:message code="cmm.search.date"/></th>
            <td>
                <div class="sb-select">
                    <span class="txtIn"> <input id="startDate" name="startDate" class="w110px" /></span>
                </div>
            </td>
        </tr>
        <c:if test="${multiStoreFg ne 0}">
            <tr>
                <%-- (다중)매장코드 --%>
                <th><s:message code="mobile.todaySale.store"/></th>
                <td>
                    <%-- 다중매장선택 모듈 멀티 선택 사용시 include --%>
                    <jsp:include page="/WEB-INF/view/mobile/sale/com/popup/selectMultiStore.jsp" flush="true">
                        <jsp:param name="targetId" value="mobileTodaySaleStore"/>
                    </jsp:include>
                    <%--// 다중매장선택 모듈 멀티 선택 사용시 include --%>
                </td>
            </tr>
        </c:if>
        <c:if test="${multiStoreFg eq 0}">
            <input type="hidden" id="mobileTodaySaleStoreCd" value="${sessionInfo.storeCd}"/>
        </c:if>
        </tbody>
    </table>

    <%-- 당일매출종합 --%>
    <div class="gridBar mt10" id="todaySaleTotal" onclick="girdFldUnfld('todaySaleTotal')">
        <a href="#" class="open"><s:message code="mobile.todaySale.todaySaleTotal"/></a>
    </div>
    <div class="wj-dialog-body sc2" id="todaySaleTotalGrid" ng-controller="todaySaleTotalCtrl">
        <%--<div class="tblBr">--%>
            <table class="tblType01">
                <colgroup>
                    <col class="w33"/>
                    <col class="w33"/>
                    <col class="w33"/>
                </colgroup>
                <tbody>
                <tr>
                    <%-- 매출건수 --%>
                    <th class="tc br bl">
                        <s:message code="mobile.todaySale.saleCnt"/>
                    </th>
                    <%-- 반품건수 --%>
                    <th class="tc br">
                        <s:message code="mobile.todaySale.returnSaleCnt"/>
                    </th>
                    <%-- 영수건수 --%>
                    <th class="tc br">
                        <s:message code="mobile.todaySale.billCnt"/>
                    </th>
                </tr>
                <tr>
                    <td class="tr br bl">
                        <label id="lblSaleCnt"></label>
                    </td>
                    <td class="tr br">
                        <label id="lblReturnSaleCnt"></label>
                    </td>
                    <td class="tr br">
                        <label id="lblBillCnt"></label>
                    </td>
                </tr>
                <tr>
                    <%-- 총매출액 --%>
                    <th class="tc br bl">
                        <s:message code="mobile.todaySale.totSaleAmt"/>
                    </th>
                    <%-- 총할인액 --%>
                    <th class="tc br">
                        <s:message code="mobile.todaySale.totDcAmt"/>
                    </th>
                    <%-- 실매출액 --%>
                    <th class="tc br">
                        <s:message code="mobile.todaySale.realSaleAmt"/>
                    </th>
                </tr>
                <tr>
                    <td class="tr br bl">
                        <label id="lblTotSaleAmt"></label>
                    </td>
                    <td class="tr br">
                        <label id="lblTotDcAmt"></label>
                    </td>
                    <td class="tr br">
                        <label id="lblRealSaleAmt"></label>
                    </td>
                </tr>
                <tr>
                    <%-- 방문객수 --%>
                    <th class="tc br bl">
                        <s:message code="mobile.todaySale.totGuestCnt"/>
                    </th>
                    <%-- 객단가 --%>
                    <th class="tc br">
                        <s:message code="mobile.todaySale.guestUprc"/>
                    </th>
                    <%-- 영수단가 --%>
                    <th class="tc br">
                        <s:message code="mobile.todaySale.billUprc"/>
                    </th>
                </tr>
                <tr>
                    <td class="tr br bl">
                        <label id="lblTotGuestCnt"></label>
                    </td>
                    <td class="tr br">
                        <label id="lblGuestUprc"></label>
                    </td>
                    <td class="tr br">
                        <label id="lblBillUprc"></label>
                    </td>
                </tr>
                <tr>
                    <%-- 주문테이블수 --%>
                    <th class="tc br bl">
                        <s:message code="mobile.todaySale.tblCnt"/>
                    </th>
                    <%-- 테이블단가 --%>
                    <th class="tc br">
                        <s:message code="mobile.todaySale.tblUprc"/>
                    </th>
                    <th class="tc br"></th>
                </tr>
                <tr>
                    <td class="tr br bl">
                        <label id="lblTblCnt"></label>
                    </td>
                    <td class="tr br">
                        <label id="lblTblUprcc"></label>
                    </td>
                    <td class="tr br"></td>
                </tr>
                <tr>
                    <%-- 카드매출 --%>
                    <th class="tc br bl">
                        <s:message code="mobile.todaySale.cardAmt"/>
                    </th>
                    <%-- 현금매출 --%>
                    <th class="tc br">
                        <s:message code="mobile.todaySale.cashAmt"/>
                    </th>
                    <%-- 기타매출 --%>
                    <th class="tc br">
                        <s:message code="mobile.todaySale.etcAmt"/>
                    </th>
                </tr>
                <tr>
                    <td class="tr br bl">
                        <label id="lblCardAmt"></label>
                    </td>
                    <td class="tr br">
                        <label id="lblCashAmt"></label>
                    </td>
                    <td class="tr br">
                        <label id="lblEtcAmt"></label>
                    </td>
                </tr>
                <tr>
                    <%-- 일반할인 --%>
                    <th class="tc br bl">
                        <s:message code="mobile.todaySale.dcAmt"/>
                    </th>
                    <%-- 쿠폰할인 --%>
                    <th class="tc br">
                        <s:message code="mobile.todaySale.coupnDcAmt"/>
                    </th>
                    <%-- 기타할인 --%>
                    <th class="tc br">
                        <s:message code="mobile.todaySale.totalDcAmt"/>
                    </th>
                </tr>
                <tr>
                    <td class="tr br bl">
                        <label id="lblDcAmt"></label>
                    </td>
                    <td class="tr br">
                        <label id="lblCoupnDcAmt"></label>
                    </td>
                    <td class="tr br">
                        <label id="lblTotalDcAmt"></label>
                    </td>
                </tr>
                </tbody>
            </table>
        <%--</div>--%>
    </div>
    <%-- //당일매출종합 --%>

    <%-- 결제수단 --%>
    <div class="gridBar mt10" id="todaySalePay" onclick="girdFldUnfld('todaySalePay')">
        <a href="#" class="open"><s:message code="mobile.todaySale.todaySalePay"/></a>
    </div>
    <div class="w100" id="todaySalePayGrid">
        <div class="wj-gridWrap" style="overflow-x: hidden; overflow-y: hidden;">
            <wj-flex-grid
                    autoGenerateColumns="false"
                    control="flex"
                    initialized="initGrid(s,e)"
                    selection-mode="Row"
                    items-source="data"
                    item-formatter="_itemFormatter"
                    is-read-only="true">

                <!-- define columns -->
                <wj-flex-grid-column header="<s:message code="mobile.todaySale.nm"/>" binding="nm" width="1.*" align="center" is-read-only="true"></wj-flex-grid-column>
                <wj-flex-grid-column header="<s:message code="mobile.todaySale.amtCnt"/>" binding="amtCnt" width="1.*" align="right" is-read-only="true" aggregate="Sum"></wj-flex-grid-column>
                <wj-flex-grid-column header="<s:message code="mobile.todaySale.amt"/>" binding="amt" width="1.*" align="right" is-read-only="true" aggregate="Sum"></wj-flex-grid-column>
                <wj-flex-grid-column header="<s:message code="mobile.todaySale.amtRate"/>" binding="amtRate" width="1.*" align="right" is-read-only="true"></wj-flex-grid-column>
            </wj-flex-grid>
        </div>
    </div>
    <%-- //결제수단 --%>

    <%-- 할인내역 --%>
    <div class="gridBar mt10" id="todaySaleDc" onclick="girdFldUnfld('todaySaleDc')">
        <a href="#" class="open"><s:message code="mobile.todaySale.todaySaleDc"/></a>
    </div>
    <div class="w100" id="todaySaleDcGrid" ng-controller="todaySaleDcCtrl">
        <div class="wj-gridWrap" style="overflow-x: hidden; overflow-y: hidden;">
            <wj-flex-grid
                    autoGenerateColumns="false"
                    control="flex"
                    initialized="initGrid(s,e)"
                    selection-mode="Row"
                    items-source="data"
                    item-formatter="_itemFormatter"
                    is-read-only="true">

                <!-- define columns -->
                <wj-flex-grid-column header="<s:message code="mobile.todaySale.nm"/>" binding="nm" width="1.*" align="center" is-read-only="true"></wj-flex-grid-column>
                <wj-flex-grid-column header="<s:message code="mobile.todaySale.amtCnt"/>" binding="amtCnt" width="1.*" align="right" is-read-only="true" aggregate="Sum"></wj-flex-grid-column>
                <wj-flex-grid-column header="<s:message code="mobile.todaySale.amt"/>" binding="amt" width="1.*" align="right" is-read-only="true" aggregate="Sum"></wj-flex-grid-column>
                <wj-flex-grid-column header="<s:message code="mobile.todaySale.amtRate"/>" binding="amtRate" width="1.*" align="right" is-read-only="true"></wj-flex-grid-column>
            </wj-flex-grid>
        </div>
    </div>
    <%-- //할인내역 --%>

    <%-- 매장/배달/포장 --%>
    <div class="gridBar mt10" id="todaySaleDlvr" onclick="girdFldUnfld('todaySaleDlvr')">
        <a href="#" class="open"><s:message code="mobile.todaySale.todaySaleDlvr"/></a>
    </div>
    <div class="w100" id="todaySaleDlvrGrid" ng-controller="todaySaleDlvrCtrl">
        <div class="wj-gridWrap" style="overflow-x: hidden; overflow-y: hidden;">
            <wj-flex-grid
                    autoGenerateColumns="false"
                    control="flex"
                    initialized="initGrid(s,e)"
                    selection-mode="Row"
                    items-source="data"
                    item-formatter="_itemFormatter"
                    is-read-only="true">

                <!-- define columns -->
                <wj-flex-grid-column header="<s:message code="mobile.todaySale.nm"/>" binding="nm" width="1.*" align="center" is-read-only="true"></wj-flex-grid-column>
                <wj-flex-grid-column header="<s:message code="mobile.todaySale.amtCnt"/>" binding="amtCnt" width="1.*" align="right" is-read-only="true" aggregate="Sum"></wj-flex-grid-column>
                <wj-flex-grid-column header="<s:message code="mobile.todaySale.amt"/>" binding="amt" width="1.*" align="right" is-read-only="true" aggregate="Sum"></wj-flex-grid-column>
                <wj-flex-grid-column header="<s:message code="mobile.todaySale.amtRate"/>" binding="amtRate" width="1.*" align="right" is-read-only="true"></wj-flex-grid-column>
            </wj-flex-grid>
        </div>
    </div>
    <%-- //매장/배달/포장 --%>

    <%-- 시간대별 --%>
    <div class="gridBar mt10" id="todaySaleTime" onclick="girdFldUnfld('todaySaleTime')">
        <a href="#" class="open"><s:message code="mobile.todaySale.todaySaleTime"/></a>
    </div>
    <div class="w100" id="todaySaleTimeGrid" ng-controller="todaySaleTimeCtrl">
        <div class="wj-gridWrap" style="overflow-x: hidden; overflow-y: hidden;">
            <wj-flex-grid
                    autoGenerateColumns="false"
                    control="flex"
                    initialized="initGrid(s,e)"
                    selection-mode="Row"
                    items-source="data"
                    item-formatter="_itemFormatter"
                    is-read-only="true">

                <!-- define columns -->
                <wj-flex-grid-column header="<s:message code="mobile.todaySale.saleTime"/>" binding="saleTime" width="1.*" align="center" is-read-only="true"></wj-flex-grid-column>
                <wj-flex-grid-column header="<s:message code="mobile.todaySale.amtCnt"/>" binding="amtCnt" width="1.*" align="right" is-read-only="true" aggregate="Sum"></wj-flex-grid-column>
                <wj-flex-grid-column header="<s:message code="mobile.todaySale.amt"/>" binding="amt" width="1.*" align="right" is-read-only="true" aggregate="Sum"></wj-flex-grid-column>
                <wj-flex-grid-column header="<s:message code="mobile.todaySale.amtRate"/>" binding="amtRate" width="1.*" align="right" is-read-only="true"></wj-flex-grid-column>
            </wj-flex-grid>
        </div>
    </div>
    <%-- //시간대별 --%>

</div>

<script type="text/javascript">
    var multiStoreFg = '${multiStoreFg}';
</script>

<script type="text/javascript" src="/resource/solbipos/js/mobile/sale/today/todaySale/todaySale.js?ver=20210412.03" charset="utf-8"></script>