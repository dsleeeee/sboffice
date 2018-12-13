/****************************************************************
 *
 * 파일명 : memberRegist.js
 * 설  명 : 회원정보관리 > 회원정보등록 JavaScript
 *
 *    수정일      수정자      Version        Function 명
 * ------------  ---------   -------------  --------------------
 * 2018.10.23     김지은      1.0
 *
 * **************************************************************/

app.controller('memberRegistCtrl', ['$scope', '$http', function ($scope, $http) {

  // 상위 객체 상속 : T/F 는 picker
  angular.extend(this, new RootController('memberRegistCtrl', $scope, $http, false));

  // 기본 회원등급
  if(memberClassList.length == 0) {
    memberClassList = [{value: "", name: "선택"}, {value: "001", name: "기본등급"}];
  }

  // 조회조건 콤보박스 데이터
  $scope._setComboData("rEmailRecvYn", recvDataMapEx);
  $scope._setComboData("rSmsRecvYn", recvDataMapEx);
  $scope._setComboData("rGendrFg", genderDataMapEx);
  $scope._setComboData("rWeddingYn", weddingDataMap);
  $scope._setComboData("rRegStoreCd", regstrStoreList);
  $scope._setComboData("rUseYn", useDataMap);
  $scope._setComboData("rMemberClass", memberClassList);

  $scope.selectedMember;
  $scope.setSelectedMember = function(data) {
    $scope.selectedMember = data;
  };
  $scope.getSelectedMember = function(){
    return $scope.selectedMember;
  };

  /*********************************************************
   * 팝업 오픈
   * 선택된 회원이 없으면 : 신규등록 (폼 리셋)
   * 선택된 회원이 있으면 : 데이터 수정
   * *******************************************************/
  $scope.$on("memberRegistCtrl", function(event, data) {

    $scope.setSelectedMember(data);

    if($.isEmptyObject(data) ) {
      $scope.resetForm();
    } else {
      $scope.getMemberInfo();
    }

    event.preventDefault();
  });


  $scope.changeWeddingCombo = function(s, e){
    if(s.selectedValue === 'Y') {
      $scope.weddingDayCombo.isReadOnly     = false;
    } else {
      $scope.weddingDayCombo.isReadOnly     = true;
    }
  };


  /*********************************************************
   * 회원 등록을 위한 폼 리셋
   * *******************************************************/
  $scope.resetForm = function(){

    $("#regForm")[0].reset();
    $("#memberInfoTitle").text("");

    $scope.$apply(function(){
      $scope.member.membrNo                 = '자동채번';
      $scope.member.beforeBizNo             = '';
      $scope.regStoreCdCombo.selectedIndex  = 0;
      $scope.genderCombo.selectedIndex      = 0;
      $scope.weddingYnCombo.selectedIndex   = 0;
      $scope.useYnCombo.selectedValue       = 'Y';
      $scope.emailRecvYnCombo.selectedIndex = 0;
      $scope.smsRecvYnCombo.selectedIndex   = 0;
      $scope.memberClassCombo.selectedIndex = 0;

      $scope.weddingDayCombo.selectedValue  = new Date();
      $scope.weddingDayCombo.selectedValue  = new Date();
      $scope.birthdayCombo.selectedValue    = new Date();

      $scope.weddingDayCombo.refresh();
      $scope.birthdayCombo.refresh();

      $scope.weddingDayCombo.isReadOnly     = true;
    });
  };

  /*********************************************************
   * 회원정보 조회
   * *******************************************************/
  $scope.getMemberInfo = function(){

    var params = $scope.getSelectedMember();

    $scope._postJSONQuery.withOutPopUp( '/membr/info/view/base/getMemberInfo.sb', params, function(response){

      console.log(response);

      if($.isEmptyObject(response.data) ) { ww
        $scope._popMsg(messages["cmm.empty.data"]);
        $scope.memberRegistLayer.hide();
        return false;
      }
      var memberDetailInfo = response.data.data;

      $("#memberInfoTitle").text("[" + memberDetailInfo.membrNo + "] " + memberDetailInfo.membrNm);

      memberDetailInfo.birthday               = stringToDate(memberDetailInfo.birthday);
      memberDetailInfo.weddingday             = stringToDate(memberDetailInfo.weddingday);

      $scope.member                           = memberDetailInfo;

      if(memberDetailInfo.weddingYn == "Y") {
        $scope.weddingDayCombo.isReadOnly     = false;
      } else {
        $scope.weddingDayCombo.isReadOnly     = true;
        $scope.member.weddingday              = new Date();
      }
    });
  };

  /*********************************************************
   * 값 체크
   * *******************************************************/
  $scope.valueCheck = function(){

    // 신규등록일 경우
    if( $.isEmptyObject($scope.selectedMember) ){
      // 등록매장을 선택해주세요.
      var msg = messages["regist.reg.store.cd"]+messages["cmm.require.select"];
      if( isNull( $scope.regStoreCdCombo.selectedValue )) {
        $scope._popMsg(msg);
        return false;
      }
    }

    // 전화번호는 숫자만 입력할 수 있습니다.
    var msg = messages["regist.tel"]+messages["cmm.require.number"];
    var numChkregexp = /[^0-9]/g;
    if(numChkregexp.test( $scope.member.telNo )) {
      $scope._popMsg(msg);
      return false;
    }

    return true;
  };

  /*********************************************************
   * 저장
   * *******************************************************/
  $scope.save = function(){

    if(!$scope.valueCheck()) return false;

    var params         = $scope.member;

    // console.log(params)

    params.weddingday  = dateToDaystring(params.weddingday);
    params.birthday    = dateToDaystring(params.birthday);
    params.lunarYn     = $(":input:radio[name=lunarYn]:checked").val();

    // console.log(params);

    var memberInfoScope = agrid.getScope('memberCtrl');

    // 회원 신규 등록시
    if($.isEmptyObject($scope.selectedMember) ) {
      $scope._postJSONSave.withPopUp("/membr/info/view/base/registMemberInfo.sb", params, function () {
        $scope._popMsg(messages["cmm.saveSucc"]);
        $scope.memberRegistLayer.hide();
        memberInfoScope.getMemberList();
      });
    }
    // 수정
    else {
      $scope._postJSONSave.withPopUp("/membr/info/view/base/updateMemberInfo.sb", params, function () {
        $scope._popMsg(messages["cmm.saveSucc"]);
        $scope.memberRegistLayer.hide();
        $scope.memberInfoDetailLayer.hide();
        memberInfoScope.getMemberList();
      });
    }
  };


  /*********************************************************
   * 회원 거래처 매핑코드 조회(보나비)
   * *******************************************************/
  $scope.searchMemberMappingCd = function(){
    $scope.memberMappingLayer.show(true, function(s) {

      var memberMappingScope = agrid.getScope('memberMappingCtrl');
      // console.log('getCompany', memberMappingScope.getCompany());
      $scope.$apply(function(){
        if( !$.isEmptyObject(memberMappingScope.getCompany())) {
          $scope.member.lnPartner = memberMappingScope.getCompany().lnPartner;
          $scope.member.cdCompany = memberMappingScope.getCompany().cdCompany;
          $scope.member.cdPartner = memberMappingScope.getCompany().cdPartner;
        }
      });
    });
  };

  /*********************************************************
   * 주소검색 TODO
   * *******************************************************/
  $scope.searchAddr = function(){
  };

  // 화면 ready 된 후 설정
  angular.element(document).ready(function () {
    // 회원조회 팝업 핸들러 추가
    $scope.memberMappingLayer.shown.addHandler(function (s) {
      setTimeout(function() {
        $scope._broadcast('memberMappingCtrl');
      }, 50)
    });
  });


}]);
