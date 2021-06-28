/****************************************************************
 *
 * 파일명 : verInfoDtl.js
 * 설  명 : 미디어관리 > 버전 상세보기 JavaScript
 *
 *    수정일      수정자      Version        Function 명
 * ------------  ---------   -------------  --------------------
 * 2021.06.09     권지현      1.0
 *
 * **************************************************************/
/**
 * get application
 */
var app = agrid.getApp();

/**********************************************************************
 *  회원정보 그리드
 **********************************************************************/
app.controller('verRegistCtrl', ['$scope', '$http', function ($scope, $http) {
  // 상위 객체 상속 : T/F 는 picker
  angular.extend(this, new RootController('verRegistCtrl', $scope, $http, true));

  // 콤보박스 데이터
  $scope._setComboData("useYnCombo", useYnData);
  $scope._setComboData("fileTypeCombo", fileTypeData);

  // 등록일자 셋팅
  var startDate = wcombo.genDateVal("#startDate", gvStartDate);
  var endDate = wcombo.genDateVal("#endDate", gvEndDate);

  $scope.isEdit = false;

  // 버전정보
  $scope.version;

  $scope.selectVersion;
  $scope.setSelectVersion = function(ver){
    $scope.selectVersion = ver;
  };
  $scope.getSelectVersion = function(){
    return $scope.selectVersion;
  };

  // 조회 버튼 클릭
  $scope.$on("verRegistCtrl", function(event, data) {

    $scope.setSelectVersion(data);

    if( !isEmptyObject($scope.getSelectVersion()) ) {
      $scope.isEdit = true;
      $scope.getVersionInfo();
    } else {
      $scope.versionUseYnCombo.selectedValue = "Y";
    }
      event.preventDefault();
  });

  // 파일업로드시 파일사이즈 변경
  $scope.uploadChange = function(){
    $scope.$apply(function() {
      var fileSize = document.getElementById("file").files[0].size;
      $scope.version.fileSize = fileSize;
    });
  };

  // 입력 값 체크
  $scope.mediaSave = function (){
    if(Number(wijmo.Globalize.format(startDate.value, 'yyyyMMdd')) > Number(wijmo.Globalize.format(endDate.value, 'yyyyMMdd'))){
      $scope._popMsg(messages["media.date.msg"]);
      return;
    }

    // 버전적용명 체크
    if($("#verSerNm").val() === null || $("#verSerNm").val() === undefined || $("#verSerNm").val() === "") {
      $scope._popMsg(messages["media.verSerNm"] + " " + messages["cmm.require.text"]);
      return;
    }


    if( isEmptyObject($scope.getSelectVersion()) ) {
      // 파일 체크
      if($("#file").val() === null || $("#file").val() === undefined || $("#file").val() === "") {
        $scope._popMsg(messages["media.file"] + " " + messages["cmm.require.text"]);
        return;
      }
    }

    $scope.chkRegist();
  }

  // 날짜 중복여부 체크
  $scope.chkRegist = function(){

    // 날짜 체크
    var param = {};
    param.storeCd = storeCd;
    param.startDate = wijmo.Globalize.format(startDate.value, 'yyyyMMdd');
    param.endDate =  wijmo.Globalize.format(endDate.value, 'yyyyMMdd');
    if( isEmptyObject($scope.getSelectVersion()) ) {
      param.verSerNo = '0';
    } else {
      param.verSerNo = $scope.version.verSerNo;
    }
    param.fileType = $scope.versionFileTypeCombo.selectedValue;
    param.useYn = $scope.versionUseYnCombo.selectedValue;

    $.postJSON("/base/store/media/chkDate.sb", param, function(result) {
            $scope.$broadcast('loadingPopupActive');
          if(result.status === 'OK') {
            $scope.regist();
          }
        },
        function(result) {
          $scope._popMsg($scope.versionFileTypeCombo.text + messages["media.chkDate.msg"]);
        });
  };

  // 저장
  $scope.regist = function(){
    var formData = new FormData($("#regForm")[0]);

    formData.append("orgnCd", orgnCd);
    if(orgnFg === "HQ"){
      formData.append("hqOfficeCd", hqOfficeCd);
    } else if(orgnFg === "STORE") {
      formData.append("hqOfficeCd", "");
      formData.append("storeCd", storeCd);
    }
    formData.append("userId", userId);
    formData.append("verSerNo", $scope.version.verSerNo);
    formData.append("verSerNm", $scope.version.verSerNm);
    formData.append("startDate", wijmo.Globalize.format(startDate.value, 'yyyyMMdd'));
    formData.append("endDate", wijmo.Globalize.format(endDate.value, 'yyyyMMdd'));
    formData.append("fileType", $scope.versionFileTypeCombo.selectedValue);
    formData.append("fileSize", $scope.version.fileSize);
    formData.append("useYn", $scope.versionUseYnCombo.selectedValue);


    var url = '';

    if( isEmptyObject($scope.getSelectVersion()) ) {
      url = '/base/store/media/verInfo/regist.sb';
    } else {
      url = '/base/store/media/verInfo/modify.sb';
    }

    $scope.$broadcast('loadingPopupActive');

    $.ajax({
      url: url,
      type: "POST",
            data: formData,
      processData: false,
      contentType: false,
      cache: false,
      success: function(result) {

        if (result.status === "OK") {
          if( isEmptyObject($scope.getSelectVersion()) ) {
            $scope._popMsg("등록되었습니다.");
          } else {
            $scope._popMsg("저장되었습니다.");
          }

          $scope.$broadcast('loadingPopupInactive');
          $scope.close();
        }
        else if (result.status === "FAIL") {
                $scope._popMsg('Ajax Fail By HTTP Request');
                $scope.$broadcast('loadingPopupInactive');
        }
        else if (result.status === "SERVER_ERROR") {
          $scope._popMsg(result.message);
          $scope.$broadcast('loadingPopupInactive');
        }

        else {
          var msg = result.status + " : " + result.message;
          $scope._popMsg(msg);
          $scope.$broadcast('loadingPopupInactive');
        }
      },
      error : function(result){
        $scope._popMsg("error");
        $scope.$broadcast('loadingPopupInactive');
      }
    },function(){
      $scope._popMsg("Ajax Fail By HTTP Request");
      $scope.$broadcast('loadingPopupInactive');
    });
  };

  // 버전 목록 조회
  $scope.getVersionInfo = function(){
    var params = {};
    params    = $scope.getSelectVersion();

    console.log('params' , params);

    $scope._postJSONQuery.withOutPopUp( "/base/store/media/verInfo/dtlInfo.sb", params, function(response){

      console.log('response',response);

      var data = response.data.data;
      $scope.version = data;

      startDate.value = getFormatDate($scope.version.startDate, '-');
      endDate.value = getFormatDate($scope.version.endDate, '-');

      $("#fileIn").attr("colspan", 0);
      $("#fileOrgH").show();
      $("#fileOrgD").show();
    });
  };

  // 닫기
  $scope.close = function(){

    // 첨부파일 리셋
    var agent = navigator.userAgent.toLowerCase();
    if ( (navigator.appName == 'Netscape' && navigator.userAgent.search('Trident') != -1) || (agent.indexOf("msie") != -1) ){
      // ie 일때
      $("#file").replaceWith( $("#file").clone(true) );
      $scope.version.uploadFile = "";
    } else {
      // other browser 일때
      $("#file").val("");
      $scope.version.uploadFile = "";
    }

    $("#fileIn").attr("colspan", 3);
    $("#fileOrgH").hide();
    $("#fileOrgD").hide();

    var scope  = agrid.getScope('mediaCtrl');
    scope._broadcast('mediaCtrl');
    $scope.versionRegistLayer.hide();
  };

}]);
