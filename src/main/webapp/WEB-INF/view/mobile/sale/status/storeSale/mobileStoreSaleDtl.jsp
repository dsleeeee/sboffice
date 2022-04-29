<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="orgnFg" value="${sessionScope.sessionInfo.orgnFg}" />
<c:set var="storeCd" value="${sessionScope.sessionInfo.storeCd}" />

<wj-popup id="wjStoreSaleDtlLayer" control="wjStoreSaleDtlLayer" show-trigger="Click" hide-trigger="Click" style="display:none;width:90%;height:85%;">
    <div class="wj-dialog wj-dialog-columns">
        <div class="wj-dialog-header wj-dialog-header-font">
            <s:message code="mobile.storeSale.storeSaleDtl"/>&nbsp;<label id="storeTitle"></label>
            <a href="#" class="wj-hide btn_close"></a>
        </div>
        <div class="wj-dialog-body" ng-controller="storeSaleDtlCtrl">
            <div class="w100">
                <%--위즈모 테이블--%>
                <div class="popGrid mt5" style="height:500px;">
                    <wj-flex-grid
                            autoGenerateColumns="false"
                            selection-mode="Row"
                            items-source="data"
                            control="flex"
                            initialized="initGrid(s,e)"
                            is-read-only="false"
                            item-formatter="_itemFormatter">

                        <wj-flex-grid-column header="<s:message code="mobile.storeSale.saleDate"/>"     binding="saleDate" width="1.*" align="center" is-read-only="true"></wj-flex-grid-column>
                        <wj-flex-grid-column header="<s:message code="mobile.storeSale.billCnt"/>"      binding="billCnt" width="1.*" align="center" is-read-only="true" aggregate="Sum"></wj-flex-grid-column>
                        <wj-flex-grid-column header="<s:message code="mobile.storeSale.realSaleAmt"/>"  binding="realSaleAmt" width="1.*" align="center" is-read-only="true" aggregate="Sum"></wj-flex-grid-column>

                    </wj-flex-grid>
                </div>
                <%--//위즈모 테이블--%>
            </div>
        </div>
    </div>
</wj-popup>

<script type="text/javascript">

    var multiStoreFg = '${multiStoreFg}';

    /**
     * get application
     */
    var app = agrid.getApp();

    /** 매장선택 controller */
    app.controller('storeSaleDtlCtrl', ['$scope', '$http', function ($scope, $http) {

        // 상위 객체 상속 : T/F 는 picker
        angular.extend(this, new RootController('storeSaleDtlCtrl', $scope, $http, true));

        // grid 초기화 : 생성되기전 초기화되면서 생성된다
        $scope.initGrid = function (s, e) {
            // 합계
            // add the new GroupRow to the grid's 'columnFooters' panel
            s.columnFooters.rows.push(new wijmo.grid.GroupRow());
            // add a sigma to the header to show that this is a summary row
            s.bottomLeftCells.setCellData(0, 0, '합계');
        };

        // 다른 컨트롤러의 broadcast 받기
        $scope.$on('storeSaleDtlCtrl', function (event, data) {
            $("#storeTitle").text("[" + data.srchStoreCd + "]" +  data.srchStoreNm);
            // 반품현황 상세 팝업 오픈
            $scope.wjStoreSaleDtlLayer.show(true);
            $scope.searchStoreSaleDtl(data);
            // 기능수행 종료 : 반드시 추가
            event.preventDefault();
        });

        $scope.searchStoreSaleDtl = function (data) {
            // 파라미터
            var params = {};
            params.storeCd = data.srchStoreCd;
            params.startDate = data.startDate;
            params.endDate = data.endDate;
            $scope._inquirySub("/mobile/sale/status/storeSale/storeSale/getMobileStoreSaleDtlList.sb", params, function () {
            });
        };
    }]);
</script>
