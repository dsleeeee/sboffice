/**
 * get application
 */
var app = agrid.getApp();

/** 상품별(포스별 매출) controller */
app.controller('prodPosCtrl', ['$scope', '$http', '$timeout', function ($scope, $http, $timeout) {

	// 상위 객체 상속 : T/F 는 picker
	angular.extend(this, new RootController('prodPosCtrl', $scope, $http, $timeout, true));

	$scope.srchPosProdStartDate = wcombo.genDateVal("#srchPosProdStartDate", getToday());
	$scope.srchPosProdEndDate   = wcombo.genDateVal("#srchPosProdEndDate", getToday());
	$scope.orgnFg = gvOrgnFg;
	$scope.isSearch = false;
	
	//조회조건 콤보박스 데이터 Set
	$scope._setComboData("posProdListScaleBox", gvListScaleBoxData);

	var checkInt = true;

	// grid 초기화 : 생성되기전 초기화되면서 생성된다
	$scope.initGrid = function (s, e) {

		// picker 사용시 호출 : 미사용시 호출안함
		$scope._makePickColumns("prodPosCtrl");

		// add the new GroupRow to the grid's 'columnFooters' panel
		s.columnFooters.rows.push(new wijmo.grid.GroupRow());
		// add a sigma to the header to show that this is a summary row
		s.bottomLeftCells.setCellData(0, 0, '합계');

		// <-- 그리드 헤더2줄 -->
		// 헤더머지
		s.allowMerging = 'ColumnHeaders';

		//헤더 생성
		s.columnHeaders.rows.push(new wijmo.grid.Row());
		s.columnHeaders.rows.push(new wijmo.grid.Row());

		for(var i = 0; i < s.columnHeaders.rows.length; i++) {
			s.columnHeaders.setCellData(i, "lv1Nm", messages["prodrank.prodClassLNm"]);
			s.columnHeaders.setCellData(i, "lv2Nm", messages["prodrank.prodClassMNm"]);
			s.columnHeaders.setCellData(i, "lv3Nm", messages["prodrank.prodClassSNm"]);
			s.columnHeaders.setCellData(i, "prodNm", messages["pos.prodNm"]);
			s.columnHeaders.setCellData(i, "saleStoreCnt", messages["pos.saleStore"]);
			s.columnHeaders.setCellData(i, "totSaleAmt", messages["pos.totSaleAmt"]);
			s.columnHeaders.setCellData(i, "totDcAmt", messages["pos.totDcAmt"]);
			s.columnHeaders.setCellData(i, "totRealSaleAmt", messages["pos.totRealSaleAmt"]);
			s.columnHeaders.setCellData(i, "totSaleCnt", messages["pos.totSaleQty"]);
		}

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
		};
		// <-- //그리드 헤더2줄 -->

		// 그리드 클릭 이벤트
    	s.addEventListener(s.hostElement, 'mousedown', function (e) {
	    	var ht = s.hitTest(e);

	    	/* 머지된 헤더 셀 클릭시 정렬 비활성화
	    	 * 헤더 cellType: 2 && 머지된 row 인덱스: 0, 1 && 동적 생성된 column 인덱스 4 초과
	    	 * 머지영역 클릭시 소트 비활성화, 다른 영역 클릭시 소트 활성화
	    	 */
	    	if(ht.cellType == 2 && ht.row < 2 && ht.col > 8) {
	    		s.allowSorting = false;
    		} else {
    			s.allowSorting = true;
    		}
    	});
	};

	// 다른 컨트롤러의 broadcast 받기
	$scope.$on("prodPosCtrl", function (event, data) {

		$scope.searchPosProdList(true);

		var storeCd = $("#posProdSelectStoreCd").val();
		var posCd = $("#posProdSelectPosCd").val();

		$scope.getRePosNmList(storeCd, posCd, true);
	});

	// 다른 컨트롤러의 broadcast 받기
	$scope.$on("prodPosCtrlSrch", function (event, data) {

	    if( $("#posProdSelectStoreCd").val() === ''){
	   	 	$scope._popMsg(messages["prodsale.day.require.selectStore"]); // 매장을 선택해 주세요.
	   	 	return false;
	    }

		$scope.searchPosProdList(false);

		var storeCd = $("#posProdSelectStoreCd").val();
		var posCd = $("#posProdSelectPosCd").val();

		$scope.getRePosNmList(storeCd, posCd, true);
	});

	// 포스별매출상품별 리스트 조회
	$scope.searchPosProdList = function (isPageChk) {

		// 파라미터
		var params = {};
		params.storeCd = $("#posProdSelectStoreCd").val();
		params.posNo = $("#posProdSelectPosCd").val();
		params.listScale = $scope.listScaleCombo.text; //-페이지 스케일 갯수
		params.arrPosCd = $scope.comboArray; //-포스정보
		params.isPageChk = isPageChk;
	    params.orgnFg    = $scope.orgnFg;
	    
	    $scope.excelStartDate	= "";
		$scope.excelEndDate 	= "";
		$scope.excelStoreCd		= params.storeCd;
		$scope.excelPosNo		= params.posNo;
		$scope.excelListScale	= params.listScale;
		$scope.excelArrPosCd	= params.arrPosCd;
		$scope.excelOrgnFg		= params.orgnFg;
		$scope.isSearch			= true;

		//등록일자 '전체기간' 선택에 따른 params
		if(!$scope.isChecked){
			params.startDate = wijmo.Globalize.format($scope.srchPosProdStartDate.value, 'yyyyMMdd');
			params.endDate = wijmo.Globalize.format($scope.srchPosProdEndDate.value, 'yyyyMMdd');
		}
		
		$scope.excelStartDate	= params.startDate;
		$scope.excelEndDate 	= params.endDate;

		if(params.startDate > params.endDate){
			$scope._popMsg(messages["prodsale.dateChk"]); // 조회종료일자가 조회시작일자보다 빠릅니다.
			return false;
		}
		
		
		
		// 조회 수행 : 조회URL, 파라미터, 콜백함수
		$scope._inquiryMain("/sale/status/prod/prodPos/list.sb", params, function() {

			// var flex = $scope.flex;
			//row수가 0이면
			// if(flex.rows.length === 0){
			//
			// 	var grid = wijmo.Control.getControl("#posProdGrid");
			// 	//컬럼 삭제
			// 	while(grid.columns.length > 6){
			//           grid.columns.removeAt(grid.columns.length-1);
			//     }
			// }

		});
	};

	//전체기간 체크박스 클릭이벤트
	$scope.isChkDt = function() {
		$scope.srchPosProdStartDate.isReadOnly = $scope.isChecked;
		$scope.srchPosProdEndDate.isReadOnly = $scope.isChecked;
	};

    // 상품분류 항목표시 체크에 따른 대분류, 중분류, 소분류 표시
    $scope.isChkProdClassDisplay = function(){
  	  var columns = $scope.flex.columns;

  	  for(var i=0; i<columns.length; i++){
  		  if(columns[i].binding === 'lv1Nm' || columns[i].binding === 'lv2Nm' || columns[i].binding === 'lv3Nm'){
  			  $scope.ChkProdClassDisplay ? columns[i].visible = true : columns[i].visible = false;
  		  }
  	  }
    };

	//매장선택 모듈 팝업 사용시 정의
	// 함수명 : 모듈에 넘기는 파라미터의 targetId + 'Show'
	// _broadcast : 모듈에 넘기는 파라미터의 targetId + 'Ctrl'
	$scope.posProdSelectStoreShow = function () {
		$scope._broadcast('posProdSelectStoreCtrl');
	};

	//포스선택 모듈 팝업 사용시 정의
	// 함수명 : 모듈에 넘기는 파라미터의 targetId + 'Show'
	// _broadcast : 모듈에 넘기는 파라미터의 targetId + 'Ctrl'
	$scope.posProdSelectPosShow = function () {
		$scope._broadcast('posProdSelectPosCtrl');
	};


	//매장의 포스(pos) 리스트 조회
	$scope.getPosNmList = function () {
//		var url             = '/sale/status/pos/pos/posNmList.sb';
		var comboParams     = {};

		var storeCd = $("#posProdSelectStoreCd").val();
		var posCd = $("#posProdSelectPosCd").val();
		$scope.getRePosNmList(storeCd,posCd,false)
	};

	//매장의 포스 리스트 재생성
	$scope.getRePosNmList = function (storeCd, posCd, gridSet) {
		var url = "/sale/status/pos/pos/posNmList.sb";
		var params = {};
	    params.storeCd = storeCd;
	    params.posNo = posCd;

	    // ajax 통신 설정
	    $http({
	    	method : 'POST', //방식
	    	url    : url, /* 통신할 URL */
	    	params : params, /* 파라메터로 보낼 데이터 */
	    	headers: {'Content-Type': 'application/json; charset=utf-8'} //헤더
	    }).then(function successCallback(response) {
	    	if ($scope._httpStatusCheck(response, true)) {
	    		if (!$.isEmptyObject(response.data.data.list)) {
	    			var list       = response.data.data.list;
	    			var arrStorePos = [];
	    			var arrStorePosNm = [];

	    			for (var i = 0; i < list.length; i++) {
	    				arrStorePos.push(list[i].posCd);
	    				arrStorePosNm.push(list[i].storeNm + "||" + list[i].posNm);
	    			}

	    			$("#posProdSelectPosCd").val(arrStorePos.join());
	    			$("#posProdSelectPosName").val(arrStorePosNm.join());

	    			storePosCd = $("#posProdSelectPosCd").val();
	    			storePosNm = $("#posProdSelectPosName").val();
					storePosCount = list.length;
	    			if(gridSet){
	    				$scope.makeDataGrid();
	    			}
	    		}
	    	}
	    }, function errorCallback(response) {
	      $scope._popMsg(messages["cmm.error"]);
	      return false;
	    }).then(function () {

	    });
	  };

	  $scope.makeDataGrid = function () {

		  var grid = wijmo.Control.getControl("#posProdGrid");

		  var colLength = grid.columns.length;

		  if (grid.columns.length > 9) {
			  for(var i = 9; i < colLength; i++) {
				  grid.columns.removeAt(grid.columns.length-1);
			  }
		  }

		  var arrPosCd = storePosCd.split(',');
		  var arrPosNm = storePosNm.split(',');

		  if (storePosCount > 0) {
		  // if (arrPosCd != null) {

			  for(var i = 1; i < arrPosCd.length + 1; i++) {

				  var colValue = arrPosCd[i-1];
				  var colName = arrPosNm[i-1];
				  var colSplit = colName.split('||');
				  var colSplit2 = colValue.split('||');

				  grid.columns.push(new wijmo.grid.Column({binding: "'"+colValue.toLowerCase()+"'SaleAmt", width: 100, align: "right", isReadOnly: "true", aggregate: "Sum"}));
				  grid.columns.push(new wijmo.grid.Column({binding: "'"+colValue.toLowerCase()+"'DcAmt", width: 100, align: "right", isReadOnly: "true", aggregate: "Sum"}));
				  grid.columns.push(new wijmo.grid.Column({binding: "'"+colValue.toLowerCase()+"'RealSaleAmt", width: 100, align: "right", isReadOnly: "true", aggregate: "Sum"}));
				  grid.columns.push(new wijmo.grid.Column({binding: "'"+colValue.toLowerCase()+"'SaleCnt", width: 100, align: "right", isReadOnly: "true", aggregate: "Sum"}));

				  grid.columnHeaders.setCellData(0, "'"+colValue.toLowerCase()+"'SaleAmt", colSplit[0]+"("+colSplit2[0]+")");
				  grid.columnHeaders.setCellData(0, "'"+colValue.toLowerCase()+"'DcAmt", colSplit[0]+"("+colSplit2[0]+")");
				  grid.columnHeaders.setCellData(0, "'"+colValue.toLowerCase()+"'RealSaleAmt", colSplit[0]+"("+colSplit2[0]+")");
				  grid.columnHeaders.setCellData(0, "'"+colValue.toLowerCase()+"'SaleCnt", colSplit[0]+"("+colSplit2[0]+")");

				  grid.columnHeaders.setCellData(1, "'"+colValue.toLowerCase()+"'SaleAmt", colSplit[1]);
				  grid.columnHeaders.setCellData(1, "'"+colValue.toLowerCase()+"'DcAmt", colSplit[1]);
				  grid.columnHeaders.setCellData(1, "'"+colValue.toLowerCase()+"'RealSaleAmt", colSplit[1]);
				  grid.columnHeaders.setCellData(1, "'"+colValue.toLowerCase()+"'SaleCnt", colSplit[1]);

				  grid.columnHeaders.setCellData(2, "'"+colValue.toLowerCase()+"'SaleAmt", messages["pos.SaleAmt"]);
				  grid.columnHeaders.setCellData(2, "'"+colValue.toLowerCase()+"'DcAmt", messages["pos.DcAmt"]);
				  grid.columnHeaders.setCellData(2, "'"+colValue.toLowerCase()+"'RealSaleAmt", messages["pos.realSaleAmt"]);
				  grid.columnHeaders.setCellData(2, "'"+colValue.toLowerCase()+"'SaleCnt", messages["pos.saleQty"]);

			  }
		  }

		  grid.itemFormatter = function (panel, r, c, cell) {

			  if (panel.cellType === wijmo.grid.CellType.ColumnHeader) {
				  //align in center horizontally and vertically
				  panel.rows[r].allowMerging    = true;
				  panel.columns[c].allowMerging = true;

				  wijmo.setCss(cell, {
					  display : 'table',
					  tableLayout : 'fixed'
				  });

				  cell.innerHTML = '<div class=\"wj-header\">' + cell.innerHTML + '</div>';

				  wijmo.setCss(cell.children[0], {
					  display : 'table-cell',
					  verticalAlign : 'middle',
					  textAlign : 'center'
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

		  };

		  $scope.flex.refresh();

		  // 기능수행 종료 : 반드시 추가
		  event.preventDefault();
	  };

	  $scope.loadedRows = function (s, e) {

		  var rowLength = s.rows.length;
		  var arrPosCd = storePosCd.split(',');
		  var arrPosNm = storePosNm.split(',');

		  if (arrPosCd != null) {

			  for(var i = 1; i < arrPosCd.length + 1; i++) {

				  var colValue = arrPosCd[i-1];
				  var colName = arrPosNm[i-1];
				  var colSplit = colName.split('||');

				  for(var j = 0; j < rowLength; j++) {

					  var saleAmt = s.getCellData(j, "'"+colValue.toLowerCase()+"'SaleAmt", false);
					  var dcAmt = s.getCellData(j, "'"+colValue.toLowerCase()+"'DcAmt", false);
					  var realSaleAmt = s.getCellData(j, "'"+colValue.toLowerCase()+"'RealSaleAmt", false);
					  var saleCnt = s.getCellData(j, "'"+colValue.toLowerCase()+"'SaleCnt", false);

					  if (saleAmt == null || saleAmt == "") {
						  s.setCellData(j, "'"+colValue.toLowerCase()+"'SaleAmt", "0");
					  }

					  if (dcAmt == null || dcAmt == "") {
						  s.setCellData(j, "'"+colValue.toLowerCase()+"'DcAmt", "0");
					  }

					  if (realSaleAmt == null || realSaleAmt == "") {
						  s.setCellData(j, "'"+colValue.toLowerCase()+"'RealSaleAmt", "0");
					  }

					  if (saleCnt == null || saleCnt == "") {
						  s.setCellData(j, "'"+colValue.toLowerCase()+"'SaleCnt", "0");
					  }
				  }
			  }
		  }
	  };

	 $scope.excelDownloadPos = function () {
		  var params       = {};
		/* 엑셀다운로드 */
		$scope._broadcast('prodPosExcelCtrl', params);
	  };

}]);

/** 상품별(포스별 매출) controller */
app.controller('prodPosExcelCtrl', ['$scope', '$http', '$timeout', function ($scope, $http, $timeout) {

	// 상위 객체 상속 : T/F 는 picker
	angular.extend(this, new RootController('prodPosExcelCtrl', $scope, $http, $timeout, true));

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
		s.columnHeaders.rows.push(new wijmo.grid.Row());

		for(var i = 0; i < s.columnHeaders.rows.length; i++) {
			s.columnHeaders.setCellData(i, "lv1Nm", messages["prodrank.prodClassLNm"]);
			s.columnHeaders.setCellData(i, "lv2Nm", messages["prodrank.prodClassMNm"]);
			s.columnHeaders.setCellData(i, "lv3Nm", messages["prodrank.prodClassSNm"]);
			s.columnHeaders.setCellData(i, "prodNm", messages["pos.prodNm"]);
			s.columnHeaders.setCellData(i, "saleStoreCnt", messages["pos.saleStore"]);
			s.columnHeaders.setCellData(i, "totSaleAmt", messages["pos.totSaleAmt"]);
			s.columnHeaders.setCellData(i, "totDcAmt", messages["pos.totDcAmt"]);
			s.columnHeaders.setCellData(i, "totRealSaleAmt", messages["pos.totRealSaleAmt"]);
			s.columnHeaders.setCellData(i, "totSaleCnt", messages["pos.totSaleQty"]);
		}

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
	$scope.$on("prodPosExcelCtrl", function (event, data) {

		$scope.searchPosProdExcelList(true);
	});

	

	// 포스별매출상품별 리스트 조회
	$scope.searchPosProdExcelList = function (isPageChk) {

		// 파라미터
		var params = {};
		params.startDate	=	$scope.excelStartDate;
		params.endDate		=	$scope.excelEndDate;
		params.storeCd		=	$scope.excelStoreCd;
		params.posNo		=	$scope.excelPosNo;
		params.listScale	=	$scope.excelListScale;
		params.arrPosCd		=	$scope.excelArrPosCd;
		params.orgnFg		=	$scope.excelOrgnFg;
		
		$scope.getRePosNmExcelList($scope.excelStoreCd, $("#posProdSelectPosCd").val());

		

		$scope.isChkProdClassDisplay();
		
		
		
		// 조회 수행 : 조회URL, 파라미터, 콜백함수
		$scope._inquiryMain("/sale/status/prod/prodPos/excelList.sb", params, function() {
			
			if ($scope.excelFlex.rows.length <= 0) {
				$scope._popMsg(messages["excelUpload.not.downloadData"]); // 다운로드 할 데이터가 없습니다.
				return false;
			}

			$scope.$broadcast('loadingPopupActive', messages["cmm.progress"]); // 데이터 처리중 메시지 팝업 오픈
			$timeout(function () {
				wijmo.grid.xlsx.FlexGridXlsxConverter.saveAsync($scope.excelFlex, {
					includeColumnHeaders: true,
					includeCellStyles   : true,
					includeColumns      : function (column) {
						return column.visible;
					}
				}, '매출현황_상품별_포스별_'+getToday()+'.xlsx', function () {
					$timeout(function () {
						$scope.$broadcast('loadingPopupInactive'); // 데이터 처리중 메시지 팝업 닫기
					}, 10);
				});
			}, 10);
			
		});
	};
	
	//매장의 포스 리스트 재생성
	$scope.getRePosNmExcelList = function (storeCd, posCd, gridSet) {
		var url = "/sale/status/pos/pos/posNmList.sb";
		var params = {};
	    params.storeCd = storeCd;
	    params.posNo = posCd;

	    // ajax 통신 설정
	    $http({
	    	method : 'POST', //방식
	    	url    : url, /* 통신할 URL */
	    	params : params, /* 파라메터로 보낼 데이터 */
	    	headers: {'Content-Type': 'application/json; charset=utf-8'} //헤더
	    }).then(function successCallback(response) {
	    	if ($scope._httpStatusCheck(response, true)) {
	    		if (!$.isEmptyObject(response.data.data.list)) {
	    			var list       = response.data.data.list;
	    			var arrStorePos = [];
	    			var arrStorePosNm = [];

	    			for (var i = 0; i < list.length; i++) {
	    				arrStorePos.push(list[i].posCd);
	    				arrStorePosNm.push(list[i].storeNm + "||" + list[i].posNm);
	    			}

	    			$("#posProdSelectPosCd").val(arrStorePos.join());
	    			$("#posProdSelectPosName").val(arrStorePosNm.join());

	    			storePosCd = $("#posProdSelectPosCd").val();
	    			storePosNm = $("#posProdSelectPosName").val();
					storePosCount = list.length;

	    			$scope.makeDataGrid();
	    			
	    		}
	    	}
	    }, function errorCallback(response) {
	      $scope._popMsg(messages["cmm.error"]);
	      return false;
	    }).then(function () {

	    });
	  };


    // 상품분류 항목표시 체크에 따른 대분류, 중분류, 소분류 표시
    $scope.isChkProdClassDisplay = function(){
  	  var columns = $scope.excelFlex.columns;

  	  for(var i=0; i<columns.length; i++){
  		  if(columns[i].binding === 'lv1Nm' || columns[i].binding === 'lv2Nm' || columns[i].binding === 'lv3Nm'){
  			  $scope.ChkProdClassDisplay ? columns[i].visible = true : columns[i].visible = false;
  		  }
  	  }
    };

	

	  $scope.makeDataGrid = function () {

		  var grid = wijmo.Control.getControl("#posProdExcelGrid");

		  var colLength = grid.columns.length;

		  if (grid.columns.length > 9) {
			  for(var i = 9; i < colLength; i++) {
				  grid.columns.removeAt(grid.columns.length-1);
			  }
		  }

		  var arrPosCd = storePosCd.split(',');
		  var arrPosNm = storePosNm.split(',');

		  if (storePosCount > 0) {
		  // if (arrPosCd != null) {

			  for(var i = 1; i < arrPosCd.length + 1; i++) {

				  var colValue = arrPosCd[i-1];
				  var colName = arrPosNm[i-1];
				  var colSplit = colName.split('||');
				  var colSplit2 = colValue.split('||');

				  grid.columns.push(new wijmo.grid.Column({binding: "'"+colValue.toLowerCase()+"'SaleAmt", width: 100, align: "right", isReadOnly: "true", aggregate: "Sum"}));
				  grid.columns.push(new wijmo.grid.Column({binding: "'"+colValue.toLowerCase()+"'DcAmt", width: 100, align: "right", isReadOnly: "true", aggregate: "Sum"}));
				  grid.columns.push(new wijmo.grid.Column({binding: "'"+colValue.toLowerCase()+"'RealSaleAmt", width: 100, align: "right", isReadOnly: "true", aggregate: "Sum"}));
				  grid.columns.push(new wijmo.grid.Column({binding: "'"+colValue.toLowerCase()+"'SaleCnt", width: 100, align: "right", isReadOnly: "true", aggregate: "Sum"}));

				  grid.columnHeaders.setCellData(0, "'"+colValue.toLowerCase()+"'SaleAmt", colSplit[0]+"("+colSplit2[0]+")");
				  grid.columnHeaders.setCellData(0, "'"+colValue.toLowerCase()+"'DcAmt", colSplit[0]+"("+colSplit2[0]+")");
				  grid.columnHeaders.setCellData(0, "'"+colValue.toLowerCase()+"'RealSaleAmt", colSplit[0]+"("+colSplit2[0]+")");
				  grid.columnHeaders.setCellData(0, "'"+colValue.toLowerCase()+"'SaleCnt", colSplit[0]+"("+colSplit2[0]+")");

				  grid.columnHeaders.setCellData(1, "'"+colValue.toLowerCase()+"'SaleAmt", colSplit[1]);
				  grid.columnHeaders.setCellData(1, "'"+colValue.toLowerCase()+"'DcAmt", colSplit[1]);
				  grid.columnHeaders.setCellData(1, "'"+colValue.toLowerCase()+"'RealSaleAmt", colSplit[1]);
				  grid.columnHeaders.setCellData(1, "'"+colValue.toLowerCase()+"'SaleCnt", colSplit[1]);

				  grid.columnHeaders.setCellData(2, "'"+colValue.toLowerCase()+"'SaleAmt", messages["pos.SaleAmt"]);
				  grid.columnHeaders.setCellData(2, "'"+colValue.toLowerCase()+"'DcAmt", messages["pos.DcAmt"]);
				  grid.columnHeaders.setCellData(2, "'"+colValue.toLowerCase()+"'RealSaleAmt", messages["pos.realSaleAmt"]);
				  grid.columnHeaders.setCellData(2, "'"+colValue.toLowerCase()+"'SaleCnt", messages["pos.saleQty"]);

			  }
		  }

		  grid.itemFormatter = function (panel, r, c, cell) {

			  if (panel.cellType === wijmo.grid.CellType.ColumnHeader) {
				  //align in center horizontally and vertically
				  panel.rows[r].allowMerging    = true;
				  panel.columns[c].allowMerging = true;

				  wijmo.setCss(cell, {
					  display : 'table',
					  tableLayout : 'fixed'
				  });

				  cell.innerHTML = '<div class=\"wj-header\">' + cell.innerHTML + '</div>';

				  wijmo.setCss(cell.children[0], {
					  display : 'table-cell',
					  verticalAlign : 'middle',
					  textAlign : 'center'
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

		  };

		  $scope.excelFlex.refresh();

		  // 기능수행 종료 : 반드시 추가
		  event.preventDefault();
	  };

	  $scope.loadedRows = function (s, e) {

		  var rowLength = s.rows.length;
		  var arrPosCd = storePosCd.split(',');
		  var arrPosNm = storePosNm.split(',');

		  if (arrPosCd != null) {

			  for(var i = 1; i < arrPosCd.length + 1; i++) {

				  var colValue = arrPosCd[i-1];
				  var colName = arrPosNm[i-1];
				  var colSplit = colName.split('||');

				  for(var j = 0; j < rowLength; j++) {

					  var saleAmt = s.getCellData(j, "'"+colValue.toLowerCase()+"'SaleAmt", false);
					  var dcAmt = s.getCellData(j, "'"+colValue.toLowerCase()+"'DcAmt", false);
					  var realSaleAmt = s.getCellData(j, "'"+colValue.toLowerCase()+"'RealSaleAmt", false);
					  var saleCnt = s.getCellData(j, "'"+colValue.toLowerCase()+"'SaleCnt", false);

					  if (saleAmt == null || saleAmt == "") {
						  s.setCellData(j, "'"+colValue.toLowerCase()+"'SaleAmt", "0");
					  }

					  if (dcAmt == null || dcAmt == "") {
						  s.setCellData(j, "'"+colValue.toLowerCase()+"'DcAmt", "0");
					  }

					  if (realSaleAmt == null || realSaleAmt == "") {
						  s.setCellData(j, "'"+colValue.toLowerCase()+"'RealSaleAmt", "0");
					  }

					  if (saleCnt == null || saleCnt == "") {
						  s.setCellData(j, "'"+colValue.toLowerCase()+"'SaleCnt", "0");
					  }
				  }
			  }
		  }
	  }
}]);
