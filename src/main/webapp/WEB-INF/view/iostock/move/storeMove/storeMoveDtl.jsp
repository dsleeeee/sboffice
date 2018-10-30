<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="menuCd" value="${sessionScope.sessionInfo.currentMenu.resrceCd}"/>
<c:set var="menuNm" value="${sessionScope.sessionInfo.currentMenu.resrceNm}"/>
<c:set var="baseUrl" value="/iostock/move/storeMove/storeMoveDtl/"/>

<wj-popup id="wjStoreMoveDtlLayer" control="wjStoreMoveDtlLayer" show-trigger="Click" hide-trigger="Click" style="display:none;width:900px;">
  <div id="storeMoveDtlLayer" class="wj-dialog wj-dialog-columns" ng-controller="storeMoveDtlCtrl">
    <div class="wj-dialog-header wj-dialog-header-font">
      <s:message code="storeMove.dtl.dtlTitle"/>
      <a href="#" class="wj-hide btn_close"></a>
    </div>
    <div class="wj-dialog-body sc2" style="height: 600px;">
      <table class="tblType01">
        <colgroup>
          <col class="w15"/>
          <col class="w35"/>
          <col class="w15"/>
          <col class="w35"/>
        </colgroup>
        <tbody>
        <tr>
          <th><s:message code="storeMove.dtl.moveDate"/></th>
          <td>
            <div class="sb-select">
              <span class="txtIn"><input id="dtlMoveDate" class="w150" ng-model="moveDate"></span>
            </div>
          </td>
          <%-- 배송구분 --%>
          <th><s:message code="storeMove.dlvrFg"/></th>
          <td>
            <div class="sb-select">
              <span class="txtIn w150">
                <wj-combo-box
                  id="srchDtlDlvrFg"
                  ng-model="dlvrFg"
                  items-source="_getComboData('srchDtlDlvrFg')"
                  display-member-path="name"
                  selected-value-path="value"
                  is-editable="false"
                  initialized="_initComboBox(s)">
                </wj-combo-box>
              </span>
            </div>
          </td>
        </tr>
        <tr>
          <%-- 출고매장 --%>
          <th><s:message code="storeMove.dtl.outStoreCd"/></th>
          <td colspan="3">
            <%-- 매장선택 모듈 멀티 선택 사용시 include
                 param 정의 : targetId - angular 콘트롤러 및 input 생성시 사용할 타켓id
                              displayNm - 로딩시 input 창에 보여질 명칭(변수 없을 경우 기본값 선택으로 표시)
                              modiFg - 수정여부(변수 없을 경우 기본값으로 수정가능)
                              closeFunc - 팝업 닫기시 호출할 함수
            --%>
            <jsp:include page="/WEB-INF/view/iostock/order/outstockReqDate/selectShopS.jsp" flush="true">
              <jsp:param name="targetId" value="storeMoveDtlOutSelectStore"/>
              <jsp:param name="modiFg" value="N"/>
            </jsp:include>
            <%--// 매장선택 모듈 멀티 선택 사용시 include --%>
          </td>
        </tr>
        <tr>
          <%-- 입고매장 --%>
          <th><s:message code="storeMove.dtl.inStoreCd"/></th>
          <td colspan="3">
            <%-- 매장선택 모듈 싱글 선택 사용시 include
                 param 정의 : targetId - angular 콘트롤러 및 input 생성시 사용할 타켓id
                              displayNm - 로딩시 input 창에 보여질 명칭(변수 없을 경우 기본값 선택으로 표시)
                              modiFg - 수정여부(변수 없을 경우 기본값으로 수정가능)
                              closeFunc - 팝업 닫기시 호출할 함수
            --%>
            <jsp:include page="/WEB-INF/view/iostock/order/outstockReqDate/selectShopS.jsp" flush="true">
              <jsp:param name="targetId" value="storeMoveDtlInSelectStore"/>
              <jsp:param name="modiFg" value="N"/>
            </jsp:include>
            <%--// 매장선택 모듈 싱글 선택 사용시 include --%>
          </td>
        </tr>
        <tr>
          <th><s:message code="storeMove.dtl.remark"/></th>
          <td colspan="3">
            <input type="text" id="dtlHdRemark" name="dtlHdRemark" ng-model="dtlHdRemark" class="sb-input w100"/>
          </td>
        </tr>
        </tbody>
      </table>

      <table class="tblType01 mt10">
        <colgroup>
          <col style="width: 13%;"/>
          <col style="width: 20%;"/>
          <col style="width: 13%;"/>
          <col style="width: 20%;"/>
          <col style="width: 13%;"/>
          <col style="width: 20%;"/>
        </colgroup>
        <tbody>
        <tr>
          <th><s:message code="storeMove.dtl.regDt"/></th>
          <td><p id="regDt" class="s12"></p></td>
          <th><s:message code="storeMove.dtl.outConfmDt"/></th>
          <td><p id="outConfmDt" class="s12"></p></td>
          <th><s:message code="storeMove.dtl.inConfmDt"/></th>
          <td><p id="inConfmDt" class="s12"></p></td>
        </tr>
        <tr>
          <th><s:message code="storeMove.dtl.hqConfmDt"/></th>
          <td><p id="hqConfmDt" class="s12"></p></td>
          <th id="thOutSlipNo"></th>
          <td><p id="outSlipNo" class="s12"></p></td>
          <th id="thInSlipNo"></th>
          <td><p id="inSlipNo" class="s12"></p></td>
        </tr>
        </tbody>
      </table>

      <ul class="txtSty3 mt10">
        <li class="red"><s:message code="storeMove.dtl.txt2"/></li>
        <li class="red"><s:message code="storeMove.dtl.txt3"/></li>
      </ul>

      <div class="tr mt20 fr">
        <%-- 상품추가 --%>
        <button type="button" id="btnDtlAddProd" class="btn_skyblue ml5 fl" ng-click="addProd()">
          <s:message code="storeMove.dtl.addProdBtn"/></button>
        <%-- 저장 --%>
        <button type="button" id="btnDtlSave" class="btn_skyblue ml5 fl" ng-click="save()">
          <s:message code="cmm.save"/></button>
        <%-- 저장 및 출고,이입확정 --%>
        <button type="button" id="btnDtlConfirm" class="btn_skyblue ml5 fl" ng-click="confirm()"></button>
        <%-- 삭제 --%>
        <button type="button" id="btnDtlDel" class="btn_skyblue ml5 fl" ng-click="delete()">
          <s:message code="cmm.delete"/></button>
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
            <wj-flex-grid-column header="<s:message code="storeMove.dtl.prodCd"/>" binding="prodCd" width="100" align="center" is-read-only="true"></wj-flex-grid-column>
            <wj-flex-grid-column header="<s:message code="storeMove.dtl.prodNm"/>" binding="prodNm" width="150" align="left" is-read-only="true"></wj-flex-grid-column>
            <wj-flex-grid-column header="<s:message code="storeMove.dtl.poUnitFg"/>" binding="poUnitFg" width="70" align="center" is-read-only="true"></wj-flex-grid-column>
            <wj-flex-grid-column header="<s:message code="storeMove.dtl.poUnitQty"/>" binding="poUnitQty" width="70" align="right" is-read-only="true"></wj-flex-grid-column>
            <wj-flex-grid-column header="<s:message code="storeMove.dtl.unitQty"/>" binding="outUnitQty" width="70" align="right" max-length=8 data-type="Number" format="n0" aggregate="Sum"></wj-flex-grid-column>
            <wj-flex-grid-column header="<s:message code="storeMove.dtl.etcQty"/>" binding="outEtcQty" width="70" align="right" max-length=8 data-type="Number" format="n0" aggregate="Sum"></wj-flex-grid-column>
            <wj-flex-grid-column header="<s:message code="storeMove.dtl.totQty"/>" binding="outTotQty" width="70" align="right" visible="false"></wj-flex-grid-column>
            <wj-flex-grid-column header="<s:message code="storeMove.dtl.totQty"/>" binding="prevOutTotQty" width="70" align="right" visible="false"></wj-flex-grid-column>
            <wj-flex-grid-column header="<s:message code="storeMove.dtl.splyUprc"/>" binding="splyUprc" width="70" align="right" max-length=8 data-type="Number" format="n0"></wj-flex-grid-column>
            <wj-flex-grid-column header="<s:message code="storeMove.dtl.splyUprc"/>" binding="outSplyUprc" width="70" align="right" is-read-only="true" visible="false"></wj-flex-grid-column>
            <wj-flex-grid-column header="<s:message code="storeMove.dtl.splyUprc"/>" binding="inSplyUprc" width="70" align="right" is-read-only="true" visible="false"></wj-flex-grid-column>
            <wj-flex-grid-column header="<s:message code="storeMove.dtl.amt"/>" binding="amt" width="70" align="right" is-read-only="true" aggregate="Sum"></wj-flex-grid-column>
            <wj-flex-grid-column header="<s:message code="storeMove.dtl.vat"/>" binding="vat" width="70" align="right" is-read-only="true" aggregate="Sum"></wj-flex-grid-column>
            <wj-flex-grid-column header="<s:message code="storeMove.dtl.tot"/>" binding="tot" width="70" align="right" is-read-only="true" aggregate="Sum"></wj-flex-grid-column>
            <wj-flex-grid-column header="<s:message code="storeMove.dtl.vatFg"/>" binding="vatFg01" width="70" align="right" is-read-only="true" visible="false"></wj-flex-grid-column>
            <wj-flex-grid-column header="<s:message code="storeMove.dtl.envst0011"/>" binding="outEnvst0011" width="70" align="right" is-read-only="true" visible="false"></wj-flex-grid-column>
            <wj-flex-grid-column header="<s:message code="storeMove.dtl.envst0011"/>" binding="inEnvst0011" width="70" align="right" is-read-only="true" visible="false"></wj-flex-grid-column>

          </wj-flex-grid>
        </div>
        <%--//위즈모 테이블--%>

      </div>
    </div>
  </div>
