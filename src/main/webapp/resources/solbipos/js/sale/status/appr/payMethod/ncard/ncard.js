/**
 * get application
 */
var app = agrid.getApp();

/** 일자별(코너별 매출) controller */
app.controller('apprNcardCtrl', ['$scope', '$http', '$timeout', function ($scope, $http, $timeout) {
  // 상위 객체 상속 : T/F 는 picker
  angular.extend(this, new RootController('apprNcardCtrl', $scope, $http, $timeout, true));

  $scope.srchApprNcardStartDate = wcombo.genDateVal("#srchApprNcardStartDate", getToday());
  $scope.srchApprNcardEndDate   = wcombo.genDateVal("#srchApprNcardEndDate", getToday());

  //조회조건 콤보박스 데이터 Set
  $scope._setComboData("apprNcardListScaleBox", gvListScaleBoxData);
  
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
    $scope._makePickColumns("apprNcardCtrl");

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
	        if(params.posNo == "" && params.cornrCd == ""){
	        	params.storeCd   = selectedRow.storeCd;
	        }
	    	if(!$scope.isChecked){
	    		  params.startDate = wijmo.Globalize.format($scope.srchApprNcardStartDate.value, 'yyyyMMdd');
	    		  params.endDate = wijmo.Globalize.format($scope.srchApprNcardEndDate.value, 'yyyyMMdd');
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
  $scope.$on("apprNcardCtrl", function (event, data) {
    $scope.searchApprNcardList(true);
    
    
    // 기능수행 종료 : 반드시 추가
    event.preventDefault();
  });
  
  // 다른 컨트롤러의 broadcast 받기
  $scope.$on("apprNcardCtrlSrch", function (event, data) {
    $scope.searchApprNcardList(false);
    
    
    // 기능수행 종료 : 반드시 추가
    event.preventDefault();
  });


  // 신용카드 승인현황 리스트 조회
  $scope.searchApprNcardList = function (isPageChk) {

    // 파라미터
    var params       = {};
    params.storeCd   = $("#apprNcardSelectStoreCd").val();
    params.posNo  	 = $("#apprNcardSelectPosCd").val();
    params.saleYn	 = $scope.saleYn;
    params.apprProcFg = $scope.apprProcFg;
    params.listScale = $scope.conListScale.text; //-페이지 스케일 갯수
    params.isPageChk = isPageChk;
    params.arrCornrCol  = [];
    
    $scope.srchPosNo  	  = $("#apprNcardSelectPosCd").val();
    $scope.srchSaleYn	  = $scope.saleYn;
    $scope.srchApprProcFg = $scope.apprProcFg;    

	//등록일자 '전체기간' 선택에 따른 params
	if(!$scope.isChecked){
	  params.startDate = wijmo.Globalize.format($scope.srchApprNcardStartDate.value, 'yyyyMMdd');
	  params.endDate = wijmo.Globalize.format($scope.srchApprNcardEndDate.value, 'yyyyMMdd');
	}
	if(params.startDate > params.endDate){
		 	$scope._popMsg(messages["prodsale.dateChk"]); // 조회종료일자가 조회시작일자보다 빠릅니다.
		 	return false;
	}
		
	// 조회 수행 : 조회URL, 파라미터, 콜백함수
	$scope._inquiryMain("/sale/status/appr/ncard/list.sb", params);
	
	$scope.editDataGrid();
  };

  //전체기간 체크박스 클릭이벤트
  $scope.isChkDt = function() {
    $scope.srchApprNcardStartDate.isReadOnly = $scope.isChecked;
    $scope.srchApprNcardEndDate.isReadOnly = $scope.isChecked;
  };

  //매장선택 모듈 팝업 사용시 정의
  // 함수명 : 모듈에 넘기는 파라미터의 targetId + 'Show'
  // _broadcast : 모듈에 넘기는 파라미터의 targetId + 'Ctrl'
  $scope.apprNcardSelectStoreShow = function () {
    $scope._broadcast('apprNcardSelectStoreCtrl');
  };

  	//포스선택 모듈 팝업 사용시 정의
	// 함수명 : 모듈에 넘기는 파라미터의 targetId + 'Show'
	// _broadcast : 모듈에 넘기는 파라미터의 targetId + 'Ctrl'
	$scope.apprNcardSelectPosShow = function () {
		$scope._broadcast('apprNcardSelectPosCtrl');
	};
	
//엑셀 다운로드
  $scope.excelDownloadNcard = function () {
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
      }, '승인현황_승인현황_비매출카드_'+getToday()+'.xlsx', function () {
        $timeout(function () {
          $scope.$broadcast('loadingPopupInactive'); // 데이터 처리중 메시지 팝업 닫기
        }, 10);
      });
    }, 10);
  };
  
  //매장의 포스(pos) 리스트 조회
	$scope.getPosNmList = function () {
		var url             = '/sale/status/pos/pos/posNmList.sb';
		var comboParams     = {};

		comboParams.storeCd = $("#posNcardSelectStoreCd").val();
	};


	// 선택한 승인구분에 따른 리스트 항목 visible
	$scope.editDataGrid = function () {
        var grid = wijmo.Control.getControl("#apprNcardGrid");
        var columns = grid.columns;
        if($scope.saleYn == "Y"){
        	columns[5].visible = true;
        	columns[6].visible = true;
        	columns[7].visible = true;
        	columns[8].visible = false;
        	columns[9].visible = false;
        	columns[10].visible = false;
        }else if($scope.saleYn == "N"){
        	columns[5].visible = false;
        	columns[6].visible = false;
        	columns[7].visible = false;
        	columns[8].visible = true;
        	columns[9].visible = true;
        	columns[10].visible = true;
        }else{
        	columns[5].visible = true;
        	columns[6].visible = true;
        	columns[7].visible = true;
        	columns[8].visible = true;
        	columns[9].visible = true;
        	columns[10].visible = true;
        }
	}
	
}]);