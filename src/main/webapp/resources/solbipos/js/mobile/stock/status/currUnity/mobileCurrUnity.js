/****************************************************************
 *
 * 파일명 : mobileCurrUnity.js
 * 설  명 : (모바일) 재고현황 > 본사매장통합현재고 JavaScript
 *
 *    수정일      수정자      Version        Function 명
 * ------------  ---------   -------------  --------------------
 * 2024.07.19     김유승      1.0
 *
 * **************************************************************/
/**
 * get application
 */
var app = agrid.getApp();

/** 본사매장통합현재고 그리드 controller */
app.controller('mobileCurrUnityCtrl', ['$scope', '$http', '$timeout', function ($scope, $http, $timeout) {
    // 상위 객체 상속 : T/F 는 picker
    angular.extend(this, new RootController('mobileCurrUnityCtrl', $scope, $http, true));


    //조회조건 콤보박스 데이터 Set
    $scope._setComboData("currUnityListScaleBox", gvListScaleBoxData);
    $scope.isMainSearch = false;
    $scope.isHqSearch = false;
    $scope.isStoreSearch = false;

    // grid 초기화 : 생성되기전 초기화되면서 생성된다
    $scope.initGrid = function (s, e) {
        // picker 사용시 호출 : 미사용시 호출안함
        // $scope._makePickColumns("mobileCurrUnityCtrl");

        // 그리드 링크 효과
        s.formatItem.addHandler(function (s, e) {
            if (e.panel === s.cells) {
                var col = s.columns[e.col];
                if ((col.binding === "hCurrQty" || col.binding === "mCurrQty") && s.cells.getCellData(e.row,e.col,false) != null ) { // 본사수량 클릭
                    wijmo.addClass(e.cell, 'wijLink');
                }
            }
        });

        // 그리드 클릭 이벤트
        s.addEventListener(s.hostElement, 'mousedown', function (e) {
            var ht = s.hitTest(e);
            if (ht.cellType === wijmo.grid.CellType.Cell) {
                var col         = ht.panel.columns[ht.col];
                var selectedRow = s.rows[ht.row].dataItem;
                if (col.binding === "hCurrQty") { // 본사수량 클릭
                    $("#currUnityHqDtl").show();
                    $("#currUnityStoreDtl").hide();
                    var params    = {};
                    params.prodCd   = selectedRow.prodCd;
                    $scope._broadcast('currUnityHqDtlSrchCtrl', params);

                } else if (col.binding === "mCurrQty") { // 매장수량 클릭
                    $("#currUnityStoreDtl").show();
                    $("#currUnityHqDtl").hide();
                    var params    = {};
                    params.prodCd   = selectedRow.prodCd;
                    $scope._broadcast('currUnityStoreDtlSrchCtrl', params);
                }
            }
        });

        // add the new GroupRow to the grid's 'columnFooters' panel
        s.columnFooters.rows.push(new wijmo.grid.GroupRow());
        // add a sigma to the header to show that this is a summary row
        s.bottomLeftCells.setCellData(0, 0, '합계');
    };

    // 다른 컨트롤러의 broadcast 받기
    $scope.$on("mobileCurrUnityCtrl", function (event, data) {
        $scope.searchMobileCurrUnityList(true);
        // 기능수행 종료 : 반드시 추가
        event.preventDefault();
    });

//다른 컨트롤러의 broadcast 받기
    $scope.$on("mobileCurrUnitySrchCtrl", function (event, data) {
        $scope.searchMobileCurrUnityList(false);
        // 기능수행 종료 : 반드시 추가
        event.preventDefault();
    });

    // 본사매장통합현재고 리스트 조회
    $scope.searchMobileCurrUnityList = function (isPageChk) {
        // 파라미터
        var params     = {};
        params.prodCd = $("#srchProdCd").val();
        params.prodNm = $("#srchProdNm").val();
        params.barcdCd = $("#srchBarcdCd").val();
        params.vendrCd = $("#currUnitySelectVendrCd").val();
        params.prodClassCd = $scope.prodClassCd;
        params.isPageChk   = isPageChk;
        params.listScale = $scope.listScaleCombo.text;

        $scope.excelMainProdCd		= params.prodCd;
        $scope.excelMainProdNm		= params.prodNm;
        $scope.excelMainBarcdCd		= params.barcdCd;
        $scope.excelMainVendrCd		= params.vendrCd;
        $scope.excelMainProdClassCd	= params.prodClassCd;
        $scope.excelMainListScale	= params.listScale;

        $scope.isMainSearch = true;


        // 조회 수행 : 조회URL, 파라미터, 콜백함수
        $scope._inquirySub("/mobile/stock/status/currUnity/mobileCurrUnity/getCurrUnityList.sb", params, function (){
            gridShowMsgNoData("mobileCurrUnity1", $scope.flex, "Y");
        }, true);

        //메인그리드 조회후 상세그리드 조회.
        $scope.loadedRows = function(sender, args){
            var rows = sender.rows;

            var params       = {};
            if(rows.length > 0){
                params.prodCd   = rows[0].dataItem.prodCd;
                $scope._broadcast("currUnityHqDtlSrchCtrl", params);
                // 본사수량 상세조회.
//	        $scope._broadcast("currUnityHqDtlSrchCtrl", params);
            } else{
                // 메인그리드 조회 후 본사수량 상세조회 그리드 초기화
                //params.prodCd = -1;
                var orderDtlScope = agrid.getScope('mobileCurrUnityHqDtlCtrl');
                orderDtlScope.dtlGridDefault();
            }


        }
    };

    // 상품분류정보 팝업
    $scope.popUpProdClass = function () {
        var popUp = $scope.prodClassPopUpLayer;
        popUp.show(true, function (s) {
            // 선택 버튼 눌렀을때만
            if (s.dialogResult === "wj-hide-apply") {
                var scope          = agrid.getScope('prodClassPopUpCtrl');
                var prodClassCd    = scope.getSelectedClass();
                var params         = {};
                params.prodClassCd = prodClassCd;
                // 조회 수행 : 조회URL, 파라미터, 콜백함수
                $scope._postJSONQuery.withPopUp("/popup/getProdClassCdNm.sb", params,
                    function (response) {
                        $scope.prodClassCd   = prodClassCd;
                        $scope.prodClassCdNm = response.data.data;
                    }
                );
            }
        });
    };

    //상품분류정보 선택취소
    $scope.delProdClass = function(){
        $scope.prodClassCd = "";
        $scope.prodClassCdNm = "";
    }

    //상품분류 항목표시 체크에 따른 대분류, 중분류, 소분류 표시
    $scope.isChkProdClassDisplay = function(){
        var columns = $scope.flex.columns;

        for(var i=0; i<columns.length; i++){
            if(columns[i].binding === 'prodClassNm'){
                $scope.ChkProdClassDisplay ? columns[i].visible = true : columns[i].visible = false;
            }
        }
    }

    // 거래처선택 모듈 팝업 사용시 정의
    // 함수명 : 모듈에 넘기는 파라미터의 targetId + 'Show'
    // _broadcast : 모듈에 넘기는 파라미터의 targetId + 'Ctrl'
    $scope.currUnitySelectVendrShow = function () {
        $scope._broadcast('currUnitySelectVendrCtrl');
    };

    //엑셀 다운로드1
    $scope.excelDownload = function () {
        // 파라미터
        var params     = {};

        $scope._broadcast('mobileCurrUnityMainExcelCtrl',params);
    };

}]);

