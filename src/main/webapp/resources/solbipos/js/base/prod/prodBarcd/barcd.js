/****************************************************************
 *
 * 파일명 : barcd.js
 * 설  명 : 상품바코드등록 JavaScript
 *
 *    수정일      수정자      Version        Function 명
 * ------------  ---------   -------------  --------------------
 * 2021.07.01     권지현      1.0
 *
 * **************************************************************/
/**
 * get application
 */
var app = agrid.getApp();
app.config(['$qProvider', function ($qProvider) {
  $qProvider.errorOnUnhandledRejections(false);
}]);

/**
 *  그리드 생성
 */
app.controller('barcdCtrl', ['$scope', '$http', '$timeout', function ($scope, $http, $timeout) {
  // 상위 객체 상속 : T/F 는 picker
  angular.extend(this, new RootController('barcdCtrl', $scope, $http, false));

  // 상품 상세 정보
  $scope.prodInfo = {};
  $scope.setProdInfo = function(data){
    $scope.prodInfo = data;
  };
  $scope.getProdInfo = function(){
    return $scope.prodInfo;
  };

  // 전체기간 체크박스
  $scope.isChecked = true;
  // 커스텀콤보 : 사이드메뉴-속성
  $scope._getComboDataQueryCustom('getSideMenuAttrClassCombo', 'sdattrClassCdComboData', 'S');
  // 커스텀콤보 : 사이드메뉴-선택메뉴
  $scope._getComboDataQueryCustom('getSideMenuSdselGrpCdCombo', 'sdselGrpCdComboData', 'S');
  // 콤보박스 데이터 Set
  $scope._setComboData('listScaleBox', gvListScaleBoxData);
  // 사용여부를 쓰는 콤보박스의 데이터 (조회용)
  $scope._setComboData('useYnAllComboData', useYn);

  // 등록일자 셋팅
  $scope.srchStartDate = wcombo.genDateVal("#srchTimeStartDate", gvStartDate);
  $scope.srchEndDate   = wcombo.genDateVal("#srchTimeEndDate", gvEndDate);

  // grid 초기화 : 생성되기전 초기화되면서 생성된다
  $scope.initGrid = function (s, e) {
    // 그리드에서 사용하는 dataMap 초기화
    $scope.useYnComboDataMap = new wijmo.grid.DataMap(useYn, 'value', 'name'); // 사용여부

    // 그리드 포맷
    s.formatItem.addHandler(function (s, e) {
      if (e.panel === s.cells) {
        var col = s.columns[e.col];
        if( col.binding === "prodCd") {
          wijmo.addClass(e.cell, 'wijLink');
        }

        // 검증결과
        if (col.binding === "result") {
          var item = s.rows[e.row].dataItem;

          // 값이 있으면 링크 효과
          if (item[("result")] !== '검증성공') {
            wijmo.addClass(e.cell, 'wij_gridText-red');
            wijmo.addClass(e.cell, 'wj-custom-readonly');
          }
        }
      }
    });

    // 그리드 선택 이벤트
    s.addEventListener(s.hostElement, 'mousedown', function(e) {
      var ht = s.hitTest(e);
      if( ht.cellType === wijmo.grid.CellType.Cell) {
        var col = ht.panel.columns[ht.col];
        var selectedRow = s.rows[ht.row].dataItem;
        // 상품코드
        if( col.binding === "prodCd") {
          $scope.setProdInfo(selectedRow);
          // 상품정보 상세 팝업
          $scope.prodDetailLayer.show();
        }
      }
    });

    // 전체기간 체크박스 선택에 따른 날짜선택 초기화
    $scope.srchStartDate.isReadOnly = $scope.isChecked;
    $scope.srchEndDate.isReadOnly = $scope.isChecked;
  };

  // 전체기간 체크박스 클릭이벤트
  $scope.isChkDt = function() {
    $scope.srchStartDate.isReadOnly = $scope.isChecked;
    $scope.srchEndDate.isReadOnly = $scope.isChecked;
  };

  // 상품정보관리 그리드 조회
  $scope.$on("barcdCtrl", function(event, data) {
    $scope.searchProdList();
    // 기능수행 종료 : 반드시 추가
    event.preventDefault();
  });

  // 상품 목록 조회
  $scope.searchProdList = function(){
    if($scope.flex.columns[1].binding == "result"){
      $scope.flex.columns[1].visible = false;
    }
    // 파라미터
    var params = {};
    // 등록일자 '전체기간' 선택에 따른 params
    if(!$scope.isChecked){
      params.startDate = wijmo.Globalize.format($scope.srchStartDate.value, 'yyyyMMdd');
      params.endDate = wijmo.Globalize.format($scope.srchEndDate.value, 'yyyyMMdd');
    }

    // 조회 수행 : 조회URL, 파라미터, 콜백함수, 팝업결과표시여부
    $scope._inquiryMain("/base/prod/prodBarcd/list.sb", params);
  };

  // 엑셀업로드 조회
  $scope.searchExcelList = function(){
    $scope._gridDataInit();
    if($scope.flex.columns[1].binding == "result"){
      $scope.flex.columns[1].visible = true;
    }
    var params = {};
    $scope._inquiryMain("/base/prod/prodBarcd/getExcelList.sb", params);
  };

  // 상품분류정보 팝업
  $scope.popUpProdClass = function() {
    var popUp = $scope.prodClassPopUpLayer;
    popUp.show(true, function (s) {
      // 선택 버튼 눌렀을때만
      if (s.dialogResult === "wj-hide-apply") {
        var scope = agrid.getScope('prodClassPopUpCtrl');
        var prodClassCd = scope.getSelectedClass();
        var params = {};
        params.prodClassCd = prodClassCd;
        // 조회 수행 : 조회URL, 파라미터, 콜백함수
        $scope._postJSONQuery.withPopUp("/popup/getProdClassCdNm.sb", params,
            function(response){
              $scope.prodClassCd = prodClassCd;
              $scope.prodClassCdNm = response.data.data;
            }
        );
      }
    });
  };

  // 상품분류정보 선택취소
  $scope.delProdClass = function(){
    $scope.prodClassCd = "";
    $scope.prodClassCdNm = "";
  };

  // <-- 엑셀업로드 -->
  $scope.excelUpload = function(){
    // 상품엑셀업로드 팝업
    $("#excelUpFile").val('');
    $("#excelUpFile").trigger('click');
  };
  // <-- //엑셀업로드 -->

  // 바코드 삭제
  $scope.delete = function() {
    var params = [];
    for (var i = $scope.flex.itemsSource.itemCount - 1; i >= 0; i--) {
      if ($scope.flex.collectionView.items[i].gChk === true) {
        $scope.flex.itemsSource.removeAt(i);
      }
    }

    for (var i = 0; i < $scope.flex.collectionView.itemsRemoved.length; i++) {
      $scope.flex.collectionView.itemsRemoved[i].status = "D";
      params.push($scope.flex.collectionView.itemsRemoved[i]);
    }

    if (params.length > 0) {
      $.postJSONArray("/base/prod/prodBarcd/chkBarCds.sb", params, function(result) {
            $scope._save("/base/prod/prodBarcd/saveBarcd.sb", params,
                function(){
                  $scope._popMsg(messages["cmm.saveSucc"]);
                  $scope.searchProdList();
                }
            );
          },
          function (result) {
            $scope._popMsg(result.data[0]);
            return false;
          });
    } else {
      $scope._popMsg(messages["cmm.not.modify"]);
    }
  };

  // 변경내역 저장
  $scope.save = function(){
    var params      = [];

    if($scope.flex.columns[1].visible){ // 검증결과 컬럼이 보일때(엑셀업로드일때)
      for (var i = 0; i < $scope.flex.collectionView.items.length; i++) {
        params.push($scope.flex.collectionView.items[i]);
      }

      $scope._popConfirm(messages["barcd.saveConfirm"], function() {  // 검증을 통과한 상품을 저장하시겠습니까?
        // 저장기능 수행 : 저장URL, 파라미터, 콜백함수
        $scope._save("/base/prod/prodBarcd/saveBarcdExcel.sb", params,
            function(){
              $scope._popMsg(messages["cmm.saveSucc"]);
              $scope.searchProdList();
            }
        );
      });
    } else {  // 일반 저장일때
      for (var i = 0; i < $scope.flex.collectionView.itemsEdited.length; i++) {
        if($scope.flex.collectionView.itemsEdited[i].barCd.getByteLengthForOracle() > 40){
          $scope._popMsg("[" + $scope.flex.collectionView.itemsEdited[i].prodCd + "]" + $scope.flex.collectionView.itemsEdited[i].prodNm + messages["barcd.maxBarCd.msg"]);
          return false;
        }
      }

      for (var i = 0; i < $scope.flex.collectionView.itemsEdited.length; i++) {
        if($scope.flex.collectionView.itemsEdited[i].barCd !== null && $scope.flex.collectionView.itemsEdited[i].barCd !== ""){
          $scope.flex.collectionView.itemsEdited[i].status = "U";
          params.push($scope.flex.collectionView.itemsEdited[i]);
        }
      }

      if (params.length > 0) {
        $.postJSONArray("/base/prod/prodBarcd/chkBarCds.sb", params, function(result) {
              $scope._save("/base/prod/prodBarcd/saveBarcd.sb", params,
                  function(){
                    $scope._popMsg(messages["cmm.saveSucc"]);
                    $scope.searchProdList();
                  }
              );
            },
            function (result) {
              $scope._popMsg(result.data[0]);
              return false;
            });
      } else {
        $scope._popMsg(messages["cmm.not.modify"]);
      }
    }
  };

  // 화면 ready 된 후 설정
  angular.element(document).ready(function () {

    // 상품상세정보 팝업 핸들러 추가
    $scope.prodDetailLayer.shown.addHandler(function (s) {
      var selectedRow = $scope.flex.selectedRows[0]._data;
      setTimeout(function() {
        var params = {};
        params.prodCd = selectedRow.prodCd;
        $scope._broadcast('prodDetailCtrl', params);
      }, 50);
    })
  });

  // 바코드자동생성
  $scope.autoBarcd = function (){
    if ($scope.flex.rows.length <= 0) {
      $scope._popMsg(messages["barcd.rows.null"]); // 그리드가 비어있습니다.<br>조회 후 바코드자동생성을 시도해주세요.
      return false;
    }
  };

  // 엑셀 다운로드
  $scope.excelDownload = function () {
    if ($scope.flex.rows.length <= 0) {
      $scope._popMsg(messages["excelUpload.not.downloadData"]); // 다운로드 할 데이터가 없습니다.
      return false;
    }
    $scope.$broadcast('loadingPopupActive', messages["cmm.progress"]); // 데이터 처리중 메시지 팝업 오픈
    $timeout(function () {
      wijmo.grid.xlsx.FlexGridXlsxConverter.saveAsync($scope.flex, {
        includeColumnHeaders: true,
        includeCellStyles: true,
        includeColumns: function (column) {
          return column.visible;
        }
      },
          messages["barcd.prodBarcd"] + '_' + getCurDateTime() +'.xlsx', function () {
            $timeout(function () {
              $scope.$broadcast('loadingPopupInactive'); // 데이터 처리중 메시지 팝업 닫기
            }, 10);
          });
    }, 10);
  };

  // 양식 다운로드
  $scope.sampleDownload = function () {
    // 파라미터
    var params = {};
    // 등록일자 '전체기간' 선택에 따른 params
    if(!$scope.isChecked){
      params.startDate = wijmo.Globalize.format($scope.srchStartDate.value, 'yyyyMMdd');
      params.endDate = wijmo.Globalize.format($scope.srchEndDate.value, 'yyyyMMdd');
    }
    params.excelGubun = 'T';

    $scope._popConfirm(messages["prod.totalExceDownload"], function() {
      $scope._broadcast('totalExcelCtrl', params);
    });
  };

}]);

