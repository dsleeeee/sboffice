/**
 * get application
 */
var app = agrid.getApp();

/** 일자별(코너별 매출) controller */
app.controller('apprAcquireNcardCtrl', ['$scope', '$http', '$timeout', function ($scope, $http, $timeout) {
  // 상위 객체 상속 : T/F 는 picker
  angular.extend(this, new RootController('apprAcquireNcardCtrl', $scope, $http, $timeout, true));

  $scope.srchApprAcquireNcardStartDate = wcombo.genDateVal("#srchApprAcquireNcardStartDate", getToday());
  $scope.srchApprAcquireNcardEndDate   = wcombo.genDateVal("#srchApprAcquireNcardEndDate", getToday());
  $scope.isSearch = false;

  //조회조건 콤보박스 데이터 Set
  $scope._setComboData("apprAcquireNcardListScaleBox", gvListScaleBoxData);

  //조회조건 승인구분 데이터 Set
  $scope._setComboData("srchNcardSaleYnDisplay", [
    {"name": messages["cmm.all"], "value": ""},
    {"name": messages["appr.approve"], "value": "Y"},
    {"name": messages["cmm.cancel"], "value": "N"}
  ]);

  //조회조건 승인처리 데이터 Set
  $scope._setComboData("srchNcardApprProcFgDisplay", [
    {"name": messages["cmm.all"], "value": ""},
    {"name": messages["card.apprProcFg1"], "value": "1"},
    {"name": messages["card.apprProcFg2"], "value": "2"},
  ]);

  // grid 초기화 : 생성되기전 초기화되면서 생성된다
  $scope.initGrid = function (s, e) {

    // picker 사용시 호출 : 미사용시 호출안함
    $scope._makePickColumns("apprAcquireNcardCtrl");

    // 그리드 링크 효과
    s.formatItem.addHandler(function (s, e) {
      if (e.panel === s.cells) {
        var col = s.columns[e.col];

        if (col.binding === "storeNm") { // 수량합계
        	var item = s.rows[e.row].dataItem;
          	wijmo.addClass(e.cell, 'wijLink');
          	wijmo.addClass(e.cell, 'wj-custom-readonly');
        }
      }
    });

    // 그리드 클릭 이벤트
    s.addEventListener(s.hostElement, 'mousedown', function (e) {
      var ht = s.hitTest(e);

      if (ht.panel == s.columnHeaders && !ht.edgeRight && !e['dataTransfer']) {
		var rng = s.getMergedRange(ht.panel, ht.row, ht.col);
		if (rng && rng.columnSpan > 1) {
			e.preventDefault();
		}
	  }

      if (ht.cellType === wijmo.grid.CellType.Cell) {
        var col         = ht.panel.columns[ht.col];
        var selectedRow = s.rows[ht.row].dataItem;
        var storeCd		 = selectedRow.storeCd;
        var arrPosNo	 = ($scope.srchPosNo).split(",");
        var params       = {};
        	params.posNo = new Array();
	        params.saleYn = $scope.srchSaleYn;
	        params.apprProcFg = $scope.srchApprProcFg;
	        if(params.posNo == ""){
	        	params.storeCd   = selectedRow.storeCd;
	        }
	    	params.acquireCd = selectedRow.acquireCd;
	    	if(!$scope.isChecked){
				params.startDate = $scope.excelStartDate;
				params.endDate = $scope.excelEndDate;
	    	}
	    	params.chkPop    = "ncardApprPop";
	    if (col.binding === "storeNm") { // 매장명
	    	if(arrPosNo != ""){
        		for(var i=0; i<arrPosNo.length; i++){
            		if(storeCd == arrPosNo[i].substring(0,7)){
            			(params.posNo).push(arrPosNo[i]);
            		}
            	}
        	}
	        $scope._broadcast('saleApprNcardCtrl', params);
	    }
      }
    }, true);

    // add the new GroupRow to the grid's 'columnFooters' panel
    s.columnFooters.rows.push(new wijmo.grid.GroupRow());
    // add a sigma to the header to show that this is a summary row
    s.bottomLeftCells.setCellData(0, 0, '합계');

    // <-- 그리드 헤더2줄 -->
    // 헤더머지
    s.allowMerging = 2;
    s.columnHeaders.rows.push(new wijmo.grid.Row());

    // 첫째줄 헤더 생성
    var dataItem         = {};
    dataItem.storeCd			   = messages["rtnStatus.storeCd"];
    dataItem.storeNm			   = messages["rtnStatus.storeNm"];

    dataItem.acquireCd		 = messages["appr.acquire.cardCd"];
    dataItem.acquireNm       = messages["appr.acquire.cardNm"];

    dataItem.cnt        = messages["cmm.all"];
    dataItem.dcAmt         = messages["cmm.all"];
    dataItem.apprAmt         = messages["cmm.all"];

    dataItem.cntA       = messages["appr.approve"];
    dataItem.dcAmtA        = messages["appr.approve"];
    dataItem.apprAmtA        = messages["appr.approve"];

    dataItem.cntB        = messages["cmm.cancel"];
    dataItem.dcAmtB         = messages["cmm.cancel"];
    dataItem.apprAmtB         = messages["cmm.cancel"];


    s.columnHeaders.rows[0].dataItem = dataItem;

    s.itemFormatter = function (panel, r, c, cell) {
        if (panel.cellType === wijmo.grid.CellType.ColumnHeader) {
            //align in center horizontally and vertically
            panel.rows[r].allowMerging    = true;
            panel.columns[c].allowMerging = true;
            wijmo.setCss(cell, {
                display    : 'table',
                tableLayout: 'fixed'
            });
            cell.innerHTML = '<div class=\"wj-header\">' + cell.innerHTML + '</div>';
            wijmo.setCss(cell.children[0], {
                display      : 'table-cell',
                verticalAlign: 'middle',
                textAlign    : 'center'
            });
        }
        // 로우헤더 의 RowNum 표시 ( 페이징/비페이징 구분 )
        else if (panel.cellType === wijmo.grid.CellType.RowHeader) {
            // GroupRow 인 경우에는 표시하지 않는다.
            if (panel.rows[r] instanceof wijmo.grid.GroupRow) {
                cell.textContent = '';
            } else {
                if (!isEmpty(panel._rows[r]._data.rnum)) {
                    cell.textContent = (panel._rows[r]._data.rnum).toString();
                } else {
                    cell.textContent = (r + 1).toString();
                }
            }
        }
        // readOnly 배경색 표시
        else if (panel.cellType === wijmo.grid.CellType.Cell) {
            var col = panel.columns[c];
            if (col.isReadOnly) {
                wijmo.addClass(cell, 'wj-custom-readonly');
            }
        }
    }
    // <-- //그리드 헤더2줄 -->
  };


  // 다른 컨트롤러의 broadcast 받기
  $scope.$on("apprAcquireNcardCtrl", function (event, data) {
    $scope.searchApprAcquireNcardList(true);


    // 기능수행 종료 : 반드시 추가
    event.preventDefault();
  });

  //다른 컨트롤러의 broadcast 받기
  $scope.$on("apprAcquireNcardCtrlSrch", function (event, data) {
    $scope.searchApprAcquireNcardList(false);


    // 기능수행 종료 : 반드시 추가
    event.preventDefault();
  });


  // 신용카드 승인현황 리스트 조회
  $scope.searchApprAcquireNcardList = function (isPageChk) {

    // 파라미터
    var params       = {};
    params.storeCd   = $("#apprAcquireNcardSelectStoreCd").val();
    params.posNo  	 = $("#apprAcquireNcardSelectPosCd").val();
    params.saleYn	 = $scope.saleYnModel;
    params.apprProcFg = $scope.apprProcFgModel;
    params.listScale = $scope.conListScale.text; //-페이지 스케일 갯수
    params.isPageChk = isPageChk;
    params.arrCornrCol  = [];

    $scope.srchPosNo  	  = $("#apprAcquireNcardSelectPosCd").val();
    $scope.srchSaleYn	  = $scope.saleYn;
    $scope.srchApprProcFg = $scope.apprProcFg;

	//등록일자 '전체기간' 선택에 따른 params
	if(!$scope.isChecked){
	  params.startDate = wijmo.Globalize.format($scope.srchApprAcquireNcardStartDate.value, 'yyyyMMdd');
	  params.endDate = wijmo.Globalize.format($scope.srchApprAcquireNcardEndDate.value, 'yyyyMMdd');
	}
	if(params.startDate > params.endDate){
		 	$scope._popMsg(messages["prodsale.dateChk"]); // 조회종료일자가 조회시작일자보다 빠릅니다.
		 	return false;
	}

	$scope.excelStartDate	= params.startDate;
	$scope.excelEndDate 	= params.endDate;
	$scope.excelStoreCd	= params.storeCd;
	$scope.excelPosNo 	= params.posNo;
	$scope.excelCornrCd	= params.cornrCd;
	$scope.excelSaleYn 	= params.saleYn;
	$scope.excelApprProcFg	= params.apprProcFg;
	$scope.isSearch		= true;

	// 조회 수행 : 조회URL, 파라미터, 콜백함수
	$scope._inquiryMain("/sale/status/appr/acquireNcard/list.sb", params);

	$scope.editDataGrid();
  };

  //전체기간 체크박스 클릭이벤트
  $scope.isChkDt = function() {
    $scope.srchApprAcquireNcardStartDate.isReadOnly = $scope.isChecked;
    $scope.srchApprAcquireNcardEndDate.isReadOnly = $scope.isChecked;
  };

  //매장선택 모듈 팝업 사용시 정의
  // 함수명 : 모듈에 넘기는 파라미터의 targetId + 'Show'
  // _broadcast : 모듈에 넘기는 파라미터의 targetId + 'Ctrl'
  $scope.apprAcquireNcardSelectStoreShow = function () {
    $scope._broadcast('apprAcquireNcardSelectStoreCtrl');
  };

  	//포스선택 모듈 팝업 사용시 정의
	// 함수명 : 모듈에 넘기는 파라미터의 targetId + 'Show'
	// _broadcast : 모듈에 넘기는 파라미터의 targetId + 'Ctrl'
	$scope.apprAcquireNcardSelectPosShow = function () {
		$scope._broadcast('apprAcquireNcardSelectPosCtrl');
	};

//엑셀 다운로드
  $scope.excelDownloadNcard = function () {
	// 파라미터
    var params       = {};
    $scope._broadcast('apprAcquireNcardExcelCtrl',params);
  };

  //매장의 포스(pos) 리스트 조회
	$scope.getPosNmList = function () {
		var url             = '/sale/status/pos/pos/posNmList.sb';
		var comboParams     = {};

		comboParams.storeCd = $("#posNcardSelectStoreCd").val();
	};


	// 선택한 승인구분에 따른 리스트 항목 visible
	$scope.editDataGrid = function () {
        var grid = wijmo.Control.getControl("#apprAcquireNcardGrid");
        var columns = grid.columns;
        if($scope.saleYnModel == 'Y'){
        	columns[7].visible = true;
        	columns[8].visible = true;
        	columns[9].visible = true;
        	columns[10].visible = false;
        	columns[11].visible = false;
        	columns[12].visible = false;
        }else if($scope.saleYnModel == 'N'){
        	columns[7].visible = false;
        	columns[8].visible = false;
        	columns[9].visible = false;
        	columns[10].visible = true;
        	columns[11].visible = true;
        	columns[12].visible = true;
        }else{
        	columns[7].visible = true;
        	columns[8].visible = true;
        	columns[9].visible = true;
        	columns[10].visible = true;
        	columns[11].visible = true;
        	columns[12].visible = true;
        }
	}

}]);