/** 본사매장통합현재고 우측 본사 수불수량 그리드 controller */
app.controller('mobileCurrUnityHqDtlCtrl', ['$scope', '$http', '$timeout', function ($scope, $http, $timeout) {
    // 상위 객체 상속 : T/F 는 picker
    angular.extend(this, new RootController('mobileCurrUnityHqDtlCtrl', $scope, $http, true));

    //조회조건 콤보박스 데이터 Set
    $scope._setComboData("currUnityHqDtlListScaleBox", gvListScaleBoxData);

    // 다른 컨트롤러의 broadcast 받기
    $scope.$on("mobileCurrUnityHqDtlCtrl", function (event, data) {
        $scope.searchMobileCurrUnityHqDtlList(true);
        // 기능수행 종료 : 반드시 추가
        event.preventDefault();
    });

    //다른 컨트롤러의 broadcast 받기
    $scope.$on("currUnityHqDtlSrchCtrl", function (event, data) {
        $scope.srchProdCd   = data.prodCd;

        $scope.searchMobileCurrUnityHqDtlList(false);
        // 기능수행 종료 : 반드시 추가
        event.preventDefault();
    });

    // 본사매장통합현재고 리스트 조회
    $scope.searchMobileCurrUnityHqDtlList = function (isPageChk) {
        // 파라미터
        var params     = {};
        params.isPageChk = isPageChk;
        params.prodCd      =	$scope.srchProdCd;

        $scope.excelHqProdCd	= params.prodCd;

        $scope.isHqSearch = true;

        // 조회 수행 : 조회URL, 파라미터, 콜백함수
        $scope._inquirySub("/mobile/stock/status/currUnity/mobileCurrUnity/getCurrUnityHqDtlList.sb", params, function (){
            gridShowMsgNoData("mobileCurrUnity2", $scope.flex, "N");
        },false);
    };

    //상세 그리드 초기화
    $scope.dtlGridDefault = function () {
        $timeout(function () {
            var cv          = new wijmo.collections.CollectionView([]);
            cv.trackChanges = true;
            $scope.data     = cv;
            $scope.flex.refresh();
            $scope.isHqSearch = false;
        }, 10);
    };

    //엑셀 다운로드2
    $scope.excelDownload = function () {
        // 파라미터
        var params     = {};

        $scope._broadcast('mobileCurrUnityHqDtlExcelCtrl',params);
    };

}]);

