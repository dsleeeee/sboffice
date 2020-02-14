/**
 * get application
 */
var app = agrid.getApp();

/** 설정기간별(매출리스트) controller */
app.controller('empDayPeriodCtrl', ['$scope', '$http', '$timeout', function ($scope, $http, $timeout) {
  // 상위 객체 상속 : T/F 는 picker
  angular.extend(this, new RootController('empDayPeriodCtrl', $scope, $http, $timeout, true));

  $scope.srchEmpDayPeriodStartDate = wcombo.genDateVal("#srchEmpDayPeriodStartDate", gvStartDate);
  $scope.srchEmpDayPeriodEndDate   = wcombo.genDateVal("#srchEmpDayPeriodEndDate", gvEndDate);

  //조회조건 콤보박스 데이터 Set
//  $scope._setComboData("empDayPeriodListScaleBox", gvListScaleBoxData);

  // grid 초기화 : 생성되기전 초기화되면서 생성된다
  $scope.initGrid = function (s, e) {
    // 조회조건 '코너 표시'
//	$scope.getEmpNmList();

    // picker 사용시 호출 : 미사용시 호출안함
    $scope._makePickColumns("empDayPeriodCtrl");

    // 그리드 링크 효과
    s.formatItem.addHandler(function (s, e) {
      if (e.panel === s.cells) {
        var col = s.columns[e.col];
        if (col.binding === "realSaleAmt") { // 실매출
          	wijmo.addClass(e.cell, 'wijLink');
          	wijmo.addClass(e.cell, 'wj-custom-readonly');
        }
      }
    });

    // 그리드 클릭 이벤트-------------------------------------------------------------------------------------------------
    s.addEventListener(s.hostElement, 'mousedown', function (e) {
      var ht = s.hitTest(e);
      if (ht.cellType === wijmo.grid.CellType.Cell) {
        var col         = ht.panel.columns[ht.col];
        var selectedRow = s.rows[ht.row].dataItem;
        var params       = {};
        	params.storeCd   = selectedRow.storeCd;
        	params.startDate = $scope.startDateForDt;
        	params.endDate   = $scope.endDateForDt;
        	params.empNo     = selectedRow.empNo;
        if (col.binding === "realSaleAmt") { // 영수증번호
            $scope._broadcast('empDayPeriodDtlCtrlSrch', params);
        }
      }
    });

    // add the new GroupRow to the grid's 'columnFooters' panel
    s.columnFooters.rows.push(new wijmo.grid.GroupRow());
    // add a sigma to the header to show that this is a summary row
    s.bottomLeftCells.setCellData(0, 0, '합계');
  }

  // 다른 컨트롤러의 broadcast 받기
  $scope.$on("empDayPeriodCtrl", function (event, data) {

	if ($("#empDayPeriodSelectStoreCd").val() === '') {
        $scope._popMsg(messages["prodsale.day.require.selectStore"]); // 매장을 선택해주세요.
        return false;
     }
	$scope.searchEmpDayPeriodList(true);

    // 기능수행 종료 : 반드시 추가
    event.preventDefault();
  });

  //다른 컨트롤러의 broadcast 받기(페이징 초기화)
  $scope.$on("empDayPeriodCtrlSrch", function (event, data) {

	if ($("#empDayPeriodSelectStoreCd").val() === '') {
        $scope._popMsg(messages["prodsale.day.require.selectStore"]); // 매장을 선택해주세요.
        return false;
     }
	$scope.searchEmpDayPeriodList(false);

    // 기능수행 종료 : 반드시 추가
    event.preventDefault();
  });


  // 판매자별 설정기간 리스트 조회
  $scope.searchEmpDayPeriodList = function (isPageChk) {
  if ($("#empDayPeriodSelectStoreCd").val() === '') {
      $scope._popMsg(messages["prodsale.day.require.selectStore"]); // 매장을 선택해주세요.
      return false;
    }

    // 파라미터
    var params       = {};
    params.storeCd   = $("#empDayPeriodSelectStoreCd").val();
//    params.listScale = $scope.empDayPeriodListScale;
    params.isPageChk = isPageChk;
    // 등록일자 '전체기간' 선택에 따른 params
    if(!$scope.isChecked){
      $scope.startDateForDt = wijmo.Globalize.format($scope.srchEmpDayPeriodStartDate.value, 'yyyyMMdd');
	  $scope.endDateForDt = wijmo.Globalize.format($scope.srchEmpDayPeriodEndDate.value, 'yyyyMMdd');

      params.startDate = wijmo.Globalize.format($scope.srchEmpDayPeriodStartDate.value, 'yyyyMMdd');
      params.endDate = wijmo.Globalize.format($scope.srchEmpDayPeriodEndDate.value, 'yyyyMMdd');
    }
    if(params.startDate > params.endDate){
   	 	$scope._popMsg(messages["prodsale.dateChk"]); // 조회종료일자가 조회시작일자보다 빠릅니다.
   	 	return false;
    }
    if($scope.isCheckedEmpAll){
    	params.empChk = "Y";
    }else{
    	params.empChk = "N";
    }
    // 조회 수행 : 조회URL, 파라미터, 콜백함수
    $scope._inquirySub("/sale/status/emp/dayperiod/list.sb", params);

    //메인그리드 조회후 상세그리드 조회.
	$scope.loadedRows = function(sender, args){
		var rows = sender.rows;

		var params		 = {};

		if(rows.length != 0) {
			console.log()
			params.startDate = $scope.startDateForDt;
        	params.endDate   = $scope.endDateForDt;
			params.storeCd   = rows[0].dataItem.storeCd;
		    params.empNo     = rows[0].dataItem.empNo;
	    }
		else {
			params.storeCd   = -1;
		}

	    // 코너별 매출현황 상세조회.
	    $scope._broadcast("empDayPeriodDtlCtrlSrch", params);
	}
  };

  //전체기간 체크박스 클릭이벤트
  $scope.isChkDt = function() {
    $scope.srchEmpDayPeriodStartDate.isReadOnly = $scope.isChecked;
    $scope.srchEmpDayPeriodEndDate.isReadOnly = $scope.isChecked;
  };

  //매장선택 모듈 팝업 사용시 정의
  // 함수명 : 모듈에 넘기는 파라미터의 targetId + 'Show'
  // _broadcast : 모듈에 넘기는 파라미터의 targetId + 'Ctrl'
  $scope.empDayPeriodSelectStoreShow = function () {
    $scope._broadcast('empDayPeriodSelectStoreCtrl');
  };

  //엑셀 다운로드
  $scope.excelDownloadDayPeriod = function () {
    if ($scope.flex.rows.length <= 0) {
      $scope._popMsg(messages["excelUpload.not.downloadData"]); // 다운로드 할 데이터가 없습니다.
      return false;
    }

    $scope.$broadcast('loadingPopupActive', messages["cmm.progress"]); // 데이터 처리중 메시지 팝업 오픈
    $timeout(function () {
      wijmo.grid.xlsx.FlexGridXlsxConverter.saveAsync($scope.flex, {
        includeColumnHeaders: true,
        includeCellStyles   : false,
        includeColumns      : function (column) {
          return column.visible;
        }
      }, '매출현황_판매자별_설정기간별_'+getToday()+'.xlsx', function () {
        $timeout(function () {
          $scope.$broadcast('loadingPopupInactive'); // 데이터 처리중 메시지 팝업 닫기
        }, 10);
      });
    }, 10);
  };

}]);


