<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="menuCd" value="${sessionScope.sessionInfo.currentMenu.resrceCd}"/>
<c:set var="menuNm" value="${sessionScope.sessionInfo.currentMenu.resrceNm}"/>

<div id="statusVanView" class="subCon" style="display: none;">

    <%-- 조회조건 --%>
    <div class="searchBar flddUnfld">
        <a href="#" class="open fl"><s:message code="statusVan.info" /></a>
        <%-- 조회 --%>
        <div class="mr15 fr" style="display:block;position: relative;margin-top: 6px;">
            <button class="btn_blue fr" ng-click="_pageView('statusVanCtrl',1)">
                <s:message code="cmm.search" />
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
                <%-- VAN사 코드 --%>
                <th>
                    <s:message code="statusVan.srchVanCd" />
                </th>
                <td>
                    <input type="text" class="sb-input w100" id="srchVanCd" ng-model="vanCd" />
                </td>
                <%-- VAN사명 --%>
                <th>
                    <s:message code="statusVan.srchVanNm" />
                </th>
                <td>
                    <input type="text" class="sb-input w100" id="srchVanNm" ng-model="vanNm" />
                </td>
            </tr>
            <tr>
                <%-- 용도 --%>
                <th>
                    <s:message code="statusVan.srchClsFg" />
                </th>
                <td>
                    <div class="sb-select">
                        <wj-combo-box
                            id="srchClsFg"
                            ng-model="clsFg"
                            items-source="_getComboData('clsFg')"
                            display-member-path="name"
                            selected-value-path="value"
                            is-editable="false"
                            initialized="_initComboBox(s)">
                        </wj-combo-box>
                    </div>
                </td>
                <%-- 상태 --%>
                <th>
                    <s:message code="statusVan.srchSysStatFg" />
                </th>
                <td>
                    <div class="sb-select">
                        <wj-combo-box
                            id="srchSysStatFg"
                            ng-model="sysStatFg"
                            items-source="_getComboData('sysStatFg')"
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

    <div class="wj-TblWrap mt20 mb20 w25 fl" ng-controller="statusVanCtrl">
        <%-- 그리드 --%>
        <div class="w100 mt10 mb20">
            <div class="wj-gridWrap" style="height:370px; overflow-y: hidden; overflow-x: hidden;">
                <div class="row">
                    <wj-flex-grid
                        autoGenerateColumns="false"
                        control="flex"
                        initialized="initGrid(s,e)"
                        sticky-headers="true"
                        selection-mode="Row"
                        items-source="data"
                        item-formatter="_itemFormatter"
                        is-read-only="true">

                        <!-- define columns -->
                        <wj-flex-grid-column header="<s:message code="statusVan.vanCd"/>" binding="vanCd" width="100" is-read-only="true" align="center"></wj-flex-grid-column>
                        <wj-flex-grid-column header="<s:message code="statusVan.vanNm"/>" binding="vanNm" width="105" is-read-only="true" align="center"></wj-flex-grid-column>
                        <wj-flex-grid-column header="<s:message code="statusVan.storeCnt"/>" binding="storeCnt" width="100" is-read-only="true" align="center"></wj-flex-grid-column>

                        <%--상세 조회시 필요--%>
                        <wj-flex-grid-column header="<s:message code="statusVan.clsFg"/>" binding="clsFg" width="115" is-read-only="true" align="center" visible="false"></wj-flex-grid-column>
                        <wj-flex-grid-column header="<s:message code="statusVan.sysStatFg"/>" binding="sysStatFg" width="115" is-read-only="true" align="center" visible="false"></wj-flex-grid-column>

                    </wj-flex-grid>
                </div>
            </div>
        </div>
    </div>

    <div class="wj-TblWrap mt20 mb20 w75 fr" ng-controller="statusVanDetailCtrl">
        <%-- 그리드 --%>
        <div class="w100 mt10 mb20">
            <div class="wj-gridWrap" style="height:370px; overflow-y: hidden; overflow-x: hidden;">
                <div class="row">
                    <wj-flex-grid
                        autoGenerateColumns="false"
                        control="flex"
                        initialized="initGrid(s,e)"
                        sticky-headers="true"
                        selection-mode="Row"
                        items-source="data"
                        item-formatter="_itemFormatter"
                        is-read-only="true">

                        <!-- define columns -->
                        <wj-flex-grid-column header="<s:message code="statusVan.hqOfficeCd"/>" binding="hqOfficeCd" width="115" is-read-only="true" align="center"></wj-flex-grid-column>
                        <wj-flex-grid-column header="<s:message code="statusVan.hqOfficeNm"/>" binding="hqOfficeNm" width="115" is-read-only="true" align="center"></wj-flex-grid-column>
                        <wj-flex-grid-column header="<s:message code="statusVan.storeCd"/>" binding="storeCd" width="115" is-read-only="true" align="center"></wj-flex-grid-column>
                        <wj-flex-grid-column header="<s:message code="statusVan.storeNm"/>" binding="storeNm" width="115" is-read-only="true" align="center"></wj-flex-grid-column>
                        <wj-flex-grid-column header="<s:message code="statusVan.clsFg"/>" binding="clsFg" data-map="clsFgDataMap" width="115" is-read-only="true" align="center"></wj-flex-grid-column>
                        <wj-flex-grid-column header="<s:message code="statusVan.sysStatFg"/>" binding="sysStatFg" data-map="sysStatFgDataMap" idth="115" is-read-only="true" align="center"></wj-flex-grid-column>
                        <wj-flex-grid-column header="<s:message code="statusVan.minSaleDate"/>" binding="minSaleDate" width="115" is-read-only="true" align="center"></wj-flex-grid-column>
                        <wj-flex-grid-column header="<s:message code="statusVan.maxSaleDate"/>" binding="maxSaleDate" width="115" is-read-only="true" align="center"></wj-flex-grid-column>
                        <wj-flex-grid-column header="<s:message code="statusVan.posCnt"/>" binding="posCnt" width="115" is-read-only="true" align="center"></wj-flex-grid-column>

                    </wj-flex-grid>
                </div>
            </div>
            <%-- 페이지 리스트 --%>
            <div class="pageNum mt20">
                <%-- id --%>
                <ul id="statusVanDetailCtrlPager" data-size="10">
                </ul>
            </div>
            <%--//페이지 리스트--%>
        </div>
    </div>

</div>

<script type="text/javascript">
    <%-- 용도구분 --%>
    var clsFgData = ${ccu.getCommCodeExcpAll("001")};
    <%-- 상태구분 --%>
    var sysStatFgData = ${ccu.getCommCodeExcpAll("005")};
</script>

<script type="text/javascript" src="/resource/solbipos/js/store/manage/status/statusVan.js?ver=2019052801.05" charset="utf-8"></script>