/** 본사매장통합현재고 우측 매장 수불수량 그리드 controller */
app.controller('mobileCurrUnityStoreDtlCtrl', ['$scope', '$http', '$timeout', function ($scope, $http, $timeout) {
    // 상위 객체 상속 : T/F 는 picker
    angular.extend(this, new RootController('mobileCurrUnityStoreDtlCtrl', $scope, $http, true));

    //조회조건 콤보박스 데이터 Set
    $scope._setComboData("currUnityStoreDtlListScaleBox", gvListScaleBoxData);
    // grid 초기화 : 생성되기전 초기화되면서 생성된다
    $scope.initGrid = function (s, e) {
        // picker 사용시 호출 : 미사용시 호출안함
        $scope._makePickColumns("mobileCurrUnityStoreDtlCtrl");
        // add the new GroupRow to the grid's 'columnFooters' panel
        s.columnFooters.rows.push(new wijmo.grid.GroupRow());
        // add a sigma to the header to show that this is a summary row
        s.bottomLeftCells.setCellData(0, 0, '합계');
    };

    // 다른 컨트롤러의 broadcast 받기
    $scope.$on("mobileCurrUnityStoreDtlCtrl", function (event, data) {
        $scope.searchMobileCurrUnityStoreDtlList(true);
        // 기능수행 종료 : 반드시 추가
        event.preventDefault();
    });

    //다른 컨트롤러의 broadcast 받기
    $scope.$on("currUnityStoreDtlSrchCtrl", function (event, data) {
        $scope.srchProdCd   = data.prodCd;

        $scope.searchMobileCurrUnityStoreDtlList(false);
        // 기능수행 종료 : 반드시 추가
        event.preventDefault();
    });

    // 본사매장통합현재고 리스트 조회
    $scope.searchMobileCurrUnityStoreDtlList = function (isPageChk) {
        // 파라미터
        var params     = {};
        params.isPageChk = isPageChk;
        params.prodCd      =	$scope.srchProdCd;

        $scope.excelStoreProdCd		= params.prodCd;

        $scope.isStoreSearch = true;

        // 조회 수행 : 조회URL, 파라미터, 콜백함수
        $scope._inquirySub("/mobile/stock/status/currUnity/mobileCurrUnity/getCurrUnityStoreDtlList.sb", params, function (){
            gridShowMsgNoData("mobileCurrUnity3", $scope.flex, "Y");
        }, false);
    };

    //엑셀 다운로드3
    $scope.excelDownload = function () {
        // 파라미터
        var params     = {};

        $scope._broadcast('mobileCurrUnityStoreDtlExcelCtrl',params);
    };

//상세 그리드 초기화
    $scope.dtlGridDefault = function () {
        $timeout(function () {
            var cv          = new wijmo.collections.CollectionView([]);
            cv.trackChanges = true;
            $scope.data     = cv;
            $scope.flex.refresh();
            $scope.isStoreSearch = false;
        }, 10);
    };

}]);

