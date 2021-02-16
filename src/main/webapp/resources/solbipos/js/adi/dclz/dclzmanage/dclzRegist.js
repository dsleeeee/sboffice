/****************************************************************
 *
 * 파일명 : dclzRegist.js
 * 설  명 : 근태관리 신규등록 팝업 JavaScript
 *
 *    수정일      수정자      Version        Function 명
 * ------------  ---------   -------------  --------------------
 * 2021.02.10     이다솜      1.0
 *
 * **************************************************************/
/**
 * get application
 */
var app = agrid.getApp();

// 입력구분 VALUE
var inFg = [
    {"name":"전체","value":""},
    {"name":"POS","value":"010"},
    {"name":"WEB","value":"020"}
];

// 시 VALUE
var Hh = [24];
for(i =0 ; i < 24; i++){
    var timeVal = i.toString();
    if(i>=0 && i<=9){
        timeVal = "0" + timeVal;
    }
    Hh[i] = {"name":timeVal,"value":timeVal}
}

// 분, 초 VALUE
var MmSs = [60];
for(i =0 ; i < 60; i++){
    var timeVal = i.toString();
    if(i>=0 && i<=9){
        timeVal = "0" + timeVal;
    }
    MmSs[i] = {"name":timeVal,"value":timeVal}
}

/**
 *  근태관리 신규등록 팝업 생성
 */
