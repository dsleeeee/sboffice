/****************************************************************
 *
 * 파일명 : membrNonBilClct.js
 * 설  명 : 회원 미수금현황 JavaScript
 *
 *    수정일      수정자      Version        Function 명
 * ------------  ---------   -------------  --------------------
 * 2019.11.15     김설아      1.0           두어시스템 회원/배달/KDS 소스 반영
 *
 * **************************************************************/
/**
 * get application
 */
var app = agrid.getApp();

/**
 *  회원 미수금현황 그리드 생성
 */
app.controller('membrNonBilClctCtrl', ['$scope', '$http','$timeout', function ($scope, $http, $timeout) {

    // 상위 객체 상속 : T/F 는 picker
    angular.extend(this, new RootController('membrNonBilClctCtrl', $scope, $http, true));

    // 검색조건에 조회기간
    var startDate = wcombo.genDateVal("#startDate", gvStartDate);
    var endDate = wcombo.genDateVal("#endDate", gvEndDate);

    // grid 초기화 : 생성되기전 초기화되면서 생성된다
    $scope.initGrid = function (s, e) {
        // 합계
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
        dataItem.membrNo    = messages["membrNonBilClct.membrNo"];
        dataItem.membrNm    = messages["membrNonBilClct.membrNm"];
        dataItem.postpaidAmt    = messages["membrNonBilClct.total"];
        dataItem.postpaidInAmt    = messages["membrNonBilClct.total"];
        dataItem.postpaidBalAmt    = messages["membrNonBilClct.total"];
        dataItem.postpaidAmtDt   = messages["membrNonBilClct.period"];
        dataItem.postpaidInAmtDt   = messages["membrNonBilClct.period"];

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

        //그리드 링크설정
        // ReadOnly 효과설정
        s.formatItem.addHandler(function (s, e) {
            if (e.panel === s.cells) {
                var col = s.columns[e.col];
                if (col.binding === "membrNo") {
                    var item = s.rows[e.row].dataItem;
                    wijmo.addClass(e.cell, 'wijLink');
                }
            }
        });

        // 그리드 선택 이벤트
        s.addEventListener(s.hostElement, 'mousedown', function(e) {
            var ht = s.hitTest(e);
            if( ht.cellType === wijmo.grid.CellType.Cell) {
                var col = ht.panel.columns[ht.col];

                // 회원번호 클릭시 상세정보 조회
                if ( col.binding === "membrNo") {
                    var selectedRow = s.rows[ht.row].dataItem;
                    var params      = {};
                    params.membrNo  = selectedRow.membrNo;
                    params.startDate = $scope.srchStartDate;
                    params.endDate = $scope.srchEndDate;

                    var storeScope = agrid.getScope('membrNonBilClctDetailCtrl');
                    storeScope._broadcast('membrNonBilClctDetailCtrl', params);
                    event.preventDefault();
                }
            }
        });
    };

    // <-- 검색 호출 -->
    $scope.$on("membrNonBilClctCtrl", function(event, data) {
        $scope.searchMembrNonBilClct();
        event.preventDefault();
    });

    // 회원 미수금현황 그리드 조회
    $scope.searchMembrNonBilClct = function(){
        var params = {};
        params.startDate = wijmo.Globalize.format(startDate.value, 'yyyyMMdd');
        params.endDate = wijmo.Globalize.format(endDate.value, 'yyyyMMdd');

        $scope.srchStartDate = params.startDate;
        $scope.srchEndDate = params.endDate;

        $scope._inquiryMain("/membr/anals/membrNonBilClct/membrNonBilClct/getMembrNonBilClctList.sb", params, function() {
            $scope.$apply(function() {
                var storeScope = agrid.getScope('membrNonBilClctDetailCtrl');
                storeScope._gridDataInit();
            });
        }, false);
    };
    // <-- //검색 호출 -->

    // 선택 매장
    $scope.selectedStore;
    $scope.setSelectedStore = function(store) {
        $scope.selectedStore = store;
    };
    $scope.getSelectedStore = function(){
        return $scope.selectedStore;
    };

    // 엑셀 다운로드
    $scope.excelDownload = function () {
        var today = new Date();
        var dd = today.getDate();
        var mm = today.getMonth() + 1; //January is 0!
        var yyyy = today.getFullYear();

        if (dd < 10) {
            dd = '0' + dd;
        }

        if (mm < 10) {
            mm = '0' + mm;
        }

        today = String(yyyy) + String(mm) + dd;

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
            }, '회원관리_회원분석_회원미수금현황_' + today + '.xlsx', function () {
                $timeout(function () {
                    $scope.$broadcast('loadingPopupInactive'); // 데이터 처리중 메시지 팝업 닫기
                }, 10);
            });
        }, 10);
    };

}]);

/**
 *  회원 미수금현황 상세조회 그리드 생성
 */
app.controller('membrNonBilClctDetailCtrl', ['$scope', '$http','$timeout', function ($scope, $http, $timeout) {

    // 상위 객체 상속 : T/F 는 picker
    angular.extend(this, new RootController('membrNonBilClctDetailCtrl', $scope, $http, true));

    // grid 초기화 : 생성되기전 초기화되면서 생성된다
    $scope.initGrid = function (s, e) {
        // 합계
        // add the new GroupRow to the grid's 'columnFooters' panel
        s.columnFooters.rows.push(new wijmo.grid.GroupRow());
        // add a sigma to the header to show that this is a summary row
        s.bottomLeftCells.setCellData(0, 0, '합계');
    };

    // <-- 검색 호출 -->
    $scope.$on("membrNonBilClctDetailCtrl", function(event, data) {
        if( !isEmptyObject(data) ) {
            $scope.setSelectedStoreDetail(data);
        }
        $scope.searchMembrNonBilClctDetailList();
        event.preventDefault();
    });

    // 회원 미수금현황 상세 그리드 조회
    $scope.searchMembrNonBilClctDetailList = function() {
        var params = {};
        params.membrNo = $scope.selectedStoreDetail.membrNo;
        params.startDate = $scope.selectedStoreDetail.startDate;
        params.endDate = $scope.selectedStoreDetail.endDate;

        $scope._inquiryMain("/membr/anals/membrNonBilClct/membrNonBilClct/getMembrNonBilClctDetailList.sb", params, function() {}, false);
    };
    // <-- //검색 호출 -->

    // 선택 매장
    $scope.selectedStoreDetail;
    $scope.setSelectedStoreDetail = function(store) {
        $scope.selectedStoreDetail = store;
    };
    $scope.getSelectedStoreDetail = function(){
        return $scope.selectedStoreDetail;
    };

    // 엑셀 다운로드
    $scope.excelDownload = function () {
        var today = new Date();
        var dd = today.getDate();
        var mm = today.getMonth() + 1; //January is 0!
        var yyyy = today.getFullYear();

        if (dd < 10) {
            dd = '0' + dd;
        }

        if (mm < 10) {
            mm = '0' + mm;
        }

        today = String(yyyy) + String(mm) + dd;

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
            }, '회원관리_회원분석_회원미수금현황_' + today + '.xlsx', function () {
                $timeout(function () {
                    $scope.$broadcast('loadingPopupInactive'); // 데이터 처리중 메시지 팝업 닫기
                }, 10);
            });
        }, 10);
    };

}]);