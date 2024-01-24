<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="f" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var="menuCd">${sessionScope.sessionInfo.currentMenu.resrceCd}</c:set>
<c:set var="menuNm">${sessionScope.sessionInfo.currentMenu.resrceNm}</c:set>
<c:set var="orgnFg" value="${sessionScope.sessionInfo.orgnFg}" />
<c:set var="hqOfficeCd" value="${sessionScope.sessionInfo.hqOfficeCd}" />
<%--<c:set var="prodEnvstVal" value="${prodEnvstVal}" />--%>
<%--<c:set var="priceEnvstVal" value="${priceEnvstVal}" />--%>
<c:set var="prodNoEnvFg" value="${prodNoEnvFg}" />
<c:set var="kitchenprintLink" value="${kitchenprintLink}" />
<c:set var="brandUseFg" value="${brandUseFg}" />

<div class="subCon" ng-controller="prodctrl2" id="prodView">
    <%--searchTbl--%>
    <div class="searchBar">
        <a href="#" class="open fl">${menuNm}</a>
        <%-- 조회 --%>
        <div class="mr15 fr" style="display:block;position: relative;margin-top: 6px;">
            <button class="btn_blue fr" id="nxBtnSearch2" ng-click="_pageView('prodctrl2',1)">
                <s:message code="cmm.search" />
            </button>
            <button class="btn_blue mr5 fl" id="btnSearchAddShow" ng-click="searchAddShowChange()">
                <s:message code="cmm.search.addShow" />
            </button>
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
        <tr>
            <%-- 등록 일자 --%>
            <th><s:message code="prod.regDate" /></th>
            <td colspan="3">
                <div class="sb-select">
                    <span class="txtIn"><input id="srchTimeStartDate" ng-model="startDate" class="w110px"></span>
                    <span class="rg">~</span>
                    <span class="txtIn"><input id="srchTimeEndDate" ng-model="endDate" class="w110px"></span>
                    <%--전체기간--%>
                    <span class="chk ml10">
                      <input type="checkbox" id="chkDt" ng-model="isChecked" ng-change="isChkDt()" />
                      <label for="chkDt">
                        <s:message code="cmm.all.day" />
                      </label>
                    </span>
                </div>
            </td>
        </tr>
        <tr>
            <%-- 상품코드 --%>
            <th><s:message code="prod.prodCd" /></th>
            <td>
                <input type="text" class="sb-input w100" id="srchProdCd" ng-model="prodCd" onkeyup="fnNxBtnSearch('2');"/>
            </td>
            <%-- 상품명 --%>
            <th><s:message code="prod.prodNm" /></th>
            <td>
                <input type="text" class="sb-input w100" id="srchProdNm" ng-model="prodNm" onkeyup="fnNxBtnSearch('2');"/>
            </td>
        </tr>
        <tr>
            <%-- 분류조회 --%>
            <th><s:message code="prod.prodClass" /></th>
            <td>
                <input type="text" class="sb-input w70" id="srchProdClassCd" ng-model="prodClassCdNm" ng-click="popUpProdClass()" style="float: left;"
                       placeholder="<s:message code="prod.prodClass" /> 선택" readonly/>
                <input type="hidden" id="_prodClassCd" name="prodClassCd" ng-model="prodClassCd" disabled />
                <button type="button" class="btn_skyblue fl mr5" id="btnCancelProdClassCd" style="margin-left: 5px;" ng-click="delProdClass()"><s:message code="cmm.selectCancel"/></button>
            </td>
            <%-- 바코드 --%>
            <th><s:message code="prod.barCd" /></th>
            <td>
                <input type="text" class="sb-input w100" id="srchBarCd" ng-model="barCd" onkeyup="fnNxBtnSearch('2');"/>
            </td>
        </tr>
        <tr>
            <%-- 사용여부 --%>
            <th><s:message code="prod.useYn" /></th>
            <td>
                <div class="sb-select">
                    <wj-combo-box
                            id="srchUseYn"
                            ng-model="useYn"
                            control="useYnAllCombo"
                            items-source="_getComboData('useYnAllComboData')"
                            display-member-path="name"
                            selected-value-path="value"
                            is-editable="false"
                            initialized="_initComboBox(s)"
                            selected-index="1">
                    </wj-combo-box>
                </div>
            </td>
            <%-- 브랜드 --%>
            <%--<c:if test="${brandUseFg == '1'}">
                <th><s:message code="prod.brandNm" /></th>
                <td><input type="text" class="sb-input w100" id="srchBrandNm" ng-model="hqBrandNm" onkeyup="fnNxBtnSearch('2');"/></td>
            </c:if>
            <c:if test="${brandUseFg == '0'}">
                <th></th>
                <td></td>
            </c:if>--%>
            <c:if test="${brandUseFg != '1' or sessionInfo.orgnFg != 'HQ'}">
                <th></th>
                <td></td>
            </c:if>
            <c:if test="${brandUseFg == '1'}">
                <c:if test="${sessionInfo.orgnFg == 'HQ'}">
                    <%-- 상품브랜드 --%>
                    <th><s:message code="prod.prodHqBrand"/></th>
                    <td>
                        <div class="sb-select">
                            <wj-combo-box
                                    id="srchProdHqBrand"
                                    items-source="_getComboData('srchProdHqBrand')"
                                    display-member-path="name"
                                    selected-value-path="value"
                                    is-editable="false"
                                    control="srchProdHqBrandCombo">
                            </wj-combo-box>
                        </div>
                    </td>
                </c:if>
            </c:if>
        </tr>
        <tr>
            <%-- 과세여부 --%>
            <th><s:message code="prod.vatFg" /></th>
            <td>
                <div class="sb-select">
                    <wj-combo-box
                            id="srchVatFg"
                            ng-model="vatFg"
                            control="vatFgAllCombo"
                            items-source="_getComboData('vatFgAllComboData')"
                            display-member-path="name"
                            selected-value-path="value"
                            is-editable="false"
                            initialized="_initComboBox(s)">
                    </wj-combo-box>
                </div>
            </td>
            <%-- 상품유형 --%>
            <th><s:message code="prod.prodTypeFg" /></th>
            <td>
                <div class="sb-select">
                    <wj-combo-box
                            id="srchProdTypeFg"
                            ng-model="prodTypeFg"
                            control="prodTypeFgAllCombo"
                            items-source="_getComboData('prodTypeFgAllCombo')"
                            display-member-path="name"
                            selected-value-path="value"
                            is-editable="false"
                            initialized="_initComboBox(s)">
                    </wj-combo-box>
                </div>
            </td>
        </tr>
        <tr>
            <%-- 가격관리구분 --%>
            <th><s:message code="prod.prcCtrlFg" /></th>
            <td>
                <div class="sb-select">
                    <wj-combo-box
                            id="srchPrcCtrlFg"
                            ng-model="prcCtrlFg"
                            control="prcCtrlFgAllCombo"
                            items-source="_getComboData('prcCtrlFgAllCombo')"
                            display-member-path="name"
                            selected-value-path="value"
                            is-editable="false"
                            initialized="_initComboBox(s)">
                    </wj-combo-box>
                </div>
            </td>
        </tr>
        </tbody>
    </table>
        <table class="searchTbl" id="tblSearchAddShow" style="display: none;">
            <colgroup>
                <col class="w15"/>
                <col class="w35"/>
                <col class="w15"/>
                <col class="w35"/>
            </colgroup>
            <tbody>
            <tr>
                <%-- 판매터치키 --%>
                <th><s:message code="prodSearch2.tuKey"/></th>
                <td>
                    <div class="sb-select">
                        <wj-combo-box
                                id="srchTuKeyCombo"
                                ng-model="tuKey"
                                items-source="_getComboData('srchComboData')"
                                display-member-path="name"
                                selected-value-path="value"
                                is-editable="false"
                                initialized="_initComboBox(s)"
                                control="srchTuKeyCombo">
                        </wj-combo-box>
                    </div>
                </td>
                <%-- 키오스크키맵 --%>
                <th><s:message code="prodSearch2.kiosk"/></th>
                <td>
                    <div class="sb-select">
                        <wj-combo-box
                                id="srchKioskCombo"
                                ng-model="kiosk"
                                items-source="_getComboData('srchComboData')"
                                display-member-path="name"
                                selected-value-path="value"
                                is-editable="false"
                                initialized="_initComboBox(s)"
                                control="srchKioskCombo">
                        </wj-combo-box>
                    </div>
                </td>
            </tr>
            <tr>
                <%-- 사이드-선택상품구성내역 --%>
                <th><s:message code="prodSearch2.sdsel"/></th>
                <td>
                    <div class="sb-select">
                        <wj-combo-box
                                id="srchSdselCombo"
                                ng-model="sdsel"
                                items-source="_getComboData('srchComboData')"
                                display-member-path="name"
                                selected-value-path="value"
                                is-editable="false"
                                initialized="_initComboBox(s)"
                                control="srchSdselCombo">
                        </wj-combo-box>
                    </div>
                </td>
                <%-- 상품이미지 --%>
                <th><s:message code="prodSearch2.bsImg"/></th>
                <td>
                    <div class="sb-select">
                        <wj-combo-box
                                id="srchBsImgCombo"
                                ng-model="bsImg"
                                items-source="_getComboData('srchComboData')"
                                display-member-path="name"
                                selected-value-path="value"
                                is-editable="false"
                                initialized="_initComboBox(s)"
                                control="srchBsImgCombo">
                        </wj-combo-box>
                    </div>
                </td>
            </tr>
            <tr>
                <%-- KIOSK이미지 --%>
                <th><s:message code="prodSearch2.kioskImg"/></th>
                <td>
                    <div class="sb-select">
                        <wj-combo-box
                                id="srchKioskImgCombo"
                                ng-model="kioskImg"
                                items-source="_getComboData('srchComboData')"
                                display-member-path="name"
                                selected-value-path="value"
                                is-editable="false"
                                initialized="_initComboBox(s)"
                                control="srchKioskImgCombo">
                        </wj-combo-box>
                    </div>
                </td>
                <%-- DID이미지 --%>
                <th><s:message code="prodSearch2.didImg"/></th>
                <td>
                    <div class="sb-select">
                        <wj-combo-box
                                id="srchDidImgCombo"
                                ng-model="didImg"
                                items-source="_getComboData('srchComboData')"
                                display-member-path="name"
                                selected-value-path="value"
                                is-editable="false"
                                initialized="_initComboBox(s)"
                                control="srchDidImgCombo">
                        </wj-combo-box>
                    </div>
                </td>
            </tr>
            <tr>
                <%-- #2이미지 --%>
                <th><s:message code="prodSearch2.proImg"/></th>
                <td>
                    <div class="sb-select">
                        <wj-combo-box
                                id="srchProImgCombo"
                                ng-model="proImg"
                                items-source="_getComboData('srchComboData')"
                                display-member-path="name"
                                selected-value-path="value"
                                is-editable="false"
                                initialized="_initComboBox(s)"
                                control="srchProImgCombo">
                        </wj-combo-box>
                    </div>
                </td>
                <%-- #테이블오더이미지 --%>
                <th><s:message code="prodSearch2.toImg"/></th>
                <td>
                    <div class="sb-select">
                        <wj-combo-box
                                id="srchToImgCombo"
                                ng-model="toImg"
                                items-source="_getComboData('srchComboData')"
                                display-member-path="name"
                                selected-value-path="value"
                                is-editable="false"
                                initialized="_initComboBox(s)"
                                control="srchToImgCombo">
                        </wj-combo-box>
                    </div>
                </td>
            </tr>
            <tr>
                <%-- 배달시스템상품명칭매핑 --%>
                <th><s:message code="prodSearch2.dlvrNm"/></th>
                <td>
                    <div class="sb-select">
                        <wj-combo-box
                                id="srchDlvrNmCombo"
                                ng-model="dlvrNm"
                                items-source="_getComboData('srchComboData')"
                                display-member-path="name"
                                selected-value-path="value"
                                is-editable="false"
                                initialized="_initComboBox(s)"
                                control="srchDlvrNmCombo">
                        </wj-combo-box>
                    </div>
                </td>
                <%-- 상품-매장주방프린터연결 수 --%>
                <th><s:message code="prodSearch2.prtCnt"/></th>
                <td>
                    <div class="sb-select">
                        <wj-combo-box
                                id="srchPrtCntCombo"
                                ng-model="prtCnt"
                                items-source="_getComboData('srchComboData')"
                                display-member-path="name"
                                selected-value-path="value"
                                is-editable="false"
                                initialized="_initComboBox(s)"
                                control="srchPrtCntCombo">
                        </wj-combo-box>
                    </div>
                </td>
            </tr>
            <tr>
                <%-- 원산지정보 --%>
                <th><s:message code="prodSearch2.orgNm"/></th>
                <td>
                    <div class="sb-select">
                        <wj-combo-box
                                id="srchOrgNmCombo"
                                ng-model="orgNm"
                                items-source="_getComboData('srchComboData')"
                                display-member-path="name"
                                selected-value-path="value"
                                is-editable="false"
                                initialized="_initComboBox(s)"
                                control="srchOrgNmCombo">
                        </wj-combo-box>
                    </div>
                </td>
                <%-- 알레르기정보 --%>
                <th><s:message code="prodSearch2.algiNm"/></th>
                <td>
                    <div class="sb-select">
                        <wj-combo-box
                                id="srchAlgiNmCombo"
                                ng-model="algiNm"
                                items-source="_getComboData('srchComboData')"
                                display-member-path="name"
                                selected-value-path="value"
                                is-editable="false"
                                initialized="_initComboBox(s)"
                                control="srchAlgiNmCombo">
                        </wj-combo-box>
                    </div>
                </td>
            </tr>
            <tr>
                <%-- 사이드-선택상품구성내역 --%>
                <th><s:message code="prodSearch2.sdyNm"/></th>
                <td>
                    <div class="sb-select">
                        <wj-combo-box
                                id="srchSdyNmCombo"
                                ng-model="sdyNm"
                                items-source="_getComboData('srchComboData')"
                                display-member-path="name"
                                selected-value-path="value"
                                is-editable="false"
                                initialized="_initComboBox(s)"
                                control="srchSdyNmCombo">
                        </wj-combo-box>
                    </div>
                </td>
                <%-- 비노출매장수 --%>
                <th><s:message code="prodSearch2.disNm"/></th>
                <td>
                    <div class="sb-select">
                        <wj-combo-box
                                id="srchDisNmCombo"
                                ng-model="disNm"
                                items-source="_getComboData('srchComboData')"
                                display-member-path="name"
                                selected-value-path="value"
                                is-editable="false"
                                initialized="_initComboBox(s)"
                                control="srchDisNmCombo">
                        </wj-combo-box>
                    </div>
                </td>
            </tr>
            <tr>
                <%-- 프로모션정보 --%>
                <th><s:message code="prodSearch2.proNm"/></th>
                <td>
                    <div class="sb-select">
                        <wj-combo-box
                                id="srchProNmCombo"
                                ng-model="proNm"
                                items-source="_getComboData('srchComboData')"
                                display-member-path="name"
                                selected-value-path="value"
                                is-editable="false"
                                initialized="_initComboBox(s)"
                                control="srchProNmCombo">
                        </wj-combo-box>
                    </div>
                </td>
                <c:if test="${sessionScope.sessionInfo.userId != 'ds021' and sessionScope.sessionInfo.userId != 'ds034' and sessionScope.sessionInfo.userId != 'h0393'}">
                    <td></td>
                    <td></td>
                </c:if>
            </tr>
            </tbody>
        </table>
    <%--//searchTbl--%>

    <div class="mt10 oh sb-select dkbr">
        <%-- 전체상품엑셀다운로드 --%>
        <button class="btn_skyblue ml5 fr" ng-click="excelDownloadTotal()" ><s:message code="cmm.excel.downTotal"/></button>
        <%-- 조회조건내역엑셀다운로드 --%>
        <button class="btn_skyblue ml5 fr" ng-click="excelDownloadCondition()" ><s:message code="cmm.excel.downCondition"/></button>
        <%-- 상품엑셀다운로드 --%>
        <button class="btn_skyblue ml5 fr" ng-click="excelDownload()" ><s:message code="cmm.excel.down"/></button>
    </div>

    <%--위즈모 테이블--%>
    <div class="wj-TblWrapBr mt10">
        <%-- 개발시 높이 조절해서 사용--%>
        <%-- tbody영역의 셀 배경이 들어가는 부분은 .bdBg를 넣어주세요. --%>
        <div id="theGrid" style="height: 370px;">
            <wj-flex-grid
                    autoGenerateColumns="false"
                    control="flex"
                    initialized="initGrid(s,e)"
                    sticky-headers="true"
                    selection-mode="Row"
                    items-source="data"
                    item-formatter="_itemFormatter"
                    id="wjGridProd">

                <!-- define columns -->
                <c:if test="${brandUseFg == '1'}">
                    <wj-flex-grid-column header="<s:message code="prod.brandNm"/>" binding="hqBrandNm" width="80" is-read-only="true" align="center"></wj-flex-grid-column>
                </c:if>
                <wj-flex-grid-column header="<s:message code="prod.prodTypeFg"/>" binding="prodTypeFg" width="90" align="center" is-read-only="true" data-map="prodTypeFgDataMap"></wj-flex-grid-column>
                <wj-flex-grid-column header="<s:message code="prod.prodClassCd"/>" binding="prodClassCd" width="90" align="center" is-read-only="true"></wj-flex-grid-column>
                <wj-flex-grid-column header="<s:message code="prod.prodClassNm"/>" binding="prodClassNm" width="90" is-read-only="true"></wj-flex-grid-column>
                <wj-flex-grid-column header="<s:message code="prod.prodCd"/>" binding="prodCd" width="100" is-read-only="true" format="d"></wj-flex-grid-column>
                <wj-flex-grid-column header="<s:message code="prod.prodNm"/>" binding="prodNm" width="150" is-read-only="true"></wj-flex-grid-column>

                <wj-flex-grid-column header="<s:message code="prodSearch2.regDt"/>" binding="regDt" width="120" is-read-only="true" align="center"></wj-flex-grid-column>
                <wj-flex-grid-column header="<s:message code="prodSearch2.regId"/>" binding="regId" width="80" is-read-only="true" align="center"></wj-flex-grid-column>
                <wj-flex-grid-column header="<s:message code="prodSearch2.regNm"/>" binding="regNm" width="100" is-read-only="true" align="center"></wj-flex-grid-column>
                <wj-flex-grid-column header="<s:message code="prodSearch2.modDt"/>" binding="modDt" width="120" is-read-only="true" align="center"></wj-flex-grid-column>
                <wj-flex-grid-column header="<s:message code="prodSearch2.modId"/>" binding="modId" width="80" is-read-only="true" align="center"></wj-flex-grid-column>
                <wj-flex-grid-column header="<s:message code="prodSearch2.modNm"/>" binding="modNm" width="100" is-read-only="true" align="center"></wj-flex-grid-column>
                <wj-flex-grid-column header="<s:message code="prodSearch2.tuKey"/>" binding="tukNm" width="150" is-read-only="true"></wj-flex-grid-column>
                <wj-flex-grid-column header="<s:message code="prodSearch2.kiosk"/>" binding="kioNm" width="150" is-read-only="true"></wj-flex-grid-column>
                <wj-flex-grid-column header="<s:message code="prodSearch2.sdsel"/>" binding="sdselNm" width="150" is-read-only="true"></wj-flex-grid-column>
                <wj-flex-grid-column header="<s:message code="prodSearch2.bsImg"/>" binding="bsImg" width="80" is-read-only="true" align="center"></wj-flex-grid-column>
                <wj-flex-grid-column header="<s:message code="prodSearch2.kioskImg"/>" binding="kioImg" width="80" is-read-only="true" align="center"></wj-flex-grid-column>
                <wj-flex-grid-column header="<s:message code="prodSearch2.didImg"/>" binding="didImg" width="80" is-read-only="true" align="center"></wj-flex-grid-column>
                <wj-flex-grid-column header="<s:message code="prodSearch2.proImg"/>" binding="proImg" width="80" is-read-only="true" align="center"></wj-flex-grid-column>
                <wj-flex-grid-column header="<s:message code="prodSearch2.toImg"/>" binding="toImg" width="80" is-read-only="true" align="center"></wj-flex-grid-column>
                <wj-flex-grid-column header="<s:message code="prodSearch2.dlvrNm"/>" binding="dlvrNm" width="150" is-read-only="true"></wj-flex-grid-column>
                <wj-flex-grid-column header="<s:message code="prodSearch2.prtCnt"/>" binding="prtCnt" width="80" is-read-only="true" align="right"></wj-flex-grid-column>
                <wj-flex-grid-column header="<s:message code="prodSearch2.orgNm"/>" binding="orgNm" width="150" is-read-only="true"></wj-flex-grid-column>
                <wj-flex-grid-column header="<s:message code="prodSearch2.algiNm"/>" binding="algiNm" width="150" is-read-only="true"></wj-flex-grid-column>
                <wj-flex-grid-column header="<s:message code="prodSearch2.sdyNm"/>" binding="sdyNm" width="80" is-read-only="true" align="right"></wj-flex-grid-column>
                <wj-flex-grid-column header="<s:message code="prodSearch2.disNm"/>" binding="disNm" width="80" is-read-only="true" align="right"></wj-flex-grid-column>
                <wj-flex-grid-column header="<s:message code="prodSearch2.proNm"/>" binding="proNm" width="150" is-read-only="true"></wj-flex-grid-column>



                <wj-flex-grid-column header="<s:message code="prod.vendr"/>" binding="vendr" width="100" is-read-only="true"></wj-flex-grid-column>
                <wj-flex-grid-column header="<s:message code="prod.saleProdYn"/>" binding="saleProdYn" width="100" is-read-only="true" align="center" data-map="useYnComboDataMap"></wj-flex-grid-column>
                <wj-flex-grid-column header="<s:message code="prod.saleUprc"/>" binding="saleUprc" width="100" is-read-only="true"></wj-flex-grid-column>
                <wj-flex-grid-column header="<s:message code="prod.prodTipYn"/>" binding="prodTipYn" width="100" is-read-only="true" align="center" data-map="prodTipYnDataMap"></wj-flex-grid-column>
                <wj-flex-grid-column header="<s:message code="prod.vatFg"/>" binding="vatFg" width="100" is-read-only="true" align="center" data-map="vatFgDataMap"></wj-flex-grid-column>
                <c:if test="${momsEnvstVal == '0'}">
                    <wj-flex-grid-column header="<s:message code="prod.useYn"/>" binding="useYn" width="100" is-read-only="true" align="center" data-map="useYnComboDataMap"></wj-flex-grid-column>
                </c:if>
                <wj-flex-grid-column header="<s:message code="prod.barCd"/>" binding="barCd" width="100" is-read-only="true"></wj-flex-grid-column>
                <wj-flex-grid-column header="<s:message code="prod.prcCtrlFg"/>" binding="prcCtrlFg" width="100" is-read-only="true" align="center" data-map="regFgDataMap"></wj-flex-grid-column>

                <c:if test="${subPriceFg == '1'}">
                    <wj-flex-grid-column header="<s:message code="prod.stinSaleUprc"/>" binding="stinSaleUprc" width="80" is-read-only="true"></wj-flex-grid-column>
                    <wj-flex-grid-column header="<s:message code="prod.packSaleUprc"/>" binding="packSaleUprc" width="80" is-read-only="true"></wj-flex-grid-column>
                    <wj-flex-grid-column header="<s:message code="prod.dlvrSaleUprc"/>" binding="dlvrSaleUprc" width="80" is-read-only="true"></wj-flex-grid-column>
                </c:if>

                <wj-flex-grid-column header="<s:message code="prod.stockProdYn"/>" binding="stockProdYn" width="80" is-read-only="true" align="center" data-map="useYnComboDataMap"></wj-flex-grid-column>
                <wj-flex-grid-column header="<s:message code="prod.setProdFg"/>" binding="setProdFg" width="80" is-read-only="true" align="center" data-map="setProdFgDataMap"></wj-flex-grid-column>
                <wj-flex-grid-column header="<s:message code="prod.pointSaveYn"/>" binding="pointSaveYn" width="80" is-read-only="true" align="center" data-map="useYnComboDataMap"></wj-flex-grid-column>
                <wj-flex-grid-column header="<s:message code="prod.sideProdYn"/>" binding="sideProdYn" width="80" is-read-only="true" align="center" data-map="useYnComboDataMap"></wj-flex-grid-column>
                <wj-flex-grid-column header="<s:message code="prod.sdattrClassCd"/>" binding="sdattrClassNm" width="80" is-read-only="true" align="center"></wj-flex-grid-column>
                <wj-flex-grid-column header="<s:message code="prod.sdselGrpCd"/>" binding="sdselGrpNm" width="80" is-read-only="true" align="center"></wj-flex-grid-column>
                <c:if test="${momsEnvstVal == '1'}">
                    <wj-flex-grid-column header="<s:message code="prod.groupProdCd"/>" binding="groupProdNm" width="80" is-read-only="true" align="center"></wj-flex-grid-column>
                </c:if>
                <wj-flex-grid-column header="<s:message code="prod.depositProdCd"/>" binding="depositProdNm" width="80" is-read-only="true" align="center"></wj-flex-grid-column>
                <wj-flex-grid-column header="<s:message code="prod.depositCupFg"/>" binding="depositCupFg" width="80" is-read-only="true" align="center" data-map="depositCupFgDataMap"></wj-flex-grid-column>
                <wj-flex-grid-column header="<s:message code="prod.pointUseYn"/>" binding="pointUseYn" width="80" is-read-only="true" align="center" data-map="useYnComboDataMap"></wj-flex-grid-column>
                <wj-flex-grid-column header="<s:message code="prod.dcYn"/>" binding="dcYn" width="80" is-read-only="true" align="center" data-map="useYnComboDataMap"></wj-flex-grid-column>

                <wj-flex-grid-column header="<s:message code="prod.splyUprc"/>" binding="splyUprc" width="80" is-read-only="true"></wj-flex-grid-column>
                <wj-flex-grid-column header="<s:message code="prod.costUprc"/>" binding="costUprc" width="80" is-read-only="true"></wj-flex-grid-column>
                <wj-flex-grid-column header="<s:message code="prod.poProdFg"/>" binding="poProdFg" width="80" is-read-only="true" align="center" data-map="poProdFgDataMap"></wj-flex-grid-column>
                <wj-flex-grid-column header="<s:message code="prod.poUnitFg"/>" binding="poUnitFg" width="80" is-read-only="true" align="center" data-map="poUnitFgDataMap"></wj-flex-grid-column>
                <wj-flex-grid-column header="<s:message code="prod.poUnitQty"/>" binding="poUnitQty" width="80" is-read-only="true"></wj-flex-grid-column>
                <wj-flex-grid-column header="<s:message code="prod.poMinQty"/>" binding="poMinQty" width="80" is-read-only="true"></wj-flex-grid-column>
                <wj-flex-grid-column header="<s:message code="prod.safeStockQty"/>" binding="safeStockQty" width="80" is-read-only="true"></wj-flex-grid-column>

                <c:if test="${momsEnvstVal == '1'}">
                    <wj-flex-grid-column header="<s:message code="prod.nuTotWt"/>" binding="nuTotWt" width="80" is-read-only="true"></wj-flex-grid-column>
                    <wj-flex-grid-column header="<s:message code="prod.nuKcal"/>" binding="nuKcal" width="80" is-read-only="true"></wj-flex-grid-column>
                    <wj-flex-grid-column header="<s:message code="prod.nuProtein"/>" binding="nuProtein" width="80" is-read-only="true"></wj-flex-grid-column>
                    <wj-flex-grid-column header="<s:message code="prod.nuSodium"/>" binding="nuSodium" width="80" is-read-only="true"></wj-flex-grid-column>
                    <wj-flex-grid-column header="<s:message code="prod.nuSugars"/>" binding="nuSugars" width="80" is-read-only="true"></wj-flex-grid-column>
                    <wj-flex-grid-column header="<s:message code="prod.nuSatFat"/>" binding="nuSatFat" width="80" is-read-only="true"></wj-flex-grid-column>
                    <wj-flex-grid-column header="<s:message code="prod.nuCaffeine"/>" binding="nuCaffeine" width="80" is-read-only="true"></wj-flex-grid-column>
                </c:if>
                <wj-flex-grid-column header="<s:message code="prod.mapProdCd"/>" binding="mapProdCd" width="80" is-read-only="true"></wj-flex-grid-column>

                <c:if test="${momsEnvstVal == '1'}">
                    <wj-flex-grid-column header="<s:message code="prod.kioskSaleTime"/>" binding="saleTimeFg" width="80" is-read-only="true" align="center" data-map="useYnComboDataMap"></wj-flex-grid-column>
                    <wj-flex-grid-column header="<s:message code="prod.kioskSaleTimeSetting"/>" binding="saleTime" width="80" is-read-only="true"></wj-flex-grid-column>
                    <wj-flex-grid-column header="<s:message code="prod.momsKioskEdge"/>" binding="momsKioskEdge" width="80" is-read-only="true" align="center" data-map="momsKioskEdgeDataMap"></wj-flex-grid-column>
                    <wj-flex-grid-column header="<s:message code="prod.optionGrp"/>" binding="optionGrpNm" width="80" is-read-only="true"></wj-flex-grid-column>
                    <wj-flex-grid-column header="<s:message code="prod.releaseDate"/>" binding="releaseDate" width="80" is-read-only="true"></wj-flex-grid-column>
                    <wj-flex-grid-column header="<s:message code="prod.discon"/>" binding="disconYn" width="80" is-read-only="true"></wj-flex-grid-column>
                    <wj-flex-grid-column header="<s:message code="prod.disconDate"/>" binding="disconDate" width="80" is-read-only="true"></wj-flex-grid-column>
                    <wj-flex-grid-column header="<s:message code="prod.inStore"/>" binding="inStore" width="80" is-read-only="true" align="center" data-map="useYnComboDataMap"></wj-flex-grid-column>
                    <wj-flex-grid-column header="<s:message code="prod.delivery"/>" binding="delivery" width="80" is-read-only="true" align="center" data-map="useYnComboDataMap"></wj-flex-grid-column>
                    <wj-flex-grid-column header="<s:message code="prod.packing"/>" binding="packing" width="80" is-read-only="true" align="center" data-map="useYnComboDataMap"></wj-flex-grid-column>

                    <wj-flex-grid-column header="<s:message code="prod.pos"/>" binding="pos" width="80" is-read-only="true" align="center" data-map="useYnComboDataMap"></wj-flex-grid-column>
                    <wj-flex-grid-column header="<s:message code="prod.kiosk"/>" binding="kiosk" width="80" is-read-only="true" align="center" data-map="useYnComboDataMap"v></wj-flex-grid-column>
                    <wj-flex-grid-column header="<s:message code="prod.app"/>" binding="app" width="80" is-read-only="true" align="center" data-map="useYnComboDataMap"></wj-flex-grid-column>
                    <wj-flex-grid-column header="<s:message code="prod.baemin"/>" binding="baemin" width="80" is-read-only="true" align="center" data-map="useYnComboDataMap"></wj-flex-grid-column>
                    <wj-flex-grid-column header="<s:message code="prod.baemin1"/>" binding="baemin1" width="80" is-read-only="true" align="center" data-map="useYnComboDataMap"></wj-flex-grid-column>
                    <wj-flex-grid-column header="<s:message code="prod.yogiyo"/>" binding="yogiyo" width="80" is-read-only="true" align="center" data-map="useYnComboDataMap"></wj-flex-grid-column>
                    <wj-flex-grid-column header="<s:message code="prod.yogiyoExp"/>" binding="yogiyoExp" width="80" is-read-only="true" align="center" data-map="useYnComboDataMap"></wj-flex-grid-column>
                    <wj-flex-grid-column header="<s:message code="prod.coupang"/>" binding="coupang" width="80" is-read-only="true" align="center" data-map="useYnComboDataMap"></wj-flex-grid-column>
                    <wj-flex-grid-column header="<s:message code="prod.baedaltong"/>" binding="baedaltong" width="80" is-read-only="true" align="center" data-map="useYnComboDataMap"></wj-flex-grid-column>
                    <wj-flex-grid-column header="<s:message code="prod.ddangyo"/>" binding="ddangyo" width="80" is-read-only="true" align="center" data-map="useYnComboDataMap"></wj-flex-grid-column>
                </c:if>
                <wj-flex-grid-column header="<s:message code="prod.title.remark"/>" binding="remark" width="80" is-read-only="true"></wj-flex-grid-column>
                <wj-flex-grid-column header="<s:message code="prod.title.info"/>" binding="prodInfo" width="80"is-read-only="true"></wj-flex-grid-column>

                <wj-flex-grid-column header="<s:message code="prod.brandCd"/>" binding="hqBrandCd" visible="false"></wj-flex-grid-column>
                <wj-flex-grid-column header="<s:message code="prod.brandNm"/>" binding="hqBrandN" visible="false"></wj-flex-grid-column>
                <wj-flex-grid-column header="<s:message code="prod.sideProdYn"/>" binding="sideProdYn" visible="false"></wj-flex-grid-column>
                <wj-flex-grid-column header="<s:message code="prod.sdattrClassCd"/>" binding="sdattrClassCd" visible="false"></wj-flex-grid-column>
                <wj-flex-grid-column header="<s:message code="prod.sdselGrpCd"/>" binding="sdselGrpCd" visible="false"></wj-flex-grid-column>
            </wj-flex-grid>
            <%-- ColumnPicker 사용시 include --%>
            <jsp:include page="/WEB-INF/view/layout/columnPicker.jsp" flush="true">
                <jsp:param name="pickerTarget" value="prodctrl2"/>
            </jsp:include>
        </div>
    </div>
    <%--//위즈모 테이블--%>

    <%-- 페이지 리스트 --%>
    <div class="pageNum mt20">
        <%-- id --%>
        <ul id="prodctrl2Pager" data-size="10">
        </ul>
    </div>
    <%--//페이지 리스트--%>

    <%--엑셀 리스트--%>
    <div class="wj-TblWrapBr mt10" ng-controller="totalExcelCtrl" style="display: none;">
        <div class="wj-gridWrap" id="qn">
            <wj-flex-grid
                    autoGenerateColumns="false"
                    selection-mode="Row"
                    items-source="data"
                    control="excelFlex"
                    initialized="initGrid(s,e)"
                    loaded-rows="loadedRows(s,e)"
                    is-read-only="true"
                    frozen-columns="6"
                    sticky-headers="true"
                    selection-mode="Row"
                    items-source="data"
                    item-formatter="_itemFormatter">
                <!-- define columns -->
                <c:if test="${brandUseFg == '1'}">
                    <wj-flex-grid-column header="<s:message code="prod.brandNm"/>" binding="hqBrandNm" width="80" is-read-only="true" align="center"></wj-flex-grid-column>
                </c:if>
                <wj-flex-grid-column header="<s:message code="prod.prodTypeFg"/>" binding="prodTypeFg" width="90" align="center" is-read-only="true" data-map="prodTypeFgDataMap"></wj-flex-grid-column>
                <wj-flex-grid-column header="<s:message code="prod.prodClassCd"/>" binding="prodClassCd" width="90" align="center" is-read-only="true"></wj-flex-grid-column>
                <wj-flex-grid-column header="<s:message code="prod.prodClassNm"/>" binding="prodClassNm" width="300" is-read-only="true"></wj-flex-grid-column>
                <wj-flex-grid-column header="<s:message code="prod.prodCd"/>" binding="prodCd" width="100" is-read-only="true" format="d"></wj-flex-grid-column>
                <wj-flex-grid-column header="<s:message code="prod.prodNm"/>" binding="prodNm" width="150" is-read-only="true"></wj-flex-grid-column>

                <wj-flex-grid-column header="<s:message code="prodSearch2.regDt"/>" binding="regDt" width="120" is-read-only="true" align="center"></wj-flex-grid-column>
                <wj-flex-grid-column header="<s:message code="prodSearch2.regId"/>" binding="regId" width="80" is-read-only="true" align="center"></wj-flex-grid-column>
                <wj-flex-grid-column header="<s:message code="prodSearch2.regNm"/>" binding="regNm" width="100" is-read-only="true" align="center"></wj-flex-grid-column>
                <wj-flex-grid-column header="<s:message code="prodSearch2.modDt"/>" binding="modDt" width="120" is-read-only="true" align="center"></wj-flex-grid-column>
                <wj-flex-grid-column header="<s:message code="prodSearch2.modId"/>" binding="modId" width="80" is-read-only="true" align="center"></wj-flex-grid-column>
                <wj-flex-grid-column header="<s:message code="prodSearch2.modNm"/>" binding="modNm" width="100" is-read-only="true" align="center"></wj-flex-grid-column>
                <wj-flex-grid-column header="<s:message code="prodSearch2.tuKey"/>" binding="tukNm" width="150" is-read-only="true"></wj-flex-grid-column>
                <wj-flex-grid-column header="<s:message code="prodSearch2.kiosk"/>" binding="kioNm" width="150" is-read-only="true"></wj-flex-grid-column>
                <wj-flex-grid-column header="<s:message code="prodSearch2.sdsel"/>" binding="sdselNm" width="150" is-read-only="true"></wj-flex-grid-column>
                <wj-flex-grid-column header="<s:message code="prodSearch2.bsImg"/>" binding="bsImg" width="80" is-read-only="true" align="center"></wj-flex-grid-column>
                <wj-flex-grid-column header="<s:message code="prodSearch2.kioskImg"/>" binding="kioImg" width="80" is-read-only="true" align="center"></wj-flex-grid-column>
                <wj-flex-grid-column header="<s:message code="prodSearch2.didImg"/>" binding="didImg" width="80" is-read-only="true" align="center"></wj-flex-grid-column>
                <wj-flex-grid-column header="<s:message code="prodSearch2.proImg"/>" binding="proImg" width="80" is-read-only="true" align="center"></wj-flex-grid-column>
                <wj-flex-grid-column header="<s:message code="prodSearch2.toImg"/>" binding="toImg" width="80" is-read-only="true" align="center"></wj-flex-grid-column>
                <wj-flex-grid-column header="<s:message code="prodSearch2.dlvrNm"/>" binding="dlvrNm" width="150" is-read-only="true"></wj-flex-grid-column>
                <wj-flex-grid-column header="<s:message code="prodSearch2.prtCnt"/>" binding="prtCnt" width="80" is-read-only="true" align="right"></wj-flex-grid-column>
                <wj-flex-grid-column header="<s:message code="prodSearch2.orgNm"/>" binding="orgNm" width="150" is-read-only="true"></wj-flex-grid-column>
                <wj-flex-grid-column header="<s:message code="prodSearch2.algiNm"/>" binding="algiNm" width="150" is-read-only="true"></wj-flex-grid-column>
                <wj-flex-grid-column header="<s:message code="prodSearch2.sdyNm"/>" binding="sdyNm" width="80" is-read-only="true" align="right"></wj-flex-grid-column>
                <wj-flex-grid-column header="<s:message code="prodSearch2.disNm"/>" binding="disNm" width="80" is-read-only="true" align="right"></wj-flex-grid-column>
                <wj-flex-grid-column header="<s:message code="prodSearch2.proNm"/>" binding="proNm" width="150" is-read-only="true"></wj-flex-grid-column>

                <wj-flex-grid-column header="<s:message code="prod.vendr"/>" binding="vendr" width="100" is-read-only="true"></wj-flex-grid-column>
                <wj-flex-grid-column header="<s:message code="prod.saleProdYn"/>" binding="saleProdYn" width="100" is-read-only="true" align="center" data-map="useYnComboDataMap"></wj-flex-grid-column>
                <wj-flex-grid-column header="<s:message code="prod.saleUprc"/>" binding="saleUprc" width="100" is-read-only="true"></wj-flex-grid-column>
                <wj-flex-grid-column header="<s:message code="prod.prodTipYn"/>" binding="prodTipYn" width="100" is-read-only="true" align="center" data-map="prodTipYnDataMap"></wj-flex-grid-column>
                <wj-flex-grid-column header="<s:message code="prod.vatFg"/>" binding="vatFg" width="100" is-read-only="true" align="center" data-map="vatFgDataMap"></wj-flex-grid-column>
                <c:if test="${momsEnvstVal == '0'}">
                    <wj-flex-grid-column header="<s:message code="prod.useYn"/>" binding="useYn" width="100" is-read-only="true" align="center" data-map="useYnComboDataMap"></wj-flex-grid-column>
                </c:if>
                <wj-flex-grid-column header="<s:message code="prod.barCd"/>" binding="barCd" width="100" is-read-only="true"></wj-flex-grid-column>
                <wj-flex-grid-column header="<s:message code="prod.prcCtrlFg"/>" binding="prcCtrlFg" width="100" is-read-only="true" align="center" data-map="regFgDataMap"></wj-flex-grid-column>

                <c:if test="${subPriceFg == '1'}">
                    <wj-flex-grid-column header="<s:message code="prod.stinSaleUprc"/>" binding="stinSaleUprc" width="80" is-read-only="true"></wj-flex-grid-column>
                    <wj-flex-grid-column header="<s:message code="prod.packSaleUprc"/>" binding="packSaleUprc" width="80" is-read-only="true"></wj-flex-grid-column>
                    <wj-flex-grid-column header="<s:message code="prod.dlvrSaleUprc"/>" binding="dlvrSaleUprc" width="80" is-read-only="true"></wj-flex-grid-column>
                </c:if>

                <wj-flex-grid-column header="<s:message code="prod.stockProdYn"/>" binding="stockProdYn" width="80" is-read-only="true" align="center" data-map="useYnComboDataMap"></wj-flex-grid-column>
                <wj-flex-grid-column header="<s:message code="prod.setProdFg"/>" binding="setProdFg" width="80" is-read-only="true" align="center" data-map="setProdFgDataMap"></wj-flex-grid-column>
                <wj-flex-grid-column header="<s:message code="prod.pointSaveYn"/>" binding="pointSaveYn" width="80" is-read-only="true" align="center" data-map="useYnComboDataMap"></wj-flex-grid-column>
                <wj-flex-grid-column header="<s:message code="prod.sideProdYn"/>" binding="sideProdYn" width="80" is-read-only="true" align="center" data-map="useYnComboDataMap"></wj-flex-grid-column>
                <wj-flex-grid-column header="<s:message code="prod.sdattrClassCd"/>" binding="sdattrClassNm" width="80" is-read-only="true" align="center"></wj-flex-grid-column>
                <wj-flex-grid-column header="<s:message code="prod.sdselGrpCd"/>" binding="sdselGrpNm" width="80" is-read-only="true" align="center"></wj-flex-grid-column>
                <c:if test="${momsEnvstVal == '1'}">
                    <wj-flex-grid-column header="<s:message code="prod.groupProdCd"/>" binding="groupProdNm" width="80" is-read-only="true" align="center"></wj-flex-grid-column>
                </c:if>
                <wj-flex-grid-column header="<s:message code="prod.depositProdCd"/>" binding="depositProdNm" width="80" is-read-only="true" align="center"></wj-flex-grid-column>
                <wj-flex-grid-column header="<s:message code="prod.depositCupFg"/>" binding="depositCupFg" width="80" is-read-only="true" align="center" data-map="depositCupFgDataMap"></wj-flex-grid-column>
                <wj-flex-grid-column header="<s:message code="prod.pointUseYn"/>" binding="pointUseYn" width="80" is-read-only="true" align="center" data-map="useYnComboDataMap"></wj-flex-grid-column>
                <wj-flex-grid-column header="<s:message code="prod.dcYn"/>" binding="dcYn" width="80" is-read-only="true" align="center" data-map="useYnComboDataMap"></wj-flex-grid-column>

                <wj-flex-grid-column header="<s:message code="prod.splyUprc"/>" binding="splyUprc" width="80" is-read-only="true"></wj-flex-grid-column>
                <wj-flex-grid-column header="<s:message code="prod.costUprc"/>" binding="costUprc" width="80" is-read-only="true"></wj-flex-grid-column>
                <wj-flex-grid-column header="<s:message code="prod.poProdFg"/>" binding="poProdFg" width="80" is-read-only="true" align="center" data-map="poProdFgDataMap"></wj-flex-grid-column>
                <wj-flex-grid-column header="<s:message code="prod.poUnitFg"/>" binding="poUnitFg" width="80" is-read-only="true" align="center" data-map="poUnitFgDataMap"></wj-flex-grid-column>
                <wj-flex-grid-column header="<s:message code="prod.poUnitQty"/>" binding="poUnitQty" width="80" is-read-only="true"></wj-flex-grid-column>
                <wj-flex-grid-column header="<s:message code="prod.poMinQty"/>" binding="poMinQty" width="80" is-read-only="true"></wj-flex-grid-column>
                <wj-flex-grid-column header="<s:message code="prod.safeStockQty"/>" binding="safeStockQty" width="80" is-read-only="true"></wj-flex-grid-column>

                <c:if test="${momsEnvstVal == '1'}">
                    <wj-flex-grid-column header="<s:message code="prod.nuTotWt"/>" binding="nuTotWt" width="80" is-read-only="true"></wj-flex-grid-column>
                    <wj-flex-grid-column header="<s:message code="prod.nuKcal"/>" binding="nuKcal" width="80" is-read-only="true"></wj-flex-grid-column>
                    <wj-flex-grid-column header="<s:message code="prod.nuProtein"/>" binding="nuProtein" width="80" is-read-only="true"></wj-flex-grid-column>
                    <wj-flex-grid-column header="<s:message code="prod.nuSodium"/>" binding="nuSodium" width="80" is-read-only="true"></wj-flex-grid-column>
                    <wj-flex-grid-column header="<s:message code="prod.nuSugars"/>" binding="nuSugars" width="80" is-read-only="true"></wj-flex-grid-column>
                    <wj-flex-grid-column header="<s:message code="prod.nuSatFat"/>" binding="nuSatFat" width="80" is-read-only="true"></wj-flex-grid-column>
                    <wj-flex-grid-column header="<s:message code="prod.nuCaffeine"/>" binding="nuCaffeine" width="80" is-read-only="true"></wj-flex-grid-column>
                </c:if>
                <wj-flex-grid-column header="<s:message code="prod.mapProdCd"/>" binding="mapProdCd" width="80" is-read-only="true"></wj-flex-grid-column>

                <c:if test="${momsEnvstVal == '1'}">
                    <wj-flex-grid-column header="<s:message code="prod.kioskSaleTime"/>" binding="saleTimeFg" width="80" is-read-only="true" align="center" data-map="useYnComboDataMap"></wj-flex-grid-column>
                    <wj-flex-grid-column header="<s:message code="prod.kioskSaleTimeSetting"/>" binding="saleTime" width="80" is-read-only="true"></wj-flex-grid-column>
                    <wj-flex-grid-column header="<s:message code="prod.momsKioskEdge"/>" binding="momsKioskEdge" width="80" is-read-only="true" align="center" data-map="momsKioskEdgeDataMap"></wj-flex-grid-column>
                    <wj-flex-grid-column header="<s:message code="prod.optionGrp"/>" binding="optionGrpNm" width="80" is-read-only="true"></wj-flex-grid-column>
                    <wj-flex-grid-column header="<s:message code="prod.releaseDate"/>" binding="releaseDate" width="80" is-read-only="true"></wj-flex-grid-column>
                    <wj-flex-grid-column header="<s:message code="prod.discon"/>" binding="disconYn" width="80" is-read-only="true"></wj-flex-grid-column>
                    <wj-flex-grid-column header="<s:message code="prod.disconDate"/>" binding="disconDate" width="80" is-read-only="true"></wj-flex-grid-column>
                    <wj-flex-grid-column header="<s:message code="prod.inStore"/>" binding="inStore" width="80" is-read-only="true" align="center" data-map="useYnComboDataMap"></wj-flex-grid-column>
                    <wj-flex-grid-column header="<s:message code="prod.delivery"/>" binding="delivery" width="80" is-read-only="true" align="center" data-map="useYnComboDataMap"></wj-flex-grid-column>
                    <wj-flex-grid-column header="<s:message code="prod.packing"/>" binding="packing" width="80" is-read-only="true" align="center" data-map="useYnComboDataMap"></wj-flex-grid-column>

                    <wj-flex-grid-column header="<s:message code="prod.pos"/>" binding="pos" width="80" is-read-only="true" align="center" data-map="useYnComboDataMap"></wj-flex-grid-column>
                    <wj-flex-grid-column header="<s:message code="prod.kiosk"/>" binding="kiosk" width="80" is-read-only="true" align="center" data-map="useYnComboDataMap"v></wj-flex-grid-column>
                    <wj-flex-grid-column header="<s:message code="prod.app"/>" binding="app" width="80" is-read-only="true" align="center" data-map="useYnComboDataMap"></wj-flex-grid-column>
                    <wj-flex-grid-column header="<s:message code="prod.baemin"/>" binding="baemin" width="80" is-read-only="true" align="center" data-map="useYnComboDataMap"></wj-flex-grid-column>
                    <wj-flex-grid-column header="<s:message code="prod.baemin1"/>" binding="baemin1" width="80" is-read-only="true" align="center" data-map="useYnComboDataMap"></wj-flex-grid-column>
                    <wj-flex-grid-column header="<s:message code="prod.yogiyo"/>" binding="yogiyo" width="80" is-read-only="true" align="center" data-map="useYnComboDataMap"></wj-flex-grid-column>
                    <wj-flex-grid-column header="<s:message code="prod.yogiyoExp"/>" binding="yogiyoExp" width="80" is-read-only="true" align="center" data-map="useYnComboDataMap"></wj-flex-grid-column>
                    <wj-flex-grid-column header="<s:message code="prod.coupang"/>" binding="coupang" width="80" is-read-only="true" align="center" data-map="useYnComboDataMap"></wj-flex-grid-column>
                    <wj-flex-grid-column header="<s:message code="prod.baedaltong"/>" binding="baedaltong" width="80" is-read-only="true" align="center" data-map="useYnComboDataMap"></wj-flex-grid-column>
                    <wj-flex-grid-column header="<s:message code="prod.ddangyo"/>" binding="ddangyo" width="80" is-read-only="true" align="center" data-map="useYnComboDataMap"></wj-flex-grid-column>
                </c:if>
                <wj-flex-grid-column header="<s:message code="prod.title.remark"/>" binding="remark" width="80" is-read-only="true"></wj-flex-grid-column>
                <wj-flex-grid-column header="<s:message code="prod.title.info"/>" binding="prodInfo" width="80"is-read-only="true"></wj-flex-grid-column>
            </wj-flex-grid>
        </div>
        <%--//엑셀 리스트--%>
    </div>
