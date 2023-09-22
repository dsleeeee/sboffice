/****************************************************************
 *
 * 파일명 : mobileEmpCard.js
 * 설  명 : (모바일) 공통 결제수단 사원카드 팝업 JavaScript
 *
 *    수정일      수정자      Version        Function 명
 * ------------  ---------   -------------  --------------------
 * 2023.09.20     권지현      1.0
 *
 * **************************************************************/
/**
 * get application
 */
var app = agrid.getApp();

/**
 *  사원카드 팝업 조회 그리드 생성
 */
app.controller('mobileEmpCardCtrl', ['$scope', '$http', '$timeout', function ($scope, $http, $timeout) {

    // 상위 객체 상속 : T/F 는 picker
    angular.extend(this, new RootController('mobileEmpCardCtrl', $scope, $http, false));

    $scope.accountFgMap = new wijmo.grid.DataMap([
        {id: "01", name: messages["dayEmpCard.accountFg01"]},
        {id: "02", name: messages["dayEmpCard.accountFg02"]},
    ], 'id', 'name');

    // grid 초기화 : 생성되기전 초기화되면서 생성된다
    $scope.initGrid = function (s, e) {
        // 합계
        // add the new GroupRow to the grid's 'columnFooters' panel
        s.columnFooters.rows.push(new wijmo.grid.GroupRow());
        // add a sigma to the header to show that this is a summary row
        s.bottomLeftCells.setCellData(0, 0, '합계');
    };

    // <-- 검색 호출 -->
    $scope.$on("mobileEmpCardCtrl", function(event, data) {
        $scope.wjMobileEmpCardLayer.show(true);

        $scope.searchMobileEmpCard(data);
        event.preventDefault();
    });

    $scope.searchMobileEmpCard = function(params){
        $scope._inquiryMain("/mobile/sale/cmmSalePopup/payInfo/mobileEmpCard/getMobileEmpCardList.sb", params, function() {}, false);
    };
    // <-- //검색 호출 -->

    // 엑셀 다운로드
    $scope.excelDownload = function () {
        if ($scope.flex.rows.length <= 0) {
            $scope._popMsg(messages["excelUpload.not.downloadData"]); // 다운로드 할 데이터가 없습니다.
            return false;
        }

        $scope.$broadcast('loadingPopupActive', messages["cmm.progress"]); // 데이터 처리중 메시지 팝업 오픈
        $timeout(function () {
            wijmo.grid.xlsx.FlexGridXlsxConverter.saveAsync($scope.flex, {
                includeColumnHeaders: true,
                includeCellStyles: true,
                includeColumns: function (column) {
                    return column.visible;
                }
            }, '사원카드_결제내역_' + getToday() + '.xlsx', function () {
                $timeout(function () {
                    $scope.$broadcast('loadingPopupInactive'); // 데이터 처리중 메시지 팝업 닫기
                }, 10);
            });
        }, 10);
    };

}]);