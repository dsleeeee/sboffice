/****************************************************************
 *
 * 파일명 : promotionProdReg.js
 * 설  명 : 프로모션 상품추가 팝업 JavaScript
 *
 *    수정일      수정자      Version        Function 명
 * ------------  ---------   -------------  --------------------
 * 2021.04.22     이다솜      1.0
 *
 * **************************************************************/

var app = agrid.getApp();

app.controller('promotionProdRegCtrl', ['$scope', '$http', function ($scope, $http) {

    angular.extend(this, new RootController('promotionProdRegCtrl', $scope, $http, false));

    // 사용여부 조회조건 콤보박스 데이터 Set
    $scope._setComboData("prodUseYnAll", useYnAllFgData);

    // grid 초기화 : 생성되기전 초기화되면서 생성된다
    $scope.initGrid = function (s, e) {

        $scope.prodUseYnFgDataMap = new wijmo.grid.DataMap(useYnFgData, 'value', 'name'); //사용여부

    };

    // 팝업 오픈 시, 상품리스트 조회
    $scope.$on("promotionProdRegCtrl", function(event, data) {

        // 상품조회
        $scope.searchProd();
        event.preventDefault();

    });

    // 상품조회
    $scope.searchProd = function () {

        var params = {};
        params.promotionCd = $("#hdPromotionCd").val();
        params.prodCd = $("#srchProdCd").val();
        params.prodNm = $("#srchProdNm").val();
        params.useYn = $scope.srchProdUseYnCombo.selectedValue;

        $scope._inquirySub("/base/promotion/promotion/getProdList.sb", params, function () {});
    };

    // 조회
    $scope.btnSearchProd = function(){

        // 상품조회
        $scope.searchProd();
    };
    
    // 추가
    $scope.btnInsertProd = function () {

        // 파라미터 설정
        var params = new Array();

        // 조건수량이 수정된 내역이 있는지 체크
        if ($scope.flex.collectionView.itemsEdited.length <= 0) {
            $scope._popMsg(messages["cmm.not.modify"]);
            return false;
        }

        // 선택한 상품 또는 분류가 있는지 체크
        var chkCount = 0;
        for (var i = 0; i < $scope.flex.collectionView.itemsEdited.length; i++) {
            var item = $scope.flex.collectionView.itemsEdited[i];
            if(item.gChk === true) chkCount++;
        }

        if(chkCount === 0){
            $scope._popMsg("추가할 " + messages["promotion.product"] + "의 체크박스" + messages["promotion.chk.item"]); // 추가할 상품의 체크박스을(를) 선택하세요.
            return false;
        }

        for (var i = 0; i < $scope.flex.collectionView.itemsEdited.length; i++) {

            var item = $scope.flex.collectionView.itemsEdited[i];

            if (item.gChk === true && (item.prodQty === null || item.prodQty === "" || item.prodQty === "0" )) {
                $scope._popMsg(messages["promotion.chk.prodQty"]); // 선택한 상품의 조건수량을 반드시 입력하세요.
                return false;
            }

            if(item.gChk === true) {
                var obj = {};
                obj.status = "I";
                obj.promotionCd = $("#hdPromotionCd").val();
                obj.gubunDs = "1"; // 상품 : 1 , 분류 : 2
                obj.prodCd = item.prodCd;
                obj.prodQty =  item.prodQty;

                params.push(obj);
            }
        }
        // 저장기능 수행 : 저장URL, 파라미터, 콜백함수
        $scope._save("/base/promotion/promotion/savePromotionProd.sb", params, function () {

            $scope.promotionProdRegLayer.hide(true);

            // 적용상품 목록 재조회
            $scope._pageView('promotionSelectProdGridCtrl', 1);

        });
    }
    


}]);