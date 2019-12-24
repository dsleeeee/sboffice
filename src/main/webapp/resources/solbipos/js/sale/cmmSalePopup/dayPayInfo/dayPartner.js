/**
 * get application
 */
var app = agrid.getApp();

/** 제휴카드 상세 내역 controller */
app.controller('dayPartnerCtrl', ['$scope', '$http', '$timeout', function ($scope, $http, $timeout) {
  // 상위 객체 상속 : T/F 는 picker
  angular.extend(this, new RootController('dayPartnerCtrl', $scope, $http, true));

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
  $scope.$on("dayPartnerCtrl", function (event, data) {
    $scope.wjDayPartnerLayer.show(true);
    $scope.searchDayPartnerList(data);
    // 기능수행 종료 : 반드시 추가
    event.preventDefault();
  });


  // 제휴카드 내역 리스트 조회
  $scope.searchDayPartnerList = function (data) {
    // 파라미터
    var params       = {};
    // 기간별매출 > 일자별 탭 > 일별종합 탭
    if(data.gubun == "day") {
      params.saleDate = data.saleDate;
    }
    // 기간별매출 > 월별 탭 > 월별종합 탭
    if(data.gubun == "month") {
      params.yearMonth = data.yearMonth;
    }
    params.storeCd  = data.storeCd;
    params.gubun  = data.gubun;

    // 조회 수행 : 조회URL, 파라미터, 콜백함수
    $scope._inquiryMain("/sale/cmmSalePopup/dayPayInfo/dayPartner/list.sb", params);
  };

}]);
