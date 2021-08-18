<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix="f" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="subCon" ng-controller="empCardInfoCtrl">

    <%-- title --%>
    <div class="searchBar">
        <a href="#" class="open fl"><s:message code="empCardInfo.title"/></a>
        <%-- 조회 --%>
        <div class="mr15 fr" style="display:block;position: relative;margin-top: 6px;">
            <button class="btn_blue fr" id="btnSearch" ng-click="_pageView('empCardInfoCtrl',1)">
                <s:message code="cmm.search"/>
            </button>
        </div>
    </div>

    <%-- 조회조건 --%>
    <table class="searchTbl">
        <colgroup>
            <col class="w13"/>
            <col class="w35"/>
            <col class="w13"/>
            <col class="w35"/>
        </colgroup>
        <tbody>
        <tr>
            <%-- 카드번호 --%>
            <th><s:message code="empCardInfo.empCardNo"/></th>
            <td>
                <input type="text" class="sb-input w100" ng-model="employeeCardNo"/>
            </td>
            <%-- 사원번호 --%>
            <th><s:message code="empCardInfo.empNo"/></th>
            <td>
                <input type="text" class="sb-input w100" ng-model="employeeNo"/>
            </td>
        </tr>
        <tr>
            <%-- 사원이름 --%>
            <th><s:message code="empCardInfo.empNm"/></th>
            <td>
                <input type="text" class="sb-input w100" ng-model="employeeNm"/>
            </td>
            <%-- 소속명 --%>
            <th><s:message code="empCardInfo.divNm"/></th>
            <td>
                <input type="text" class="sb-input w100" ng-model="divNm"/>
            </td>
        </tr>
        <tr>
            <%-- 부서명 --%>
            <th><s:message code="empCardInfo.deptNm"/></th>
            <td>
                <input type="text" class="sb-input w100" ng-model="deptNm"/>
            </td>
            <%-- 직위명 --%>
            <th><s:message code="empCardInfo.positionNm"/></th>
            <td>
                <input type="text" class="sb-input w100" ng-model="positionNm"/>
            </td>
        </tr>
        </tbody>
    </table>

    <%-- grid --%>
    <div id="grid" class="w100">
        <div class="mt20 oh sb-select dkbr">
            <%-- 페이지 스케일  --%>
            <wj-combo-box
                    class="w100px fl"
                    id="listScaleBox"
                    ng-model="listScale"
                    items-source="_getComboData('listScaleBox')"
                    display-member-path="name"
                    selected-value-path="value"
                    is-editable="false"
                    initialized="initComboBox(s)">
            </wj-combo-box>
            <%--// 페이지 스케일  --%>

            <%-- excel 업로드 --%>
            <button class="btn_skyblue ml5 fr" id="btnExcelUpload" ng-click="excelUpload()">
                <s:message code="empCardInfo.excelUpload"/>
            </button>

            <%-- excel 양식 다운로드 --%>
            <button class="btn_skyblue ml5 fr" id="btnExcelDownload" ng-click="excelDownload()">
                <s:message code="empCardInfo.sampleDownload"/>
            </button>

        </div>
        <div class="wj-gridWrap mt10" style="height:370px; overflow-y: hidden;">
            <div class="row">
                <wj-flex-grid
                        control="flex"
                        autoGenerateColumns="false"
                        selection-mode="Row"
                        initialized="initGrid(s,e)"
                        items-source="data"
                        item-formatter="_itemFormatter">

                    <!-- define columns -->
                    <wj-flex-grid-column header="<s:message code="empCardInfo.empCardNo"/>" binding="employeeCardNo" width="200" align="center" is-read-only="true"></wj-flex-grid-column>
                    <wj-flex-grid-column header="<s:message code="empCardInfo.empNo"/>" binding="employeeNo" width="150" align="center" is-read-only="true"></wj-flex-grid-column>
                    <wj-flex-grid-column header="<s:message code="empCardInfo.empNm"/>" binding="employeeNm" width="150" align="center" is-read-only="true"></wj-flex-grid-column>
                    <wj-flex-grid-column header="<s:message code="empCardInfo.divNm"/>" binding="divNm" width="200" align="center" is-read-only="true"></wj-flex-grid-column>
                    <wj-flex-grid-column header="<s:message code="empCardInfo.deptNm"/>" binding="deptNm" width="200" align="center" is-read-only="true"></wj-flex-grid-column>
                    <wj-flex-grid-column header="<s:message code="empCardInfo.positionNm"/>" binding="positionNm" width="150" align="center" is-read-only="true"></wj-flex-grid-column>
                </wj-flex-grid>
            </div>
        </div>
        <%-- 페이지 리스트 --%>
        <div class="pageNum mt20">
            <%-- id --%>
            <ul id="empCardInfoCtrlPager" data-size="10">
            </ul>
        </div>
        <%--//페이지 리스트--%>
    </div>
</div>

<script type="text/javascript">
</script>

<script type="text/javascript" src="/resource/solbipos/js/base/store/emp/empCardInfo.js?ver=20210818.01" charset="utf-8"></script>

<%-- 사원카드정보관리 엑셀업로드 --%>
<c:import url="/WEB-INF/view/base/store/emp/excelUploadEmpCardInfo.jsp">
</c:import>