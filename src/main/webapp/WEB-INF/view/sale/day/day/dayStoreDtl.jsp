<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="menuCd" value="${sessionScope.sessionInfo.currentMenu.resrceCd}"/>
<c:set var="menuNm" value="${sessionScope.sessionInfo.currentMenu.resrceNm}"/>
<c:set var="baseUrl" value="/sale/day/day/dayStoreDtl/"/>

<wj-popup control="wjDayStoreDtlLayer" show-trigger="Click" hide-trigger="Click" style="display:none;width:780px;height:480px;" fade-in="false" fade-out="false">
    <div ng-controller="dayStoreDtlCtrl">

        <%-- header --%>
        <div class="wj-dialog-header wj-dialog-header-font">
          <s:message code="day.dayStoreDtl.dayStore"/>
          <a href="#" class="wj-hide btn_close"></a>
        </div>

        <%-- body --%>
        <div class="wj-dialog-body">
            <div class="oh sb-select dkbr">
                <%-- 엑셀다운로드 --%>
                <button class="btn_skyblue ml5 fr" ng-click="excelDownload()">
                    <s:message code="cmm.excel.down" />
                </button>
            </div>
            <%-- 그리드 --%>
            <div class="w100 mt10 mb20">
                <div class="wj-gridWrap" style="height:350px; overflow-y: hidden; overflow-x: hidden;">
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
                        <wj-flex-grid-column header="<s:message code="day.dayStoreDtl.storeCd"/>" binding="storeCd" width="80" is-read-only="true" align="center"></wj-flex-grid-column>
                        <wj-flex-grid-column header="<s:message code="day.dayStoreDtl.storeNm"/>" binding="storeNm" width="140" is-read-only="true" align="center"></wj-flex-grid-column>
                        <wj-flex-grid-column header="<s:message code="day.dayStoreDtl.totSaleAmt"/>" binding="totSaleAmt" width="90" is-read-only="true" align="right" aggregate="Sum"></wj-flex-grid-column>
                        <wj-flex-grid-column header="<s:message code="day.dayStoreDtl.totDcAmt"/>" binding="totDcAmt" width="90" is-read-only="true" align="right" aggregate="Sum"></wj-flex-grid-column>
                        <wj-flex-grid-column header="<s:message code="day.dayStoreDtl.realSaleAmt"/>" binding="realSaleAmt" width="90" is-read-only="true" align="right" aggregate="Sum"></wj-flex-grid-column>
                        <wj-flex-grid-column header="<s:message code="day.dayStoreDtl.billCnt"/>" binding="billCnt" width="90" is-read-only="true" align="center" aggregate="Sum"></wj-flex-grid-column>
                        <wj-flex-grid-column header="<s:message code="day.dayStoreDtl.billUprc"/>" binding="billUprc" width="90" is-read-only="true" align="right" aggregate="Sum"></wj-flex-grid-column>

                    </wj-flex-grid>
                </div>
            </div>
        </div>

    </div>
</wj-popup>

<script type="text/javascript" src="/resource/solbipos/js/sale/day/day/dayStoreDtl.js?ver=20210719.01" charset="utf-8"></script>