app.controller('dclzRegistCtrl', ['$scope', '$http', function ($scope, $http) {
    // 상위 객체 상속 : T/F 는 picker
    angular.extend(this, new RootController('dclzRegistCtrl', $scope, $http, true));

    // 영업일자 콤보박스
    var saleDate = wcombo.genDateVal("#saleDate", gvStartDate);

    // 사원명
    $scope._setComboData("empNoCombo", empList);

    // 출근일시
    var empInDt = wcombo.genDateVal("#empInDt", gvStartDate);
    $scope._setComboData("empInDtHhCombo", Hh);
    $scope._setComboData("empInDtMmCombo", MmSs);
    $scope._setComboData("empInDtSsCombo", MmSs);

    // 퇴근일시
    var empOutDt = wcombo.genDateVal("#empOutDt", gvStartDate);
    $scope._setComboData("empOutDtHhCombo", Hh);
    $scope._setComboData("empOutDtMmCombo", MmSs);
    $scope._setComboData("empOutDtSsCombo", MmSs);

    // grid 초기화 : 생성되기전 초기화되면서 생성된다
    $scope.initGrid = function (s, e) {

    };

    $scope.$on("dclzRegistCtrl", function (event, data) {

        // 초기화
        $scope.resetInput();

        // 수정 모드 시, 기존 정보 조회
        if(!isEmptyObject(data)){
            $("#saveType").val("mod");

            $("#saleDate").attr("disabled", true);
            $("#saleDate").css('background-color', '#F0F0F0');
            $("#empNo").attr("disabled", true);
            $("#empNo").css('background-color', '#F0F0F0');

            $("#btnDel").css("display", "");

            $scope.getInfo(data);

        }else{
            $("#saveType").val("reg");

            $("#saleDate").attr("disabled", false);
            $("#saleDate").css('background-color', '#FFFFFF');
            $("#empNo").attr("disabled", false);
            $("#empNo").css('background-color', '#FFFFFF');

            $("#btnDel").css("display", "none");
        }

        event.preventDefault();
    });

    // 수정 모드 시, 기존 정보 조회
    $scope.getInfo = function(data){

        var params = {};
        params.storeCd = data.storeCd;
        params.empInDate = data.empInDate;
        params.empNo = data.empNo;
        params.inFg = data.inFg;

        $scope._postJSONQuery.withOutPopUp( "/adi/dclz/dclzmanage/dclzmanage/detail.sb", params, function(response){

            var result = response.data.data;

            saleDate.value =  stringToDate(result.saleDate); // 영업일자
            $scope.empNoCombo.selectedValue = result.empNo; // 사원명

            empInDt.value = stringToDate((result.empInDt).substr(0, 8));  // 출근일시
            $scope.empInDtHhCombo.selectedValue = (result.empInDt).substr(8, 2);
            $scope.empInDtMmCombo.selectedValue = (result.empInDt).substr(10, 2);
            $scope.empInDtSsCombo.selectedValue = (result.empInDt).substr(12, 2);

            empOutDt.value = stringToDate((result.empOutDt).substr(0, 8)); // 퇴근일시
            $scope.empOutDtHhCombo.selectedValue = (result.empOutDt).substr(8, 2);
            $scope.empOutDtMmCombo.selectedValue = (result.empOutDt).substr(10, 2);
            $scope.empOutDtSsCombo.selectedValue = (result.empOutDt).substr(12, 2);

            $scope.remark = result.remark; // 비고

            $("#hdStoreCd").val(result.storeCd);
            $("#hdEmpInDate").val(result.empInDate);
            $("#hdInFg").val(result.inFg);


        });

    };
    
    // 등록
    $scope.regist = function () {

        var params = {};
        params.saleDate = wijmo.Globalize.format(saleDate.value, 'yyyyMMdd');
        params.empNo = $scope.empNo;
        params.empInDate = wijmo.Globalize.format(empInDt.value, 'yyyyMMdd');
        params.empInDt = wijmo.Globalize.format(empInDt.value, 'yyyyMMdd') + $scope.empInDtHh + $scope.empInDtMm + $scope.empInDtSs;
        params.empOutDt = wijmo.Globalize.format(empOutDt.value, 'yyyyMMdd') + $scope.empOutDtHh + $scope.empOutDtMm + $scope.empOutDtSs;
        params.remark = $scope.remark;

        /** 퇴근시간이 출근시간보다 빠르거나 같습니다. */
        var msg = messages["dclzManage.dtChkMsg"];
        if(Number(params.empInDt) >= Number(params.empOutDt)){
            $scope._popMsg(msg);
            return;
        }

        // 저장기능 수행 : 저장URL, 파라미터, 콜백함수
        $scope._postJSONSave.withPopUp("/adi/dclz/dclzmanage/dclzmanage/regist.sb", params, function (response) {

            if (response.data.status === "OK") {
                // 성공 메시지
                $scope._popMsg(messages["cmm.saveSucc"]);

                // 재조회
                var dclzManageScope = agrid.getScope("dclzManageCtrl");
                dclzManageScope.dclzSearch();

                // 팝업 닫기
                $scope.close();
            }
        });
    }
    
    // 삭제
    $scope.delete = function () {

        if($("#saveType").val() === "mod"){

            /** 해당 근태정보를 삭제하시겠습니까? */
            var msg = messages["dclzManage.delMsg"];
            s_alert.popConf(msg, function () {
                var params = {};
                params.storeCd = $("#hdStoreCd").val();
                params.empInDate = $("#hdEmpInDate").val();
                params.empNo = $scope.empNo;
                params.inFg = $("#hdInFg").val();

                // 저장기능 수행 : 저장URL, 파라미터, 콜백함수
                $scope._postJSONSave.withPopUp("/adi/dclz/dclzmanage/dclzmanage/remove.sb", params, function (response) {

                    if (response.data.status === "OK") {
                        // 성공 메시지
                        $scope._popMsg(messages["cmm.delSucc"]);

                        // 재조회
                        var dclzManageScope = agrid.getScope("dclzManageCtrl");
                        dclzManageScope.dclzSearch();

                        // 팝업 닫기
                        $scope.close();
                    }
                });
            });
        }
    };
    
    // 닫기
    $scope.close = function () {

        // 초기화
        $scope.resetInput();

        $scope.wjDclzRegistLayer.hide();
    }

    // 초기화
    $scope.resetInput = function(){

        // 영업일자
        saleDate.value = getCurDate('-');

        // 사원명
        $scope.empNoCombo.selectedIndex = 0;

        // 출근일시
        empInDt.value = getCurDate('-');
        $scope.empInDtHhCombo.selectedIndex = 9;
        $scope.empInDtMmCombo.selectedIndex = 0;
        $scope.empInDtSsCombo.selectedIndex = 0;

        // 퇴근일시
        empOutDt.value = getCurDate('-');
        $scope.empOutDtHhCombo.selectedIndex = 18;
        $scope.empOutDtMmCombo.selectedIndex = 0;
        $scope.empOutDtSsCombo.selectedIndex = 0;

        // 비고
        $scope.remark = "";

        // 등록인지 수정인지 구분자
        $("#saveType").val("");

        //
        $("#hdStoreCd").val("");
        $("#hdEmpInDate").val("");
        $("#hdInFg").val("");
    }


}]);