app.controller('totalExcelCtrl', ['$scope', '$http', '$timeout', function ($scope, $http, $timeout) {

  // 상위 객체 상속 : T/F 는 picker
  angular.extend(this, new RootController('totalExcelCtrl', $scope, $http, true));

  // grid 초기화 : 생성되기전 초기화되면서 생성된다
  $scope.initGrid = function (s, e) { };

  // 다른 컨트롤러의 broadcast 받기
  $scope.$on("totalExcelCtrl", function (event, data) {
    $scope.searchProdExcelList(data);
    // 기능수행 종료 : 반드시 추가
    event.preventDefault();
  });

  // 상품매출순위 리스트 조회
  $scope.searchProdExcelList = function (data) {
    // 파라미터
    var params       = {};
    params.startDate = data.startDate;
    params.endDate = data.endDate;
    params.excelGubun = "T";

    // 조회 수행 : 조회URL, 파라미터, 콜백함수
    $scope._inquiryMain("/base/prod/prodBarcd/getProdExcelList.sb", params, function() {

      $scope.$broadcast('loadingPopupActive', messages["cmm.progress"]); // 데이터 처리중 메시지 팝업 오픈
      $timeout(function () {
        wijmo.grid.xlsx.FlexGridXlsxConverter.saveAsync($scope.excelFlex, {
          includeColumnHeaders: true,
          includeCellStyles   : true,
          includeColumns      : function (column) {
            return column.visible;
          }
        }, messages["barcd.prodBarcd"] + '(업로드양식)' + getCurDateTime() +'.xlsx', function () {
          $timeout(function () {
            $scope.$broadcast('loadingPopupInactive'); // 데이터 처리중 메시지 팝업 닫기
          }, 10);
        });
      }, 10);
    });
  };
}]);