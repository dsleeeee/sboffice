/**
 * get application
 */
var app = agrid.getApp();

/** controller */
app.controller('bizAreaCtrl', ['$scope', '$http', '$timeout', function ($scope, $http, $timeout) {
  // 상위 객체 상속 : T/F 는 picker
  angular.extend(this, new RootController('bizAreaCtrl', $scope, $http, true));

  $scope.srchStartDate  = wcombo.genDateVal("#srchStartDate", gvStartDate);
  $scope.srchEndDate    = wcombo.genDateVal("#srchEndDate", gvEndDate);

  // grid 초기화 : 생성되기전 초기화되면서 생성된다
  $scope.initGrid = function (s, e) {
    $scope.bizAreaDataMap = new wijmo.grid.DataMap(bizAreaData, 'value', 'name');

    // picker 사용시 호출 : 미사용시 호출안함
    $scope._makePickColumns("bizAreaCtrl");

    // add the new GroupRow to the grid's 'columnFooters' panel
    s.columnFooters.rows.push(new wijmo.grid.GroupRow());
    // add a sigma to the header to show that this is a summary row
    s.bottomLeftCells.setCellData(0, 0, '합계');
  };


  // 다른 컨트롤러의 broadcast 받기
  $scope.$on("bizAreaCtrl", function (event, data) {
    $scope.searchBizAreaList();
    // 기능수행 종료 : 반드시 추가
    event.preventDefault();
  });


  // 영수증별매출상세현황 리스트 조회
  $scope.searchBizAreaList = function () {

    // 파라미터
    var params       = {};
    params.storeCds   = $("#bizAreaStoreCd").val();
    params.startDate = wijmo.Globalize.format($scope.srchStartDate.value, 'yyyyMMdd');
    params.endDate = wijmo.Globalize.format($scope.srchEndDate.value, 'yyyyMMdd');
    params.listScale = 500;
    
    console.log(params);

    // 조회 수행 : 조회URL, 파라미터, 콜백함수
    $scope._inquiryMain("/sale/area/bizArea/bizArea/getBizAreaList.sb", params);
  };


  // 매장선택 모듈 팝업 사용시 정의
  // 함수명 : 모듈에 넘기는 파라미터의 targetId + 'Show'
  // _broadcast : 모듈에 넘기는 파라미터의 targetId + 'Ctrl'
  $scope.bizAreaStoreShow = function () {
    $scope._broadcast('bizAreaStoreCtrl');
  };

  // 엑셀 다운로드
  $scope.excelDownload = function () {
    var params = {};
    params.storeCds   = $("#bizAreaStoreCd").val();
    params.startDate = wijmo.Globalize.format($scope.srchStartDate.value, 'yyyyMMdd');
    params.endDate = wijmo.Globalize.format($scope.srchEndDate.value, 'yyyyMMdd');

    $scope._broadcast('bizAreaExcelCtrl',params);
  }
}]);


app.controller('bizAreaExcelCtrl', ['$scope', '$http', '$timeout', function ($scope, $http, $timeout) {

  // 상위 객체 상속 : T/F 는 picker
  angular.extend(this, new RootController('bizAreaExcelCtrl', $scope, $http, true));

  // grid 초기화 : 생성되기전 초기화되면서 생성된다
  $scope.initGrid = function (s, e) {
    // add the new GroupRow to the grid's 'columnFooters' panel
    s.columnFooters.rows.push(new wijmo.grid.GroupRow());
    // add a sigma to the header to show that this is a summary row
    s.bottomLeftCells.setCellData(0, 0, '합계');
  };

  // 다른 컨트롤러의 broadcast 받기
  $scope.$on("bizAreaExcelCtrl", function (event, data) {
    $scope.searchExcelList(data);
    // 기능수행 종료 : 반드시 추가
    event.preventDefault();
  });

  // 엑셀 리스트 조회
  $scope.searchExcelList = function (data) {
    // 파라미터
    var params       = {};
    params.storeCds = data.storeCds;
    params.startDate = data.startDate;
    params.endDate = data.endDate;

    // 조회 수행 : 조회URL, 파라미터, 콜백함수
    $scope._inquiryMain("/sale/area/bizArea/bizArea/getBizAreaExcelList.sb", params, function() {
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
        }, messages["bizAreaMoms.bizAreaMoms"]+getToday()+'.xlsx', function () {
          $timeout(function () {
            $scope.$broadcast('loadingPopupInactive'); // 데이터 처리중 메시지 팝업 닫기
          }, 10);
        });
      }, 10);
    });
  };

}]);