</wj-popup>


<script type="text/javascript">

  /** 물량오류 상세 그리드 controller */
  app.controller('storeMoveDtlCtrl', ['$scope', '$http', function ($scope, $http) {
    // 상위 객체 상속 : T/F 는 picker
    angular.extend(this, new RootController('storeMoveDtlCtrl', $scope, $http, true));

    $scope.moveDate            = wcombo.genDate("#dtlMoveDate");
    $scope.moveDate.isReadOnly = true;
    $scope.sessionStoreCd      = "${sessionInfo.storeCd}";

    $scope._setComboData("srchDtlDlvrFg", [
      {"name": messages["storeMove.dlvrFg0"], "value": "0"},
      {"name": messages["storeMove.dlvrFg1"], "value": "1"},
      {"name": messages["storeMove.dlvrFg2"], "value": "2"}
    ]);

    // grid 초기화 : 생성되기전 초기화되면서 생성된다
    $scope.initGrid = function (s, e) {
      // 그리드 포맷 핸들러
      s.formatItem.addHandler(function (s, e) {
        if (e.panel === s.cells) {
          var col  = s.columns[e.col];
          var item = s.rows[e.row].dataItem;
          if (col.binding === "outEtcQty") { // 입수에 따라 주문수량 컬럼 readonly 컨트롤
            if (item.poUnitQty === 1) {
              wijmo.addClass(e.cell, 'wj-custom-readonly');
              wijmo.setAttribute(e.cell, 'aria-readonly', true);

              // Attribute 의 변경사항을 적용.
              var html         = e.cell.outerHTML;
              e.cell.outerHTML = html;
            }
          }
        }
      });

      s.cellEditEnded.addHandler(function (s, e) {
        if (e.panel === s.cells) {
          var col = s.columns[e.col];
          // 주문수량 수정시 금액,VAT,합계 계산하여 보여준다.
          if (col.binding === "outUnitQty" || col.binding === "outEtcQty" || col.binding === "splyUprc") {
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


    $scope.calcAmt = function (item) {
      <%-- 수량이 없는 경우 계산하지 않음.
      null 또는 undefined 가 나올수 있으므로 확실하게 확인하기 위해 nvl 처리로 null 로 바꿔서 비교 --%>
      if (nvl(item.outUnitQty, null) === null || (item.poUnitQty !== 1 && nvl(item.outEtcQty, null) === null)) return false;

      var outSplyUprc  = parseInt(nvl(item.splyUprc, 0));
      var poUnitQty    = parseInt(item.poUnitQty);
      var vat01        = parseInt(item.vatFg01);
      var outEnvst0011 = parseInt(item.outEnvst0011);

      var unitQty    = parseInt(nvl(item.outUnitQty, 0)) * parseInt(item.poUnitQty);
      var etcQty     = parseInt(nvl(item.outEtcQty, 0));
      var totQty     = parseInt(unitQty + etcQty);
      var tempOutAmt = Math.round(totQty * outSplyUprc / poUnitQty);
      var outAmt     = tempOutAmt - Math.round(tempOutAmt * vat01 * outEnvst0011 / 11);
      var outVat     = Math.round(tempOutAmt * vat01 / (10 + outEnvst0011));
      var outTot     = parseInt(outAmt + outVat);

      item.outTotQty = totQty; // 총수량
      item.amt       = outAmt; // 이출금액
      item.vat       = outVat; // 이출VAT
      item.tot       = outTot; // 이출합계
    };


    // 다른 컨트롤러의 broadcast 받기
    $scope.$on("storeMoveDtlCtrl", function (event, data) {
      $scope.slipNo = data.slipNo;
      $scope.wjStoreMoveDtlLayer.show(true);

      $scope.fnBtnLayerDisplay(false);
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
        url    : '/iostock/move/storeMove/storeMoveDtl/getSlipNoInfo.sb', /* 통신할 URL */
        params : params, /* 파라메터로 보낼 데이터 */
        headers: {'Content-Type': 'application/json; charset=utf-8'} //헤더
      }).then(function successCallback(response) {
        if ($scope.httpStatusCheck(response)) {
          if (!$.isEmptyObject(response.data.data)) {

            $scope.moveDate.value = new Date(getFormatDate(response.data.data.moveDate, "-"));
            $scope.procFg         = response.data.data.procFg;
            $scope.dlvrFg         = response.data.data.dlvrFg;
            $scope.dtlHdRemark    = response.data.data.remark;
            $scope.outStoreCd     = response.data.data.outStoreCd;
            $scope.outStoreNm     = response.data.data.outStoreNm;
            $scope.inStoreCd      = response.data.data.inStoreCd;
            $scope.inStoreNm      = response.data.data.inStoreNm;

            $("#storeMoveDtlOutSelectStoreCd").val($scope.outStoreCd);
            $("#storeMoveDtlOutSelectStoreNm").val('['+$scope.outStoreCd+'] '+$scope.outStoreNm);
            $("#storeMoveDtlInSelectStoreCd").val($scope.inStoreCd);
            $("#storeMoveDtlInSelectStoreNm").val('['+$scope.inStoreCd+'] '+$scope.inStoreNm);

            var regDt      = response.data.data.regDt;
            var outConfmDt = response.data.data.outConfmDt;
            var inConfmDt  = response.data.data.inConfmDt;
            var hqConfmDt  = response.data.data.hqConfmDt;
            var outSlipNo  = response.data.data.outSlipNo;
            var inSlipNo   = response.data.data.inSlipNo;

            $("#regDt").html(regDt !== null ? getFormatDateTime(regDt) : '');
            $("#outConfmDt").html(outConfmDt !== null ? getFormatDateTime(outConfmDt) : '');
            $("#inConfmDt").html(inConfmDt !== null ? getFormatDateTime(inConfmDt) : '');
            $("#hqConfmDt").html(hqConfmDt !== null ? getFormatDateTime(hqConfmDt) : '');
            $("#thOutSlipNo").html($scope.sessionStoreCd == $scope.outStoreCd ? messages ["storeMove.dtl.outSlipNo"] : '');
            $("#outSlipNo").html($scope.sessionStoreCd == $scope.outStoreCd ? outSlipNo : '');
            $("#thInSlipNo").html($scope.sessionStoreCd == $scope.inStoreCd ? messages ["storeMove.dtl.inSlipNo"] : '');
            $("#inSlipNo").html($scope.sessionStoreCd == $scope.inStoreCd ? inSlipNo : '');

            if ($scope.procFg === '0') {
              if ($scope.sessionStoreCd == $scope.outStoreCd) {
                $("#btnDtlConfirm").text(messages["storeMove.dtl.outConfirmBtn"]);
                $scope.fnBtnLayerDisplay(true);
                $scope.flex.isReadOnly = false;
              }
            }
            else {
              $scope.flex.isReadOnly = true;

              if ($scope.procFg === '1' && $scope.sessionStoreCd == $scope.inStoreCd) {
                $("#btnDtlConfirm").html(messages["storeMove.dtl.inConfirmBtn"]);
                $("#btnDtlConfirm").show();
              }
            }

            $scope.searchStoreMoveDtlList();
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


    // 매장이동관리 상세내역 리스트 조회
    $scope.searchStoreMoveDtlList = function () {
      // 파라미터
      var params            = {};
      params.slipNo         = $scope.slipNo;
      params.sessionStoreCd = $scope.sessionStoreCd;
      // 조회 수행 : 조회URL, 파라미터, 콜백함수
      $scope._inquirySub("/iostock/move/storeMove/storeMoveDtl/list.sb", params, function () {
        // $scope.$broadcast('loadingPopupActive', messages["cmm.progress"]);
        // // 데이터 처리중 팝업 띄우기위해 setTimeout 사용.
        // setTimeout(function () {
        //   for (var i = 0; i < $scope.flex.collectionView.items.length; i++) {
        //     var item = $scope.flex.collectionView.items[i];
        //     $scope.flex.collectionView.editItem(item);
        //     $scope.calcAmt(item);
        //     $scope.flex.collectionView.commitEdit();
        //   }
        //   $scope.$broadcast('loadingPopupInactive');
        // }, 100);
      });
    };


    // 저장
    $scope.save = function (confirmFg) {
      var params = [];

      // 확정이면서 그리드의 수정된 내역은 없는 경우 저장로직 태우기 위해 값 하나를 강제로 수정으로 변경한다.
      if (confirmFg === "Y" && $scope.flex.collectionView.itemsEdited.length <= 0) {
        var item = $scope.flex.collectionView.items[0];
        if (item === null) return false;

        $scope.flex.collectionView.editItem(item);
        item.status = "U";
        $scope.flex.collectionView.commitEdit();
      }

      for (var i = 0; i < $scope.flex.collectionView.itemsEdited.length; i++) {
        var item = $scope.flex.collectionView.itemsEdited[i];

        if (item.outEtcQty !== null && (parseInt(item.outEtcQty) >= parseInt(item.poUnitQty))) {
          $scope._popMsg(messages["storeMove.dtl.not.etcQty"]); // 낱개수량은 입수량보다 작아야 합니다.
          return false;
        }
        if (item.outTot !== null && (parseInt(item.outTot) > 9999999999)) {
          $scope._popMsg(messages["storeMove.dtl.not.overOutTot"]); // 이출금액이 너무 큽니다.
          return false;
        }

        item.status    = "U";
        item.slipNo    = $scope.slipNo;
        item.dlvrFg    = $scope.dlvrFg;
        item.remark    = $scope.dtlHdRemark;
        item.procFg    = $scope.procFg;
        item.storageCd = "001";
        item.hqBrandCd = "00"; // TODO 브랜드코드 가져오는건 우선 하드코딩으로 처리. 2018-09-13 안동관
        item.confirmFg = confirmFg;

        params.push(item);
      }

      $scope._save("/iostock/move/storeMove/storeMoveDtl/save.sb", params, function () {
        $scope.saveStoreMoveDtlCallback()
      });
    };


    $scope.confirm = function () {
      var msg = messages["storeMove.dtl.confirmMsg"]; // 현전표를 확정하시겠습니까?
      s_alert.popConf(msg, function () {
        $scope.save('Y');
      });
    };


    $scope.saveStoreMoveDtlCallback = function () {
      $scope.wjStoreMoveDtlLayer.hide(true);

      var storeMoveScope = agrid.getScope('storeMoveCtrl');
      storeMoveScope.searchStoreMoveList();
    };


    $scope.addProd = function () {
      var params        = {};
      params.slipNo     = $scope.slipNo;
      params.outStoreCd = $scope.outStoreCd;
      params.inStoreCd  = $scope.inStoreCd;

      $scope._broadcast('storeMoveAddProdCtrl', params);
    };


    $scope.delete = function () {
      var msg = messages["storeMove.dtl.delMsg"]; // 현전표를 삭제하시겠습니까?
      s_alert.popConf(msg, function () {
        var params    = {};
        params.slipNo = $scope.slipNo;

        <%-- 로딩바 show --%>
        $scope.$broadcast('loadingPopupActive', messages["cmm.saving"]);

        // ajax 통신 설정
        $http({
          method : 'POST', //방식
          url    : '/iostock/move/storeMove/storeMoveDtl/delete.sb', /* 통신할 URL */
          params : params, /* 파라메터로 보낼 데이터 */
          headers: {'Content-Type': 'application/json; charset=utf-8'} //헤더
        }).then(function successCallback(response) {
          if ($scope.httpStatusCheck(response)) {
            if (response.data.status === "OK") {
              $scope._popMsg(messages["cmm.saveSucc"]);
              $scope.saveStoreMoveDtlCallback();
            }
          }
        }, function errorCallback(response) {
          // called asynchronously if an error occurs
          // or server returns response with an error status.
          $scope._popMsg(messages["cmm.saveFail"]);
          <%-- 로딩바 hide --%>
          $scope.$broadcast('loadingPopupInactive');
          return false;
        }).then(function () {
          // "complete" code here
          <%-- 로딩바 hide --%>
          $scope.$broadcast('loadingPopupInactive');
        });
      });
    };


    // 버튼 display
    $scope.fnBtnLayerDisplay = function (displayFg) {
      if (displayFg) {
        $("#btnDtlAddProd").show();
        $("#btnDtlSave").show();
        $("#btnDtlConfirm").show();
        $("#btnDtlDel").show();
      }
      else {
        $("#btnDtlAddProd").hide();
        $("#btnDtlSave").hide();
        $("#btnDtlConfirm").hide();
        $("#btnDtlDel").hide();
      }
    };


    // 매장선택 모듈 팝업 사용시 정의
    // 함수명 : 모듈에 넘기는 파라미터의 targetId + 'Show'
    // _broadcast : 모듈에 넘기는 파라미터의 targetId + 'Ctrl'
    $scope.storeMoveDtlOutSelectStoreShow = function () {
      $scope._broadcast('storeMoveDtlOutSelectStoreCtrl');
    };

    // 매장선택 모듈 팝업 사용시 정의
    // 함수명 : 모듈에 넘기는 파라미터의 targetId + 'Show'
    // _broadcast : 모듈에 넘기는 파라미터의 targetId + 'Ctrl'
    $scope.storeMoveDtlInSelectStoreShow = function () {
      $scope._broadcast('storeMoveDtlInSelectStoreCtrl');
    };


    // http 조회 후 status 체크
    $scope.httpStatusCheck = function (res) {
      if (res.data.status === "OK") {
        return true;
      }
      else if (res.data.status === "FAIL") {
        $scope._popMsg("Ajax Fail By HTTP Request");
        return false;
      }
      else if (res.data.status === "SESSION_EXFIRE") {
        $scope._popMsg(res.data.message, function () {
          location.href = res.data.url;
        });
        return false;
      }
      else if (res.data.status === "SERVER_ERROR") {
        $scope._popMsg(res.data.message);
        return false;
      }
      else {
        var msg = res.data.status + " : " + res.data.message;
        $scope._popMsg(msg);
        return false;
      }
    };


  }]);
</script>
