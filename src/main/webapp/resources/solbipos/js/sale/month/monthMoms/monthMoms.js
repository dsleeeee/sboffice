/**
 * get application
 */
var app = agrid.getApp();

/** 승인 controller */
app.controller('monthMomsCtrl', ['$scope', '$http', '$timeout', function ($scope, $http, $timeout) {
  // 상위 객체 상속 : T/F 는 picker
  angular.extend(this, new RootController('monthMomsCtrl', $scope, $http, true));

  // 검색조건에 조회기간
  var startMonth = new wijmo.input.InputDate('#startMonth', {
    format       : "yyyy-MM",
    selectionMode: "2" // 달력 선택 모드(1:day 2:month)
  });
  var endMonth = new wijmo.input.InputDate('#endMonth', {
    format       : "yyyy-MM",
    selectionMode: "2" // 달력 선택 모드(1:day 2:month)
  });

  // grid 초기화 : 생성되기전 초기화되면서 생성된다
  $scope.initGrid = function (s, e) {

    // picker 사용시 호출 : 미사용시 호출안함
    $scope._makePickColumns("monthMomsCtrl");

    //Grid Header 2줄 - START	----------------------------------------------------------------
    s.allowMerging = 2;
    s.columnHeaders.rows.push(new wijmo.grid.Row());

    //첫째줄 Header 생성
    var dataItem = {};
    dataItem.saleYm       = messages["monthMoms.saleYm"];
    dataItem.branchNm     = messages["monthMoms.branchNm"];
    dataItem.storeCd      = messages["monthMoms.storeCd"];
    dataItem.storeNm      = messages["monthMoms.storeNm"];
    dataItem.billCnt      = messages["monthMoms.sale"];
    dataItem.billUprc     = messages["monthMoms.sale"];
    dataItem.totGuestCnt  = messages["monthMoms.sale"];
    dataItem.guestUprc    = messages["monthMoms.sale"];
    dataItem.saleQty      = messages["monthMoms.sale"];
    dataItem.totSaleAmt   = messages["monthMoms.sale"];
    dataItem.realSaleAmt  = messages["monthMoms.sale"];
    dataItem.dcAmt        = messages["monthMoms.pay"];
    dataItem.rtnAmt       = messages["monthMoms.pay"];
    dataItem.cashAmt      = messages["monthMoms.pay"];
    dataItem.cardAmt      = messages["monthMoms.pay"];
    dataItem.etcAmt       = messages["monthMoms.pay"];
    s.columnHeaders.rows[0].dataItem = dataItem;
    //Grid Header 2줄 - END		----------------------------------------------------------------

    s.itemFormatter = function (panel, r, c, cell) {
      if (panel.cellType === wijmo.grid.CellType.ColumnHeader) {		//align in center horizontally and vertically
        panel.rows   [r].allowMerging	= true;
        panel.columns[c].allowMerging	= true;

        wijmo.setCss(cell, {
              display    : 'table',
              tableLayout: 'fixed'
            }
        );

        cell.innerHTML = '<div class=\"wj-header\">' + cell.innerHTML + '</div>';

        wijmo.setCss(cell.children[0], {
              display      : 'table-cell',
              verticalAlign: 'middle',
              textAlign    : 'center'
            }
        );
      }
      else if (panel.cellType === wijmo.grid.CellType.RowHeader) {	//Row헤더 의 RowNum 표시 ( 페이징/비페이징 구분 )
        if (panel.rows[r] instanceof wijmo.grid.GroupRow) {			//GroupRow 인 경우는 표시하지 않음
          cell.textContent = '';
        } else {
          if (!isEmpty(panel._rows[r]._data.rnum)) {
            cell.textContent = (panel._rows[r]._data.rnum).toString();
          } else {
            cell.textContent = (r + 1).toString();
          }
        }
      }
      else if (panel.cellType === wijmo.grid.CellType.Cell) {			//readOnly 배경색 표시
        var col = panel.columns[c];
        if (col.isReadOnly) {
          wijmo.addClass(cell, 'wj-custom-readonly');
        }
      }
    }	//s.itemFormatter = function (panel, r, c, cell) {

    // add the new GroupRow to the grid's 'columnFooters' panel
    s.columnFooters.rows.push(new wijmo.grid.GroupRow());
    // add a sigma to the header to show that this is a summary row
    s.bottomLeftCells.setCellData(0, 0, '합계');
  };


  // 다른 컨트롤러의 broadcast 받기
  $scope.$on("monthMomsCtrl", function (event, data) {
    $scope.searchMonthMomsList();
    // 기능수행 종료 : 반드시 추가
    event.preventDefault();
  });


  // 영수증별매출상세현황 리스트 조회
  $scope.searchMonthMomsList = function () {

    // 파라미터
    var params       = {};
    params.storeCds   = $("#monthMomsStoreCd").val();
    params.startMonth = wijmo.Globalize.format(startMonth.value, 'yyyyMM'); // 조회기간
    params.endMonth = wijmo.Globalize.format(endMonth.value, 'yyyyMM');// 조회기간
    params.listScale = 500;
    
    console.log(params);

    // 조회 수행 : 조회URL, 파라미터, 콜백함수
    $scope._inquiryMain("/sale/month/monthMoms/monthMoms/getMonthMomsList.sb", params);
  };


  // 매장선택 모듈 팝업 사용시 정의
  // 함수명 : 모듈에 넘기는 파라미터의 targetId + 'Show'
  // _broadcast : 모듈에 넘기는 파라미터의 targetId + 'Ctrl'
  $scope.monthMomsStoreShow = function () {
    $scope._broadcast('monthMomsStoreCtrl');
  };

  // 엑셀 다운로드
  $scope.excelDownload = function () {
    var params = {};
    params.storeCds   = $("#monthMomsStoreCd").val();
    params.startMonth = wijmo.Globalize.format(startMonth.value, 'yyyyMM'); // 조회기간
    params.endMonth = wijmo.Globalize.format(endMonth.value, 'yyyyMM');// 조회기간

    $scope._broadcast('monthMomsExcelCtrl',params);
  }
}]);


