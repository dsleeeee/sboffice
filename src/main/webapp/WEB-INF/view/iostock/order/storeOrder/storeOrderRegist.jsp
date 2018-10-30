<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="menuCd" value="${sessionScope.sessionInfo.currentMenu.resrceCd}"/>
<c:set var="menuNm" value="${sessionScope.sessionInfo.currentMenu.resrceNm}"/>
<c:set var="baseUrl" value="/iostock/order/storeOrder/storeOrderRegist/"/>

<wj-popup id="wjStoreOrderRegistLayer" control="wjStoreOrderRegistLayer" show-trigger="Click" hide-trigger="Click" style="display:none;width:900px;">
  <div id="storeOrderRegistLayer" class="wj-dialog wj-dialog-columns" ng-controller="storeOrderRegistCtrl">
    <div class="wj-dialog-header wj-dialog-header-font">
      <s:message code="storeOrder.dtl.registTitle"/>
      <a href="#" class="wj-hide btn_close"></a>
    </div>
    <div class="wj-dialog-body sc2" style="height: 600px;">
      <p class="s14 bk mb5 fl">[<s:message code="storeOrder.dtl.order"/>]
        <s:message code="storeOrder.dtl.addProd"/></p>
      <p id="registSubTitle" class="s14 bk mb5 fl"></p>

      <table class="tblType01">
        <colgroup>
          <col class="w15"/>
          <col class="w35"/>
          <col class="w15"/>
          <col class="w35"/>
        </colgroup>
        <tbody>
        <tr>
          <%-- 상품코드 --%>
          <th><s:message code="storeOrder.dtl.prodCd"/></th>
          <td>
            <input type="text" id="srchProdCd" name="srchProdCd" ng-model="prodCd" class="sb-input w100" maxlength="13"/>
          </td>
          <%-- 상품코드 --%>
          <th><s:message code="storeOrder.dtl.prodNm"/></th>
          <td>
            <input type="text" id="srchProdNm" name="srchProdNm" ng-model="prodNm" class="sb-input w100" maxlength="50"/>
          </td>
        </tr>
        <tr>
          <th><s:message code="storeOrder.dtl.barcd"/></th>
          <td>
            <input type="text" id="srchBarcdCd" name="srchBarcdCd" ng-model="barcdCd" class="sb-input w100" maxlength="40"/>
          </td>
          <th><s:message code="storeOrder.dtl.prodClass"/></th>
          <td>
            <input type="text" id="srchProdClass" name="prodClass" ng-model="prodClass" class="sb-input w100" maxlength="40"/>
          </td>
        </tr>
        <tr>
          <th><s:message code="storeOrder.dtl.option1"/></th>
          <td colspan="3">
            <span class="txtIn w150 sb-select fl mr5">
              <wj-combo-box
                id="option1"
                ng-model="option1"
                items-source="_getComboData('option1')"
                display-member-path="name"
                selected-value-path="value"
                is-editable="false"
                initialized="_initComboBox(s)">
              </wj-combo-box>
            </span>
            <a href="#" class="btn_grayS" ng-click="setSafeToOrder()"><s:message code="storeOrder.dtl.safeStockApply"/></a>
          </td>
        </tr>
        <tr>
          <th><s:message code="storeOrder.dtl.option2"/></th>
          <td colspan="3">
            <span class="txtIn w150 sb-select fl mr5">
              <wj-combo-box
                id="option2"
                ng-model="option2"
                items-source="_getComboData('option2')"
                display-member-path="name"
                selected-value-path="value"
                is-editable="false"
                initialized="_initComboBox(s)"
                selected-index-changed="selectedIndexChanged(s, e)"
              >
              </wj-combo-box>
            </span>
            <p id="option2OrdLayer" class="s14 bk lh30 fl ml10" style="display: none;"><s:message code="storeOrder.dtl.reqDate"/></p>
            <p id="option2OutLayer" class="s14 bk lh30 fl ml10" style="display: none;"><s:message code="storeOrder.dtl.outDate"/></p>
            <p id="option2SaleLayer" class="s14 bk lh30 fl ml10" style="display: none;"><s:message code="storeOrder.dtl.saleDate"/></p>
            <div id="option2DateLayer" class="sb-select fl ml10" style="display: none;">
              <span class="txtIn"><input id="srchRegStartDate" class="w120px"></span>
              <span class="rg">~</span>
              <span class="txtIn"><input id="srchRegEndDate" class="w120px"></span>
            </div>
            <p id="option2OrdLayer2" class="s14 bk lh30 fl ml10" style="display: none;"><s:message code="storeOrder.dtl.txtOption2Ord"/></p>
            <p id="option2OutLayer2" class="s14 bk lh30 fl ml10" style="display: none;"><s:message code="storeOrder.dtl.txtOption2Out"/></p>
            <p id="option2SaleLayer2" class="s14 bk lh30 fl ml10" style="display: none;"><s:message code="storeOrder.dtl.txtOption2Sale"/></p>
          </td>
        </tr>
        <tr>
          <th><s:message code="storeOrder.dtl.remark"/></th>
          <td colspan="3">
            <input type="text" id="regHdRemark" name="regHdRemark" ng-model="regHdRemark" class="sb-input w100" maxlength="300"/>
          </td>
        </tr>
        <tr>
          <td colspan="4">
            <a href="#" class="btn_grayS" ng-click=""><s:message code="storeOrder.dtl.excelFormDownload"/></a>
            <a href="#" class="btn_grayS" ng-click=""><s:message code="storeOrder.dtl.excelFormUpload"/></a>
            <a href="#" class="btn_grayS" ng-click=""><s:message code="storeOrder.dtl.textFormUpload"/></a>
            <a href="#" class="btn_grayS" ng-click=""><s:message code="cmm.excel.down"/></a>
            <a href="#" class="btn_grayS" ng-click=""><s:message code="storeOrder.dtl.excelFormUploadErrorInfo"/></a>
          </td>
        </tr>
        </tbody>
      </table>

      <div class="mt10 oh">
        <%-- 조회 --%>
        <button type="button" class="btn_blue fr" id="btnSearch" ng-click="searchStoreOrderRegistList();"><s:message code="cmm.search"/></button>
      </div>

      <ul class="txtSty3 mt10">
        <li class="red"><s:message code="storeOrder.dtl.txt1"/></li>
        <li class="red"><s:message code="storeOrder.dtl.txt2"/></li>
        <li class="red"><s:message code="storeOrder.dtl.txt3"/></li>
        <li class="red"><s:message code="storeOrder.dtl.txt4"/></li>
        <li class="red"><s:message code="storeOrder.dtl.txt5"/></li>
      </ul>

      <div class="mt40 tr">
        <p id="registStoreLoanInfo" class="fl s14 bk lh30"></p>
        <div class="tr">
          <%-- 저장 --%>
          <button type="button" class="btn_skyblue ml5" id="btnSave" ng-click="saveStoreOrderRegist()"><s:message code="cmm.save"/></button>
        </div>
      </div>

      <%--<div class="wj-TblWrap ml20 mr20 pdb20">--%>
      <div class="w100 mt10 mb20">
        <%--위즈모 테이블--%>
        <div class="wj-gridWrap" style="height: 500px;">
          <wj-flex-grid
            autoGenerateColumns="false"
            selection-mode="Row"
            items-source="data"
            control="flex"
            initialized="initGrid(s,e)"
            is-read-only="false"
            item-formatter="_itemFormatter">

            <!-- define columns -->
            <%--<wj-flex-grid-column header="<s:message code="cmm.chk"/>"                         binding="gChk"             width="40"  align="center" ></wj-flex-grid-column>--%>
            <wj-flex-grid-column header="<s:message code="storeOrder.dtl.prodCd"/>" binding="prodCd" width="100" align="center" is-read-only="true"></wj-flex-grid-column>
            <wj-flex-grid-column header="<s:message code="storeOrder.dtl.prodNm"/>" binding="prodNm" width="150" align="left" is-read-only="true"></wj-flex-grid-column>
            <wj-flex-grid-column header="<s:message code="storeOrder.dtl.orderSplyUprc"/>" binding="orderSplyUprc" width="70" align="right" is-read-only="true" data-type="Number" format="n0"></wj-flex-grid-column>
            <wj-flex-grid-column header="<s:message code="storeOrder.dtl.prevOrderUnitQty"/>" binding="prevOrderUnitQty" width="70" align="right" is-read-only="true" data-type="Number" format="n0" aggregate="Sum"></wj-flex-grid-column>
            <wj-flex-grid-column header="<s:message code="storeOrder.dtl.prevOrderEtcQty"/>" binding="prevOrderEtcQty" width="70" align="right" is-read-only="true" data-type="Number" format="n0" aggregate="Sum"></wj-flex-grid-column>
            <wj-flex-grid-column header="<s:message code="storeOrder.dtl.prevOrderTotQty"/>" binding="prevOrderTotQty" width="70" align="right" is-read-only="true" visible="false"></wj-flex-grid-column>
            <wj-flex-grid-column header="<s:message code="storeOrder.dtl.orderUnitQty"/>" binding="orderUnitQty" width="70" align="right" max-length=8 data-type="Number" format="n0" aggregate="Sum"></wj-flex-grid-column>
            <wj-flex-grid-column header="<s:message code="storeOrder.dtl.orderEtcQty"/>" binding="orderEtcQty" width="70" align="right" max-length=8 data-type="Number" format="n0" aggregate="Sum"></wj-flex-grid-column>
            <wj-flex-grid-column header="<s:message code="storeOrder.dtl.orderTotQty"/>" binding="orderTotQty" width="70" align="right" is-read-only="true" visible="false"></wj-flex-grid-column>
            <wj-flex-grid-column header="<s:message code="storeOrder.dtl.orderAmt"/>" binding="orderAmt" width="70" align="right" is-read-only="true" data-type="Number" format="n0" aggregate="Sum"></wj-flex-grid-column>
            <wj-flex-grid-column header="<s:message code="storeOrder.dtl.orderVat"/>" binding="orderVat" width="70" align="right" is-read-only="true" data-type="Number" format="n0" aggregate="Sum"></wj-flex-grid-column>
            <wj-flex-grid-column header="<s:message code="storeOrder.dtl.orderTot"/>" binding="orderTot" width="70" align="right" is-read-only="true" data-type="Number" format="n0" aggregate="Sum"></wj-flex-grid-column>
            <wj-flex-grid-column header="<s:message code="storeOrder.dtl.saleUprc"/>" binding="saleUprc" width="70" align="right" is-read-only="true"></wj-flex-grid-column>
            <wj-flex-grid-column header="<s:message code="storeOrder.dtl.poUnitFg"/>" binding="poUnitFg" width="70" align="center" is-read-only="true"></wj-flex-grid-column>
            <wj-flex-grid-column header="<s:message code="storeOrder.dtl.poUnitQty"/>" binding="poUnitQty" width="70" align="right" is-read-only="true"></wj-flex-grid-column>
            <wj-flex-grid-column header="<s:message code="storeOrder.dtl.safeStock"/>" binding="safeStockUnitQty" width="70" align="right" is-read-only="true"></wj-flex-grid-column>
            <wj-flex-grid-column header="<s:message code="storeOrder.dtl.safeStock"/>" binding="safeStockEtcQty" width="70" align="right" is-read-only="true"></wj-flex-grid-column>
            <wj-flex-grid-column header="<s:message code="storeOrder.dtl.storeCurrQty"/>" binding="storeCurrUnitQty" width="70" align="right" is-read-only="true"></wj-flex-grid-column>
            <wj-flex-grid-column header="<s:message code="storeOrder.dtl.storeCurrQty"/>" binding="storeCurrEtcQty" width="70" align="right" is-read-only="true"></wj-flex-grid-column>
            <wj-flex-grid-column header="<s:message code="storeOrder.dtl.remark"/>" binding="remark" width="200" align="left" max-length=300></wj-flex-grid-column>
            <wj-flex-grid-column header="<s:message code="storeOrder.dtl.poMinQty"/>" binding="poMinQty" width="70" align="right" is-read-only="true" visible="false"></wj-flex-grid-column>
            <wj-flex-grid-column header="<s:message code="storeOrder.dtl.vatFg"/>" binding="vatFg01" width="70" align="right" is-read-only="true" visible="false"></wj-flex-grid-column>
            <wj-flex-grid-column header="<s:message code="storeOrder.dtl.envst0011"/>" binding="envst0011" width="70" align="right" is-read-only="true" visible="false"></wj-flex-grid-column>

          </wj-flex-grid>
        </div>
        <%--//위즈모 테이블--%>
      </div>
      <%-- 페이지 리스트 --%>
      <div class="pageNum mt20">
        <%-- id --%>
        <ul id="storeOrderRegistCtrlPager" data-size="10">
        </ul>
      </div>
      <%--//페이지 리스트--%>
    </div>
  </div>