/** 설정기간별매출(매출상세) controller */
app.controller('empDayPeriodDtlCtrl', ['$scope', '$http','$timeout', function ($scope, $http, $timeout) {
	 // 상위 객체 상속 : T/F 는 picker
	  angular.extend(this, new RootController('empDayPeriodDtlCtrl', $scope, $http, $timeout, true));

	  //조회조건 콤보박스 데이터 Set
//	  $scope._setComboData("empDayPeriodDtlListScaleBox", gvListScaleBoxData);

	  // grid 초기화 : 생성되기전 초기화되면서 생성된다
	  $scope.initGrid = function (s, e) {

	    // picker 사용시 호출 : 미사용시 호출안함
	    $scope._makePickColumns("empDayPeriodDtlCtrl");

	    // add the new GroupRow to the grid's 'columnFooters' panel
	    s.columnFooters.rows.push(new wijmo.grid.GroupRow());
	    // add a sigma to the header to show that this is a summary row
	    s.bottomLeftCells.setCellData(0, 0, '합계');

	    // 그리드 링크 효과
	    s.formatItem.addHandler(function (s, e) {
	      if (e.panel === s.cells) {
	        var col = s.columns[e.col];
	        if(col.binding === "billNo") { // 영수증번호
	        	wijmo.addClass(e.cell, 'wijLink');
	        	wijmo.addClass(e.cell, 'wj-custom-readonly');
	        }
	      }
	    });

	    // 그리드 클릭 이벤트-------------------------------------------------------------------------------------------------
	    s.addEventListener(s.hostElement, 'mousedown', function (e) {
	      var ht = s.hitTest(e);
	      if (ht.cellType === wijmo.grid.CellType.Cell) {
	        var col         = ht.panel.columns[ht.col];
	        var selectedRow = s.rows[ht.row].dataItem;
	        var params       = {};
	        	params.chkPop   = "empPop";
	        	params.posNo	 = selectedRow.posNo;
	        	params.billNo    = selectedRow.billNo;
	        	params.storeCd   = selectedRow.storeCd;
	        	params.startDate = selectedRow.saleDate;
	        	params.endDate   = selectedRow.saleDate;
	        if (col.binding === "billNo") { // 영수증번호
	            $scope._broadcast('saleComProdCtrl', params);
	        }
	      }
	    });

	  }

	  // 다른 컨트롤러의 broadcast 받기
	  $scope.$on("empDayPeriodDtlCtrl", function (event, data) {
		  if(data != undefined){
			$scope.startDate = data.startDate;
			$scope.endDate   = data.endDate;
			$scope.storeCd   = data.storeCd;
			$scope.empNo     = data.empNo;
		  }

	    $scope.searchEmpDayPeriodDtlList(true);
	    // 기능수행 종료 : 반드시 추가
	    event.preventDefault();
	  });

	  // 다른 컨트롤러의 broadcast 받기(페이징 초기화)
	  $scope.$on("empDayPeriodDtlCtrlSrch", function (event, data) {
		  if(data != undefined){
			$scope.startDate = data.startDate;
			$scope.endDate   = data.endDate;
			$scope.storeCd   = data.storeCd;
			$scope.empNo     = data.empNo;
		  }

	    $scope.searchEmpDayPeriodDtlList(false);
	    // 기능수행 종료 : 반드시 추가
	    event.preventDefault();
	  });


	  // 코너별매출일자별 리스트 조회
	  $scope.searchEmpDayPeriodDtlList = function (isPageChk) {
		if ($("#empDayPeriodSelectStoreCd").val() === '') {
	      $scope._popMsg(messages["prodsale.day.require.selectStore"]); // 매장을 선택해주세요.
	      return false;
	    }

	    // 파라미터
	    var params       = {};
	    params.startDate = $scope.startDate;
	    params.endDate   = $scope.endDate;
	    params.storeCd   = $scope.storeCd;
	    params.empNo     = $scope.empNo;
//	    params.listScale = $scope.empDayPeriodDtlListScale;
	    params.isPageChk = isPageChk;

	    // 조회 수행 : 조회URL, 파라미터, 콜백함수
	    $scope._inquirySub("/sale/status/emp/dayperiod/dtl.sb", params);
	  };

	//엑셀 다운로드
	  $scope.excelDownloadDayPeriodDtl = function () {
	    if ($scope.dtlFlex.rows.length <= 0) {
	      $scope._popMsg(messages["excelUpload.not.downloadData"]); // 다운로드 할 데이터가 없습니다.
	      return false;
	    }

	    $scope.$broadcast('loadingPopupActive', messages["cmm.progress"]); // 데이터 처리중 메시지 팝업 오픈
	    $timeout(function () {
	      wijmo.grid.xlsx.FlexGridXlsxConverter.saveAsync($scope.dtlFlex, {
	        includeColumnHeaders: true,
	        includeCellStyles   : false,
	        includeColumns      : function (column) {
	          return column.visible;
	        }
	      }, '매출현황_판매자별_설정기간별(상세)_'+getToday()+'.xlsx', function () {
	        $timeout(function () {
	          $scope.$broadcast('loadingPopupInactive'); // 데이터 처리중 메시지 팝업 닫기
	        }, 10);
	      });
	    }, 10);
	  };

}]);
