/****************************************************************
 *
 * 파일명 : coupon.js
 * 설  명 : 쿠폰등록 JavaScript
 *
 *    수정일      수정자      Version        Function 명
 * ------------  ---------   -------------  --------------------
 * 2018.08.13     김지은      1.0
 *
 * **************************************************************/
/**
 * get application
 */
var app = agrid.getApp();
var selectedCouponClass;

/**
 *  쿠폰분류등록 그리드 생성
 */
app.controller('couponClassCtrl', ['$scope', '$http', function ($scope, $http) {
  // 상위 객체 상속 : T/F 는 picker
  angular.extend(this, new RootController('couponClassCtrl', $scope, $http, true));
  // grid 초기화 : 생성되기전 초기화되면서 생성된다
  $scope.initGrid = function (s, e) {
    // 그리드 DataMap 설정
    $scope.useYnDataMap = new wijmo.grid.DataMap(useYn, 'value', 'name');
    $scope.coupnDcFgDataMap = new wijmo.grid.DataMap(coupnDcFg, 'value', 'name');
    $scope.coupnApplyFgDataMap = new wijmo.grid.DataMap(coupnApplyFg, 'value', 'name');

    // ReadOnly 효과설정
    s.formatItem.addHandler(function (s, e) {
      if (e.panel === s.cells) {
        var col = s.columns[e.col];
        var item = s.rows[e.row].dataItem;
        if (col.binding === "payClassCd") {
          wijmo.addClass(e.cell, 'wijLink');
        }
      }
    });

    // 쿠폰분류 그리드 선택 이벤트
    s.addEventListener(s.hostElement, 'mousedown', function(e) {
      var ht = s.hitTest(e);
      if( ht.cellType === wijmo.grid.CellType.Cell) {
        var col = ht.panel.columns[ht.col];
        var selectedRow = s.rows[ht.row].dataItem;
        if ( col.binding === "payClassCd" && selectedRow.status !== "I") {
          if(selectedRow.status === "I") {
            e.cancel = false;
          } else if(selectedRow.useYn === "N") {
            s_alert.pop(messages["coupon.not.use.payClassCd"]);
            var couponGrid = agrid.getScope('couponCtrl');
            couponGrid._gridDataInit();
            return;
          } else {
            $("#couponSubTitle").text(" [" + selectedRow.payClassNm+ "]");
            $scope._broadcast('couponCtrl', selectedRow);
          }
        }
      }
    });

    // 쿠폰 분류 그리드 조회 후에 dropdown readonly 되는 것 방지
    s.beginningEdit.addHandler(function (s, e) {
      var col = s.columns[e.col];
      if (col.binding === "serNoYn" || col.binding === "useYn") {
          e.cancel = false;
      }
    });

    // 조회 이벤트 발생
    setTimeout(function() {
      $scope._broadcast('couponClassCtrl', true);
    }, 100)
  };

  $scope.$on("couponClassCtrl", function(event, data) {
    $scope.searchCouponClass();
    event.preventDefault();
  });

  // 쿠폰 분류 그리드 조회
  $scope.searchCouponClass = function(){
    // 파라미터
    var params = {};
    params.coupnEnvstVal = coupnEnvstVal;

    // 조회 수행 : 조회URL, 파라미터, 콜백함수, 팝업결과표시여부
    $scope._inquirySub(baseUrl + "class/getCouponClassList.sb", params, function() {}, false);
  };

  // 쿠폰 분류 그리드 행 추가
  $scope.addRow = function() {
    // 파라미터 설정
    var params = {};
    params.status = "I";
    params.gChk = true;
    params.payClassCd="자동채번"
    params.serNoYn = "Y";
    params.useYn = "Y";

    // 추가기능 수행 : 파라미터
    $scope._addRow(params);
  };

  // 쿠폰 분류 그리드 행 삭제
  // $scope.del = function(){
  //   for (var i = 0; i < $scope.flex.collectionView.items.length; i++) {
  //     var item = $scope.flex.collectionView.items[i];
  //
  //     if(item.gChk) {
  //       if(item.couponCnt > 0) {
  //         // s_alert.pop("<s:message code='coupon.exists.coupon' />");
  //         s_alert.pop("해당분류에 등록된 쿠폰이 존재합니다. 분류 삭제 전에 등록 쿠폰을 먼저 삭제해주세요.");
  //         return;
  //       }
  //       $scope.flex.collectionView.removeAt(i);
  //     }
  //   }
  // };

  // 쿠폰분류 그리드 저장
  $scope.save = function() {
    // 파라미터 설정
    var params = new Array();
    for (var i = 0; i < $scope.flex.collectionView.itemsEdited.length; i++) {
      $scope.flex.collectionView.itemsEdited[i].status = "U";
      $scope.flex.collectionView.itemsEdited[i].coupnEnvstVal = coupnEnvstVal;
      params.push($scope.flex.collectionView.itemsEdited[i]);
    }
    for (var i = 0; i < $scope.flex.collectionView.itemsAdded.length; i++) {
      $scope.flex.collectionView.itemsAdded[i].status = "I";
      $scope.flex.collectionView.itemsAdded[i].coupnEnvstVal = coupnEnvstVal;
      params.push($scope.flex.collectionView.itemsAdded[i]);
    }
    for (var i = 0; i < $scope.flex.collectionView.itemsRemoved.length; i++) {
      $scope.flex.collectionView.itemsRemoved[i].status = "D";
      $scope.flex.collectionView.itemsRemoved[i].coupnEnvstVal = coupnEnvstVal;
      params.push($scope.flex.collectionView.itemsRemoved[i]);
    }

    // 저장기능 수행 : 저장URL, 파라미터, 콜백함수
    $scope._save(baseUrl + "class/saveCouponClassList.sb", params, function(){ $scope.allSearch() });
  };

  // 쿠폰 삭제 완료 후처리 (쿠폰분류 재조회)
  $scope.allSearch = function () {
    $scope.searchCouponClass();
  };
}]);


