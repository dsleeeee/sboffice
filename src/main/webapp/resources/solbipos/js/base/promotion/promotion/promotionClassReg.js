/****************************************************************
 *
 * 파일명 : promotionClassReg.js
 * 설  명 : 프로모션 분류추가 팝업 JavaScript
 *
 *    수정일      수정자      Version        Function 명
 * ------------  ---------   -------------  --------------------
 * 2021.04.23     이다솜      1.0
 *
 * **************************************************************/

var app = agrid.getApp();

app.controller('promotionClassRegCtrl', ['$scope', '$http', function ($scope, $http) {

    angular.extend(this, new RootController('promotionClassRegCtrl', $scope, $http, false));

    // grid 초기화 : 생성되기전 초기화되면서 생성된다
    $scope.initGrid = function (s, e) {

    };

    // 팝업 오픈 시, 상품리스트 조회
    $scope.$on("promotionClassRegCtrl", function(event, data) {

        // 구매대상 선택값에 따라 조건수량 입력여부 결정
        $("#hdSelectProdDs2").val(data);

        // 구매대상 선택값이 전체구매, 일부구매(종류+수량)인 경우만 조건수량 입력가능
        var grid = wijmo.Control.getControl("#wjGridPromotionClassReg");
        var columns = grid.columns;
        if($("#hdSelectProdDs2").val() === "1" || $("#hdSelectProdDs2").val() === "2") {
            columns[3].visible = true;
        }else{
            columns[3].visible = false;
        }

        // 분류조회
        $scope.searchClass();
        event.preventDefault();
    });

    // 분류조회
    $scope.searchClass = function () {

        var params = {};
        params.promotionCd = $("#hdPromotionCd").val();
        params.prodClassCd = $("#srchClassCd").val();
        params.prodClassNm = $("#srchClassNm").val();

        $scope._inquirySub("/base/promotion/promotion/getClassList.sb", params, function () {});
    };

    // 조회
    $scope.btnSearchClass = function(){

        // 분류조회
        $scope.searchClass();
    };

    // 추가
    $scope.btnInsertClass = function () {

        // 파라미터 설정
        var params = new Array();

        // 구매대상 선택값이 전체구매, 일부구매(종류+수량)인 경우만 조건수량 체크
        if($("#hdSelectProdDs2").val() === "1" || $("#hdSelectProdDs2").val() === "2") {
            // 조건수량이 수정된 내역이 있는지 체크
            if ($scope.flex.collectionView.itemsEdited.length <= 0) {
                $scope._popMsg(messages["cmm.not.modify"]);
                return false;
            }
        }

        // 선택한 상품 또는 분류가 있는지 체크
        var chkCount = 0;
        for (var i = 0; i < $scope.flex.collectionView.itemsEdited.length; i++) {
            var item = $scope.flex.collectionView.itemsEdited[i];
            if(item.gChk === true) chkCount++;
        }

        if(chkCount === 0){
            $scope._popMsg("추가할 " + messages["promotion.class"] + "의 체크박스" + messages["promotion.chk.item"]); // 추가할 분류의 체크박스를을(를) 선택하세요.
            return false;
        }

        for (var i = 0; i < $scope.flex.collectionView.itemsEdited.length; i++) {

            var item = $scope.flex.collectionView.itemsEdited[i];

            // 구매대상 선택값이 전체구매, 일부구매(종류+수량)인 경우만 조건수량 체크
            if($("#hdSelectProdDs2").val() === "1" || $("#hdSelectProdDs2").val() === "2") {
                if (item.gChk === true && (item.prodQty === null || item.prodQty === "" || item.prodQty === "0" || item.prodQty === 0)) {
                    $scope._popMsg(messages["promotion.chk.classQty"]); // 선택한 분류의 조건수량을 반드시 입력하세요.
                    return false;
                }
            }

            if(item.gChk === true) {
                var obj = {};
                obj.status = "I";
                obj.promotionCd = $("#hdPromotionCd").val();
                obj.gubunDs = "2"; // 상품 : 1 , 분류 : 2
                obj.prodClassCd = item.prodClassCd;

                // 구매대상 선택값이 전체구매, 일부구매(종류+수량)인 경우만 조건수량 입력
                if($("#hdSelectProdDs2").val() === "1" || $("#hdSelectProdDs2").val() === "2") {
                    obj.prodQty = item.prodQty;
                }else{
                    obj.prodQty = 1;
                }

                params.push(obj);
            }
        }
        // 저장기능 수행 : 저장URL, 파라미터, 콜백함수
        $scope._save("/base/promotion/promotion/savePromotionProd.sb", params, function () {

            $scope.promotionClassRegLayer.hide(true);

            // 적용상품 목록 재조회
            $scope._pageView('promotionSelectProdGridCtrl', 1);

        });
    }

}]);