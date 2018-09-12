<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<input type="hidden" id="<c:out value="${param.targetId}Cd"/>"/>
<input type="text"   id="<c:out value="${param.targetId}Nm"/>" class="sb-input" style="cursor:pointer; width:200px;" value="<s:message code="cmm.chk"/>" ng-click="<c:out value="${param.targetId}"/>Show()" readonly/>
<button type="button" class="btn_skyblue" id="<c:out value="${param.targetId}SelectCancelBtn"/>"><s:message code="outstockReqDate.selectCancel" /></button>

<wj-popup id="wj<c:out value="${param.targetId}"/>LayerS" control="wj<c:out value="${param.targetId}"/>LayerS" show-trigger="Click" hide-trigger="Click" style="display:none;width:500px;">
    <div class="wj-dialog wj-dialog-columns" ng-controller="<c:out value="${param.targetId}"/>Ctrl">
        <div class="wj-dialog-header wj-dialog-header-font">
            <s:message code="cmm.store.select"/>
            <a href="javascript:;" class="wj-hide btn_close"></a>
        </div>
        <div class="wj-dialog-body">
            <div class="w100">
                <div class="mt20 oh sb-select dkbr">
                    <%-- 페이지 스케일  --%>
                    <wj-combo-box
                            class="w150 fl"
                            id="listScaleBox"
                            ng-model="listScale"
                            items-source="_getComboData('listScaleBox')"
                            display-member-path="name"
                            selected-value-path="value"
                            is-editable="false"
                            initialized="initComboBox(s)">
                    </wj-combo-box>
                    <%--// 페이지 스케일  --%>
                </div>

                <%--위즈모 테이블--%>
                <div class="wj-gridWrap mt10" style="height: 400px;" >
                    <wj-flex-grid
                            autoGenerateColumns="false"
                            selection-mode="Row"
                            items-source="data"
                            <%--control="storeGridS"--%>
                            control="flex"
                            initialized="initGrid(s,e)"
                            is-read-only="true"
                            item-formatter="_itemFormatter">

                        <!-- define columns -->
                        <wj-flex-grid-column header="<s:message code="outstockReqDate.storeCd"/>"      binding="storeCd"      width="70" align="center"></wj-flex-grid-column>
                        <wj-flex-grid-column header="<s:message code="outstockReqDate.storeNm"/>"      binding="storeNm"      width="*"  align="left"  ></wj-flex-grid-column>

                    </wj-flex-grid>
                </div>
                <%--//위즈모 테이블--%>
            </div>

            <%-- 페이지 리스트 --%>
            <div class="pageNum mt20">
                <%-- id --%>
                <ul id="<c:out value="${param.targetId}"/>CtrlPager" data-size="10">
                </ul>
            </div>
            <%--//페이지 리스트--%>
        </div>
    </div>
</wj-popup>




<script type="text/javascript">

    /** 매장선택 controller */
    app.controller('<c:out value="${param.targetId}"/>Ctrl', ['$scope', '$http', function($scope, $http) {
        var targetId = '<c:out value="${param.targetId}"/>';
        // 상위 객체 상속 : T/F 는 picker
        angular.extend(this, new RootController(targetId+'Ctrl', $scope, $http, true));

        // grid 초기화 : 생성되기전 초기화되면서 생성된다
        $scope.initGrid = function (s, e) {
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
                    if (col.binding === "storeCd") {
                        $("#"+targetId+"Cd").val(selectedRow.storeCd);
                        $("#"+targetId+"Nm").val("["+selectedRow.storeCd+"] "+selectedRow.storeNm);
                        eval('$scope.wj'+targetId+'LayerS.hide(true)');
                    }
                }
            });
        };

        var searchFg = "N"; // 조회 했는지 여부
        // 다른 컨트롤러의 broadcast 받기
        $scope.$on(targetId+'Ctrl', function(event, paramObj) {
            // 매장선택 팝업 오픈
            eval('$scope.wj'+targetId+'LayerS.show(true)');

            if(searchFg == "N") {
                $scope.searchStore();
            }
            // 기능수행 종료 : 반드시 추가
            event.preventDefault();
        });

        $scope.searchStore = function () {
            // 파라미터
            var params = {};
            $scope._inquirySub("/iostock/order/outstockReqDate/days/selectStoreList.sb", params, function () {
                searchFg = "Y";
            });
        };
    }]);

    $(document).ready(function () {
        <%-- 선택취소 버튼 클릭 --%>
        $("#<c:out value='${param.targetId}'/>SelectCancelBtn").click(function(){
            $("#<c:out value='${param.targetId}Cd'/>").val("");
            $("#<c:out value='${param.targetId}Nm'/>").val('<s:message code="cmm.chk"/>');
        });
    });

</script>
