<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="f" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var="menuCd" value="${sessionScope.sessionInfo.currentMenu.resrceCd}"/>
<c:set var="menuNm" value="${sessionScope.sessionInfo.currentMenu.resrceNm}"/>
<c:set var="orgnFg" value="${sessionScope.sessionInfo.orgnFg}" />
<c:set var="orgnCd" value="${sessionScope.sessionInfo.orgnCd}" />

<div class="subCon" id="payTemporaryGiftView" style="display: none;padding: 10px 20px 40px;">

    <div ng-controller="payTemporaryGiftCtrl">
        <%-- 조회조건 --%>
        <%--<div class="searchBar flddUnfld">--%>
        <div class="searchBar">
            <a href="#" class="open fl"><s:message code="payTemporaryGift.info"/></a>
            <%-- 조회 --%>
            <div class="mr15 fr" style="display:block;position: relative;margin-top: 6px;">
                <button class="btn_blue fr" ng-click="_broadcast('payTemporaryGiftCtrl',1)">
                    <s:message code="cmm.search" />
                </button>
                <c:if test="${sessionInfo.orgnFg == 'HQ'}">
                    <%-- 확장조회 --%>
                    <button class="btn_blue mr5 fl" id="btnSearchAddShow" ng-click="searchAddShowChange()">
                        <s:message code="cmm.search.addShow"/>
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
                        <span class="txtIn"><input id="srchStartDate" class="w110px"></span>
                        <span class="rg">~</span>
                        <span class="txtIn"><input id="srchEndDate" class="w110px"></span>
                    </div>
                </td>
            </tr>
            <c:if test="${sessionInfo.orgnFg == 'HQ'}">
                <tr>
                    <%-- 매장브랜드 --%>
                    <th><s:message code="cmm.moms.storeHqBrand"/></th>
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
                    <th><s:message code="cmm.store.select"/></th>
                    <td>
                        <%-- 매장선택 모듈 사용시 include --%>
                        <jsp:include page="/WEB-INF/view/common/popup/selectStore.jsp" flush="true">
                            <jsp:param name="targetTypeFg" value="M"/>
                            <jsp:param name="targetId" value="payTemporaryGiftStore"/>
                        </jsp:include>
                        <%--// 매장선택 모듈 사용시 include --%>
                    </td>
                </tr>
            </c:if>
            <c:if test="${sessionInfo.orgnFg == 'STORE'}">
                <input type="hidden" id="payTemporaryGiftStoreCd" value="${sessionInfo.storeCd}"/>
            </c:if>
            </tbody>
        </table>
        <table class="searchTbl" id="tblSearchAddShow2" style="display: none;">
            <colgroup>
                <col class="w15"/>
                <col class="w35"/>
                <col class="w15"/>
                <col class="w35"/>
            </colgroup>
            <tbody>
            <tr>
                <%-- 팀별 --%>
                <th><s:message code="cmm.moms.momsTeam"/></th>
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
                <th><s:message code="cmm.moms.momsAcShop"/></th>
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
                <th><s:message code="cmm.moms.momsAreaFg"/></th>
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
                <th><s:message code="cmm.moms.momsCommercial"/></th>
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
                <th><s:message code="cmm.moms.momsShopType"/></th>
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
                <th><s:message code="cmm.moms.momsStoreManageType"/></th>
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
            <tr>
                <%-- 그룹 --%>
                <th><s:message code="cmm.moms.branch"/></th>
                <td>
                    <div class="sb-select">
                        <wj-combo-box
                                id="srchBranchCdCombo"
                                ng-model="branchCd"
                                items-source="_getComboData('branchCdCombo')"
                                display-member-path="name"
                                selected-value-path="value"
                                is-editable="false"
                                initialized="_initComboBox(s)"
                                control="srchBranchCdCombo">
                        </wj-combo-box>
                    </div>
                </td>
                <%-- 매장그룹 --%>
                <th><s:message code="cmm.moms.momsStoreFg01"/></th>
                <td>
                    <div class="sb-select">
                        <wj-combo-box
                                id="srchMomsStoreFg01Combo"
                                ng-model="momsStoreFg01"
                                items-source="_getComboData('momsStoreFg01Combo')"
                                display-member-path="name"
                                selected-value-path="value"
                                is-editable="false"
                                initialized="_initComboBox(s)"
                                control="srchMomsStoreFg01Combo">
                        </wj-combo-box>
                    </div>
                </td>
            </tr>
            <c:if test="${sessionScope.sessionInfo.userId == 'ds021' or sessionScope.sessionInfo.userId == 'ds034' or sessionScope.sessionInfo.userId == 'h0393'}">
                <tr>
                    <%-- 매장그룹2 --%>
                    <th><s:message code="cmm.moms.momsStoreFg02"/></th>
                    <td>
                        <div class="sb-select">
                            <wj-combo-box
                                    id="srchMomsStoreFg02Combo"
                                    ng-model="momsStoreFg02"
                                    items-source="_getComboData('momsStoreFg02Combo')"
                                    display-member-path="name"
                                    selected-value-path="value"
                                    is-editable="false"
                                    initialized="_initComboBox(s)"
                                    control="srchMomsStoreFg02Combo">
                            </wj-combo-box>
                        </div>
                    </td>
                    <%-- 매장그룹3 --%>
                    <th><s:message code="cmm.moms.momsStoreFg03"/></th>
                    <td>
                        <div class="sb-select">
                            <wj-combo-box
                                    id="srchMomsStoreFg03Combo"
                                    ng-model="momsStoreFg03"
                                    items-source="_getComboData('momsStoreFg03Combo')"
                                    display-member-path="name"
                                    selected-value-path="value"
                                    is-editable="false"
                                    initialized="_initComboBox(s)"
                                    control="srchMomsStoreFg03Combo">
                            </wj-combo-box>
                        </div>
                    </td>
                </tr>
                <tr>
                    <%-- 매장그룹4 --%>
                    <th><s:message code="cmm.moms.momsStoreFg04"/></th>
                    <td>
                        <div class="sb-select">
                            <wj-combo-box
                                    id="srchMomsStoreFg04Combo"
                                    ng-model="momsStoreFg04"
                                    items-source="_getComboData('momsStoreFg04Combo')"
                                    display-member-path="name"
                                    selected-value-path="value"
                                    is-editable="false"
                                    initialized="_initComboBox(s)"
                                    control="srchMomsStoreFg04Combo">
                            </wj-combo-box>
                        </div>
                    </td>
                    <%-- 매장그룹5 --%>
                    <th><s:message code="cmm.moms.momsStoreFg05"/></th>
                    <td>
                        <div class="sb-select">
                            <wj-combo-box
                                    id="srchMomsStoreFg05Combo"
                                    ng-model="momsStoreFg05"
                                    items-source="_getComboData('momsStoreFg05Combo')"
                                    display-member-path="name"
                                    selected-value-path="value"
                                    is-editable="false"
                                    initialized="_initComboBox(s)"
                                    control="srchMomsStoreFg05Combo">
                            </wj-combo-box>
                        </div>
                    </td>
                </tr>
            </c:if>
            </tbody>
        </table>

        <div class="mt10 oh sb-select dkbr">
            <%-- 엑셀다운로드 --%>
            <button class="btn_skyblue ml5 fr" ng-click="excelDownloadInfo()"><s:message code="cmm.excel.downCondition"/></button>
        </div>

        <%-- 그리드 --%>
        <div class="w100 mt10 mb20">
            <div class="wj-gridWrap" style="height:370px; overflow-y: hidden; overflow-x: hidden;">
                <wj-flex-grid
                        autoGenerateColumns="false"
                        control="flex"
                        initialized="initGrid(s,e)"
                        sticky-headers="true"
                        selection-mode="Row"
                        items-source="data"
                        item-formatter="_itemFormatter">

                    <!-- define columns -->
                    <c:if test="${sessionInfo.orgnFg == 'HQ'}">
                        <wj-flex-grid-column header="<s:message code="payTemporaryGift.storeCd"/>" binding="storeCd" width="70" align="center" is-read-only="true"></wj-flex-grid-column>
                        <wj-flex-grid-column header="<s:message code="payTemporaryGift.storeNm"/>" binding="storeNm" width="100" align="center" is-read-only="true"></wj-flex-grid-column>
                    </c:if>
                    <wj-flex-grid-column header="<s:message code="payTemporaryGift.saleDate"/>" binding="saleDate" width="80" align="center" is-read-only="true"></wj-flex-grid-column>
                    <wj-flex-grid-column header="<s:message code="payTemporaryGift.posNo"/>" binding="posNo" width="65" align="center" is-read-only="true"></wj-flex-grid-column>
                    <wj-flex-grid-column header="<s:message code="payTemporaryGift.billNo"/>" binding="billNo" width="65" align="center" is-read-only="true"></wj-flex-grid-column>
                    <wj-flex-grid-column header="<s:message code="payTemporaryGift.lineNo"/>" binding="lineNo" width="65" align="center" is-read-only="true"></wj-flex-grid-column>
                    <wj-flex-grid-column header="<s:message code="payTemporaryGift.lineSeqNo"/>" binding="lineSeqNo" width="85" align="center" is-read-only="true"></wj-flex-grid-column>
                    <wj-flex-grid-column header="<s:message code="payTemporaryGift.saleYn"/>" binding="saleYn" data-map="saleYnDataMap" width="70" align="center" is-read-only="true"></wj-flex-grid-column>
                    <wj-flex-grid-column header="<s:message code="payTemporaryGift.saleCnt"/>" binding="saleCnt" width="65" align="right" is-read-only="true" aggregate="Sum"></wj-flex-grid-column>
                    <wj-flex-grid-column header="<s:message code="payTemporaryGift.saleAmt"/>" binding="saleAmt" width="90" align="right" is-read-only="true" aggregate="Sum"></wj-flex-grid-column>
                    <wj-flex-grid-column header="<s:message code="cmm.moms.branch"/>" binding="branchCd" data-map="branchCdDataMap" width="80" align="center" is-read-only="true"></wj-flex-grid-column>
                    <wj-flex-grid-column header="<s:message code="cmm.moms.momsTeam"/>" binding="momsTeam" data-map="momsTeamDataMap" width="70" align="center" is-read-only="true"></wj-flex-grid-column>
                    <wj-flex-grid-column header="<s:message code="cmm.moms.momsAcShop"/>" binding="momsAcShop" data-map="momsAcShopDataMap" width="80" align="center" is-read-only="true"></wj-flex-grid-column>
                    <wj-flex-grid-column header="<s:message code="cmm.moms.momsAreaFg"/>" binding="momsAreaFg" data-map="momsAreaFgDataMap" width="80" align="center" is-read-only="true"></wj-flex-grid-column>
                    <wj-flex-grid-column header="<s:message code="cmm.moms.momsCommercial"/>" binding="momsCommercial" data-map="momsCommercialDataMap" width="90" align="center" is-read-only="true"></wj-flex-grid-column>
                    <wj-flex-grid-column header="<s:message code="cmm.moms.momsShopType"/>" binding="momsShopType" data-map="momsShopTypeDataMap" width="70" align="center" is-read-only="true"></wj-flex-grid-column>
                    <wj-flex-grid-column header="<s:message code="cmm.moms.momsStoreManageType"/>" binding="momsStoreManageType" data-map="momsStoreManageTypeDataMap" width="90" align="center" is-read-only="true"></wj-flex-grid-column>
                    <wj-flex-grid-column header="<s:message code="cmm.moms.momsStoreFg01"/>" binding="momsStoreFg01" data-map="momsStoreFg01DataMap" width="90" align="center" is-read-only="true"></wj-flex-grid-column>
                    <c:if test="${sessionScope.sessionInfo.userId == 'ds021' or sessionScope.sessionInfo.userId == 'ds034' or sessionScope.sessionInfo.userId == 'h0393'}">
                        <wj-flex-grid-column header="<s:message code="cmm.moms.momsStoreFg02"/>" binding="momsStoreFg02" data-map="momsStoreFg02DataMap" width="90" align="center" is-read-only="true"></wj-flex-grid-column>
                        <wj-flex-grid-column header="<s:message code="cmm.moms.momsStoreFg03"/>" binding="momsStoreFg03" data-map="momsStoreFg03DataMap" width="90" align="center" is-read-only="true"></wj-flex-grid-column>
                        <wj-flex-grid-column header="<s:message code="cmm.moms.momsStoreFg04"/>" binding="momsStoreFg04" data-map="momsStoreFg04DataMap" width="90" align="center" is-read-only="true"></wj-flex-grid-column>
                        <wj-flex-grid-column header="<s:message code="cmm.moms.momsStoreFg05"/>" binding="momsStoreFg05" data-map="momsStoreFg05DataMap" width="90" align="center" is-read-only="true"></wj-flex-grid-column>
                    </c:if>
                </wj-flex-grid>
            </div>
        </div>
        <%-- 페이지 리스트 --%>
        <div class="pageNum mt20">
            <ul id="payTemporaryGiftCtrlPager" data-size="10">
            </ul>
        </div>
        <%--//페이지 리스트--%>
    </div>

    <%-- 엑셀다운로드 그리드 --%>
    <div class="w100 mt10 mb20" style="display: none;" ng-controller="payTemporaryGiftExcelCtrl">
        <div class="wj-gridWrap" style="height:370px; overflow-y: hidden; overflow-x: hidden;">
            <wj-flex-grid
                    autoGenerateColumns="false"
                    control="excelFlex"
                    initialized="initGrid(s,e)"
                    sticky-headers="true"
                    selection-mode="Row"
                    items-source="data"
                    item-formatter="_itemFormatter">

                <!-- define columns -->
                <c:if test="${sessionInfo.orgnFg == 'HQ'}">
                    <wj-flex-grid-column header="<s:message code="payTemporaryGift.storeCd"/>" binding="storeCd" width="70" align="center" is-read-only="true"></wj-flex-grid-column>
                    <wj-flex-grid-column header="<s:message code="payTemporaryGift.storeNm"/>" binding="storeNm" width="100" align="center" is-read-only="true"></wj-flex-grid-column>
                </c:if>
                <wj-flex-grid-column header="<s:message code="payTemporaryGift.saleDate"/>" binding="saleDate" width="80" align="center" is-read-only="true"></wj-flex-grid-column>
                <wj-flex-grid-column header="<s:message code="payTemporaryGift.posNo"/>" binding="posNo" width="65" align="center" is-read-only="true"></wj-flex-grid-column>
                <wj-flex-grid-column header="<s:message code="payTemporaryGift.billNo"/>" binding="billNo" width="65" align="center" is-read-only="true"></wj-flex-grid-column>
                <wj-flex-grid-column header="<s:message code="payTemporaryGift.lineNo"/>" binding="lineNo" width="65" align="center" is-read-only="true"></wj-flex-grid-column>
                <wj-flex-grid-column header="<s:message code="payTemporaryGift.lineSeqNo"/>" binding="lineSeqNo" width="85" align="center" is-read-only="true"></wj-flex-grid-column>
                <wj-flex-grid-column header="<s:message code="payTemporaryGift.saleYn"/>" binding="saleYn" data-map="saleYnDataMap" width="70" align="center" is-read-only="true"></wj-flex-grid-column>
                <wj-flex-grid-column header="<s:message code="payTemporaryGift.saleCnt"/>" binding="saleCnt" width="65" align="right" is-read-only="true" aggregate="Sum"></wj-flex-grid-column>
                <wj-flex-grid-column header="<s:message code="payTemporaryGift.saleAmt"/>" binding="saleAmt" width="90" align="right" is-read-only="true" aggregate="Sum"></wj-flex-grid-column>
                <wj-flex-grid-column header="<s:message code="cmm.moms.branch"/>" binding="branchCd" data-map="branchCdDataMap" width="80" align="center" is-read-only="true"></wj-flex-grid-column>
                <wj-flex-grid-column header="<s:message code="cmm.moms.momsTeam"/>" binding="momsTeam" data-map="momsTeamDataMap" width="70" align="center" is-read-only="true"></wj-flex-grid-column>
                <wj-flex-grid-column header="<s:message code="cmm.moms.momsAcShop"/>" binding="momsAcShop" data-map="momsAcShopDataMap" width="80" align="center" is-read-only="true"></wj-flex-grid-column>
                <wj-flex-grid-column header="<s:message code="cmm.moms.momsAreaFg"/>" binding="momsAreaFg" data-map="momsAreaFgDataMap" width="80" align="center" is-read-only="true"></wj-flex-grid-column>
                <wj-flex-grid-column header="<s:message code="cmm.moms.momsCommercial"/>" binding="momsCommercial" data-map="momsCommercialDataMap" width="90" align="center" is-read-only="true"></wj-flex-grid-column>
                <wj-flex-grid-column header="<s:message code="cmm.moms.momsShopType"/>" binding="momsShopType" data-map="momsShopTypeDataMap" width="70" align="center" is-read-only="true"></wj-flex-grid-column>
                <wj-flex-grid-column header="<s:message code="cmm.moms.momsStoreManageType"/>" binding="momsStoreManageType" data-map="momsStoreManageTypeDataMap" width="90" align="center" is-read-only="true"></wj-flex-grid-column>
                <wj-flex-grid-column header="<s:message code="cmm.moms.momsStoreFg01"/>" binding="momsStoreFg01" data-map="momsStoreFg01DataMap" width="90" align="center" is-read-only="true"></wj-flex-grid-column>
                <c:if test="${sessionScope.sessionInfo.userId == 'ds021' or sessionScope.sessionInfo.userId == 'ds034' or sessionScope.sessionInfo.userId == 'h0393'}">
                    <wj-flex-grid-column header="<s:message code="cmm.moms.momsStoreFg02"/>" binding="momsStoreFg02" data-map="momsStoreFg02DataMap" width="90" align="center" is-read-only="true"></wj-flex-grid-column>
                    <wj-flex-grid-column header="<s:message code="cmm.moms.momsStoreFg03"/>" binding="momsStoreFg03" data-map="momsStoreFg03DataMap" width="90" align="center" is-read-only="true"></wj-flex-grid-column>
                    <wj-flex-grid-column header="<s:message code="cmm.moms.momsStoreFg04"/>" binding="momsStoreFg04" data-map="momsStoreFg04DataMap" width="90" align="center" is-read-only="true"></wj-flex-grid-column>
                    <wj-flex-grid-column header="<s:message code="cmm.moms.momsStoreFg05"/>" binding="momsStoreFg05" data-map="momsStoreFg05DataMap" width="90" align="center" is-read-only="true"></wj-flex-grid-column>
                </c:if>
            </wj-flex-grid>
        </div>
    </div>

