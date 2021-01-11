/****************************************************************
 *
 * 파일명 : monthTime.js
 * 설  명 : 기간별매출 > 월별탭 > 시간대별 JavaScript
 *
 *    수정일      수정자      Version        Function 명
 * ------------  ---------   -------------  --------------------
 * 2019.12.12     김설아      1.0
 *
 * **************************************************************/
/**
 * get application
 */
var app = agrid.getApp();

// 시간대 DropBoxDataMap
var saleTimeFgData = [
    {"name":"전체","value":""},
    {"name":"심야","value":"0"},
    {"name":"아침","value":"1"},
    {"name":"점심","value":"2"},
    {"name":"저녁","value":"3"}
];

/**
 *  시간대별 매출 조회 그리드 생성
 */
app.controller('monthTimeCtrl', ['$scope', '$http', '$timeout', function ($scope, $http, $timeout) {

    // 상위 객체 상속 : T/F 는 picker
    angular.extend(this, new RootController('monthTimeCtrl', $scope, $http, true));

    // 검색조건에 조회기간
    var startMonth = new wijmo.input.InputDate('#startMonthMonthTime', {
        format       : "yyyy-MM",
        selectionMode: "2" // 달력 선택 모드(1:day 2:month)
    });
    var endMonth = new wijmo.input.InputDate('#endMonthMonthTime', {
        format       : "yyyy-MM",
        selectionMode: "2" // 달력 선택 모드(1:day 2:month)
    });

    // 조회조건 콤보박스 데이터 Set
    $scope._setComboData("saleTimeCombo", saleTimeFgData);

    // grid 초기화 : 생성되기전 초기화되면서 생성된다
    $scope.initGrid = function (s, e) {

        // picker 사용시 호출 : 미사용시 호출안함
        $scope._makePickColumns("monthTimeCtrl");

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
        dataItem.yearMonth    = messages["month.yearMonth"];
        dataItem.storeCnt    = messages["month.storeCnt"];
        dataItem.realSaleAmt    = messages["month.tot"];
        dataItem.saleCnt    = messages["month.tot"];
        dataItem.totGuestCnt    = messages["month.tot"];

        // 시간대별 컬럼 생성
        var j=0;
        for (var i = 0; i < 24; i++) {
            j=i + 1;
            if(i<10){
                dataItem['realSaleAmtT0' + i] = i + "시 ~ " + j + "시";
                dataItem['saleCntT0' + i] = i + "시 ~ " + j + "시";
                dataItem['totGuestCntT0' + i] = i + "시 ~ " + j + "시";

            }else{
                dataItem['realSaleAmtT' + i] = i + "시 ~ " + j + "시";
                dataItem['saleCntT' + i] = i + "시 ~ " + j + "시";
                dataItem['totGuestCntT' + i] = i + "시 ~ " + j + "시";
            }
            j=0;
        }

        // 시간대 '전체' 선택 시 보이는 컬럼
        dataItem.realSaleAmtT0  = messages["month.time.T0"];
        dataItem.saleCntT0  = messages["month.time.T0"];
        dataItem.totGuestCntT0  = messages["month.time.T0"];

        dataItem.realSaleAmtT1  = messages["month.time.T1"];
        dataItem.saleCntT1  = messages["month.time.T1"];
        dataItem.totGuestCntT1  = messages["month.time.T1"];

        dataItem.realSaleAmtT2  = messages["month.time.T2"];
        dataItem.saleCntT2  = messages["month.time.T2"];
        dataItem.totGuestCntT2  = messages["month.time.T2"];

        dataItem.realSaleAmtT3  = messages["month.time.T3"];
        dataItem.saleCntT3  = messages["month.time.T3"];
        dataItem.totGuestCntT3  = messages["month.time.T3"];

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

    // <-- 검색 호출 -->
    $scope.$on("monthTimeCtrl", function(event, data) {
        $scope.searchMonthTime();
        event.preventDefault();
    });

    $scope.searchMonthTime = function() {
        var params = {};
        params.startMonth = wijmo.Globalize.format(startMonth.value, 'yyyyMM');
        params.endMonth = wijmo.Globalize.format(endMonth.value, 'yyyyMM');
        params.storeCds = $("#monthTimeStoreCd").val();
        params.saleTime = $scope.monthSaleTime;

        $scope._inquiryMain("/sale/day/month/month/getMonthTimeList.sb", params, function() {}, false);

        // 선택한 시간대에 따른 리스트 항목 visible
        var grid = wijmo.Control.getControl("#wjGridMonthTimeList");
        var columns = grid.columns;
        var start = 0;
        var end = 0;

        if($scope.monthSaleTime === "0") { //심야
            start = 5;
            end = 25;
        } else if($scope.monthSaleTime  === "1") { //아침
            start = 26;
            end = 37;
        } else if($scope.monthSaleTime  === "2") { //점심
            start = 38;
            end = 52;
        } else if($scope.monthSaleTime  === "3") { //저녁
            start = 53;
            end = 76;
        } else if($scope.monthSaleTime === "") { //전체
            start = 77;
            end = 88;
        }

        // 본사권한인 경우, 보여야 하는 컬럼 항목이 늘어나야 함(StoreCnt)
        // if($scope.orgnFg === 'H') {
        //     start++;
        //     end++;
        // }

        for(var i = 5; i <= 89; i++) {
            if(i >= start && i <= end) {
                columns[i].visible = true;
            } else {
                columns[i].visible = false;
            }
        }
    };
    // <-- //검색 호출 -->

    // 매장선택 모듈 팝업 사용시 정의
    // 함수명 : 모듈에 넘기는 파라미터의 targetId + 'Show'
    // _broadcast : 모듈에 넘기는 파라미터의 targetId + 'Ctrl'
    $scope.monthTimeStoreShow = function () {
        $scope._broadcast('monthTimeStoreCtrl');
    };

    // 엑셀 다운로드
    $scope.excelDownloadInfo = function () {

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
                messages["day.month"] + '(' + messages["month.time"] + ')_' + getCurDateTime() +'.xlsx', function () {
                    $timeout(function () {
                        $scope.$broadcast('loadingPopupInactive'); // 데이터 처리중 메시지 팝업 닫기
                    }, 10);
                });
        }, 10);
    };
}]);