app.controller('apprAcquireNcardExcelCtrl', ['$scope', '$http', '$timeout', function ($scope, $http, $timeout) {

	// 상위 객체 상속 : T/F 는 picker
	angular.extend(this, new RootController('apprAcquireNcardExcelCtrl', $scope, $http, $timeout, true));

	var checkInt = true;

	// grid 초기화 : 생성되기전 초기화되면서 생성된다
	$scope.initGrid = function (s, e) {

		// add the new GroupRow to the grid's 'columnFooters' panel
		s.columnFooters.rows.push(new wijmo.grid.GroupRow());
		// add a sigma to the header to show that this is a summary row
		s.bottomLeftCells.setCellData(0, 0, '합계');

		// <-- 그리드 헤더2줄 -->
		// 헤더머지
		s.allowMerging = 'ColumnHeaders';

		//헤더 생성
		s.columnHeaders.rows.push(new wijmo.grid.Row());

		// 첫째줄 헤더 생성
	    var dataItem             = {};
	    dataItem.storeCd			   = messages["rtnStatus.storeCd"];
	    dataItem.storeNm			   = messages["rtnStatus.storeNm"];

	    dataItem.acquireCd		 = messages["appr.acquire.cardCd"];
	    dataItem.acquireNm       = messages["appr.acquire.cardNm"];

	    dataItem.cnt        = messages["cmm.all"];
	    dataItem.dcAmt         = messages["cmm.all"];
	    dataItem.apprAmt         = messages["cmm.all"];

	    dataItem.cntA       = messages["appr.approve"];
	    dataItem.dcAmtA        = messages["appr.approve"];
	    dataItem.apprAmtA        = messages["appr.approve"];

	    dataItem.cntB        = messages["cmm.cancel"];
	    dataItem.dcAmtB         = messages["cmm.cancel"];
	    dataItem.apprAmtB         = messages["cmm.cancel"];


	    s.columnHeaders.rows[0].dataItem = dataItem;

		//그리드 아이템포멧 생성
		s.itemFormatter = function (panel, r, c, cell) {
			if (panel.cellType === wijmo.grid.CellType.ColumnHeader) {
				//align in center horizontally and vertically
				panel.rows[r].allowMerging    = true;
				panel.columns[c].allowMerging = true;
				wijmo.setCss(cell, {
					display    : 'table',
					tableLayout: 'fixed'
				});
				cell.innerHTML = '<div class=\"wj-header\">' + cell.innerHTML + '</div>';
				wijmo.setCss(cell.children[0], {
					display      : 'table-cell',
					verticalAlign: 'middle',
					textAlign    : 'center'
				});
			} else if (panel.cellType === wijmo.grid.CellType.RowHeader) { // 로우헤더 의 RowNum 표시 ( 페이징/비페이징 구분 )
				// GroupRow 인 경우에는 표시하지 않는다.
				if (panel.rows[r] instanceof wijmo.grid.GroupRow) {
					cell.textContent = '';
				} else {
					if (!isEmpty(panel._rows[r]._data.rnum)) {
						cell.textContent = (panel._rows[r]._data.rnum).toString();
					} else {
						cell.textContent = (r + 1).toString();
					}
				}
			} else if (panel.cellType === wijmo.grid.CellType.Cell) { // readOnly 배경색 표시
				var col = panel.columns[c];
				if (col.isReadOnly) {
					wijmo.addClass(cell, 'wj-custom-readonly');
				}
			}
		}

		// <-- //그리드 헤더2줄 -->
	};

	// 다른 컨트롤러의 broadcast 받기
	$scope.$on("apprAcquireNcardExcelCtrl", function (event, data) {

		if(data != undefined && $scope.isSearch) {
			$scope.searchApprCardExcelList();
			// 기능수행 종료 : 반드시 추가
			event.preventDefault();
		} else{
			$scope._popMsg(messages["excelUpload.not.downloadData"]); // 다운로드 할 데이터가 없습니다.
			return false;
		}

	});

	// 신용카드 승인현황 리스트 조회
	  $scope.searchApprCardExcelList = function () {

	    // 파라미터
	    var params       = {};
	    params.startDate = $scope.excelStartDate;
		params.endDate = $scope.excelEndDate;
		params.storeCd = $scope.excelStoreCd;
		params.posNo = $scope.excelPosNo;
		params.cornrCd = $scope.excelCornrCd;
		params.saleYn = $scope.excelSaleYn;
		params.apprProcFg = $scope.excelApprProcFg;

		if(params.startDate > params.endDate){
			 	$scope._popMsg(messages["prodsale.dateChk"]); // 조회종료일자가 조회시작일자보다 빠릅니다.
			 	return false;
		}

		// 조회 수행 : 조회URL, 파라미터, 콜백함수
		$scope._inquiryMain("/sale/status/appr/acquireNcard/excelList.sb", params, function() {

			var flex = $scope.excelFlex;

			if (flex.rows.length <= 0) {
				$scope._popMsg(messages["excelUpload.not.downloadData"]); // 다운로드 할 데이터가 없습니다.
				return false;
			}

			$scope.$broadcast('loadingPopupActive', messages["cmm.progress"]); // 데이터 처리중 메시지 팝업 오픈
			$timeout(function () {
				wijmo.grid.xlsx.FlexGridXlsxConverter.saveAsync(flex, {
					includeColumnHeaders: true,
					includeCellStyles   : true,
					includeColumns      : function (column) {
						return column.visible;
					}
				}, messages["dailyReport.appr"]+'_'+messages["dailyReport.acquire"]+'_'+messages["dailyReport.apprNcard"]+'_'+getToday()+'.xlsx', function () {
					$timeout(function () {
						$scope.$broadcast('loadingPopupInactive'); // 데이터 처리중 메시지 팝업 닫기
					}, 10);
				});
			}, 10);

		});

		$scope.editDataGrid();
	  };

	// 선택한 승인구분에 따른 리스트 항목 visible
		$scope.editDataGrid = function () {
	        var grid = wijmo.Control.getControl("#apprAcquireNcardExcelGrid");
	        var columns = grid.columns;
	        if($scope.excelSaleYn == 'Y'){
	        	columns[7].visible = true;
	        	columns[8].visible = true;
	        	columns[9].visible = true;
	        	columns[10].visible = false;
	        	columns[11].visible = false;
	        	columns[12].visible = false;
	        }else if($scope.excelSaleYn == 'N'){
	        	columns[7].visible = false;
	        	columns[8].visible = false;
	        	columns[9].visible = false;
	        	columns[10].visible = true;
	        	columns[11].visible = true;
	        	columns[12].visible = true;
	        }else{
	        	columns[7].visible = true;
	        	columns[8].visible = true;
	        	columns[9].visible = true;
	        	columns[10].visible = true;
	        	columns[11].visible = true;
	        	columns[12].visible = true;
	        }
		}

}]);