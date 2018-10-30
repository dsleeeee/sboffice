/****************************************************************
 *
 * 파일명 : storeEnv.js
 * 설  명 : 매장정보관리 > 매장환경설정 JavaScript
 *
 *    수정일      수정자      Version        Function 명
 * ------------  ---------   -------------  --------------------
 * 2018.10.23     김지은      1.0
 *
 * **************************************************************/

app.controller('storeEnvCtrl', ['$scope', '$http', function ($scope, $http) {

  // 상위 객체 상속 : T/F 는 picker
  angular.extend(this, new RootController('storeEnvCtrl', $scope, $http, false));

  // 조회시 선택된 환경변수 그룹 (재조회를 위해 변수로 관리)
  $scope.envGroupCd = "00";
  $scope.setEnvGroupCd = function(envGroupCd){
    $scope.envGroupCd = envGroupCd;
  };
  $scope.getEnvGroupCd = function(){
    return $scope.envGroupCd;
  };

  // 팝업 오픈시 매장정보 조회
  $scope.$on("storeEnvCtrl", function(event, data) {

    $scope.setEnvGroupCd("00"); // 초기 환경변수 그룹코드는 매장환경[00]
    $scope.showStoreEnv();
    event.preventDefault();
  });


  /*********************************************************
   * 매장환경 탭 클릭시 매장환경 레이어 먼저 보여줌
   * *******************************************************/
  $scope.showStoreEnv = function(){
    $("#cmmEnvArea").show();
    $("#posEnvArea").hide();

    var cmmEnvScope = agrid.getScope('cmmEnvCtrl');
    cmmEnvScope.changeEnvGroup($scope.getEnvGroupCd());
  };

  /*********************************************************
   * 매장정보 탭 클릭
   * *******************************************************/
  $scope.changeTab = function(){
    $scope.storeEnvLayer.hide();

    var infoPopup = $scope.storeInfoLayer;

    // 팝업 열린 뒤. 딜레이줘서 열리고 나서 실행되도록 함
    infoPopup.shown.addHandler(function (s) {
      setTimeout(function() {
        $scope._broadcast('storeInfoCtrl');
      }, 50)
    });

    // 팝업 닫을때
    infoPopup.show(true, function (s) {
    });
  };

  /*********************************************************
   *  환경변수 그리기 [환경변수 타입 (P:포스환경변수, S:그 외)]
   * *******************************************************/
  $scope.setEnvContents = function(envType, list){

    var innerHtml = "";
    // var envCnt    = 0;
    var allCnt    = 0; // 전체 환경값 갯수
    var existCnt  = 0; // 현재 등록된 환경값 갯수

    // 환경변수 테이블 그리기
    for(var i=0; i<envstGrp.length; i++) {

      var storeEnvCnt = 0;
      var storeEnvHtml = "";
      var storeEnvstGrp = envstGrp[i];

      storeEnvHtml += "<h3 class='h3_tbl2 lh30'>" + storeEnvstGrp.name + " <button class='open'></button>";

      if (i == 0) { // 기본값으로 설정 버튼
        storeEnvHtml += "<span class='fr'><a href='javascript:;' class='btn_grayS' id='btnDefault'>";
        storeEnvHtml += messages["storeManage.setting.default.env"];
        storeEnvHtml += "</a></span>";
      }

      storeEnvHtml += "</h3>";
      storeEnvHtml += "<table class='searchTbl'>";
      storeEnvHtml += "  <colgroup>";
      storeEnvHtml += "    <col class='w5' />";
      storeEnvHtml += "    <col class='w25' />";
      storeEnvHtml += "    <col class='w20' />";
      storeEnvHtml += "    <col class='w5' />";
      storeEnvHtml += "    <col class='w25' />";
      storeEnvHtml += "    <col class='w20' />";
      storeEnvHtml += "  </colgroup>";
      storeEnvHtml += "<tbody>";

      var b_env = ""; // 변경전의 환경변수

      for (var j = 0; j < list.length; j++) {

        if (storeEnvstGrp.value == list[j].envstGrpCd) {
          if (b_env == "" || b_env != list[j].envstCd) {
            if (storeEnvCnt == 0 || storeEnvCnt % 2 == 0) storeEnvHtml += "<tr>";

            storeEnvHtml += "  <th class='tc'>" + list[j].envstCd + "</th>";
            storeEnvHtml += "  <td>" + list[j].envstNm + "</td>";
            storeEnvHtml += "  <td>";

            if (list[j].dirctInYn == "Y") { // 직접입력
              storeEnvHtml += "    <input type='text' name='envstValCd' id='env" + list[j].envstCd + "' class='sb-input w100'>";
            } else {  // 값 선택
              storeEnvHtml += "    <select name='envstValCd' id='env" + list[j].envstCd + "' class='sb-select w100' />";
            }

            storeEnvHtml += "    <input type='hidden' name='status'    value='" + (list[j].existFg == "N" ? "I" : "U") + "'>";
            storeEnvHtml += "    <input type='hidden' name='envstCd'   value='" + list[j].envstCd + "'>";
            storeEnvHtml += "    <input type='hidden' name='envstNm'   value='" + list[j].envstNm + "'>";
            storeEnvHtml += "    <input type='hidden' name='envstGrpCd'value='" + list[j].envstGrpCd + "'>";
            storeEnvHtml += "    <input type='hidden' name='defltYn'   value='" + list[j].defltYn + "'>";
            storeEnvHtml += "    <input type='hidden' name='dirctInYn' value='" + list[j].dirctInYn + "'>";
            storeEnvHtml += "    <input type='hidden' name='targtFg'   value='" + list[j].targtFg + "'>";
            storeEnvHtml += "    <input type='hidden' name='oldEnvstVal'   value='" + list[j].selEnvstVal + "'>";
            storeEnvHtml += "  </td>";

            b_env = list[j].envstCd;
            storeEnvCnt++;
            allCnt++;

            if (list[j].existFg == "Y") existCnt++;
            if (list[j].envstCdCnt == storeEnvCnt && (storeEnvCnt % 2 == 1)) {
              storeEnvHtml += "  <td class='tc'></td>";
              storeEnvHtml += "  <td></td>";
              storeEnvHtml += "  <td></td>";
              storeEnvHtml += "</tr>";
            } else if (storeEnvCnt % 2 == 0) {
              storeEnvHtml += "</tr>";
            }
          }
        }
      }

      storeEnvHtml += "  </tbody>";
      storeEnvHtml += "</table>";
      storeEnvHtml += "</div>";
      storeEnvHtml += "<br>";

      if (storeEnvCnt > 0) innerHtml += storeEnvHtml;
    }

    if(envType === "S") {
      $("#storeConfigContent").html(innerHtml);
    } else if(envType === "P") {
      $("#posConfigContent").html(innerHtml);
    }

    // 환경변수 select option 추가
    var envstCd = "";
    var sOption = false;

    for(var i=0; i<list.length; i++){
      if(list[i].dirctInYn == "N") {
        $("#env"+list[i].envstCd).append("<option value='"+ list[i].envstValCd +"' >" + list[i].envstValNm +  "</option>");
        if(i == 0 || envstCd != list[i].envstCd ) {
          envstCd = list[i].envstCd;
          if(list[i].selEnvstVal == list[i].envstValCd){
            sOption = true;
            $("#env"+list[i].envstCd).val(list[i].envstValCd).prop("selected", true);
          }
          else{
            sOption = false;
            $("#env"+list[i].envstCd).val(list[i].envstValCd).prop("selected", true);
          }
        }else if(list[i].selEnvstVal == list[i].envstValCd){
          sOption = true;
          $("#env"+list[i].envstCd).val(list[i].envstValCd).prop("selected", true);
        }else if(sOption == false && list[i].defltYn == "Y") {
          $("#env"+list[i].envstCd).val(list[i].envstValCd).prop("selected", true);
        }

        if(list[i].defltYn == "Y") {
          $("#env"+list[i].envstCd).attr("defaultVal", list[i].envstValCd);
        }

      } else {
        if(list[i].selEnvstVal === "" || list[i].selEnvstVal == null ) {
          $("#env"+list[i].envstCd).val("*");
        } else{
          $("#env"+list[i].envstCd).val(list[i].selEnvstVal);
        }
      }
    }

    // 등록되지 않은 환경값이 있을 경우
    if(allCnt > existCnt) {

      var msg = messages["storeManage.no.regist.env"]
          + messages["storeManage.require.regist.env"] +"\n"
          + allCnt + messages["storeManage.total.env.count"]
          + (allCnt - existCnt)+ messages["storeManage.no.regist.env.count"]
      ;

      $scope._popMsg(msg);

    }
  };

}]);

