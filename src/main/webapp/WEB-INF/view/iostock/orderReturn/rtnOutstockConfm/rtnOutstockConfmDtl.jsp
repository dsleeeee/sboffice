<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="menuCd" value="${sessionScope.sessionInfo.currentMenu.resrceCd}"/>
<c:set var="menuNm" value="${sessionScope.sessionInfo.currentMenu.resrceNm}"/>
<c:set var="baseUrl" value="/iostock/orderReturn/rtnOutstockConfm/rtnOutstockConfmDtl/"/>

<wj-popup id="wjRtnOutstockConfmDtlLayer" control="wjRtnOutstockConfmDtlLayer" show-trigger="Click" hide-trigger="Click" style="display:none;width:900px;">
  <div id="rtnOutstockConfmDtlLayer" class="wj-dialog wj-dialog-columns" ng-controller="rtnOutstockConfmDtlCtrl">
    <div class="wj-dialog-header wj-dialog-header-font">
      <span id="spanDtlTitle"></span>
      <a href="#" class="wj-hide btn_close"></a>
    </div>
    <div class="wj-dialog-body sc2" style="height: 600px;">
      <table class="tblType01">
        <colgroup>
          <col class="w20"/>
          <col class="w80"/>
        </colgroup>
        <tbody>
        <tr>
          <%-- 비고 --%>
          <th><s:message code="rtnOutstockConfm.dtl.hdRemark"/></th>
          <td>
            <input type="text" id="hdRemark" name="hdRemark" ng-model="hdRemark" class="sb-input w100" maxlength="300"/>
          </td>
        </tr>
        <tr>
          <%-- 본사비고(매장열람불가) --%>
          <th><s:message code="rtnOutstockConfm.dtl.hqRemark"/></th>
          <td>
            <input type="text" id="hqRemark" name="hqRemark" ng-model="hqRemark" class="sb-input w100" maxlength="300"/>
          </td>
        </tr>
        <tr>
          <%-- 배송기사 --%>
          <th><s:message code="rtnOutstockConfm.dtl.dlvrNm"/></th>
          <td>
            <span class="txtIn w150px sb-select fl mr5">
              <wj-combo-box
                id="srchDtlDlvrCd"
                ng-model="dlvrCd"
                items-source="_getComboData('srchDtlDlvrCd')"
                display-member-path="name"
                selected-value-path="value"
                is-editable="false"
                initialized="_initComboBox(s)">
              </wj-combo-box>
            </span>
          </td>
        </tr>
        <tr>
          <%-- 거래명세표 --%>
          <th><s:message code="rtnOutstockConfm.dtl.stmtAcct"/></th>
          <td>
            <span class="txtIn w150px sb-select fl mr5">
              <wj-combo-box
                id="stmtAcctFg"
                ng-model="stmtAcctFg"
                items-source="_getComboData('stmtAcctFg')"
                display-member-path="name"
                selected-value-path="value"
                is-editable="false"
                initialized="_initComboBox(s)">
              </wj-combo-box>
            </span>
            <a href="#" class="btn_grayS" ng-click=""><s:message code="rtnOutstockConfm.dtl.stmtAcctPrint"/></a>
            <a href="#" class="btn_grayS" ng-click=""><s:message code="rtnOutstockConfm.dtl.stmtAcctExcel"/></a>
          </td>
        </tr>
        </tbody>
      </table>

      <ul class="txtSty3 mt10">
        <li class="red"><s:message code="rtnOutstockConfm.dtl.txt1"/></li>
        <li class="red"><s:message code="rtnOutstockConfm.dtl.txt2"/></li>
        <li class="red"><s:message code="rtnOutstockConfm.dtl.txt3"/></li>
      </ul>

      <div class="tr mt20 fr">
        <div id="outstockBtnLayer" style="display: none;">
          <%-- 출고확정 체크박스 --%>
          <span id="spanOutstockConfirmFg" class="chk pdb5 txtIn fl" style="top: 0px;" ng-if="spanOutstockConfirmFg">
            <input type="checkbox" name="outstockConfirmFg" id="outstockConfirmFg" value="Y" ng-click="fnConfirmChk()"/>
            <label for="outstockConfirmFg"><s:message code="rtnOutstockConfm.dtl.confirmFg"/></label>
          </span>
          <%-- 출고일자 --%>
          <div id="divDtlOutDate" class="sb-select ml10 fl" style="display: none;">
            <span class="txtIn"><input id="dtlOutDate" class="w120px"></span>
          </div>
          <%-- 저장 --%>
          <button type="button" id="btnDtlSave" class="btn_skyblue ml5 fl" ng-click="save()" ng-if="btnDtlSave"><s:message code="cmm.save"/></button>
        </div>
        <div id="outstockAfterBtnLayer" style="display: none;">
          <%-- 출고 후 저장 --%>
          <button type="button" id="btnOutstockAfterDtlSave" class="btn_skyblue ml5 fl" ng-click="saveOutstockAfter()" ng-if="btnOutstockAfterDtlSave"><s:message code="cmm.save"/></button>
        </div>
      </div>
      <div style="clear: both;"></div>

      <div class="w100 mt10 mb20">
        <%--위즈모 테이블--%>
        <div class="wj-gridWrap" style="height: 400px;">
          <wj-flex-grid
            autoGenerateColumns="false"
            selection-mode="Row"
            items-source="data"
            control="flex"
            initialized="initGrid(s,e)"
            is-read-only="false"
            item-formatter="_itemFormatter">

            <!-- define columns -->
            <wj-flex-grid-column header="<s:message code="rtnOutstockConfm.dtl.slipNo"/>" binding="slipNo" width="0" align="center" is-read-only="true" visible="false"></wj-flex-grid-column>
            <wj-flex-grid-column header="<s:message code="rtnOutstockConfm.dtl.slipFg"/>" binding="slipFg" width="0" align="center" is-read-only="true" visible="false"></wj-flex-grid-column>
            <wj-flex-grid-column header="<s:message code="rtnOutstockConfm.dtl.seq"/>" binding="seq" width="0" align="center" is-read-only="true" visible="false"></wj-flex-grid-column>
            <wj-flex-grid-column header="<s:message code="rtnOutstockConfm.dtl.storeCd"/>" binding="storeCd" width="0" align="center" is-read-only="true" visible="false"></wj-flex-grid-column>
            <wj-flex-grid-column header="<s:message code="rtnOutstockConfm.dtl.prodCd"/>" binding="prodCd" width="100" align="center" is-read-only="true"></wj-flex-grid-column>
            <wj-flex-grid-column header="<s:message code="rtnOutstockConfm.dtl.prodNm"/>" binding="prodNm" width="150" align="left" is-read-only="true"></wj-flex-grid-column>
            <wj-flex-grid-column header="<s:message code="rtnOutstockConfm.dtl.barcdCd"/>" binding="barcdCd" width="150" align="left" is-read-only="true"></wj-flex-grid-column>
            <wj-flex-grid-column header="<s:message code="rtnOutstockConfm.dtl.poUnitFg"/>" binding="poUnitFg" width="70" align="center" is-read-only="true" data-map="poUnitFgMap"></wj-flex-grid-column>
            <wj-flex-grid-column header="<s:message code="rtnOutstockConfm.dtl.poUnitQty"/>" binding="poUnitQty" width="70" align="right" is-read-only="true"></wj-flex-grid-column>
            <wj-flex-grid-column header="<s:message code="rtnOutstockConfm.dtl.outSplyUprc"/>" binding="outSplyUprc" width="70" align="right" is-read-only="false" max-length=10 data-type="Number" format="n0"></wj-flex-grid-column>
            <wj-flex-grid-column header="<s:message code="rtnOutstockConfm.dtl.outUnitQty"/>" binding="outUnitQty" width="70" align="right" is-read-only="false" max-length=8 data-type="Number" format="n0" aggregate="Sum"></wj-flex-grid-column>
            <wj-flex-grid-column header="<s:message code="rtnOutstockConfm.dtl.outEtcQty"/>" binding="outEtcQty" width="70" align="right" is-read-only="false" max-length=8 data-type="Number" format="n0" aggregate="Sum"></wj-flex-grid-column>
            <wj-flex-grid-column header="<s:message code="rtnOutstockConfm.dtl.outTotQty"/>" binding="outTotQty" width="70" align="right" is-read-only="true" visible="false"></wj-flex-grid-column>
            <wj-flex-grid-column header="<s:message code="rtnOutstockConfm.dtl.outAmt"/>" binding="outAmt" width="70" align="right" is-read-only="true" data-type="Number" format="n0" aggregate="Sum"></wj-flex-grid-column>
            <wj-flex-grid-column header="<s:message code="rtnOutstockConfm.dtl.outVat"/>" binding="outVat" width="70" align="right" is-read-only="true" data-type="Number" format="n0" aggregate="Sum"></wj-flex-grid-column>
            <wj-flex-grid-column header="<s:message code="rtnOutstockConfm.dtl.outTot"/>" binding="outTot" width="70" align="right" is-read-only="true" data-type="Number" format="n0" aggregate="Sum"></wj-flex-grid-column>
            <wj-flex-grid-column header="<s:message code="rtnOutstockConfm.dtl.remark"/>" binding="remark" width="200" align="left" is-read-only="false" max-length=300></wj-flex-grid-column>
            <wj-flex-grid-column header="<s:message code="rtnOutstockConfm.dtl.vatFg"/>" binding="vatFg01" width="70" align="right" is-read-only="true" visible="false"></wj-flex-grid-column>
            <wj-flex-grid-column header="<s:message code="rtnOutstockConfm.dtl.envst0011"/>" binding="envst0011" width="70" align="right" is-read-only="true" visible="false"></wj-flex-grid-column>

          </wj-flex-grid>
        </div>
        <%--//위즈모 테이블--%>

      </div>
    </div>
  </div>
