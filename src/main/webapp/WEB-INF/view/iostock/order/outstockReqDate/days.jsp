<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="menuCd" value="${sessionScope.sessionInfo.currentMenu.resrceCd}"/>
<c:set var="menuNm" value="${sessionScope.sessionInfo.currentMenu.resrceNm}"/>
<c:set var="baseUrl" value="/iostock/order/outstockReqDate/days/"/>

<div class="subCon">
    <div class="searchBar flddUnfld">
        <a href="javascript:void(0);" class="open">${menuNm}</a>
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
            <%-- 매장코드 --%>
            <th><s:message code="outstockReqDate.storeCd"/></th>
            <td><input type="text" id="searchStoreCd" name="searchStoreCd" ng-model="storeCd" class="sb-input w100" maxlength="4"/></td>
            <%-- 매장명 --%>
            <th><s:message code="outstockReqDate.storeNm"/></th>
            <td><input type="text" id="searchStoreNm" name="searchStoreNm" ng-model="storeNm" class="sb-input w100" maxlength="12" /></td>
        </tr>
        </tbody>
    </table>

    <div class="mt10 pdb20 oh bb">
        <%-- 조회 --%>
        <button class="btn_blue fr" id="btnSearch" ng-click="_broadcast('daysCtrl')"><s:message code="cmm.search" /></button>
    </div>

    <div class="wj-TblWrap" ng-controller="daysCtrl">
        <div class="mt20 oh sb-select dkbr">
            <%--페이지 스케일 --%>
            <div id="listScaleBoxDays" class="w130 fl"></div>
            <div class="tr">
                <%-- 신규등록 --%>
                <button class="btn_skyblue" ng-click="saveDays()"><s:message code="cmm.save" /></button>
            </div>
        </div>

        <%--위즈모 테이블--%>
        <div class="wj-TblWrapBr mt10" style="height: 400px;" >
            <wj-flex-grid
                    autoGenerateColumns="false"
                    selection-mode="Row"
                    items-source="data"
                    control="flex"
                    initialized="initGrid(s,e)"
                    is-read-only="false"
                    item-formatter="_itemFormatter">

                <!-- define columns -->
                <wj-flex-grid-column header="<s:message code="outstockReqDate.sun"/>" binding="gChk" width="40" align="center"></wj-flex-grid-column>
                <wj-flex-grid-column header="<s:message code="outstockReqDate.storeCd"/>" binding="storeCd" width="70" align="center" is-read-only="true"></wj-flex-grid-column>
                <wj-flex-grid-column header="<s:message code="outstockReqDate.storeNm"/>" binding="storeNm" width="*"  align="left" is-read-only="true"></wj-flex-grid-column>
                <wj-flex-grid-column header="<s:message code="outstockReqDate.sun"/>"  binding="sun"  width="50" align="center"></wj-flex-grid-column>
                <wj-flex-grid-column header="<s:message code="outstockReqDate.mon"/>"  binding="mon"  width="50" align="center"></wj-flex-grid-column>
                <wj-flex-grid-column header="<s:message code="outstockReqDate.tue"/>"  binding="tue"  width="50" align="center"></wj-flex-grid-column>
                <wj-flex-grid-column header="<s:message code="outstockReqDate.wed"/>"  binding="wed"  width="50" align="center"></wj-flex-grid-column>
                <wj-flex-grid-column header="<s:message code="outstockReqDate.thu"/>"  binding="thu"  width="50" align="center"></wj-flex-grid-column>
                <wj-flex-grid-column header="<s:message code="outstockReqDate.fri"/>"  binding="fri"  width="50" align="center"></wj-flex-grid-column>
                <wj-flex-grid-column header="<s:message code="outstockReqDate.sat"/>"  binding="sat"  width="50" align="center"></wj-flex-grid-column>
                <wj-flex-grid-column header="<s:message code="outstockReqDate.remark"/>" binding="remark" width="*" align="left" is-read-only="false"></wj-flex-grid-column>

                <!-- enable column filtering-->
                <wj-flex-grid-filter></wj-flex-grid-filter>
            </wj-flex-grid>
        </div>
        <%--//위즈모 테이블--%>
    </div>
