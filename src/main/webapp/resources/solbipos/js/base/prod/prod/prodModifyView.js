/****************************************************************
 *
 * 파일명 : prodModifyView.js
 * 설  명 : 상품정보관리 수정 팝업 JavaScript
 *
 *    수정일      수정자      Version        Function 명
 * ------------  ---------   -------------  --------------------
 * 2018.10.24     노현수      1.0
 *
 * **************************************************************/
/**
 * 팝업 그리드 생성
 */
app.controller('prodModifyCtrl', ['$scope', '$http', function ($scope, $http) {
  // 상위 객체 상속 : T/F 는 picker
  angular.extend(this, new RootController('prodModifyCtrl', $scope, $http, false));

  var vProdNoEnvFg = prodNoEnvFg;

  // 상품정보
  $scope.prodModifyInfo = {};
  $scope.setProdModifyInfo = function(data){
    $scope.prodModifyInfo = data;
  };
  $scope.getProdModifyInfo = function(){
    return $scope.prodModifyInfo;
  };
  // 상품정보 조회
  $scope.$on("prodModifyCtrl", function(event, data) {
    // data 조회하지 않고 상세정보와 동일하므로 파라미터로 처리
    $scope.$broadcast('loadingPopupActive');
    // 등록/수정 모드 파악
    $scope.chkSaveMode(data);
    // 상품정보 set
    $scope.setProdModifyInfo(data);
    // 메시지창 닫기
    setTimeout(function() {
      $scope.$broadcast('loadingPopupInactive');
    }, 30);
    // 기능수행 종료 : 반드시 추가
    event.preventDefault();
  });

  // 상품분류정보 팝업
  $scope.popUpProdClass = function() {
    var popUp = $scope.prodClassPopUpLayer;
    popUp.show(true, function (s) {
      // 선택 버튼 눌렀을때만
      if (s.dialogResult === "wj-hide-apply") {
        var scope = agrid.getScope('prodClassPopUpCtrl');
        var prodClassCd = scope.getSelectedClass();
        var params = {};
        params.prodClassCd = prodClassCd;
        // 조회 수행 : 조회URL, 파라미터, 콜백함수
        $scope._postJSONQuery.withPopUp("/popup/getProdClassCdNm.sb", params,
          function(response){
            var prodInfo = $scope.getProdModifyInfo();
            prodInfo.prodClassCd = prodClassCd;
            prodInfo.prodClassCdNm = response.data.data;
            $scope.setProdModifyInfo(prodInfo);
          }
        );
      }
    });
  };
  
  // 상품코드 중복체크
  $scope.chkProdCd = function () {

      if(isNull($scope.prodModifyInfo.prodCd)) {
          $scope._popMsg(messages["prod.prodCd"]+messages["cmm.require.text"]);
          return false;
      }

      var params    = {};
      params.prodCd = $scope.prodModifyInfo.prodCd

      $scope._postJSONQuery.withPopUp( "/base/prod/prod/prod/getProdCdCnt.sb", params, function(response){

          var result = response.data.data;

          if(result === 0){ // 사용가능
              $scope._popMsg(messages["prod.notProdCdDuplicate.msg"]);
              $scope.prodModifyInfo.prodCdChkFg = $scope.prodModifyInfo.prodCd;

          }else{ // 중복
              $scope._popMsg(messages["prod.prodCdDuplicate.msg"]);
              $scope.prodModifyInfo.prodCdChkFg ="";
          }
      });

  };

  // 상품저장
  $scope.saveProd = function() {

        var params = $scope.prodModifyInfo;
        params.prodNoEnv = $("#prodCdInputType").val();
        params.saveMode = $("#saveMode").val();

        if($scope.valueCheck()){

            // 저장수행
            $scope._postJSONSave.withPopUp("/base/prod/prod/prod/save.sb", params, function (response) {

              var result = response.data.data;

              if(result < 1){
                $scope._popMsg(messages["cmm.registFail"]);

              }else{
                $scope._popMsg(messages["cmm.saveSucc"]);
                $scope.prodModifyLayer.hide();

                // 저장기능 수행후 재조회
                $scope._broadcast('prodCtrl');
              }
            });
        }
    }

  // 값 체크
  $scope.valueCheck = function () {

        // 매장코드 수동입력 시
        if($("#saveMode").val() === "REG") {
            if ($("#prodCdInputType").val() === "1") { // 'MANUAL'

                // 상품코드 중복체크를 해주세요.
                var msg = messages["prod.prodCdDuplicateChk.msg"];
                if (isNull($scope.prodModifyInfo.prodCdChkFg)) {
                    $scope._popMsg(msg);
                    return false;
                }

                // 상품코드 중복체크를 다시 해주세요.
                var msg = messages["prod.prodCdDuplicateChkAgain.msg"];
                if ($scope.prodModifyInfo.prodCd !== $scope.prodModifyInfo.prodCdChkFg) {
                    $scope._popMsg(msg);
                    return false;
                }
            }
        }

        return true;
    }

  // 등록/수정 모드에 따른 VIEW 변경
  $scope.chkSaveMode = function(data){
       
      // 수정 모드 시
      if(data.prodCd !== null && data.prodCd !== undefined && data.prodCd !== ""){

          $("#prodCd").attr("readonly",true);
          $("#prodCd").css("width", "100%");
          $("#prodCdChkFg").val("");
          if(prodNoEnvFg === "MANUAL"){ $("#prodCdInputType").val("1"); }else{ $("#prodCdInputType").val("0"); }
          $("#btnChkProdCd").css("display", "none");
          $("#saveMode").val("MOD");

      }else{

          if(prodNoEnvFg === "MANUAL"){
              $("#prodCd").removeAttr("readonly");
              $("#prodCd").css("width", "63%");
              $("#prodCdChkFg").val("");
              $("#prodCdInputType").val("1");
              $("#btnChkProdCd").css("display", "");
              document.getElementById("prodCd").placeholder = "";
          }else{
              $("#prodCd").attr("readonly",true);
              $("#prodCd").css("width", "100%");
              $("#prodCdChkFg").val("");
              $("#prodCdInputType").val("0");
              $("#btnChkProdCd").css("display", "none");
              document.getElementById("prodCd").placeholder = "상품코드는 자동생성 됩니다.";
          }

          $("#saveMode").val("REG");
      }
  }

}]);