</div>

<script type="text/javascript">
    var payColList = [];
    <%--javascript에서 사용할 결제수단 json 데이터 생성--%>
    <c:forEach var="payCol" items="${payColList}">
        var payParam = {};
        payParam.payCd = "${payCol.payCd}";
        payParam.payMethod = "${payCol.payMethod}";
        payColList.push(payParam);
    </c:forEach>

    var dcColList = [];
    <%--javascript에서 사용할 할인 json 데이터 생성--%>
    <c:forEach var="dcCol" items="${dcColList}">
        var dcParam = {};
        dcParam.dcCd = "${dcCol.dcCd}";
        dcParam.dcMethod = "${dcCol.dcMethod}";
        dcColList.push(dcParam);
    </c:forEach>

    var payCol = '${payCol}';
    var dcCol = '${dcCol}';
    var guestCol = '${guestCol}';
    var arrPayCol = payCol.split(',');
    var arrDcCol = dcCol.split(',');
    var arrGuestCol = guestCol.split(',');
</script>

<script type="text/javascript" src="/resource/solbipos/js/sale/status/payTemporary/payTemporaryGift.js?ver=20240221.01" charset="utf-8"></script>

<%-- 영수증 상세 레이어 --%>
<c:import url="/WEB-INF/view/sale/cmmSalePopup/billInfo/billInfo.jsp">
    <c:param name="menuCd" value="${menuCd}"/>
    <c:param name="menuNm" value="${menuNm}"/>
    <c:param name="payColList" value="${payColList}"/>
    <c:param name="guestColList" value="${guestColList}"/>
</c:import>