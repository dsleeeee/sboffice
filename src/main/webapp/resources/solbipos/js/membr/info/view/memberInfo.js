/****************************************************************
 *
 * 파일명 : memberInfo.js
 * 설  명 : 회원정보관리 JavaScript
 *
 *    수정일      수정자      Version        Function 명
 * ------------  ---------   -------------  --------------------
 * 2018.11.08     김지은      1.0
 *
 * **************************************************************/
/**
 * get application
 */
var app = agrid.getApp();

/**********************************************************************
 *  회원정보 그리드
 **********************************************************************/
app.controller('memberCtrl', ['$scope', '$http', function ($scope, $http) {
  // 상위 객체 상속 : T/F 는 picker
  angular.extend(this, new RootController('memberCtrl', $scope, $http, true));

  // 조회조건 콤보박스 데이터 Set
  $scope._setComboData("listScaleBox", gvListScaleBoxData);

  $scope._getComboDataQuery('072', 'emailRecvYn', 'A');
  $scope._getComboDataQuery('072', 'smsRecvYn', 'A');
  $scope._getComboDataQuery('032', 'anvType', 'A');
  $scope._getComboDataQuery('077', 'periodType', 'A');
  $scope._getComboDataQuery('055', 'gendrFg', 'A');

  // 선택 회원
  $scope.selectedMember;
  $scope.setSelectedMember = function(member) {
    $scope.selectedMember = member;
  };
  $scope.getSelectedMember = function(){
    return $scope.selectedMember;
  };

  // grid 초기화 : 생성되기전 초기화되면서 생성된다
  $scope.initGrid = function (s, e) {

    $scope.emailRecvDataMap = new wijmo.grid.DataMap(recvDataMap, 'value', 'name');
    $scope.smsRecvDataMap = new wijmo.grid.DataMap(recvDataMap, 'value', 'name');
    $scope.useYnDataMap = new wijmo.grid.DataMap(useDataMap, 'value', 'name');

    // ReadOnly 효과설정
    s.formatItem.addHandler(function (s, e) {
      if (e.panel === s.cells) {
        var col = s.columns[e.col];
        // 회원번호, 회원명 클릭시 상세정보 팝업
        if (col.binding === "membrNo" || col.binding === "membrNm") {
          wijmo.addClass(e.cell, 'wijLink');
        }
        // 후불적용매장등록 클릭시 매장선택 팝업
        if(col.binding === "postpaidStore") {
          wijmo.addClass(e.cell, 'wijLink');
        }
      }
    });

    // 회원선택
    s.addEventListener(s.hostElement, 'mousedown', function(e) {
      var ht = s.hitTest(e);
      if( ht.cellType === wijmo.grid.CellType.Cell) {
        var col = ht.panel.columns[ht.col];
        // 회원번호, 회원명 클릭시 상세정보 팝업
        if ( col.binding === "membrNo" ||  col.binding === "membrNm") {
          var selectedData = s.rows[ht.row].dataItem;
          $scope.setSelectedMember(selectedData);
          $scope.memberInfoDetailLayer.show(true);
          event.preventDefault();
        }

        // 후불적용매장등록 클릭시 매장선택 팝업
        if (col.binding === "postpaidStore" ) {
          var selectedData = s.rows[ht.row].dataItem;
          // 해당 매장의 등록매장이 본사의 디폴트 매장과 동일할 경우에만 후불적용 매장을 등록할 수 있다.
          $scope.setSelectedMember(selectedData);
          $scope.postpaidStoreRegistLayer.show(true);
          event.preventDefault();
        }
      }
    });
  };

  // 조회 버튼 클릭
  $scope.$on("memberCtrl", function(event, data) {

    // 이출, 이입매장 초기화
    $("#regStoreCd").val("");
    $("#regStoreNm").val(messages["cmm.select"]);

    // $scope.getMemberList();
    event.preventDefault();
  });

  // 회원 목록 조회
  $scope.getMemberList = function(){
    var params = {};

    params.regStoreCd = $("#regStoreCd").val();

    $scope._inquiryMain("/membr/info/view/view/getMemberlist.sb", params, function() {
    });
  };

  // 매장선택 모듈 팝업 사용시 정의
  // 함수명 : 모듈에 넘기는 파라미터의 targetId + 'Show'
  // _broadcast : 모듈에 넘기는 파라미터의 targetId + 'Ctrl'
  $scope.regStoreShow = function () {
    $scope._broadcast('regStoreCtrl');
  };

  // 화면 ready 된 후 설정
  angular.element(document).ready(function () {

    // 회원조회 팝업 핸들러 추가
    $scope.memberInfoDetailLayer.shown.addHandler(function (s) {
      setTimeout(function() {
        $scope._broadcast('memberInfoDetailCtrl', $scope.getSelectedMember());
      }, 50)
    });

    // 회원 등록 및 수정 팝업 핸들러 추가
    $scope.memberRegistLayer.shown.addHandler(function (s) {
      setTimeout(function() {
        $scope._broadcast('memberRegistCtrl', $scope.getSelectedMember());
      }, 50)
    });

    // 후불회원등록 팝업 핸들러 추가
    $scope.postpaidStoreRegistLayer.shown.addHandler(function (s) {
      setTimeout(function() {
        $scope._broadcast('postpaidStoreRegistCtrl', $scope.getSelectedMember());
      }, 50)
    });
  });

  // 신규회원 등록
  $scope.registMember = function(){
    $scope.setSelectedMember(null);
    $scope.memberRegistLayer.show(true);
  };
}]);

