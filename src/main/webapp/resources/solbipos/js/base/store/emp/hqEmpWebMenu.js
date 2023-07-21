/****************************************************************
 *
 * 파일명 : hqEmpWebMenu.js
 * 설  명 : 사원관리 > 사원정보관리 > 사원메뉴권한 > 웹사이트 메뉴 Tab JavaScript
 *
 *    수정일      수정자      Version        Function 명
 * ------------  ---------   -------------  --------------------
 * 2020.05.29     이다솜      1.0
 *
 * **************************************************************/

// 모바일 메뉴 탭 클릭
function changeMobileTab(){
    var scope = agrid.getScope('hqEmpWebMenuCtrl');
    scope.changeMobileTab();
}

// 선택한 사원정보 데이터를 담기위해
var selData = [];

app.controller('hqEmpWebMenuCtrl', ['$scope', '$http', function ($scope, $http) {

    // 상위 객체 상속 : T/F 는 picker
    angular.extend(this, new RootController('hqEmpWebMenuCtrl', $scope, $http, false));

    // 팝업 오픈시 사원메뉴권한 조회
    $scope.$on("hqEmpWebMenuCtrl", function(event, data) {
        $("#copyEmpNo").val("");
        $("#copyEmpNm").val("선택");
        // 선택한 사원정보 데이터
        selData = data;

        // 본사마스터 계정(사원번호 0000)은 수정불가(관리자에서 해야함)
        if(selData.empNo == "0000"){
            $("#tableCopy").css("display", "none");
            $("#btnCopyAuth").css("display", "none");
            $("#btnRemoveMenu").css("display", "none");
            $("#btnAddMenu").css("display", "none");
        }else{
            $("#tableCopy").css("display", "");
            $("#btnCopyAuth").css("display", "");
            $("#btnRemoveMenu").css("display", "");
            $("#btnAddMenu").css("display", "");
        }

        // 메뉴권한복사 콤보박스 데이터 조회 및 셋팅
        var params= {};
        params.empNo = selData.empNo;

        $.postJSON("/base/store/emp/hq/authHqEmpList.sb", params, function(result) {
                $scope._setComboData("empNoCombo", result.data.list);
            },
            function(result){
                s_alert.pop(result.message);
            }
        );

        // 메뉴 리스트 조회
        $scope.menuList(selData);
        event.preventDefault();

    });

    // 메뉴 리스트 조회
    $scope.menuList = function(data){

        // 사용메뉴 조회
        var params = [];
        params.empNo = data.empNo

        $scope._inquirySub("/base/store/emp/hq/avlblMenu.sb", params, function() {

            // 미사용메뉴 조회
            var beUseMenuGrid = agrid.getScope("notUseHqEmpWebMenuCtrl");
            beUseMenuGrid._pageView('notUseHqEmpWebMenuCtrl', 1);

        });
    };

    // 권한복사 버튼 클릭
    $scope.copyAuth = function(){

        if($("#copyEmpNo").val() === ""){
            $scope._popMsg(messages["hqEmp.require.empNullChk"]);
            return false;
        }
        if(selData.empNo === $("#copyEmpNo").val()){
            $scope._popMsg(messages["hqEmp.require.empChk"]);
            return false;
        }
        var param = {};
        param.empNo      = selData.empNo;
        param.copyEmpNo  = $("#copyEmpNo").val();

        console.log(param);

        $.postJSONSave("/base/store/emp/hq/copyAuth.sb", param, function(result) {
                var res = result.data;
                if(res > 0) {
                    $scope._popMsg(messages["cmm.copySucc"]);
                    $scope._broadcast('hqEmpWebMenuCtrl', selData);
                }
            },
            function (result) {
                s_alert.pop(result.message);
            }
        );
    }

    // 미사용등록
    $scope.notUseReg = function(){

        var params = new Array();
        for (var i = 0; i < $scope.flex.collectionView.items.length; i++) {
            if($scope.flex.collectionView.items[i].gChk) {
                $scope.flex.collectionView.items[i].empNo = selData.empNo;
                $scope.flex.collectionView.items[i].resrceCd = $scope.flex.collectionView.items[i].resrceCdSmall;
                params.push($scope.flex.collectionView.items[i]);
            }
        }

        if(params.length <= 0) {
            $scope._popMsg(messages["hqEmp.require.chkNotUseMenu"]);
            return false;
        }

        // 저장기능 수행 : 저장URL, 파라미터, 콜백함수
        $scope._save('/base/store/emp/hq/removeAuth.sb', params, function() {
            // 저장 후 재조회
            $scope._broadcast('hqEmpWebMenuCtrl', selData);
            $scope._broadcast('notUseHqEmpWebMenuCtrl', selData);
        });
    };

    // 모바일 메뉴 탭 클릭
    $scope.changeMobileTab = function(){
        s_alert.pop("준비중인 메뉴입니다.");
        return;
    }

    // 매장선택 모듈 팝업 사용시 정의
    // 함수명 : 모듈에 넘기는 파라미터의 targetId + 'Show'
    // _broadcast : 모듈에 넘기는 파라미터의 targetId + 'Ctrl'
    $scope.copyEmpShow = function () {
        $scope._broadcast('copyEmpCtrl');
    };
}]);

app.controller('notUseHqEmpWebMenuCtrl', ['$scope', '$http', function ($scope, $http) {

    // 상위 객체 상속 : T/F 는 picker
    angular.extend(this, new RootController('notUseHqEmpWebMenuCtrl', $scope, $http, false));

    // 팝업 오픈시 매장정보 조회
    $scope.$on("notUseHqEmpWebMenuCtrl", function (event, data) {

        // 미사용메뉴 리스트 조회
        $scope.notUsemenuList();

    });

    // 미사용메뉴 리스트 조회
    $scope.notUsemenuList = function () {

        // 사용메뉴 조회
        var params = [];
        params.empNo = selData.empNo;
        $scope._inquirySub("/base/store/emp/hq/beUseMenu.sb", params, function() {

        });
    };

    // 사용등록
    $scope.useReg = function(){

        var params = new Array();
        for (var i = 0; i < $scope.flex.collectionView.items.length; i++) {
            if($scope.flex.collectionView.items[i].gChk) {
                $scope.flex.collectionView.items[i].empNo = selData.empNo;
                $scope.flex.collectionView.items[i].resrceCd = $scope.flex.collectionView.items[i].resrceCdSmall;
                params.push($scope.flex.collectionView.items[i]);
            }
        }

        if(params.length <= 0) {
            $scope._popMsg(messages["hqEmp.require.chkUseMenu"]);
            return false;
        }

        // 저장기능 수행 : 저장URL, 파라미터, 콜백함수
        $scope._save('/base/store/emp/hq/addAuth.sb', params, function() {
            // 저장 후 재조회
            $scope._broadcast('notUseHqEmpWebMenuCtrl', selData);
            $scope._broadcast('hqEmpWebMenuCtrl', selData);
        });
    };

}]);