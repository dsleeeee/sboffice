/****************************************************************
 *
 * 파일명 : dayOfWeekTime.js
 * 설  명 : 기간별매출 > 요일별탭 > 시간대별탭 JavaScript
 *
 *    수정일      수정자      Version        Function 명
 * ------------  ---------   -------------  --------------------
 * 2019.12.04     김설아      1.0
 *
 * **************************************************************/
/**
 * get application
 */
var app = agrid.getApp();

// 시 VALUE
var Hh = [24];
for(i =0 ; i < 24; i++){
    var timeVal = i.toString();
    if(i>=0 && i<=9){
        timeVal = "0" + timeVal;
    }
    Hh[i] = {"name":timeVal,"value":timeVal}
}

/**
 *  시간대별 매출 조회 그리드 생성
 */
app.controller('dayOfWeekTimeCtrl', ['$scope', '$http', '$timeout', function ($scope, $http, $timeout) {

    // 상위 객체 상속 : T/F 는 picker
    angular.extend(this, new RootController('dayOfWeekTimeCtrl', $scope, $http, true));

    // 검색조건에 조회기간
    var startDate = wcombo.genDateVal("#startDateDayOfWeekTime", gvStartDate);
    var endDate = wcombo.genDateVal("#endDateDayOfWeekTime", gvEndDate);

    $scope.timeSlotData = [];
    var comboArray  = [{name:"전체", value:""}];
    for(var i = 0; i < timeSlotColList.length; i++){
        var comboData   = {};
        comboData.name = timeSlotColList[i].name + "(" + timeSlotColList[i].value + ")";
        comboData.value = timeSlotColList[i].value;
        comboArray.push(comboData);
    }

    timeSlotData = comboArray;
    $scope._setComboData("timeSlotCombo", timeSlotData);

    // 조회조건 콤보박스 데이터 Set
    $scope._setComboData("startTimeCombo", Hh);
    $scope._setComboData("endTimeCombo", Hh);
    $scope.startTime     = "0";
    $scope.endTime       = "23";

    // grid 초기화 : 생성되기전 초기화되면서 생성된다
    $scope.initGrid = function (s, e) {

        // picker 사용시 호출 : 미사용시 호출안함
        $scope._makePickColumns("dayOfWeekTimeCtrl");

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
        dataItem.yoil    = messages["dayofweek.yoil"];
        dataItem.storeCnt    = messages["dayofweek.storeCnt"];
        dataItem.realSaleAmt    = messages["dayofweek.tot"];
        dataItem.saleCnt    = messages["dayofweek.tot"];
        dataItem.totGuestCnt    = messages["dayofweek.tot"];

        // 시간대별 컬럼 생성
        var j=0;
        for (var i = 0; i < 24; i++) {
            j=i + 1;
            dataItem['realSaleAmtT' + i] = i + "시 ~ " + j + "시";
            dataItem['saleCntT' + i] = i + "시 ~ " + j + "시";
            dataItem['totGuestCntT' + i] = i + "시 ~ " + j + "시";
            j=0;
        }

        // 시간대분류 컬럼 생성
        for (var i = 0; i < timeSlotColList.length; i++) {
            dataItem['realSaleAmtT' + timeSlotColList[i].value.replaceAll("~","")] = timeSlotColList[i].name + "(" + timeSlotColList[i].value + ")";
            dataItem['saleCntT' + timeSlotColList[i].value.replaceAll("~","")]     = timeSlotColList[i].name + "(" + timeSlotColList[i].value + ")";
            dataItem['totGuestCntT' + timeSlotColList[i].value.replaceAll("~","")] = timeSlotColList[i].name + "(" + timeSlotColList[i].value + ")";
        }

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
    $scope.$on("dayOfWeekTimeCtrl", function(event, data) {
        if($scope.startTime*1 > $scope.endTime*1){ // *1하는이유 : Time들이 String이라 int로 바꿀라고
            $scope._popMsg(messages["day.time.startEnd"]); // 검색 시작 시간대가 검색 종료 시간대보다 큽니다.
            return false;
        }

        $scope.searchDayOfWeekTime();
        event.preventDefault();
    });

    $scope.searchDayOfWeekTime = function() {
        var params = {};
        params.startDate = wijmo.Globalize.format(startDate.value, 'yyyyMMdd'); //조회기간
        params.endDate = wijmo.Globalize.format(endDate.value, 'yyyyMMdd'); //조회기간
        params.storeCds = $("#dayofweekTimeStoreCd").val();
        params.startTime = $scope.startTime;
        params.endTime = $scope.endTime;
        params.optionFg = $("input[name=optionFg]:checked").val();
        params.timeSlot = $scope.timeSlot;

        $scope._inquiryMain("/sale/day/dayOfWeek/dayOfWeek/getDayOfWeekTimeList.sb", params, function() {}, false);

        // 선택한 시간대에 따른 리스트 항목 visible
        var grid = wijmo.Control.getControl("#wjGridDayofweekTimeList");
        var columns = grid.columns;
        var start = $scope.startTime*1;
        var end = $scope.endTime*1;
        var defaultCol = 4;

        if($scope.orgnFg === 'H') {
            defaultCol++;
        }

        if($("input[name=optionFg]:checked").val() == "time"){ // 시간대
            // 선택한 시간대에 따른 리스트 항목 visible
        for(var i = defaultCol; i <= columns.length; i++){ //72번 돈다
            columns[i].visible = false;
            for(var j = start; j <= end; j++) {
                if (columns[i].binding == 'realSaleAmtT'+j || columns[i].binding == 'saleCntT'+j || columns[i].binding == 'totGuestCntT'+j) {
                    columns[i].visible = true;
                }
            }
        }
        } else if($("input[name=optionFg]:checked").val() == "timeSlot") {   // 시간대분류
            // 선택한 시간대에 따른 리스트 항목 visible
            for (var i = defaultCol; i < columns.length; i++) {
                columns[i].visible = false;
                for (var j = 0; j < timeSlotColList.length; j++) {
                    if ($scope.timeSlot == timeSlotColList[j].value || $scope.timeSlot === "") {
                        if (columns[i].binding == 'realSaleAmtT' + timeSlotColList[j].value.replaceAll("~", "") || columns[i].binding == 'saleCntT' + timeSlotColList[j].value.replaceAll("~", "") || columns[i].binding == 'totGuestCntT' + timeSlotColList[j].value.replaceAll("~", "")) {
                            columns[i].visible = true;
                        }
                    }
                }
            }
        }
    };
    // <-- //검색 호출 -->

    // 라디오버튼 클릭시 이벤트 발생
    $("input:radio[name=optionFg]").click(function(){
        if($("input[name=optionFg]:checked").val() == "time"){              // 시간대
            $("#timeOption").show();
            $("#timeSlotOption").hide();
        }else {       // 시간대분류
            $("#timeOption").hide();
            $("#timeSlotOption").show();
        }
    });

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
                messages["dayofweek.dayofweek"] + '(' + messages["dayofweek.timeSale"] + ')_' + getCurDateTime() +'.xlsx', function () {
                    $timeout(function () {
                        $scope.$broadcast('loadingPopupInactive'); // 데이터 처리중 메시지 팝업 닫기
                    }, 10);
                });
        }, 10);
    };

}]);