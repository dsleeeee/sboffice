/**
 * get application
 */
var app = agrid.getApp();

/** VMEM 포인트 상세 내역 controller */
app.controller('vpointCtrl', ['$scope', '$http', '$timeout', function ($scope, $http, $timeout) {
  // 상위 객체 상속 : T/F 는 picker
  angular.extend(this, new RootController('vpointCtrl', $scope, $http, true));

  $scope.cashBillApprProcFgMap = new wijmo.grid.DataMap([
    {id: "1", name: messages["vpoint.cashBillApprProcFg1"]},
    {id: "2", name: messages["vpoint.cashBillApprProcFg2"]},
    {id: "3", name: messages["vpoint.cashBillApprProcFg3"]},
  ], 'id', 'name');

  // grid 초기화 : 생성되기전 초기화되면서 생성된다
  $scope.initGrid = function (s, e) {

    // 그리드 링크 효과
    s.formatItem.addHandler(function (s, e) {
      if (e.panel === s.cells) {
        var col = s.columns[e.col];

        if (col.format === "date") {
          e.cell.innerHTML = getFormatDate(e.cell.innerText);
        } else if (col.format === "dateTime") {
          e.cell.innerHTML = getFormatDateTime(e.cell.innerText);
        } else if (col.format === "time") {
          e.cell.innerHTML = getFormatTime(e.cell.innerText, 'hms');
        }
      }
    });

    // add the new GroupRow to the grid's 'columnFooters' panel
    s.columnFooters.rows.push(new wijmo.grid.GroupRow());
    // add a sigma to the header to show that this is a summary row
    s.bottomLeftCells.setCellData(0, 0, '합계');
  };


  // 다른 컨트롤러의 broadcast 받기
  $scope.$on("vpointCtrl", function (event, data) {
    $scope.storeCd  = data.storeCd;
    $scope.saleDate = data.saleDate;
    $scope.posNo    = data.posNo;
    $scope.billNo   = data.billNo;

    $scope.wjVpointLayer.show(true);

    $scope.searchVpointList();

    // 기능수행 종료 : 반드시 추가
    event.preventDefault();
  });


  // VMEM 포인트 내역 리스트 조회
  $scope.searchVpointList = function () {
    // 파라미터
    var params       = {};
    params.storeCd   = $scope.storeCd;
    params.saleDate  = $scope.saleDate;
    params.posNo     = $scope.posNo;
    params.billNo    = $scope.billNo;

    // 조회 수행 : 조회URL, 파라미터, 콜백함수
    $scope._inquiryMain("/sale/cmmSalePopup/payInfo/vpoint/vpoint.sb", params);
  };

}]);
