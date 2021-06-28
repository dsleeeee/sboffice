/****************************************************************
 *
 * 파일명 : smsReserve.js
 * 설  명 : SMS예약 팝업 JavaScript
 *
 *    수정일      수정자      Version        Function 명
 * ------------  ---------   -------------  --------------------
 * 2021.06.10     김설아      1.0
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

// 분 VALUE
var Dd = [60];
for(i =0 ; i < 60; i++){
    var timeVal = i.toString();
    if(i>=0 && i<=9){
        timeVal = "0" + timeVal;
    }
    Dd[i] = {"name":timeVal,"value":timeVal}
}

/**
 *  SMS예약 팝업 조회 그리드 생성
 */
app.controller('smsReserveCtrl', ['$scope', '$http', function ($scope, $http) {

    // 상위 객체 상속 : T/F 는 picker
    angular.extend(this, new RootController('smsReserveCtrl', $scope, $http, false));

    // 예약시간
    var startDateSmsReserve = wcombo.genDateVal("#startDateSmsReserve", getToday());
    $scope._setComboData("startTimeSmsReserveCombo", Hh);
    $scope._setComboData("startMinuteSmsReserveCombo", Dd);

    // grid 초기화 : 생성되기전 초기화되면서 생성된다
    $scope.initGrid = function (s, e) {
    };

    // <-- 검색 호출 -->
    $scope.$on("smsReserveCtrl", function(event, data) {
        $("#lblReserveYn").text(data.reserveYn);
        event.preventDefault();
    });
    // <-- //검색 호출 -->

    // 예약전송
    $scope.smsReserveSave = function() {
        var startDate = wijmo.Globalize.format(startDateSmsReserve.value, 'yyyyMMdd');
        var reserveDate = startDate + $scope.startTimeSmsReserveCombo + $scope.startMinuteSmsReserveCombo + "00";
        var reserveYn = $("#lblReserveYn").text();

        if(parseInt(reserveDate) < parseInt(getCurDateTime())) {
            $scope._popMsg(messages["sendStatus.reserveTimeAlert"]); // 예약시간은 현재시간 이후로 가능합니다.
            return false;
        }

        // 전송 저장
        var smsReserveScope = agrid.getScope('smsSendCtrl');
        smsReserveScope.smsSendSave(reserveYn, reserveDate);

        // 팝업 닫기
        $scope.close();
    };

    // 팝업 닫기
    $scope.close = function() {
        $scope.wjSmsReserveLayer.hide();
        event.preventDefault();
    };
}]);