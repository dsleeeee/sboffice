/****************************************************************
 *
 * 파일명 : sideMenuProdStore.js
 * 설  명 : 선택상품(매장별) 탭 JavaScript
 *
 *    수정일      수정자      Version        Function 명
 * ------------  ---------   -------------  --------------------
 * 2023.06.07     김설아      1.0
 *
 * **************************************************************/
/**
 * get application
 */
var app = agrid.getApp();

/**
 *  선택상품(매장별) 조회 그리드 생성
 */
app.controller('sideMenuProdStoreCtrl', ['$scope', '$http', '$timeout', function ($scope, $http, $timeout) {

    // 상위 객체 상속 : T/F 는 picker
    angular.extend(this, new RootController('sideMenuProdStoreCtrl', $scope, $http, false));

    // 콤보박스 셋팅
    $scope._setComboData("regYnCombo", regYnAllData); // 등록구분
    $scope._setComboData("regYnChgCombo", regYnData); // 일괄변경 - 등록구분

    // grid 초기화 : 생성되기전 초기화되면서 생성된다
    $scope.initGrid = function (s, e) {
        // 그리드 DataMap 설정
        $scope.regStoreFgDataMap = new wijmo.grid.DataMap(regStoreFgData, 'value', 'name'); // 적용매장구분
        $scope.regYnDataMap = new wijmo.grid.DataMap(regYnData, 'value', 'name'); // 등록구분

        // 그리드 값 변경 시 체크박스 체크
        s.cellEditEnded.addHandler(function (s, e) {
            if (e.panel === s.cells) {
                var col = s.columns[e.col];
                var item = s.rows[e.row].dataItem;
                if (col.binding === "regYn") {
                    item.gChk = true;
                }
            }
            s.collectionView.commitEdit();
        });
    };

    // <-- 검색 호출 -->
    $scope.$on("sideMenuProdStoreCtrl", function(event, data) {
        $scope.searchSideMenuProdStore();
        event.preventDefault();
    });

    $scope.searchSideMenuProdStore = function() {
        if($("#sideMenuProdStoreStoreCd").val() == ""){
            $scope._popMsg(messages["cmm.require.selectStore"]); // 매장을 선택해 주세요.
            return false;
        }

        var params = {};
        params.storeCd = $("#sideMenuProdStoreStoreCd").val();
        // params.sdselGrpCd = $("#sideMenuProdStoreSdselGrpCd").val();
        params.regYn = $scope.regYn;

        $scope._inquiryMain("/base/prod/sideMenuStore/sideMenuProdStore/getSideMenuProdStoreList.sb", params, function() {}, false);
    };
    // <-- //검색 호출 -->

    // 선택그룹 선택 모듈 팝업 사용시 정의
    // 함수명 : 모듈에 넘기는 파라미터의 targetId + 'Show'
    // _broadcast : 모듈에 넘기는 파라미터의 targetId + 'Ctrl'
    // $scope.sideMenuProdStoreSdselGrpShow = function () {
    //     $scope._broadcast('sideMenuProdStoreSdselGrpCtrl');
    // };

    // 일괄적용
    $scope.batchChange = function(chgGubun) {
        if($scope.flex.rows.length <= 0) {
            $scope._popMsg(messages["cmm.empty.data"]);
            return false;
        }

        var params = new Array();
        for (var i = 0; i < $scope.flex.collectionView.items.length; i++) {
            if($scope.flex.collectionView.items[i].gChk) {
                params.push($scope.flex.collectionView.items[i]);
            }
        }
        if(params.length <= 0) {
            s_alert.pop(messages["cmm.not.select"]);
            return;
        }

        for (var i = 0; i < $scope.flex.collectionView.items.length; i++) {
            if($scope.flex.collectionView.items[i].gChk) {
                // 적용매장구분
                if(chgGubun == "regYnChg") {
                    $scope.flex.collectionView.items[i].regYn = $scope.regYnChg;
                }
            }
        }
        $scope.flex.refresh();
    };

    // 저장
    $scope.save = function() {
        if($scope.flex.rows.length <= 0) {
            $scope._popMsg(messages["cmm.empty.data"]);
            return false;
        }

        $scope._popConfirm(messages["cmm.choo.save"], function() {
            // 파라미터 설정
            var params = new Array();
            for (var i = 0; i < $scope.flex.collectionView.items.length; i++) {
                if($scope.flex.collectionView.items[i].gChk) {
                    params.push($scope.flex.collectionView.items[i]);
                }
            }

            // 저장기능 수행 : 저장URL, 파라미터, 콜백함수
            $scope._save("/base/prod/sideMenuStore/sideMenuProdStore/getSideMenuProdStoreSave.sb", params, function(){
                $scope.searchSideMenuProdStore();
            });
        });
    };

    // 엑셀다운로드
    $scope.excelDownload = function(){

        if ($scope.flex.rows.length <= 0) {
            $scope._popMsg(messages["excelUpload.not.downloadData"]);	//다운로드 할 데이터가 없습니다.
            return false;
        }

        $scope.$broadcast('loadingPopupActive', messages["cmm.progress"]); // 데이터 처리중 메시지 팝업 열기
        $timeout(function () {
            wijmo.grid.xlsx.FlexGridXlsxConverter.saveAsync($scope.flex, {
                includeColumnHeaders: true,
                includeCellStyles   : true,
                includeColumns      : function (column) {
                    // return column.visible;
                    return column.binding != 'gChk';
                }
            }, '매장별사이드관리_매장별(선택상품)' + getCurDateTime() + '.xlsx', function () {
                $timeout(function () {
                    $scope.$broadcast('loadingPopupInactive'); // 데이터 처리중 메시지 팝업 닫기
                }, 10);
            });
        }, 10);
    }

}]);