</wj-popup>


<script type="text/javascript">

  /** 주문등록 상세 그리드 controller */
  app.controller('storeOrderRegistCtrl', ['$scope', '$http', '$rootScope', function ($scope, $http, $rootScope) {
    // 상위 객체 상속 : T/F 는 picker
    angular.extend(this, new RootController('storeOrderRegistCtrl', $scope, $http, true));

    $scope._setComboData("option1", [
      {"name": messages["storeOrder.dtl.option1All"], "value": ""},
      {"name": messages["storeOrder.dtl.option1SafeStock"], "value": "S"}
    ]);

    $scope._setComboData("option2", [
      {"name": messages["storeOrder.dtl.option2All"], "value": ""},
      {"name": messages["storeOrder.dtl.option2Order"], "value": "ORD"},
      {"name": messages["storeOrder.dtl.option2Outstock"], "value": "OUT"},
      {"name": messages["storeOrder.dtl.option2Sale"], "value": "SALE"}
    ]);

    $scope.srchRegStartDate = wcombo.genDate("#srchRegStartDate");
    $scope.srchRegEndDate   = wcombo.genDate("#srchRegEndDate");

    // grid 초기화 : 생성되기전 초기화되면서 생성된다
    $scope.initGrid = function (s, e) {
      // s.allowMerging = wijmo.grid.AllowMerging.AllHeaders;
      // 그리드 포맷 핸들러
      s.formatItem.addHandler(function (s, e) {
        if (e.panel === s.cells) {
          var col  = s.columns[e.col];
          var item = s.rows[e.row].dataItem;
          if (col.binding === "orderEtcQty") { // 입수에 따라 주문수량 컬럼 readonly 컨트롤
            // console.log(item);
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
          if (col.binding === "orderUnitQty" || col.binding === "orderEtcQty") {
            var item = s.rows[e.row].dataItem;
            $scope.calcAmt(item);
          }
        }

        s.collectionView.commitEdit();
      });

      // add the new GroupRow to the grid's 'columnFooters' panel
      // s.columnFooters.rows.push(new wijmo.grid.GroupRow());
      // add a sigma to the header to show that this is a summary row
      // s.bottomLeftCells.setCellData(0, 0, '합계');
    };

    $scope.calcAmt = function (item) {
      var orderSplyUprc = parseInt(item.orderSplyUprc);
      var poUnitQty     = parseInt(item.poUnitQty);
      var vat01         = parseInt(item.vatFg01);
      var envst0011     = parseInt(item.envst0011);

      var unitQty  = (parseInt(nvl(item.prevOrderUnitQty, 0)) + parseInt(nvl(item.orderUnitQty, 0))) * parseInt(item.poUnitQty);
      var etcQty   = parseInt(nvl(item.prevOrderEtcQty, 0)) + parseInt(nvl(item.orderEtcQty, 0));
      var totQty   = parseInt(unitQty + etcQty);
      var tempAmt  = Math.round(totQty * orderSplyUprc / poUnitQty);
      var orderAmt = tempAmt - Math.round(tempAmt * vat01 * envst0011 / 11);
      var orderVat = Math.round(tempAmt * vat01 / (10 + envst0011));
      var orderTot = parseInt(orderAmt + orderVat);

      item.orderTotQty = totQty;   // 총수량
      item.orderAmt    = orderAmt; // 금액
      item.orderVat    = orderVat; // VAT
      item.orderTot    = orderTot; // 합계
    };


    // 다른 컨트롤러의 broadcast 받기
    $scope.$on("storeOrderRegistCtrl", function (event, data) {

      // 그리드 초기화
      var cv          = new wijmo.collections.CollectionView([]);
      cv.trackChanges = true;
      $scope.data     = cv;

      if (!$.isEmptyObject(data)) {
        $scope.reqDate     = data.reqDate;
        $scope.slipFg      = data.slipFg;
        $scope.callParent  = data.callParent;
        $scope.regHdRemark = data.hdRemark;

        // 신규 요청등록인 경우
        if ($scope.callParent === "storeOrder") {
          // 당일보다 이전일자 요청등록 불가
          var today = getCurDate();
          if (parseInt(today) > parseInt($scope.reqDate)) {
            $scope._popMsg(messages["storeOrder.dtl.not.prevDateOrder"]);
            return false;
          }
          $scope.storeOrderDateCheck(); // 출고요청가능일인지 여부 체크
        }
        // 주문 상품상세내역 페이지에서 호출한 경우
        else if ($scope.callParent === "storeOrderDtl") {
          $scope.storeCloseCheck(); // 주문진행구분 체크
        }
      }
      else { // 페이징처리에서 broadcast 호출시
        $scope.searchStoreOrderRegistList();
      }

      // 기능수행 종료 : 반드시 추가
      event.preventDefault();
    });

    // 출고요청가능일인지 여부 체크
    $scope.storeOrderDateCheck = function () {
      var params     = {};
      params.reqDate = $scope.reqDate;
      params.slipFg  = $scope.slipFg;

      // ajax 통신 설정
      $http({
        method : 'POST', //방식
        url    : '/iostock/order/storeOrder/storeOrderRegist/orderDateCheck.sb', /* 통신할 URL */
        params : params, /* 파라메터로 보낼 데이터 */
        headers: {'Content-Type': 'application/json; charset=utf-8'} //헤더
      }).then(function successCallback(response) {
        if ($scope.httpStatusCheck(response)) {
          if (!$.isEmptyObject(response.data.data)) {
            if (response.data.data.orderFg > 0) {
              $scope._popMsg(messages["storeOrder.dtl.not.orderDate"]);
              return false;
            }
          }
          $scope.storeCloseCheck();
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

    // 매장마감여부 체크
    $scope.storeCloseCheck = function () {
      var params     = {};
      params.reqDate = $scope.reqDate;
      params.slipFg  = $scope.slipFg;

      // ajax 통신 설정
      $http({
        method : 'POST', //방식
        url    : '/iostock/order/storeOrder/storeOrderRegist/storeCloseCheck.sb', /* 통신할 URL */
        params : params, /* 파라메터로 보낼 데이터 */
        headers: {'Content-Type': 'application/json; charset=utf-8'} //헤더
      }).then(function successCallback(response) {
        if ($scope.httpStatusCheck(response)) {
          if (!$.isEmptyObject(response.data.data)) {
            if (response.data.data.orderCloseFg === "Y") {
              $scope._popMsg(messages["storeOrder.dtl.orderClose"]);
              return false;
            }
          }
          $scope.orderProcFgCheck(); // 주문진행구분 체크
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

    // 주문진행구분 체크 및 HD 비고 조회
    $scope.orderProcFgCheck = function () {
      var params     = {};
      params.reqDate = $scope.reqDate;
      params.slipFg  = $scope.slipFg;

      // ajax 통신 설정
      $http({
        method : 'POST', //방식
        url    : '/iostock/order/storeOrder/storeOrderRegist/orderProcFgCheck.sb', /* 통신할 URL */
        params : params, /* 파라메터로 보낼 데이터 */
        headers: {'Content-Type': 'application/json; charset=utf-8'} //헤더
      }).then(function successCallback(response) {
        if ($scope.httpStatusCheck(response)) {
          // 진행구분이 주문등록이 아니면 상품추가/변경 불가
          if (!$.isEmptyObject(response.data.data)) {
            if (response.data.data.procFg != "00") {
              $scope._popMsg(messages["storeOrder.dtl.not.orderProcEnd"]);
              return false;
            }
            $scope.regHdRemark = response.data.data.remark;
          }

          $scope.searchStoreLoan("Y");
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

    // 매장여신 조회
    $scope.searchStoreLoan = function (popShowFg) {
      var params     = {};
      params.reqDate = $scope.reqDate;
      params.slipFg  = $scope.slipFg;

      // ajax 통신 설정
      $http({
        method : 'POST', //방식
        url    : '/iostock/order/storeOrder/storeOrderRegist/storeLoan.sb', /* 통신할 URL */
        params : params, /* 파라메터로 보낼 데이터 */
        headers: {'Content-Type': 'application/json; charset=utf-8'} //헤더
      }).then(function successCallback(response) {
        if ($scope.httpStatusCheck(response)) {
          if (!$.isEmptyObject(response.data.data)) {
            // 발주중지 상태이면 상품추가/변경 불가
            if (response.data.data.orderCloseYn === "Y") {
              $scope._popMsg(messages["storeOrder.dtl.orderClose"]);
              return false;
            }
            else {
              $scope.prevOrderTot      = response.data.data.prevOrderTot;      //이전 주문금액
              $scope.limitLoanAmt      = response.data.data.limitLoanAmt;      //여신 한도액
              $scope.currLoanAmt       = response.data.data.currLoanAmt;       //여신잔액
              $scope.maxOrderAmt       = response.data.data.maxOrderAmt;       //1회주문한도
              $scope.noOutstockAmtFg   = response.data.data.noOutstockAmtFg;   //미출고금액고려여부
              $scope.availableOrderAmt = response.data.data.availableOrderAmt; //주문가능액

              //미출고금액 고려여부 사용인 경우
              if ($scope.noOutstockAmtFg === "Y") {
                if ($scope.availableOrderAmt <= ($scope.currLoanAmt - $scope.prevOrderTot)) {
                  // 해당 조건에는 조회해 온 주문가능액 그대로 사용
                }
                else if ($scope.availableOrderAmt >= ($scope.currLoanAmt - $scope.prevOrderTot) && $scope.maxOrderAmt != 0) {
                  $scope.availableOrderAmt = $scope.currLoanAmt - $scope.prevOrderTot;
                }
                else {
                  $scope.availableOrderAmt = $scope.availableOrderAmt - $scope.prevOrderTot;
                }
              }

              $("#registStoreLoanInfo").html("1회주문한도액 : " + addComma($scope.maxOrderAmt) + " 여신잔액 : " + addComma($scope.currLoanAmt) + " 미출고액 : " + addComma($scope.prevOrderTot) + " 주문가능액 : " + addComma($scope.availableOrderAmt));
            }
          }
        }
      }, function errorCallback(response) {
        // called asynchronously if an error occurs
        // or server returns response with an error status.
        $scope._popMsg(messages["cmm.saveFail"]);
        return false;
      }).then(function () {
        // "complete" code here
        if (popShowFg === "Y") {
          $scope.wjStoreOrderRegistLayer.show(true);
          $("#registSubTitle").html(' ('+messages["storeOrder.reqDate"]+' : ' + getFormatDate($scope.reqDate, '-') + ')');
        }
      });
    };

    // 주문가능상품 리스트 조회
    $scope.searchStoreOrderRegistList = function () {
      // 파라미터
      var params       = {};
      params.reqDate   = $scope.reqDate;
      params.slipFg    = $scope.slipFg;
      params.startDate = wijmo.Globalize.format($scope.srchRegStartDate.value, 'yyyyMMdd');
      params.endDate   = wijmo.Globalize.format($scope.srchRegEndDate.value, 'yyyyMMdd');
      params.listScale = 500;

      // 조회 수행 : 조회URL, 파라미터, 콜백함수
      $scope._inquiryMain("/iostock/order/storeOrder/storeOrderRegist/list.sb", params);
    };


    // 주문 상품 저장
    $scope.saveStoreOrderRegist = function () {
      var params   = [];
      var orderTot = 0;
      for (var i = 0; i < $scope.flex.collectionView.itemsEdited.length; i++) {
        var item = $scope.flex.collectionView.itemsEdited[i];

        if (item.orderTotQty !== null && item.orderTotQty !== "0" && (parseInt(item.orderTotQty) < parseInt(item.poMinQty))) {
          $scope._popMsg(messages["storeOrder.dtl.not.minOrderQty"]); // 주문수량은 최소주문수량 이상 입력하셔야 합니다.
          return false;
        }
        if (item.orderEtcQty !== null && (parseInt(item.orderEtcQty) >= parseInt(item.poUnitQty))) {
          $scope._popMsg(messages["storeOrder.dtl.not.orderEtcQty"]); // 낱개수량은 입수량보다 작아야 합니다.
          return false;
        }
        if (item.orderTot !== null && (parseInt(item.orderTot) > 9999999999)) {
          $scope._popMsg(messages["storeOrder.dtl.not.overOrderTot"]); // 주문금액이 너무 큽니다.
          return false;
        }

        item.status    = "U";
        item.reqDate   = $scope.reqDate;
        item.slipFg    = $scope.slipFg;
        item.hqBrandCd = "00"; // TODO 브랜드코드 가져오는건 우선 하드코딩으로 처리. 2018-09-13 안동관
        item.hdRemark  = $scope.regHdRemark;
        orderTot += parseInt(item.orderTot);
        params.push(item);
      }

      // 주문가능액 체크
      if ($scope.availableOrderAmt != null) {
        // console.log("orderTot = "+orderTot);
        if (parseInt($scope.availableOrderAmt) < parseInt(orderTot)) {
          $scope._popMsg(messages["storeOrder.dtl.orderTotOver"]);
          return false;
        }
      }

      $scope._save("/iostock/order/storeOrder/storeOrderRegist/save.sb", params, function () {
        $scope.saveRegistCallback()
      });
    };


    // 저장 후 콜백 서치 함수
    $scope.saveRegistCallback = function () {
      $scope.searchStoreOrderRegistList();
      $scope.searchStoreLoan("N");

      // 신규 요청등록인 경우
      if ($scope.callParent === "storeOrder") {
        var storeOrderScope = agrid.getScope('storeOrderCtrl');
        storeOrderScope.searchStoreOrderList();
      }
      // 주문 상품상세내역 페이지에서 호출한 경우
      else if ($scope.callParent === "storeOrderDtl") {
        var storeOrderScope = agrid.getScope('storeOrderCtrl');
        storeOrderScope.searchStoreOrderList();

        var storeOrderDtlScope = agrid.getScope('storeOrderDtlCtrl');
        storeOrderDtlScope.searchStoreOrderDtlList();
      }
    };


    // 안전재고 수량적용.
    $scope.setSafeToOrder = function () {
      $rootScope.$broadcast('loadingPopupActive', messages["cmm.progress"]);
      // 데이터 처리중 팝업 띄우기위해 setTimeout 사용.
      setTimeout(function() {
        for (var i = 0; i < $scope.flex.collectionView.items.length; i++) {
          var item = $scope.flex.collectionView.items[i];
          if(item.safeStockUnitQty !== null || item.safeStockEtcQty !== null) {
            $scope.flex.collectionView.editItem(item);

            if(nvl(item.safeStockUnitQty, 0) > 0) {
              item.orderUnitQty = parseInt(item.safeStockUnitQty) - parseInt(nvl(item.storeCurrUnitQty, 0));
            }
            if(nvl(item.safeStockEtcQty, 0) > 0) {
              item.orderEtcQty = parseInt(item.safeStockEtcQty) - parseInt(nvl(item.storeCurrEtcQty, 0));
            }
            $scope.calcAmt(item);
            $scope.flex.collectionView.commitEdit();
          }
        }
        $rootScope.$broadcast('loadingPopupInactive');
      }, 100);
    };

    // 옵션2 값 변경 이벤트 함수
    $scope.selectedIndexChanged = function (s, e) {
      if (s.selectedValue === "") {
        $scope.option2LayerHide();
      }
      else {
        $scope.option2LayerHide();
        $("#option2DateLayer").show();

        if (s.selectedValue === "ORD") {
          $("#option2OrdLayer").show();
          $("#option2OrdLayer2").show();
        }
        else if (s.selectedValue === "OUT") {
          $("#option2OutLayer").show();
          $("#option2OutLayer2").show();
        }
        else if (s.selectedValue === "SALE") {
          $("#option2SaleLayer").show();
          $("#option2SaleLayer2").show();
        }
      }
    };


    $scope.option2LayerHide = function () {
      $("#option2DateLayer").hide();
      $("#option2OrdLayer").hide();
      $("#option2OrdLayer2").hide();
      $("#option2OutLayer").hide();
      $("#option2OutLayer2").hide();
      $("#option2SaleLayer").hide();
      $("#option2SaleLayer2").hide();
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
