<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix="f" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="subCon" id="storeChgCostPriceExcelUploadView" style="padding: 10px 20px 40px;">

    <%-- 양식다운로드 --%>
    <div ng-controller="storeChgCostPriceExcelUploadSampleCtrl">
        <div class="searchBar">
            <a href="#" class="open fl"><s:message code="storeChgCostPrice.excelUpload"/></a>
            <%-- 조회 --%>
            <div class="mr15 fr" style="display:block;position: relative;margin-top: 6px;">
            </div>
        </div>

        <table class="searchTbl">
            <colgroup>
                <col class="w15" />
                <col class="w35" />
                <col class="w15" />
                <col class="w35" />
            </colgroup>
            <tbody>
                <%-- 변경항목 --%>
                <tr>
                    <th><s:message code="storeChgCostPrice.costUprcType"/></th>
                    <td>
                        <div class="sb-select fl w50 mr5">
                            <wj-combo-box
                                    id="excelCostUprcType"
                                    ng-model="excelCostUprcType"
                                    control="excelCostUprcTypeCombo"
                                    items-source="_getComboData('excelCostUprcType')"
                                    display-member-path="name"
                                    selected-value-path="value"
                                    is-editable="false"
                                    selected-index-changed="selectedIndexChanged(s)">
                            </wj-combo-box>
                        </div>
                        <div class="sb-select" id="divExcelIostockYm">
                           <span class="txtIn"><input id="excelIostockYm" ng-model="excelIostockYm" class="w110px"></span>
                       </div>
                    </td>
                    <td></td>
                    <td></td>
                </tr>
            </tbody>
        </table>


        <div class="mt10 oh">
            <p class="tl s14 mt5 lh15">1. [변경항목]과 적용할 매장 선택 후, '양식다운로드' 버튼을 클릭하여 양식을 다운받아주세요.</p>
            <p class="tl s14 mt5 lh15 red">※ [변경항목] 수불원가 선택시, 수불년월 선택 필수</p>
            <p class="tl s14 mt5 lh15">2. 다운받은 양식을 입력해주세요.</p>
            <p class="tl s14 mt5 lh15">3. '엑셀업로드' 버튼을 클릭하여 업로드 해주세요.</p>
            <p class="tl s14 mt5 lh15">4. '원가'가 업로드되면 '저장'을 클릭하여 검증 및 저장을 해주세요.</p>
            <p class="tl s14 mt5 lh15">- 검증결과가 '검증성공'인 원가만 저장됩니다.</p>
            <p class="tl s14 mt5 lh15 red">※ 업로드시 '매장코드, 상품코드, 매장변경원가' 기준으로 처리되며, [변경항목]을 반드시 선택해야 합니다.</p>
            <%-- 엑셀업로드 --%>
            <button class="btn_skyblue ml5 fr" ng-click="excelUpload()">
                <s:message code="cmm.excel.excelUpload"/>
            </button>
            <%-- 양식다운로드 --%>
            <button class="btn_skyblue ml5 fr" ng-click="sampleDownload()">
                <s:message code="cmm.excel.sampleDown"/>
            </button>
            <%-- 매장 --%>
            <div class="ml5 fr">
                <%-- 매장선택 모듈 사용시 include --%>
                <jsp:include page="/WEB-INF/view/common/popup/selectStore.jsp" flush="true">
                    <jsp:param name="targetTypeFg" value="M"/>
                    <jsp:param name="targetId" value="storeChgCostPriceExcelUploadStore"/>
                </jsp:include>
                <%--// 매장선택 모듈 사용시 include --%>
            </div>
            <div class="sb-select dkbr ml5 fr">
                <%-- 매장선택 --%>
                <p class="tl s14 mt5 lh15"><s:message code="cmm.store.select"/></p>
            </div>
        </div>

        <div class="wj-gridWrap" style="display: none">
            <wj-flex-grid
                    autoGenerateColumns="false"
                    control="excelFlex"
                    initialized="initGrid(s,e)"
                    sticky-headers="true"
                    selection-mode="Row"
                    items-source="data"
                    item-formatter="_itemFormatter"
                    ime-enabled="true">

                <!-- define columns -->
                <wj-flex-grid-column header="<s:message code="storeChgCostPrice.storeCd"/>" binding="storeCd" width="100" is-read-only="true" align="center"></wj-flex-grid-column>
                <wj-flex-grid-column header="<s:message code="storeChgCostPrice.storeNm"/>" binding="storeNm" width="120" is-read-only="true" align="left"></wj-flex-grid-column>
                <wj-flex-grid-column header="<s:message code="storeChgCostPrice.prodCd"/>" binding="prodCd" width="120" is-read-only="true" align="center"></wj-flex-grid-column>
                <wj-flex-grid-column header="<s:message code="storeChgCostPrice.prodNm"/>" binding="prodNm" width="150" is-read-only="true" align="left"></wj-flex-grid-column>
                <wj-flex-grid-column header="<s:message code="storeChgCostPrice.hq"/><s:message code="storeChgCostPrice.saleUprc"/>" binding="hqSaleUprc" is-read-only="true" width="90" align="right"></wj-flex-grid-column>
                <wj-flex-grid-column header="<s:message code="storeChgCostPrice.store"/><s:message code="storeChgCostPrice.saleUprc"/>" binding="storeSaleUprc" is-read-only="true" width="90" align="right"></wj-flex-grid-column>
                <wj-flex-grid-column header="<s:message code="storeChgCostPrice.hq"/><s:message code="storeChgCostPrice.costUprc"/>" binding="hqCostUprc" is-read-only="true" width="90" align="right"></wj-flex-grid-column>
                <wj-flex-grid-column header="<s:message code="storeChgCostPrice.store"/><s:message code="storeChgCostPrice.curr.costPrice"/>" binding="storeCostUprc" is-read-only="true" width="100" align="right"></wj-flex-grid-column>
                <wj-flex-grid-column header="<s:message code="storeChgCostPrice.store"/><s:message code="storeChgCostPrice.change.costPrice"/>" binding="costUprc" is-read-only="true" width="100" align="right"></wj-flex-grid-column>
            </wj-flex-grid>
        </div>
    </div>

    <%-- 매장원가임의변경 엑셀업로드 그리드 --%>
    <div ng-controller="storeChgCostPriceExcelUploadCtrl">
        <div class="mt10 oh sb-select dkbr">
            <%-- 엑셀다운로드 --%>
            <button class="btn_skyblue ml5 fr" ng-click="excelDownload()">
                <s:message code="cmm.excel.down" />
            </button>
            <%-- 삭제 --%>
            <button class="btn_skyblue ml5 fr" ng-click="delete()">
                <s:message code="cmm.del" />
            </button>
            <%-- 저장 --%>
            <button class="btn_skyblue ml5 fr" id="btnSave" ng-click="save()">
                <s:message code="cmm.save" />
            </button>
        </div>

        <div class="w100 mt10 mb20">
            <div class="wj-gridWrap" style="height:310px; overflow-y: hidden; overflow-x: hidden;">
                <wj-flex-grid
                        autoGenerateColumns="false"
                        control="flex"
                        initialized="initGrid(s,e)"
                        sticky-headers="true"
                        selection-mode="Row"
                        items-source="data"
                        item-formatter="_itemFormatter"
                        ime-enabled="true"
                        frozen-columns="2">

                    <!-- define columns -->
                    <wj-flex-grid-column header="<s:message code="cmm.chk"/>" binding="gChk" width="40"></wj-flex-grid-column>
                    <wj-flex-grid-column header="<s:message code="storeChgCostPrice.result"/>" binding="result" width="100" is-read-only="true" align="center"></wj-flex-grid-column>
                    <wj-flex-grid-column header="<s:message code="storeChgCostPrice.storeCd"/>" binding="storeCd" width="100" is-read-only="true" align="center"></wj-flex-grid-column>
                    <wj-flex-grid-column header="<s:message code="storeChgCostPrice.storeNm"/>" binding="storeNm" width="120" is-read-only="true" align="left"></wj-flex-grid-column>
                    <wj-flex-grid-column header="<s:message code="storeChgCostPrice.prodCd"/>" binding="prodCd" width="120" is-read-only="true" align="center"></wj-flex-grid-column>
                    <wj-flex-grid-column header="<s:message code="storeChgCostPrice.prodNm"/>" binding="prodNm" width="150" is-read-only="true" align="left"></wj-flex-grid-column>
                    <wj-flex-grid-column header="<s:message code="storeChgCostPrice.hq"/><s:message code="storeChgCostPrice.saleUprc"/>" binding="hqSaleUprc" is-read-only="true" width="90" align="right"></wj-flex-grid-column>
                    <wj-flex-grid-column header="<s:message code="storeChgCostPrice.store"/><s:message code="storeChgCostPrice.saleUprc"/>" binding="storeSaleUprc" is-read-only="true" width="90" align="right"></wj-flex-grid-column>
                    <wj-flex-grid-column header="<s:message code="storeChgCostPrice.hq"/><s:message code="storeChgCostPrice.costUprc"/>" binding="hqCostUprc" is-read-only="true" width="90" align="right"></wj-flex-grid-column>
                    <wj-flex-grid-column header="<s:message code="storeChgCostPrice.store"/><s:message code="storeChgCostPrice.curr.costPrice"/>" binding="storeCostUprc" is-read-only="true" width="100" align="right"></wj-flex-grid-column>
                    <wj-flex-grid-column header="<s:message code="storeChgCostPrice.store"/><s:message code="storeChgCostPrice.change.costPrice"/>" binding="costUprc" width="100" align="right"></wj-flex-grid-column>
                    <wj-flex-grid-column header="<s:message code="storeChgCostPrice.prcCtrlFg"/>" binding="prcCtrlFg" data-map="prcCtrlFgDataMap" is-read-only="true" width="100" align="center"></wj-flex-grid-column>

                    <%-- 임시테이블 삭제시 필요 --%>
                    <wj-flex-grid-column header="<s:message code="storeChgCostPrice.seq"/>" binding="seq" width="100" is-read-only="true" align="center" visible="false"></wj-flex-grid-column>
                </wj-flex-grid>
            </div>
        </div>
    </div>

    <%-- 엑셀업로드 --%>
    <div style="display: none" ng-controller="storeChgCostPriceExcelUploadAddCtrl">
        <input type="file" class="form-control" id="storeChgCostPriceExcelUpFile"
                               ng-model="storeChgCostPriceExcelUpFile"
                               onchange="angular.element(this).scope().excelFileChanged()"
                               accept="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet, application/vnd.ms-excel.sheet.macroEnabled.12"/>

        <div class="w100 mt10 mb20">
            <div class="wj-gridWrap" style="height:50px; overflow-y: hidden; overflow-x: hidden;">
                <wj-flex-grid
                        autoGenerateColumns="false"
                        control="flex"
                        initialized="initGrid(s,e)"
                        sticky-headers="true"
                        selection-mode="Row"
                        items-source="data"
                        item-formatter="_itemFormatter">

                    <!-- define columns -->
                    <wj-flex-grid-column header="<s:message code="storeChgCostPrice.storeCd"/>" binding="storeCd" width="100" is-read-only="true" align="center"></wj-flex-grid-column>
                    <wj-flex-grid-column header="<s:message code="storeChgCostPrice.prodCd"/>" binding="prodCd" width="100" is-read-only="true" align="center"></wj-flex-grid-column>
                    <wj-flex-grid-column header="<s:message code="storeChgCostPrice.store"/><s:message code="storeChgCostPrice.change.costPrice"/>" binding="costUprc" width="100" align="right"></wj-flex-grid-column>
                </wj-flex-grid>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
</script>

<script type="text/javascript" src="/resource/solbipos/js/base/price/storeChgCostPrice/storeChgCostPriceExcelUpload.js?ver=20240530.01" charset="utf-8"></script>