// 엑셀 전체 다운 컨트롤러1
app.controller('mobileCurrUnityMainExcelCtrl', ['$scope', '$http', '$timeout', function ($scope, $http, $timeout) {

    // 상위 객체 상속 : T/F 는 picker
    angular.extend(this, new RootController('mobileCurrUnityMainExcelCtrl', $scope, $http, $timeout, true));

    var checkInt = true;

    // grid 초기화 : 생성되기전 초기화되면서 생성된다
    $scope.initGrid = function (s, e) {
        // add the new GroupRow to the grid's 'columnFooters' panel
        s.columnFooters.rows.push(new wijmo.grid.GroupRow());
        // add a sigma to the header to show that this is a summary row
        s.bottomLeftCells.setCellData(0, 0, '합계');
    };

    // 다른 컨트롤러의 broadcast 받기
    $scope.$on("mobileCurrUnityMainExcelCtrl", function (event, data) {
        if(data != undefined && $scope.isMainSearch) {
            $scope.searchMobileCurrUnityExcelList(true);
            // 기능수행 종료 : 반드시 추가
            event.preventDefault();
        } else{
            $scope._popMsg(messages["excelUpload.not.downloadData"]); // 다운로드 할 데이터가 없습니다.
            return false;
        }

    });

    //상품분류 항목표시 체크에 따른 대분류, 중분류, 소분류 표시
    $scope.isChkProdClassDisplay = function(){
        var columns = $scope.mainExcelFlex.columns;

        for(var i=0; i<columns.length; i++){
            if(columns[i].binding === 'prodClassNm'){
                $scope.ChkProdClassDisplay ? columns[i].visible = true : columns[i].visible = false;
            }
        }
    };

    // 전체 엑셀 리스트 조회
    $scope.searchMobileCurrUnityExcelList = function (isPageChk) {// 파라미터

        // 파라미터
        var params     = {};
        params.prodCd = $scope.excelMainProdCd;
        params.prodNm = $scope.excelMainProdNm;
        params.barcdCd = $scope.excelMainBarcdCd;
        params.vendrCd = $scope.excelMainVendrCd;
        params.prodClassCd = $scope.excelMainProdClassCd;
        params.listScale = $scope.excelMainListScale;

        $scope.isChkProdClassDisplay();

        // 조회 수행 : 조회URL, 파라미터, 콜백함수
        $scope._inquiryMain("/mobile/stock/status/currUnity/mobileCurrUnity/getCurrUnityExcelList.sb", params, function(){
            if ($scope.mainExcelFlex.rows.length <= 0 || !$scope.isMainSearch) {
                $scope._popMsg(messages["excelUpload.not.downloadData"]); // 다운로드 할 데이터가 없습니다.
                return false;
            }

            $scope.$broadcast('loadingPopupActive', messages["cmm.progress"]); // 데이터 처리중 메시지 팝업 오픈
            $timeout(function () {
                wijmo.grid.xlsx.FlexGridXlsxConverter.saveAsync($scope.mainExcelFlex, {
                    includeColumnHeaders: true,
                    includeCellStyles   : true,
                    includeColumns      : function (column) {
                        return column.visible;
                    }
                }, '재고현황_본사매장통합현재고_'+getToday()+'.xlsx', function () {
                    $timeout(function () {
                        $scope.$broadcast('loadingPopupInactive'); // 데이터 처리중 메시지 팝업 닫기
                    }, 10);
                });
            }, 10);
        });
    };

}]);