/**
 * 쿠폰 그리드 생성
 */
app.controller('couponCtrl', ['$scope', '$http', function ($scope, $http) {
  // 상위 객체 상속 : T/F 는 picker
  angular.extend(this, new RootController('couponCtrl', $scope, $http, false));
  // grid 초기화 : 생성되기전 초기화되면서 생성된다
  $scope.initGrid = function (s, e) {
    // 그리드 DataMap 설정
    $scope.useYnDataMap = new wijmo.grid.DataMap(useYn, 'value', 'name');
    $scope.coupnDcFgDataMap = new wijmo.grid.DataMap(coupnDcFg, 'value', 'name');
    $scope.coupnApplyFgDataMap = new wijmo.grid.DataMap(coupnApplyFg, 'value', 'name');

    // ReadOnly 효과설정
    s.formatItem.addHandler(function (s, e) {
      if (e.panel === s.cells) {
        var col = s.columns[e.col];
        if (col.binding === "coupnCd") {
          wijmo.addClass(e.cell, 'wj-custom-readonly');
        }
        else if (col.binding === "prodCnt" || col.binding === "storeCnt") {
          wijmo.addClass(e.cell, 'wijLink');
        }
      }
    });
    // 쿠폰 그리드 에디팅 방지
    s.beginningEdit.addHandler(function (s, e) {
      var col = s.columns[e.col];
      var dataItem = s.rows[e.row].dataItem;

      // 쿠폰 코드는 입력 불가능
      if (col.binding === "coupnCd") {
        e.cancel = false;
      }
      // 데이터 조회 후 dropdown 이 readonly 되는 문제
      if (col.binding === "coupnDcFg" || col.binding === "coupnApplyFg" || col.binding === "useYn") {
        e.cancel = false;
      }
      // 상품수량과 적용매장수는 수정할 수 없음.
      if (col.binding === "prodCnt" || col.binding === "storeCnt" ) {
        e.cancel = true;
      }
      // 할인구분 => 금액 관련이면, 할인율은 입력못함
      if(e.col === 6) {
        if(dataItem.coupnDcFg === "3" || dataItem.coupnDcFg === "4" || dataItem.coupnDcFg === "6") {
          e.cancel = true;
        } else {
          e.cancel = false;
        }
      }
      // 할인구분 => % 관련이면, 할인금액 입력못함
      if(e.col === 7) {
        if(dataItem.coupnDcFg === "1" || dataItem.coupnDcFg === "2") {
          e.cancel = true;
        } else {
          e.cancel = false;
        }
      }
    });

    // 할인구분에 따라 %와 금액 초기화
    s.cellEditEnded.addHandler(function (s, e) {
      var col = s.columns[e.col];
      var dataItem = s.rows[e.row].dataItem;

      if(col.binding === "coupnDcFg") {
        // 할인구분 => 금액 관련이면, 할인율은 입력못함
        if(dataItem.coupnDcFg === "3" || dataItem.coupnDcFg === "4" || dataItem.coupnDcFg === "6") {
          dataItem.coupnDcRate = "";
        }
        // 할인구분 => % 관련이면, 할인금액 입력못함
        else if(dataItem.coupnDcFg === "1" || dataItem.coupnDcFg === "2") {
          dataItem.coupnDcAmt = "";
        }
      }
    });

    // 쿠폰 그리드 선택 이벤트
    s.addEventListener(s.hostElement, 'mousedown', function(e) {
      var ht = s.hitTest(e);
      if( ht.cellType === wijmo.grid.CellType.Cell) {
        var col = ht.panel.columns[ht.col];
        var selectedRow = s.rows[ht.row].dataItem;

        if ( col.binding === "prodCnt" && selectedRow.status !== "I") {
          // 상품 등록 팝업
          var popup = $scope.couponPordLayer;
          popup.show(true, function (s) {
            var regProdGrid = agrid.getScope('regProdCtrl');
            regProdGrid._gridDataInit();
            var noRegProdGrid = agrid.getScope('noRegProdCtrl');
            noRegProdGrid._gridDataInit();
          });
        }
        else if ( col.binding === "storeCnt" && selectedRow.status !== "I") {
          // 매장 등록 팝업
          var popup = $scope.couponStoreLayer;
          popup.show(true, function (s) {
            var regStoreGrid = agrid.getScope('regStoreCtrl');
            regStoreGrid._gridDataInit();
            var noRegStoreGrid = agrid.getScope('noRegStoreCtrl');
            noRegStoreGrid._gridDataInit();
          });

        }
      }
    });
  };

  $scope.$on("couponCtrl", function(event, data) {
    selectedCouponClass = data;

    $scope.searchCoupon(data);
    // 기능수행 종료 : 반드시 추가
    event.preventDefault();
  });

  // 쿠폰 그리드 조회
  $scope.searchCoupon = function(data){
    var params = {};
    params.coupnEnvstVal = coupnEnvstVal;
    params.payClassCd = data.payClassCd;
    // 조회 수행 : 조회URL, 파라미터, 콜백함수, 팝업결과표시여부
    $scope._inquirySub(baseUrl + "class/getCouponList.sb", params, function(){}, false);
  };

  // 쿠폰 그리드 행 추가
  $scope.addRow = function() {
    var gridRepresent = agrid.getScope("couponClassCtrl");
    var selectedRow = gridRepresent.flex.selectedRows[0]._data;

    // 파라미터 설정
    var params = {};
    params.status = "I";
    params.gChk = true;
    params.coupnCd="자동채번"
    params.coupnDcFg = "1";
    params.coupnApplyFg = "1";
    params.useYn = "Y";
    params.prodCnt = "0";
    params.storeCnt = "0";
    params.payClassCd = selectedRow.payClassCd;

    // 추가기능 수행 : 파라미터
    $scope._addRow(params);
  };

  // 쿠폰 그리드 행 삭제
  $scope.del = function(){
    for (var i = 0; i < $scope.flex.collectionView.items.length; i++) {
      var item = $scope.flex.collectionView.items[i];

      if(item.gChk) {
        if(item.prodCnt > 0 ) {
          // s_alert.pop("<s:message code='coupon.exists.prod' />");
          s_alert.pop("쿠폰이 등록된 상품이 존재합니다. 쿠폰 삭제 전에 등록 상품을 먼저 삭제해주세요.");
          return;
        }
        if(orgnFg === "HQ") {
          if(item.storeCd > 0 ) {
            // s_alert.pop("<s:message code='coupon.exists.store' />");
            s_alert.pop("쿠폰이 등록된 매장이 존재합니다. 쿠폰 삭제 전에 등록 매장을 먼저 삭제해주세요.");
            return;
          }
        }
        $scope.flex.collectionView.removeAt(i);
      }
    }
  };

  // 쿠폰 저장
  $scope.save = function() {
    // 파라미터 설정
    var params = new Array();
    for (var i = 0; i < $scope.flex.collectionView.itemsEdited.length; i++) {
      $scope.flex.collectionView.itemsEdited[i].status = "U";
      $scope.flex.collectionView.itemsEdited[i].coupnEnvstVal = coupnEnvstVal;
      params.push($scope.flex.collectionView.itemsEdited[i]);
    }
    for (var i = 0; i < $scope.flex.collectionView.itemsAdded.length; i++) {
      $scope.flex.collectionView.itemsAdded[i].status = "I";
      $scope.flex.collectionView.itemsAdded[i].coupnEnvstVal = coupnEnvstVal;
      params.push($scope.flex.collectionView.itemsAdded[i]);
    }

    for (var i = 0; i < $scope.flex.collectionView.itemsRemoved.length; i++) {
      $scope.flex.collectionView.itemsRemoved[i].status = "D";
      $scope.flex.collectionView.itemsRemoved[i].coupnEnvstVal = coupnEnvstVal;
      params.push($scope.flex.collectionView.itemsRemoved[i]);
    }

    // 저장기능 수행 : 저장URL, 파라미터, 콜백함수
    $scope._save(baseUrl + "class/saveCouponList.sb", params, function(){ $scope.allSearch() });
  };

  // 저장 완료 후처리 (쿠폰분류, 쿠폰 재조회)
  $scope.allSearch = function () {
    var couponClassGrid = agrid.getScope("couponClassCtrl");
    couponClassGrid.searchCouponClass();
    $scope.searchCoupon(selectedCouponClass);
  };

}]);

// 탭 클릭
$("#couponStoreTab").click(function(){
  location.href = "/base/pay/coupon/store/couponStoreView.sb";
});


