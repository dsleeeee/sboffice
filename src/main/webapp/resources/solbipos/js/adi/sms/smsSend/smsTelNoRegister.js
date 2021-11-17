/****************************************************************
 *
 * 파일명 : smsTelNoRegister.js
 * 설  명 : 발신번호 사전등록 팝업 JavaScript
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

/**
 *  발신번호 사전등록 팝업 조회 그리드 생성
 */
app.controller('smsTelNoRegisterCtrl', ['$scope', '$http', function ($scope, $http) {

    // 상위 객체 상속 : T/F 는 picker
    angular.extend(this, new RootController('smsTelNoRegisterCtrl', $scope, $http, false));

    // grid 초기화 : 생성되기전 초기화되면서 생성된다
    $scope.initGrid = function (s, e) {
    };

    // <-- 검색 호출 -->
    $scope.$on("smsTelNoRegisterCtrl", function(event, data) {
        event.preventDefault();
    });
    // <-- //검색 호출 -->

    // 인증요청
    $scope.telNoRequest = function() {

        var auth_form = document.form_auth;

        var return_gubun;
        var width  = 410;
        var height = 500;

        var leftpos = screen.width  / 2 - ( width  / 2 );
        var toppos  = screen.height / 2 - ( height / 2 );

        var winopts  = "width=" + width   + ", height=" + height + ", toolbar=no,status=no,statusbar=no,menubar=no,scrollbars=no,resizable=no";
        var position = ",left=" + leftpos + ", top="    + toppos;

        var url =   $("#gw_url").val() + '?' + // KCP 인증창
            'site_cd=' + $("#site_cd").val() + '&' +             // 상점코드
            'ordr_idxx=' + $("#ordr_idxx").val() + '&' +            // 상점관리요청번호
            'req_tx=cert' + '&' +                                   // 요청의 종류를 구분하는 변수
            'cert_method=01' + '&' +                                // 01-휴대폰인증 02-공인인증(추후제공)
            'up_hash=' + $("#up_hash").val() + '&' +                // 요청 hash data
            'Ret_URL='  + $("#Ret_URL").val() +  '&' +              // 본인인증 결과 리턴페이지
            'cert_otp_use=Y';                                       // 인요청시 OTP승인 여부

        var params  = {};
        params.certId = $("#ordr_idxx").val();

        // 저장기능 수행 : 저장URL, 파라미터, 콜백함수
        $.postJSONArray("/adi/sms/smsTelNoManage/smsTelNoManage/getSmsTelNoManageSave.sb", params, function (result) {
                console.log("결과" + result);
                console.log('주소  : ' + url);
            },
            function (result) {
                s_alert.pop("결과msg" + result.message);
            });

        var AUTH_POP = window.open(url, 'auth_popup', winopts + position);
    };

    // 팝업 닫기
    $scope.close = function() {
        // 발신번호 등록됬는지 확인
        var smsTelNoRegisterScope = agrid.getScope('smsSendCtrl');
        smsTelNoRegisterScope.tellNumChkPop();

        $scope.wjSmsTelNoRegisterLayer.hide();
        event.preventDefault();
    };

    // 값가져오기
    $scope.getVal = function() {
        // 발신번호 등록됬는지 확인
        // $scope._inquirySub("/adi/sms/smsTelNoManage/smsTelNoManage/getVal.sb", null, function (response){});

        $.postJSON("/adi/sms/smsTelNoManage/smsTelNoManage/getVal.sb", null, function(result) {
            var data = result.data;
            console.log(data);
                $("#site_cd").val(data.siteCd);
                $("#web_siteid").val(data.webSiteid);
                $("#gw_url").val(data.gwUrl);
                $("#Ret_URL").val(data.retUrl);
                $("#ordr_idxx").val(data.ordrIdxx);
                $("#up_hash").val(data.upHash);
                $("#sessionId").val(data.sessionId);
            }
        );
    };
}]);