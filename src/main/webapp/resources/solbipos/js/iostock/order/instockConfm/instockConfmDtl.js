/** 입고확정 상세 그리드 controller */
app.controller('instockConfmDtlCtrl', ['$scope', '$http', '$timeout', function ($scope, $http, $timeout) {
  // 상위 객체 상속 : T/F 는 picker
  angular.extend(this, new RootController('instockConfmDtlCtrl', $scope, $http, true));

  $scope.dtlInDate = wcombo.genDate("#dtlInDate");

  $scope._setComboData("stmtAcctFg", [
    {"name": messages["instockConfm.dtl.stmtAcctAll"], "value": ""},
    {"name": messages["instockConfm.dtl.stmtAcctSplr"], "value": "1"},
    {"name": messages["instockConfm.dtl.stmtAcctSplrRcpnt"], "value": "2"}
  ]);

  // grid 초기화 : 생성되기전 초기화되면서 생성된다
  $scope.initGrid = function (s, e) {
    // 배송기사
    var comboParams = {};
    var url         = '/iostock/order/outstockConfm/outstockConfm/getDlvrCombo.sb';
    // 파라미터 (comboFg, comboId, gridMapId, url, params, option, callback)
    $scope._queryCombo("combo", "srchDtlDlvrCd", null, url, comboParams, "S"); // 명칭관리 조회시 url 없이 그룹코드만 넘긴다.

    comboParams             = {};
    comboParams.nmcodeGrpCd = "097";
    url                     = '/iostock/cmm/iostockCmm/getOrgnCombo.sb';
    // 파라미터 (comboFg, comboId, gridMapId, url, params, option)
    $scope._queryCombo("map", null, 'poUnitFgMap', url, comboParams, "A"); // 명칭관리 조회시 url 없이 그룹코드만 넘긴다.

    // 그리드 포맷 핸들러
    s.formatItem.addHandler(function (s, e) {
      if (e.panel === s.cells) {
        var col  = s.columns[e.col];
        var item = s.rows[e.row].dataItem;
        if (col.binding === "inEtcQty") { // 입수에 따라 출고수량 컬럼 readonly 컨트롤
          if (item.poUnitQty === 1) {
            wijmo.addClass(e.cell, 'wj-custom-readonly');
            wijmo.setAttribute(e.cell, 'aria-readonly', true);

            // Attribute 의 변경사항을 적용.
            e.cell.outerHTML = e.cell.outerHTML;
          }
        }
      }
    });

    s.cellEditEnded.addHandler(function (s, e) {
      if (e.panel === s.cells) {
        var col = s.columns[e.col];
        if (col.binding === "inUnitQty" || col.binding === "inEtcQty") { // 입고수량 수정시
          var item = s.rows[e.row].dataItem;
          $scope.calcAmt(item);
        }
      }

      s.collectionView.commitEdit();
    });

    // add the new GroupRow to the grid's 'columnFooters' panel
    s.columnFooters.rows.push(new wijmo.grid.GroupRow());
    // add a sigma to the header to show that this is a summary row
    s.bottomLeftCells.setCellData(0, 0, '합계');
  };

  // 금액 계산
  $scope.calcAmt = function (item) {
    var outSplyUprc = parseInt(item.outSplyUprc);
    var poUnitQty   = parseInt(item.poUnitQty);
    var vat01       = parseInt(item.vatFg01);
    var envst0011   = parseInt(item.envst0011);

    var unitQty = parseInt(nvl(item.inUnitQty, 0)) * parseInt(item.poUnitQty);
    var etcQty  = parseInt(nvl(item.inEtcQty, 0));
    var totQty  = parseInt(unitQty + etcQty);
    var tempAmt = Math.round(totQty * outSplyUprc / poUnitQty);
    var inAmt   = tempAmt - Math.round(tempAmt * vat01 * envst0011 / 11);
    var inVat   = Math.round(tempAmt * vat01 / (10 + envst0011));
    var inTot   = parseInt(inAmt + inVat);

    item.inTotQty = totQty; // 총입고수량
    item.inAmt    = inAmt; // 금액
    item.inVat    = inVat; // VAT
    item.inTot    = inTot; // 합계
  };

  // 다른 컨트롤러의 broadcast 받기
  $scope.$on("instockConfmDtlCtrl", function (event, data) {
    $scope.slipFg = data.slipFg;
    $scope.slipNo = data.slipNo;
    $scope.wjInstockConfmDtlLayer.show(true);

    $scope.getSlipNoInfo();
    // 기능수행 종료 : 반드시 추가
    event.preventDefault();
  });

  // 전표상세 조회
  $scope.getSlipNoInfo = function () {
    var params    = {};
    params.slipNo = $scope.slipNo;

    // ajax 통신 설정
    $http({
      method : 'POST', //방식
      url    : '/iostock/order/instockConfm/instockConfmDtl/getSlipNoInfo.sb', /* 통신할 URL */
      params : params, /* 파라메터로 보낼 데이터 */
      headers: {'Content-Type': 'application/json; charset=utf-8'} //헤더
    }).then(function successCallback(response) {
      if ($scope._httpStatusCheck(response, true)) {
        if (!$.isEmptyObject(response.data.data)) {

          $scope.dtlInDate.value = new Date(getFormatDate(response.data.data.outDate, "-"));
          $scope.outDate         = response.data.data.outDate;
          $scope.inDate          = response.data.data.inDate;
          $scope.slipFg          = response.data.data.slipFg;
          $scope.slipKind        = response.data.data.slipKind;
          $scope.slipKindNm      = response.data.data.slipKindNm;
          $scope.procFg          = response.data.data.procFg;
          $scope.storeCd         = response.data.data.storeCd;
          $scope.storeNm         = response.data.data.storeNm;
          $scope.hdRemark        = response.data.data.remark;
          $scope.dlvrCd          = nvl(response.data.data.dlvrCd, '');
          $scope.dlvrNm          = response.data.data.dlvrNm;

          // 출고확정
          if ($scope.procFg === "20") {
            $("#spanDtlTitle").html(messages["instockConfm.dtl.slipNo"] + ' : ' + $scope.slipNo + ', ' + messages["instockConfm.dtl.store"] + ' : ' + $scope.storeNm + ', ' + messages["instockConfm.dtl.outDate"] + ' : ' + getFormatDate($scope.outDate));
            $scope.instockBtnLayerDisplay(true);

            if (gEnvst1043 === "N") {
              $scope.flex.isReadOnly = true;
            } else {
              $scope.flex.isReadOnly = false;
            }
          }
          // 수주확정 또는 입고확정
          else if ($scope.procFg === "10" || $scope.procFg === "30") {
            $scope.instockBtnLayerDisplay(false);
            $scope.flex.isReadOnly = true;

            // 수주확정
            if ($scope.procFg === "10") {
              $("#spanDtlTitle").html(messages["instockConfm.dtl.slipNo"] + ' : ' + $scope.slipNo + ', ' + messages["instockConfm.dtl.store"] + ' : ' + $scope.storeNm + ', ' + messages["instockConfm.dtl.reqDate"] + ' : ' + getFormatDate($scope.outDate));
            }
            // 입고확정
            else if ($scope.procFg === "30") {
              $("#spanDtlTitle").html(messages["instockConfm.dtl.slipNo"] + ' : ' + $scope.slipNo + ', ' + messages["instockConfm.dtl.store"] + ' : ' + $scope.storeNm + ', ' + messages["instockConfm.dtl.outDate"] + ' : ' + getFormatDate($scope.outDate) + ', ' + messages["instockConfm.dtl.inDate"] + ' : ' + getFormatDate($scope.inDate));
            }
          }

          $scope.searchInstockConfmDtlList();
        }
      }
    }, function errorCallback(response) {
      // called asynchronously if an error occurs
      // or server returns response with an error status.
      $scope._popMsg(messages["cmm.saveFail"]);
      return false;
    }).then(function () {
      // "complete" code here
    });
  };


  // 입고확정 상세내역 리스트 조회
  $scope.searchInstockConfmDtlList = function () {
    // 파라미터
    var params    = {};
    params.slipNo = $scope.slipNo;
    // 조회 수행 : 조회URL, 파라미터, 콜백함수
    $scope._inquirySub("/iostock/order/instockConfm/instockConfmDtl/list.sb", params, function () {
    });
  };


  // 저장
  $scope.save = function () {
    var params = [];

    // 확정처리가 체크 되어있으면서 그리드의 수정된 내역은 없는 경우 저장로직 태우기 위해 값 하나를 강제로 수정으로 변경한다.
    if ($("#instockConfirmFg").is(":checked") && $scope.flex.collectionView.itemsEdited.length <= 0) {
      var item = $scope.flex.collectionView.items[0];
      if (item === null) return false;

      $scope.flex.collectionView.editItem(item);
      item.status = "U";
      $scope.flex.collectionView.commitEdit();
    }

    for (var i = 0; i < $scope.flex.collectionView.itemsEdited.length; i++) {
      var item = $scope.flex.collectionView.itemsEdited[i];

      if (item.inUnitQty === null && item.inEtcQty === null) {
        $scope._popMsg(messages["instockConfm.dtl.require.inQty"]); // 입고수량을 입력해주세요.
        return false;
      }
      if (item.inEtcQty !== null && (parseInt(item.inEtcQty) >= parseInt(item.poUnitQty))) {
        $scope._popMsg(messages["instockConfm.dtl.not.inEtcQty"]); // 낱개수량은 입수량보다 작아야 합니다.
        return false;
      }
      if (item.inTot !== null && (parseInt(item.inTot) > 9999999999)) {
        $scope._popMsg(messages["instockConfm.dtl.not.overInTot"]); // 입고금액이 너무 큽니다.
        return false;
      }

      item.status    = "U";
      item.inDate    = wijmo.Globalize.format($scope.dtlInDate.value, 'yyyyMMdd');
      item.hdRemark  = $scope.hdRemark;
      item.confirmFg = ($("#instockConfirmFg").is(":checked") ? $("#instockConfirmFg").val() : "");

      params.push(item);
    }

    $scope._save("/iostock/order/instockConfm/instockConfmDtl/save.sb", params, function () {
      $scope.saveInstockConfmDtlCallback()
    });
  };


  // 저장 후 콜백 함수
  $scope.saveInstockConfmDtlCallback = function () {
    var instockConfmScope = agrid.getScope('instockConfmCtrl');
    instockConfmScope.searchInstockConfmList();

    $scope.wjInstockConfmDtlLayer.hide(true);
  };


  $scope.fnConfirmChk = function () {
    if ($("#instockConfirmFg").prop("checked")) {
      $("#divDtlInDate").show();
    } else {
      $("#divDtlInDate").hide();
    }
  };


  // 출고내역으로 입고내역 세팅
  $scope.setOutToIn = function () {
    $scope.$broadcast('loadingPopupActive', messages["cmm.progress"]);
    // 데이터 처리중 팝업 띄우기위해 $timeout 사용.
    $timeout(function () {
      for (var i = 0; i < $scope.flex.collectionView.items.length; i++) {
        var item = $scope.flex.collectionView.items[i];
        $scope.flex.collectionView.editItem(item);

        item.inUnitQty = item.outUnitQty;
        item.inEtcQty  = item.outEtcQty;
        $scope.calcAmt(item);

        $scope.flex.collectionView.commitEdit();
      }
      $scope.$broadcast('loadingPopupInactive');
    }, 100);
  };


  $scope.instockBtnLayerDisplay = function (isVisible) {
    if (isVisible) {
      $("#instockBtnLayer").show();
    } else {
      $("#instockBtnLayer").hide();
    }

    $scope.spanInstockConfirmFg = isVisible;
    $scope.btnSetOutToIn        = isVisible;
    $scope.btnDtlSave           = isVisible;
  };


  // 거래명세표
  $scope.reportTrans = function () {
    var params        = {};
    params.slipFg     = $scope.slipFg;
    params.strSlipNo  = $scope.slipNo;
    params.stmtAcctFg = $scope.stmtAcctFg;
    $scope._broadcast('transReportCtrl', params);
  };


  // DB 데이터를 조회해와서 그리드에서 사용할 Combo를 생성한다.
  // comboFg : map - 그리드에 사용할 Combo, combo - ComboBox 생성. 두가지 다 사용할경우 combo,map 으로 하면 둘 다 생성.
  // comboId : combo 생성할 ID
  // gridMapId : grid 에서 사용할 Map ID
  // url : 데이터 조회할 url 정보. 명칭관리 조회시에는 url 필요없음.
  // params : 데이터 조회할 url에 보낼 파라미터
  // option : A - combo 최상위에 전체라는 텍스트를 붙여준다. S - combo 최상위에 선택이라는 텍스트를 붙여준다. A 또는 S 가 아닌 경우는 데이터값만으로 생성
  // callback : queryCombo 후 callback 할 함수
  $scope._queryCombo = function (comboFg, comboId, gridMapId, url, params, option, callback) {
    var comboUrl = "/iostock/cmm/iostockCmm/getCombo.sb";
    if (url) {
      comboUrl = url;
    }

    // ajax 통신 설정
    $http({
      method : 'POST', //방식
      url    : comboUrl, /* 통신할 URL */
      params : params, /* 파라메터로 보낼 데이터 */
      headers: {'Content-Type': 'application/json; charset=utf-8'} //헤더
    }).then(function successCallback(response) {
      if ($scope._httpStatusCheck(response, true)) {
        if (!$.isEmptyObject(response.data.data.list)) {
          var list       = response.data.data.list;
          var comboArray = [];
          var comboData  = {};

          if (comboFg.indexOf("combo") >= 0 && nvl(comboId, '') !== '') {
            comboArray = [];
            if (option === "A") {
              comboData.name  = messages["cmm.all"];
              comboData.value = "";
              comboArray.push(comboData);
            } else if (option === "S") {
              comboData.name  = messages["cmm.select"];
              comboData.value = "";
              comboArray.push(comboData);
            }

            for (var i = 0; i < list.length; i++) {
              comboData       = {};
              comboData.name  = list[i].nmcodeNm;
              comboData.value = list[i].nmcodeCd;
              comboArray.push(comboData);
            }
            $scope._setComboData(comboId, comboArray);
          }

          if (comboFg.indexOf("map") >= 0 && nvl(gridMapId, '') !== '') {
            comboArray = [];
            for (var i = 0; i < list.length; i++) {
              comboData      = {};
              comboData.id   = list[i].nmcodeCd;
              comboData.name = list[i].nmcodeNm;
              comboArray.push(comboData);
            }
            $scope[gridMapId] = new wijmo.grid.DataMap(comboArray, 'id', 'name');
          }
        }
      }
    }, function errorCallback(response) {
      $scope._popMsg(messages["cmm.error"]);
      return false;
    }).then(function () {
      if (typeof callback === 'function') {
        $timeout(function () {
          callback();
        }, 10);
      }
    });
  };

}]);