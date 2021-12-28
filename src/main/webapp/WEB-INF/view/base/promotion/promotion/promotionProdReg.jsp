<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="f" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<wj-popup control="promotionProdRegLayer" show-trigger="Click" hide-trigger="Click" style="display:none;width:600px;">
    <div class="wj-dialog wj-dialog-columns title" ng-controller="promotionProdRegCtrl">

        <%-- header --%>
        <div class="wj-dialog-header wj-dialog-header-font">
            <s:message code="promotion.prodAdd" />
            <a href="" class="wj-hide btn_close" ng-click="close()"></a>
        </div>

        <%-- body --%>
        <div class="wj-dialog-body">
            <%-- 조회조건 --%>
            <table class="tblType01">
                <colgroup>
                    <col class="w15" />
                    <col class="w35" />
                    <col class="w15" />
                    <col class="w35" />
                </colgroup>
                <tbody>
                <tr>
                    <th><s:message code="promotion.brand" /></th>
                    <td>
                        <div class="sb-select w100">
                            <wj-combo-box
                                    id="srchProdBrand"
                                    items-source="_getComboData('srchProdBrand')"
                                    display-member-path="name"
                                    selected-value-path="value"
                                    is-editable="false"
                                    control="srchProdBrandCombo">
                            </wj-combo-box>
                        </div>
                    </td>
                    <th><s:message code="promotion.menuGroup" /></th>
                    <td>
                        <div class="sb-select w100">
                            <wj-combo-box
                                    id="srchProdStoreGroup"
                                    items-source="_getComboData('srchProdStoreGroup')"
                                    display-member-path="name"
                                    selected-value-path="value"
                                    is-editable="false"
                                    control="srchProdStoreGroupCombo">
                            </wj-combo-box>
                        </div>
                    </td>
                </tr>
                <tr>
                    <th><s:message code="promotion.prodCd" /></th>
                    <td>
                        <input type="text" id="srchProdCd" onkeyup="fnNxBtnSearch('1');"/>
                    </td>
                    <th><s:message code="promotion.prodNm" /></th>
                    <td>
                        <input type="text" id="srchProdNm" onkeyup="fnNxBtnSearch('1');"/>
                    </td>
                </tr>
                <tr>
                    <%-- 사용여부 --%>
                    <th><s:message code="promotion.useYn" /></th>
                    <td>
                        <div class="sb-select w100">
                            <wj-combo-box
                                    id="srchProdUseYn"
                                    items-source="_getComboData('prodUseYnAll')"
                                    display-member-path="name"
                                    selected-value-path="value"
                                    is-editable="false"
                                    control="srchProdUseYnCombo">
                            </wj-combo-box>
                        </div>
                    </td>
                    <th></th>
                    <td></td>
                </tr>
                </tbody>
            </table>
            <%-- 버튼영역 --%>
            <div class="mt10 tr">
                <button class="btn_skyblue" id="nxBtnSearch1" ng-click="btnSearchProd()"><s:message code="cmm.search" /></button>
                <button class="btn_skyblue ml5 fr" id="btnInsertProd" ng-click="btnInsertProd()"><s:message code="cmm.add"/></button>
            </div>
            <%-- 그리드 영역 --%>
            <div class="w100 mt10 mb20">
                <%--위즈모 테이블--%>
                <div class="wj-gridWrap" style="height: 300px; overflow-y: hidden; overflow-x: hidden;">
                    <wj-flex-grid
                            autoGenerateColumns="false"
                            control="flex"
                            initialized="initGrid(s,e)"
                            sticky-headers="true"
                            selection-mode="Row"
                            items-source="data"
                            item-formatter="_itemFormatter"
                            id="wjGridPromotionProdReg">

                         <!-- define columns -->
                        <wj-flex-grid-column header="<s:message code="cmm.chk"/>" binding="gChk" width="40"></wj-flex-grid-column>
                        <wj-flex-grid-column header="<s:message code="promotion.brand"/>" binding="brandNm" width="80" align="center" is-read-only="true"></wj-flex-grid-column>
                        <wj-flex-grid-column header="<s:message code="promotion.menuGroup"/>" binding="storeGroupNms" width="250" is-read-only="true"></wj-flex-grid-column>
                        <wj-flex-grid-column header="<s:message code="promotion.menuGroup"/>" binding="storeGroupCds" width="250" is-read-only="true" visible="false"></wj-flex-grid-column>
                        <wj-flex-grid-column header="<s:message code="promotion.prodCd"/>" binding="prodCd" width="100" align="center" is-read-only="true"></wj-flex-grid-column>
                        <wj-flex-grid-column header="<s:message code="promotion.prodNm"/>" binding="prodNm" width="210" align="left" is-read-only="true"></wj-flex-grid-column>
                        <wj-flex-grid-column header="<s:message code="promotion.prodQty"/>" binding="prodQty" width="70" align="center"></wj-flex-grid-column>
                        <wj-flex-grid-column header="<s:message code="promotion.useYn"/>" binding="useYn" data-map="prodUseYnFgDataMap" width="70" align="center" is-read-only="true"></wj-flex-grid-column>
                    </wj-flex-grid>
                </div>
                <%--//위즈모 테이블--%>
            </div>
        </div>

        <%--구매대상 선택값 --%>
        <input type="hidden" id="hdSelectProdDs1" />
    </div>
</wj-popup>

<script type="text/javascript" src="/resource/solbipos/js/base/promotion/promotion/promotionProdReg.js?ver=20210422.08" charset="utf-8"></script>