// 엑셀 전체 다운 컨트롤러2
app.controller('mobileCurrUnityHqDtlExcelCtrl', ['$scope', '$http', '$timeout', function ($scope, $http, $timeout) {

    // 상위 객체 상속 : T/F 는 picker
    angular.extend(this, new RootController('mobileCurrUnityHqDtlExcelCtrl', $scope, $http, $timeout, true));

    var checkInt = true;

    // grid 초기화 : 생성되기전 초기화되면서 생성된다
    $scope.initGrid = function (s, e) {
        // add the new GroupRow to the grid's 'columnFooters' panel
        s.columnFooters.rows.push(new wijmo.grid.GroupRow());
        // add a sigma to the header to show that this is a summary row
        s.bottomLeftCells.setCellData(0, 0, '합계');
    };

    // 다른 컨트롤러의 broadcast 받기
    $scope.$on("mobileCurrUnityHqDtlExcelCtrl", function (event, data) {
        if(data != undefined) {
            $scope.isPageChk = data.isPageChk;
            $scope.prodCd = data.prodCd;

            $scope.searchMobileCurrUnityHqDtlExcelList(true);
            // 기능수행 종료 : 반드시 추가
            event.preventDefault();

        }
    });

    // 전체 엑셀 리스트 조회
    $scope.searchMobileCurrUnityHqDtlExcelList = function (isPageChk) {// 파라미터

        // 파라미터
        var params     = {};
        params.isPageChk = isPageChk;
        params.prodCd      =	$scope.srchProdCd;

        // 조회 수행 : 조회URL, 파라미터, 콜백함수
        $scope._inquiryMain("/mobile/stock/status/currUnity/mobileCurrUnity/getCurrUnityHqDtlExcelList.sb", params, function(){
            if ($scope.HqDtlExcelFlex.rows.length <= 0 || !$scope.isHqSearch) {
                $scope._popMsg(messages["excelUpload.not.downloadData"]); // 다운로드 할 데이터가 없습니다.
                return false;
            }

            $scope.$broadcast('loadingPopupActive', messages["cmm.progress"]); // 데이터 처리중 메시지 팝업 오픈
            $timeout(function () {
                wijmo.grid.xlsx.FlexGridXlsxConverter.saveAsync($scope.HqDtlExcelFlex, {
                    includeColumnHeaders: true,
                    includeCellStyles   : true,
                    includeColumns      : function (column) {
                        return column.visible;
                    }
                }, '재고현황_본사매장통합현재고_본사재고수량_'+getToday()+'.xlsx', function () {
                    $timeout(function () {
                        $scope.$broadcast('loadingPopupInactive'); // 데이터 처리중 메시지 팝업 닫기
                    }, 10);
                });
            }, 10);
        });
    };

}]);


//엑셀 전체 다운 컨트롤러3
app.controller('mobileCurrUnityStoreDtlExcelCtrl', ['$scope', '$http', '$timeout', function ($scope, $http, $timeout) {

    // 상위 객체 상속 : T/F 는 picker
    angular.extend(this, new RootController('mobileCurrUnityStoreDtlExcelCtrl', $scope, $http, $timeout, true));

    var checkInt = true;

    // grid 초기화 : 생성되기전 초기화되면서 생성된다
    $scope.initGrid = function (s, e) {
        // add the new GroupRow to the grid's 'columnFooters' panel
        s.columnFooters.rows.push(new wijmo.grid.GroupRow());
        // add a sigma to the header to show that this is a summary row
        s.bottomLeftCells.setCellData(0, 0, '합계');
    };

    // 다른 컨트롤러의 broadcast 받기
    $scope.$on("mobileCurrUnityStoreDtlExcelCtrl", function (event, data) {
        if(data != undefined) {
            $scope.isPageChk = data.isPageChk;
            $scope.prodCd = data.prodCd;

            $scope.searchMobileCurrUnityStoreDtlExcelList(true);
            // 기능수행 종료 : 반드시 추가
            event.preventDefault();

        }
    });

    // 전체 엑셀 리스트 조회
    $scope.searchMobileCurrUnityStoreDtlExcelList = function (isPageChk) {// 파라미터
        // 파라미터
        var params     = {};
        params.isPageChk = isPageChk;
        params.prodCd      =	$scope.srchProdCd;

        // 조회 수행 : 조회URL, 파라미터, 콜백함수
        $scope._inquirySub("/mobile/stock/status/currUnity/mobileCurrUnity/getCurrUnityStoreDtlExcelList.sb", params, function(){
            if ($scope.storeDtlExcelFlex.rows.length <= 0 || !$scope.isStoreSearch) {
                $scope._popMsg(messages["excelUpload.not.downloadData"]); // 다운로드 할 데이터가 없습니다.
                return false;
            }

            $scope.$broadcast('loadingPopupActive', messages["cmm.progress"]); // 데이터 처리중 메시지 팝업 오픈
            $timeout(function () {
                wijmo.grid.xlsx.FlexGridXlsxConverter.saveAsync($scope.storeDtlExcelFlex, {
                    includeColumnHeaders: true,
                    includeCellStyles   : true,
                    includeColumns      : function (column) {
                        return column.visible;
                    }
                }, '재고현황_본사매장통합현재고_매장재고수량'+getToday()+'.xlsx', function () {
                    $timeout(function () {
                        $scope.$broadcast('loadingPopupInactive'); // 데이터 처리중 메시지 팝업 닫기
                    }, 10);
                });
            }, 10);
        });
    };

}]);