</div>

<script type="text/javascript">
    var listScaleBoxDays;
    /**
     * get application
     */
    var app = agrid.getApp();
    app.service('storeVO', function () {
        var g_storeCd = "";
        var g_storeNm = "";
        this.setStoreCd = function (storeCd) {
            this.g_storeCd = storeCd;
        };
        this.getStoreCd = function () {
            return this.g_storeCd;
        };
        this.setStoreNm = function (storeNm) {
            this.g_storeNm = storeNm;
        };
        this.getStoreNm = function () {
            return this.g_storeNm;
        };
    });

    /** 요일별 그리드 controller */
    app.controller('daysCtrl', ['$scope', '$http', 'storeVO', function ($scope, $http, storeVO) {
        // 상위 객체 상속 : T/F 는 picker
        angular.extend(this, new RootController($scope, $http, true));
        // grid 초기화 : 생성되기전 초기화되면서 생성된다
        $scope.initGrid = function (s, e) {
            // picker 사용시 호출 : 미사용시 호출안함
            $scope._makePickColumns("daysCtrl");

            // 그리드 링크 효과
            s.formatItem.addHandler(function (s, e) {
                if (e.panel == s.cells) {
                    let col = s.columns[e.col];
                    if (col.binding === "storeCd") {
                        let item = s.rows[e.row].dataItem;
                        wijmo.addClass(e.cell, 'wijLink');
                        wijmo.addClass(e.cell, 'wj-custom-readonly');
                    }
                }
            });

            // 그리드 매장코드 클릭 이벤트
            s.addEventListener(s.hostElement, 'mousedown', function(e) {
                var ht = s.hitTest(e);
                if( ht.cellType === wijmo.grid.CellType.Cell) {
                    var col = ht.panel.columns[ht.col];
                    var selectedRow = s.rows[ht.row].dataItem;
                    if ( col.binding === "storeCd") {
                        var params = {};
                        params.storeCd = selectedRow.storeCd;
                        params.storeNm = selectedRow.storeNm;
                        storeVO.setStoreCd(selectedRow.storeCd);
                        storeVO.setStoreNm(selectedRow.storeNm);
                        // $scope._broadcast('dlvrInfoCtrl', params);
                    }
                }
            });
        };

        // 다른 컨트롤러의 broadcast 받기
        $scope.$on("daysCtrl", function(event, data) {
            $scope.searchDaysList();
            // 기능수행 종료 : 반드시 추가
            event.preventDefault();
        });

        $scope.searchDaysList = function() {
            // 파라미터
            var params = {};
            // params.listScale = 15;
            params.listScale = listScaleBoxDays.selectedValue;
            params.curr = 1;
            // 조회 수행 : 조회URL, 파라미터, 콜백함수
            $scope._inquiryMain("/iostock/order/outstockReqDate/days/list.sb", params);
        };

        // 요청일 저장
        $scope.saveDays = function () {
            var params = new Array();
            for (var i = 0; i < $scope.flex.collectionView.itemsEdited.length; i++) {
                $scope.flex.collectionView.itemsEdited[i].status = "U";
                params.push($scope.flex.collectionView.itemsEdited[i]);
            }
            $scope._save("/iostock/order/outstockReqDate/days/saveDays.sb", params, '$scope.searchDaysList');
        };

    }]);

    $(document).ready(function () {
        listScaleBoxDays = wcombo.genCommonBox("#listScaleBoxDays", gvListScaleBoxData); //listScaleBoxData 는 공통으로 빼둠. (commonVariables.jsp)

        <%-- 엑셀 다운로드 버튼 클릭 --%>
        $("#btnExcel").click(function(){
            var name = "${menuNm}";
            name = name+" 테스트";
            // wexcel.down(gridStoreLoan, name, name + ".xlsx");
        });
    });

</script>
<%--<script type="text/javascript" src="/resource/solbipos/js/iostock/loan/storeLoan.js?ver=2018082101" charset="utf-8"></script>--%>