</div>

<script>
    <%--var prodEnvstVal = "${prodEnvstVal}";--%>
    <%--var priceEnvstVal = "${priceEnvstVal}";--%>
    var prodNoEnvFg = "${prodNoEnvFg}";
    var prodAuthEnvstVal = "${prodAuthEnvstVal}";
    var orgnFg = "${orgnFg}";
    var hqOfficeCd = "${hqOfficeCd}";

    // 내점/배달/포장 가격관리 사용여부 (0: 미사용 1: 사용)
    var subPriceFg = "${subPriceFg}";
    // 프린터연결팝업창 여부(0:안띄움 1:띄움)
    var kitchenprintLink = "${kitchenprintLink}";
    // (상품관리)브랜드사용여부
    var brandUseFg = "${brandUseFg}";
    // 브랜드
    var brandList = ${brandList};
    // 매장상품제한구분 사용여부(매장 세트구성상품 등록시 사용, 매장에서 사용하지만 본사환경설정값으로 여부파악)
    var storeProdUseFg = "${storeProdUseFg}";

    // [1250 맘스터치] 환경설정값
    var momsEnvstVal = "${momsEnvstVal}";

    var branchCdComboList = ${branchCdComboList};
    var momsTeamComboList = ${momsTeamComboList};
    var momsAcShopComboList = ${momsAcShopComboList};
    var momsAreaFgComboList = ${momsAreaFgComboList};
    var momsCommercialComboList = ${momsCommercialComboList};
    var momsShopTypeComboList = ${momsShopTypeComboList};
    var momsStoreManageTypeComboList = ${momsStoreManageTypeComboList};

    // 사용자 매장브랜드(조회용)
    var userHqBrandCdComboList = ${userHqBrandCdComboList};

    <%-- 과세구분 --%>
    var vatFgData = ${ccu.getCommCode("039")};
    <%-- 상품유형 --%>
    var prodTypeFgData = ${ccu.getCommCode("008")};
    <%-- 세트상품구분 --%>
    var setProdFgData = ${ccu.getCommCode("009")};
    <%-- 발주상품구분 --%>
    var poProdFgData = ${ccu.getCommCode("092")};
    <%-- 발주단위 --%>
    var poUnitFgData = ${ccu.getCommCode("093")};
    <%-- 가격관리  < 이거로하면 전체가 안 나옴 --%>
    <%--var prcCtrlFgData = ${ccu.getCommCodeSelect("045")};--%>

    // POS에서 해당 WEB 화면 최초 접속한 경우(접속하면서 session 생성), 왼쪽 메뉴영역은 접어두기.
    // 최초 접속시에는 이전 URL 인자값으로 판별가능
    var referrer = document.referrer;
    if(referrer.indexOf("userId") > 0 && referrer.indexOf("resrceCd") > 0 && referrer.indexOf("accessCd") > 30 ){
        $(".menuControl").trigger("click");
    }

    // POS에서 해당 WEB 화면 재접속한 경우(이전 접속 session 그대로 존재), 'posLoginReconnect'값 판단하여 왼쪽 메뉴영역은 접어두기.
    // 재접속시에는 이전 URL 인자값이 없어, 로그인 여부 판별시에 특정 parameter 값을 보내 처리.
    if("${posLoginReconnect}" === "Y"){ // 직접입력한경우
        $(".menuControl").trigger("click");
    }