app.controller('monthMomsExcelCtrl', ['$scope', '$http', '$timeout', function ($scope, $http, $timeout) {

  // 상위 객체 상속 : T/F 는 picker
  angular.extend(this, new RootController('monthMomsExcelCtrl', $scope, $http, true));

  // grid 초기화 : 생성되기전 초기화되면서 생성된다
  $scope.initGrid = function (s, e) {

    //Grid Header 2줄 - START	----------------------------------------------------------------
    s.allowMerging = 2;
    s.columnHeaders.rows.push(new wijmo.grid.Row());

    //첫째줄 Header 생성
    var dataItem = {};
    dataItem.saleYm       = messages["monthMoms.saleYm"];
    dataItem.branchNm     = messages["monthMoms.branchNm"];
    dataItem.storeCd      = messages["monthMoms.storeCd"];
    dataItem.storeNm      = messages["monthMoms.storeNm"];
    dataItem.billCnt      = messages["monthMoms.sale"];
    dataItem.billUprc     = messages["monthMoms.sale"];
    dataItem.totGuestCnt  = messages["monthMoms.sale"];
    dataItem.guestUprc    = messages["monthMoms.sale"];
    dataItem.saleQty      = messages["monthMoms.sale"];
    dataItem.totSaleAmt   = messages["monthMoms.sale"];
    dataItem.realSaleAmt  = messages["monthMoms.sale"];
    dataItem.dcAmt        = messages["monthMoms.pay"];
    dataItem.rtnAmt       = messages["monthMoms.pay"];
    dataItem.cashAmt      = messages["monthMoms.pay"];
    dataItem.cardAmt      = messages["monthMoms.pay"];
    dataItem.etcAmt       = messages["monthMoms.pay"];
    s.columnHeaders.rows[0].dataItem = dataItem;
    //Grid Header 2줄 - END		----------------------------------------------------------------

    s.itemFormatter = function (panel, r, c, cell) {
      if (panel.cellType === wijmo.grid.CellType.ColumnHeader) {		//align in center horizontally and vertically
        panel.rows   [r].allowMerging	= true;
        panel.columns[c].allowMerging	= true;

        wijmo.setCss(cell, {
              display    : 'table',
              tableLayout: 'fixed'
            }
        );

        cell.innerHTML = '<div class=\"wj-header\">' + cell.innerHTML + '</div>';

        wijmo.setCss(cell.children[0], {
              display      : 'table-cell',
              verticalAlign: 'middle',
              textAlign    : 'center'
            }
        );
      }
      else if (panel.cellType === wijmo.grid.CellType.RowHeader) {	//Row헤더 의 RowNum 표시 ( 페이징/비페이징 구분 )
        if (panel.rows[r] instanceof wijmo.grid.GroupRow) {			//GroupRow 인 경우는 표시하지 않음
          cell.textContent = '';
        } else {
          if (!isEmpty(panel._rows[r]._data.rnum)) {
            cell.textContent = (panel._rows[r]._data.rnum).toString();
          } else {
            cell.textContent = (r + 1).toString();
          }
        }
      }
      else if (panel.cellType === wijmo.grid.CellType.Cell) {			//readOnly 배경색 표시
        var col = panel.columns[c];
        if (col.isReadOnly) {
          wijmo.addClass(cell, 'wj-custom-readonly');
        }
      }
    }	//s.itemFormatter = function (panel, r, c, cell) {

    // add the new GroupRow to the grid's 'columnFooters' panel
    s.columnFooters.rows.push(new wijmo.grid.GroupRow());
    // add a sigma to the header to show that this is a summary row
    s.bottomLeftCells.setCellData(0, 0, '합계');
  };

  // 다른 컨트롤러의 broadcast 받기
  $scope.$on("monthMomsExcelCtrl", function (event, data) {
    $scope.searchExcelList(data);
    // 기능수행 종료 : 반드시 추가
    event.preventDefault();
  });

  // 엑셀 리스트 조회
  $scope.searchExcelList = function (data) {
    // 파라미터
    var params       = {};
    params.storeCds = data.storeCds;
    params.startMonth = data.startMonth;
    params.endMonth = data.endMonth;

    // 조회 수행 : 조회URL, 파라미터, 콜백함수
    $scope._inquiryMain("/sale/month/monthMoms/monthMoms/getMonthMomsExcelList.sb", params, function() {
      if ($scope.flex.rows.length <= 0) {
        $scope._popMsg(messages["excelUpload.not.downloadData"]); // 다운로드 할 데이터가 없습니다.
        return false;
      }

      $scope.$broadcast('loadingPopupActive', messages["cmm.progress"]); // 데이터 처리중 메시지 팝업 오픈
      $timeout(function () {
        wijmo.grid.xlsx.FlexGridXlsxConverter.saveAsync($scope.flex, {
          includeColumnHeaders: true,
          includeCellStyles   : true,
          includeColumns      : function (column) {
            return column.visible;
          }
        }, messages["monthMomsMoms.monthMomsMoms"]+getToday()+'.xlsx', function () {
          $timeout(function () {
            $scope.$broadcast('loadingPopupInactive'); // 데이터 처리중 메시지 팝업 닫기
          }, 10);
        });
      }, 10);
    });
  };

}]);