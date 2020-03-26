/****************************************************************
 *
 * 파일명 : prodSaleDtl.js
 * 설  명 : 상품매출 상세내역 팝업 JavaScript
 *
 *    수정일      수정자      Version        Function 명
 * ------------  ---------   -------------  --------------------
 *                            1.0
 * 2019.12.11     김설아      1.1
 *
 * **************************************************************/
/**
 * get application
 */
var app = agrid.getApp();

/**
 *  팝업 그리드 생성
 */
app.controller('prodSaleDtlCtrl', ['$scope', '$http', '$timeout', function ($scope, $http, $timeout) {

    // 상위 객체 상속 : T/F 는 picker
    angular.extend(this, new RootController('prodSaleDtlCtrl', $scope, $http, true));

    // grid 초기화 : 생성되기전 초기화되면서 생성된다
    $scope.initGrid = function (s, e) {
        // 합계
        // add the new GroupRow to the grid's 'columnFooters' panel
        s.columnFooters.rows.push(new wijmo.grid.GroupRow());
        // add a sigma to the header to show that this is a summary row
        s.bottomLeftCells.setCellData(0, 0, '합계');
    };

    // 팝업 호출시 상세정보 조회
    $scope.$on("prodSaleDtlCtrl", function(event, data) {
        $scope.wjProdSaleDtlLayer.show(true);
        $scope.searchProdSaleDtlList(data);
        event.preventDefault();
    });

    $scope.searchProdSaleDtlList = function(data){
        var params = {};
        // 기간별매출 > 일자별 탭 > 과면세별,포스별,코너별 탭
        if(data.gubun == "day" ||  data.gubun == "dayCorner") {
            params.saleDate = data.saleDate;
        }
        // 기간별매출 > 월별 탭 > 과면세별,포스별,코너별 탭
        if(data.gubun == "month" ||  data.gubun == "monthCorner") {
            params.yearMonth = data.yearMonth;
        }
        // 기간별매출 > 일자별 탭 > 포스별 탭
        if(data.gubun == "dayPos") {
            params.saleDate = data.saleDate;
            params.posNo  = data.posNo;
        }
        // 기간별매출 > 월별 탭 > 포스별 탭
        if(data.gubun == "monthPos") {
            params.yearMonth = data.yearMonth;
            params.posNo  = data.posNo;
        }
        // 기간별매출 > 일자별 탭 > 상품분류별 탭
        if(data.gubun == "dayProdClass") {
            params.saleDate = data.saleDate;
            params.strProdClassCd  = data.strProdClassCd;
            params.level = data.level;
            params.prodCd = data.prodCd;
            params.prodNm = data.prodNm;
            params.barCd = data.barCd;
            params.prodClassCd = data.prodClassCd;
        }
        // 기간별매출 > 월별 탭 > 상품분류별 탭
        if(data.gubun == "monthProdClass") {
            params.yearMonth = data.yearMonth;
            params.strProdClassCd  = data.strProdClassCd;
            params.level = data.level;
            params.prodCd = data.prodCd;
            params.prodNm = data.prodNm;
            params.barCd = data.barCd;
            params.prodClassCd = data.prodClassCd;
        }
        params.storeCds  = data.storeCd;
        params.gubun  = data.gubun;

        $scope._inquiryMain("/sale/cmmSalePopup/prodInfo/prodSaleDtl/list.sb", params, function() {}, false);
    };

}]);