</script>

<script type="text/javascript" src="/resource/solbipos/js/base/prod/prodSearch/prodSearch2.js?ver=20240118.03" charset="utf-8"></script>

<%-- 레이어 팝업 : 상품상세정보 --%>
<c:import url="/WEB-INF/view/base/prod/prod/prodDetailView.jsp">
    <c:param name="menuCd" value="${menuCd}"/>
    <c:param name="menuNm" value="${menuNm}"/>
    <c:param name="prodNoEnvFg" value="${prodNoEnvFg}"/>
</c:import>

<%-- 레이어 팝업 : 상품정보 입력/수정 --%>
<c:import url="/WEB-INF/view/base/prod/prod/prodModifyView.jsp">
    <c:param name="menuCd" value="${menuCd}"/>
    <c:param name="menuNm" value="${menuNm}"/>
    <c:param name="kitchenprintLink" value="${kitchenprintLink}"/>
</c:import>

<%-- 레이어 팝업 : 상품별 적용매장 선택 팝업 --%>
<c:import url="/WEB-INF/view/base/prod/prod/prodStoreRegistView.jsp">
    <c:param name="menuCd" value="${menuCd}"/>
    <c:param name="menuNm" value="${menuNm}"/>
</c:import>

<%-- 레이어 팝업 : 매장 리스트 팝업 --%>
<c:import url="/WEB-INF/view/base/prod/prod/storeProdBatchList.jsp">
    <c:param name="menuCd" value="${menuCd}"/>
    <c:param name="menuNm" value="${menuNm}"/>
</c:import>

<%-- 레이어 팝업 : 매장별 상품 일괄적용 팝업 --%>
<c:import url="/WEB-INF/view/base/prod/prod/storeProdBatchRegist.jsp">
    <c:param name="menuCd" value="${menuCd}"/>
    <c:param name="menuNm" value="${menuNm}"/>
</c:import>

<%-- 레이어 팝업 : 상품삭제 팝업 --%>
<c:import url="/WEB-INF/view/base/prod/prod/prodDeleteView.jsp">
    <c:param name="menuCd" value="${menuCd}"/>
    <c:param name="menuNm" value="${menuNm}"/>
</c:import>