</wj-popup>


<script type="text/javascript">

  /** 출고확정 상세 그리드 controller */
  app.controller('rtnOutstockConfmDtlCtrl', ['$scope', '$http', '$timeout', function ($scope, $http, $timeout) {
    // 상위 객체 상속 : T/F 는 picker
    angular.extend(this, new RootController('rtnOutstockConfmDtlCtrl', $scope, $http, true));

    $scope.dtlOutDate = wcombo.genDate("#dtlOutDate");

    $scope._setComboData("stmtAcctFg", [
      {"name": messages["rtnOutstockConfm.dtl.stmtAcctAll"], "value": ""},
      {"name": messages["rtnOutstockConfm.dtl.stmtAcctSplr"], "value": "1"},
      {"name": messages["rtnOutstockConfm.dtl.stmtAcctSplrRcpnt"], "value": "2"}
    ]);

    // grid 초기화 : 생성되기전 초기화되면서 생성된다
    $scope.initGrid = function (s, e) {
      // 배송기사
      var comboParams             = {};
      var url = '/iostock/order/outstockConfm/outstockConfm/getDlvrCombo.sb';
      // 파라미터 (comboFg, comboId, gridMapId, url, params, option, callback)
      $scope._queryCombo("combo", "srchDtlDlvrCd", null, url, comboParams, "S"); // 명칭관리 조회시 url 없이 그룹코드만 넘긴다.

      comboParams         = {};
      comboParams.nmcodeGrpCd = "097";
      url = '/iostock/cmm/iostockCmm/getOrgnCombo.sb';
      // 파라미터 (comboFg, comboId, gridMapId, url, params, option)
      $scope._queryCombo("map", null, 'poUnitFgMap', url, comboParams, "A"); // 명칭관리 조회시 url 없이 그룹코드만 넘긴다.

      // 그리드 포맷 핸들러
      s.formatItem.addHandler(function (s, e) {
        if (e.panel === s.cells) {
          var col  = s.columns[e.col];
          var item = s.rows[e.row].dataItem;
          if (col.binding === "outEtcQty") { // 입수에 따라 출고수량 컬럼 readonly 컨트롤
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
          if (col.binding === "outSplyUprc" || col.binding === "outUnitQty" || col.binding === "outEtcQty") { // 출고수량 수정시
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

      var unitQty = parseInt(nvl(item.outUnitQty, 0)) * parseInt(item.poUnitQty);
      var etcQty  = parseInt(nvl(item.outEtcQty, 0));
      var totQty  = parseInt(unitQty + etcQty);
      var tempAmt = Math.round(totQty * outSplyUprc / poUnitQty);
      var outAmt  = tempAmt - Math.round(tempAmt * vat01 * envst0011 / 11);
      var outVat  = Math.round(tempAmt * vat01 / (10 + envst0011));
      var outTot  = parseInt(outAmt + outVat);

      item.outTotQty = totQty; // 총출고수량
      item.outAmt    = outAmt; // 금액
      item.outVat    = outVat; // VAT
      item.outTot    = outTot; // 합계
    };

    // 다른 컨트롤러의 broadcast 받기
    $scope.$on("rtnOutstockConfmDtlCtrl", function (event, data) {
      $scope.slipNo = data.slipNo;
      $scope.wjRtnOutstockConfmDtlLayer.show(true);

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
        url    : '/iostock/orderReturn/rtnOutstockConfm/rtnOutstockConfmDtl/getSlipNoInfo.sb', /* 통신할 URL */
        params : params, /* 파라메터로 보낼 데이터 */
        headers: {'Content-Type': 'application/json; charset=utf-8'} //헤더
      }).then(function successCallback(response) {
        if ($scope._httpStatusCheck(response, true)) {
          if (!$.isEmptyObject(response.data.data)) {

            $scope.dtlOutDate.value = new Date(getFormatDate(response.data.data.outDate, "-"));
            $scope.outDate          = response.data.data.outDate;
            $scope.inDate           = response.data.data.inDate;
            $scope.slipFg           = response.data.data.slipFg;
            $scope.slipKind         = response.data.data.slipKind;
            $scope.slipKindNm       = response.data.data.slipKindNm;
            $scope.procFg           = response.data.data.procFg;
            $scope.storeCd          = response.data.data.storeCd;
            $scope.storeNm          = response.data.data.storeNm;
            $scope.hdRemark         = response.data.data.remark;
            $scope.hqRemark         = response.data.data.hqRemark;
            $scope.dlvrCd           = nvl(response.data.data.dlvrCd, '');
            $scope.dlvrNm           = response.data.data.dlvrNm;

            // 수주확정
            if ($scope.procFg === "10") {
              $("#spanDtlTitle").html(messages["rtnOutstockConfm.dtl.slipNo"]+' : ' + $scope.slipNo + ', '+messages["rtnOutstockConfm.dtl.store"]+' : ' + $scope.storeNm + ', '+messages["rtnOutstockConfm.dtl.reqDate"]+' : ' + getFormatDate($scope.outDate));
              $("#outstockBtnLayer").show();
              $scope.spanOutstockConfirmFg = true;
              $scope.btnDtlSave = true;
              $scope.btnOutstockAfterDtlSave = false;
              $scope.flex.isReadOnly = false;
            }
            // 출고확정 또는 입고확정
            else if ($scope.procFg === "20" || $scope.procFg === "30") {
              $("#outstockBtnLayer").hide();
              $scope.spanOutstockConfirmFg = false;
              $scope.btnDtlSave = false;
              $scope.btnOutstockAfterDtlSave = true;
              $scope.flex.isReadOnly = true;

              // 출고확정
              if ($scope.procFg === "20") {
                $("#spanDtlTitle").html(messages["rtnOutstockConfm.dtl.slipNo"]+' : ' + $scope.slipNo + ', '+messages["rtnOutstockConfm.dtl.store"]+' : ' + $scope.storeNm + ', '+messages["rtnOutstockConfm.dtl.outDate"]+' : ' + getFormatDate($scope.outDate));
              }
              // 입고확정
              else if ($scope.procFg === "30") {
                $("#spanDtlTitle").html(messages["rtnOutstockConfm.dtl.slipNo"]+' : ' + $scope.slipNo + ', '+messages["rtnOutstockConfm.dtl.store"]+' : ' + $scope.storeNm + ', '+messages["rtnOutstockConfm.dtl.outDate"]+' : ' + getFormatDate($scope.outDate) + ', '+messages["rtnOutstockConfm.dtl.inDate"]+' : ' + getFormatDate($scope.inDate));
              }
            }

            $scope.searchRtnOutstockConfmDtlList();
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

    // 출고확정 상세내역 리스트 조회
    $scope.searchRtnOutstockConfmDtlList = function () {
      // 파라미터
      var params    = {};
      params.slipNo = $scope.slipNo;
      // 조회 수행 : 조회URL, 파라미터, 콜백함수
      $scope._inquirySub("/iostock/orderReturn/rtnOutstockConfm/rtnOutstockConfmDtl/list.sb", params, function () {
      });
    };

    // 저장
    $scope.save = function () {
      var params = [];

      // 확정처리가 체크 되어있으면서 그리드의 수정된 내역은 없는 경우 저장로직 태우기 위해 값 하나를 강제로 수정으로 변경한다.
      if ($("#outstockConfirmFg").is(":checked") && $scope.flex.collectionView.itemsEdited.length <= 0) {
        var item = $scope.flex.collectionView.items[0];
        if (item === null) return false;

        $scope.flex.collectionView.editItem(item);
        item.status = "U";
        $scope.flex.collectionView.commitEdit();
      }

      for (var i = 0; i < $scope.flex.collectionView.itemsEdited.length; i++) {
        var item = $scope.flex.collectionView.itemsEdited[i];

        if (item.outUnitQty === null && item.outEtcQty === null) {
          $scope._popMsg(messages["rtnOutstockConfm.dtl.require.outQty"]); // 출고수량을 입력해주세요.
          return false;
        }
        if (item.outEtcQty !== null && (parseInt(item.outEtcQty) >= parseInt(item.poUnitQty))) {
          $scope._popMsg(messages["rtnOutstockConfm.dtl.not.outEtcQty"]); // 낱개수량은 입수량보다 작아야 합니다.
          return false;
        }
        if (item.outTot !== null && (parseInt(item.outTot) > 9999999999)) {
          $scope._popMsg(messages["rtnOutstockConfm.dtl.not.overOutTot"]); // 출고금액이 너무 큽니다.
          return false;
        }

        item.status    = "U";
        item.outDate   = wijmo.Globalize.format($scope.dtlOutDate.value, 'yyyyMMdd');
        item.hdRemark  = $scope.hdRemark;
        item.hqRemark  = $scope.hqRemark;
        item.dlvrCd    = $scope.dlvrCd;
        item.confirmFg = ($("#outstockConfirmFg").is(":checked") ? $("#outstockConfirmFg").val() : "");

        params.push(item);
      }

      $scope._save("/iostock/orderReturn/rtnOutstockConfm/rtnOutstockConfmDtl/save.sb", params, function () {
        $scope.saveRtnOutstockConfmDtlCallback()
      });
    };

    // 저장 후 콜백 함수
    $scope.saveRtnOutstockConfmDtlCallback = function () {
      var rtnOutstockConfmScope = agrid.getScope('rtnOutstockConfmCtrl');
      rtnOutstockConfmScope.searchRtnOutstockConfmList();

      $scope.wjRtnOutstockConfmDtlLayer.hide(true);
    };

    // 출고확정 이후 저장. 비고, 본사비고, 배송기사를 저장한다.
    $scope.saveOutstockAfter = function () {
      // 파라미터
      var params      = {};
      params.slipNo   = $scope.slipNo;
      params.hdRemark = $scope.hdRemark;
      params.hqRemark = $scope.hqRemark;
      params.dlvrCd   = $scope.dlvrCd;

      // ajax 통신 설정
      $http({
        method : 'POST', //방식
        url    : '/iostock/orderReturn/rtnOutstockConfm/rtnOutstockConfmDtl/saveOutstockAfter.sb', /* 통신할 URL */
        params : params, /* 파라메터로 보낼 데이터 */
        headers: {'Content-Type': 'application/json; charset=utf-8'} //헤더
      }).then(function successCallback(response) {
        if ($scope._httpStatusCheck(response, true)) {
          $scope._popMsg(messages["cmm.saveSucc"]);
          $scope.flex.collectionView.clearChanges();
          $scope.saveRtnOutstockConfmDtlCallback();
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

    $scope.fnConfirmChk = function () {
      if ($("#outstockConfirmFg").prop("checked")) {
        $("#divDtlOutDate").show();
      }
      else {
        $("#divDtlOutDate").hide();
      }
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
</script>
