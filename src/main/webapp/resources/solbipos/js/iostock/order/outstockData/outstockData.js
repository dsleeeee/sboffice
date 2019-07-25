/**
 * get application
 */
var app = agrid.getApp();

/** 출고자료생성 그리드 controller */
app.controller('outstockDataCtrl', ['$scope', '$http', function ($scope, $http) {
  // 상위 객체 상속 : T/F 는 picker
  angular.extend(this, new RootController('outstockDataCtrl', $scope, $http, true));

  $scope.slipFg     = 1;
  var srchStartDate = wcombo.genDateVal("#srchStartDate", gvStartDate);
  var srchEndDate   = wcombo.genDateVal("#srchEndDate", gvEndDate);
  var outDate       = wcombo.genDate("#outDate");

  // 그리드 DataMap 설정
  $scope.sysStatFgMap = new wijmo.grid.DataMap(sysStatFg, 'value', 'name');

  $scope._setComboData("srchDateFg", [
    {"name": messages["outstockData.reqDate"], "value": "req"},
    {"name": messages["outstockData.regDate"], "value": "reg"},
    {"name": messages["outstockData.modDate"], "value": "mod"}
  ]);

  // grid 초기화 : 생성되기전 초기화되면서 생성된다
  $scope.initGrid = function (s, e) {

    // picker 사용시 호출 : 미사용시 호출안함
    $scope._makePickColumns("outstockDataCtrl");

    // 그리드 링크 효과
    s.formatItem.addHandler(function (s, e) {
      if (e.panel === s.cells) {
        var col = s.columns[e.col];
        if (col.binding === "storeCd") { // 매장코드
          wijmo.addClass(e.cell, 'wijLink');
          wijmo.addClass(e.cell, 'wj-custom-readonly');
        }

        if (col.format === "date") {
          e.cell.innerHTML = getFormatDate(e.cell.innerText);
        }
        else if (col.format === "dateTime") {
          e.cell.innerHTML = getFormatDateTime(e.cell.innerText);
        }
      }
    });

    // 그리드 클릭 이벤트
    s.addEventListener(s.hostElement, 'mousedown', function (e) {
      var ht = s.hitTest(e);
      if (ht.cellType === wijmo.grid.CellType.Cell) {
        var col         = ht.panel.columns[ht.col];
        var selectedRow = s.rows[ht.row].dataItem;
        if (col.binding === "storeCd") { // 매장코드 클릭
          var params       = {};
          params.dateFg    = $scope.searchedDateFg;
          params.startDate = $scope.searchedStartDate;
          params.endDate   = $scope.searchedEndDate;
          params.storeCd   = selectedRow.storeCd;
          params.storeNm   = selectedRow.storeNm;
          params.slipFg    = $scope.slipFg;
          $scope._broadcast('outstockDataDtlCtrl', params);
        }
      }
    });

    // add the new GroupRow to the grid's 'columnFooters' panel
    s.columnFooters.rows.push(new wijmo.grid.GroupRow());
    // add a sigma to the header to show that this is a summary row
    s.bottomLeftCells.setCellData(0, 0, '합계');
  };

  // 다른 컨트롤러의 broadcast 받기
  $scope.$on("outstockDataCtrl", function (event, data) {
    $scope.searchOutstockDataList();
    // 기능수행 종료 : 반드시 추가
    event.preventDefault();
  });

  // 주문 리스트 조회
  $scope.searchOutstockDataList = function () {
    // 조회 당시의 조회일값 세팅
    $scope.searchedDateFg    = $scope.dateFg;
    $scope.searchedStartDate = wijmo.Globalize.format(srchStartDate.value, 'yyyyMMdd');
    $scope.searchedEndDate   = wijmo.Globalize.format(srchEndDate.value, 'yyyyMMdd');

    // 파라미터
    var params       = {};
    params.dateFg    = $scope.searchedDateFg;
    params.slipFg    = $scope.slipFg;
    params.startDate = $scope.searchedStartDate;
    params.endDate   = $scope.searchedEndDate;

    // 조회 수행 : 조회URL, 파라미터, 콜백함수
    $scope._inquiryMain("/iostock/order/outstockData/outstockData/list.sb", params);
  };

  $scope.saveValueCheck = function () {
    var params         = [];
    var sysStatFgCheck = true;
    var loanCheck      = true;

    if ($scope.flex.collectionView.itemsEdited.length <= 0) {
      $scope._popMsg(messages["cmm.not.modify"]);
      return false;
    }

    for (var i = 0; i < $scope.flex.collectionView.itemsEdited.length; i++) {
      var item = $scope.flex.collectionView.itemsEdited[i];

      if (item.gChk === true) {
        if (sysStatFgCheck && item.sysStatFg !== "1") {
          sysStatFgCheck = false;
        }
        if (loanCheck && item.availableOrderAmt !== null && (parseInt(item.dstbTot) > parseInt(item.availableOrderAmt))) {
          loanCheck = false;
        }
        item.status    = "U";
        item.dateFg    = $scope.searchedDateFg;
        item.startDate = $scope.searchedStartDate;
        item.endDate   = $scope.searchedEndDate;
        item.outDate   = wijmo.Globalize.format(outDate.value, 'yyyyMMdd');
        item.empNo     = "0000";
        item.storageCd = "001";
        item.hqBrandCd = "00"; // TODO 브랜드코드 가져오는건 우선 하드코딩으로 처리. 2018-09-13 안동관
        params.push(item);
      }
    }

    if (!sysStatFgCheck) {
      /** 선택하신 자료 중 매장상태가 오픈이 아닌 매장이 있습니다. 계속하시겠습니까? */
      var msg = messages["outstockData.sysStatFgCheck"];
      s_alert.popConf(msg, function () {
        $scope.loanCheckConfirm(loanCheck, params);
      });
      return false;
    }
    else {
      $scope.loanCheckConfirm(loanCheck, params);
    }
  };

  // 주문가능액 confirm
  $scope.loanCheckConfirm = function (loanCheck, params) {
    if (!loanCheck) {
      /** 선택하신 자료중 출고합계금액이 주문가능액보다 큰 매장이 있습니다. 계속하시겠습니까? */
      var msg = messages["outstockData.loanCheck"];
      s_alert.popConf(msg, function () {
        $scope.slipNoCreateConfirm(params);
      });
      return false;
    }
    else {
      $scope.slipNoCreateConfirm(params);
    }
  };

  // 전표생성 confirm
  $scope.slipNoCreateConfirm = function (params) {
    /** 선택하신 자료를 주문전표로 생성합니다. 계속하시겠습니까? */
    var msg = messages["outstockData.orderSlipNoCreate"];
    s_alert.popConf(msg, function () {
      $scope.saveDataCreate(params);
    });
    return false;
  };

  // 출고자료생성
  $scope.saveDataCreate = function (params) {
    $scope._save("/iostock/order/outstockData/outstockData/saveDataCreate.sb", params, function () {
      $scope.searchOutstockDataList()
    });
  };

}]);