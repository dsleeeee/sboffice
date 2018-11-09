<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="menuCd" value="${sessionScope.sessionInfo.currentMenu.resrceCd}"/>
<c:set var="menuNm" value="${sessionScope.sessionInfo.currentMenu.resrceNm}"/>
<c:set var="baseUrl" value="/iostock/order/dstbCloseStore/dstbCloseStoreAdd/"/>

<wj-popup id="wjDstbCloseStoreAddLayer" control="wjDstbCloseStoreAddLayer" show-trigger="Click" hide-trigger="Click" style="display:none;width:900px;">
  <div id="dstbCloseStoreAddLayer" class="wj-dialog wj-dialog-columns" ng-controller="dstbCloseStoreAddCtrl">
    <div class="wj-dialog-header wj-dialog-header-font">
      <s:message code="dstbCloseStore.add.title"/>
      <a href="#" class="wj-hide btn_close"></a>
    </div>
    <div class="wj-dialog-body sc2" style="height: 600px;">
      <p class="s14 bk mb5 fl"><s:message code="dstbCloseStore.add.addProdSubTitle"/></p>
      <p id="addProdSubTitle" class="s14 bk ml5 mb5 fl"></p>
      <p id="orderFgSubTitle" class="s14 bk ml5 mb5 fl"></p>
      <table class="tblType01">
        <colgroup>
          <col class="w15"/>
          <col class="w35"/>
          <col class="w15"/>
          <col class="w35"/>
        </colgroup>
        <tbody>
        <tr>
          <%-- 매장코드 --%>
          <th><s:message code="dstbCloseStore.add.store"/></th>
          <td colspan="3">
            <%-- 매장선택 모듈 싱글 선택 사용시 include
                 param 정의 : targetId - angular 콘트롤러 및 input 생성시 사용할 타켓id
                              displayNm - 로딩시 input 창에 보여질 명칭(변수 없을 경우 기본값 선택으로 표시)
                              modiFg - 수정여부(변수 없을 경우 기본값으로 수정가능)
                              closeFunc - 팝업 닫기시 호출할 함수
            --%>
            <jsp:include page="/WEB-INF/view/iostock/order/outstockReqDate/selectShopS.jsp" flush="true">
              <jsp:param name="targetId" value="dstbCloseStoreAddSelectStore"/>
              <jsp:param name="closeFunc" value="fnGridClear"/>
            </jsp:include>
            <%--// 매장선택 모듈 싱글 선택 사용시 include --%>
          </td>
        </tr>
        <tr>
          <%-- 상품코드 --%>
          <th><s:message code="dstbCloseStore.add.prodCd"/></th>
          <td>
            <input type="text" id="srchProdCd" name="srchProdCd" ng-model="prodCd" class="sb-input w100" maxlength="13"/>
          </td>
          <%-- 상품코드 --%>
          <th><s:message code="dstbCloseStore.add.prodNm"/></th>
          <td>
            <input type="text" id="srchProdNm" name="srchProdNm" ng-model="prodNm" class="sb-input w100" maxlength="50"/>
          </td>
        </tr>
        <tr>
          <%-- 바코드 --%>
          <th><s:message code="dstbCloseStore.add.barcd"/></th>
          <td>
            <input type="text" id="srchBarcdCd" name="srchBarcdCd" ng-model="barcdCd" class="sb-input w100" maxlength="40"/>
          </td>
          <%-- 분류 --%>
          <th><s:message code="dstbCloseStore.add.prodClassNm"/></th>
          <td>
            <input type="text" id="srchProdClass" name="prodClass" ng-model="prodClass" class="sb-input w100" maxlength="40"/>
          </td>
        </tr>
        <tr>
          <%-- 옵션1 --%>
          <th><s:message code="dstbCloseStore.add.option1"/></th>
          <td></td>
          <%-- 옵션2 --%>
          <th><s:message code="dstbCloseStore.add.option2"/></th>
          <td></td>
        </tr>
        <tr>
          <td colspan="4">
            <a href="#" class="btn_grayS" ng-click=""><s:message code="dstbCloseStore.add.excelFormDownload"/></a>
            <a href="#" class="btn_grayS" ng-click=""><s:message code="dstbCloseStore.add.excelFormUpload"/></a>
            <a href="#" class="btn_grayS" ng-click=""><s:message code="dstbCloseStore.add.textFormUpload"/></a>
            <a href="#" class="btn_grayS" ng-click=""><s:message code="cmm.excel.down"/></a>
            <a href="#" class="btn_grayS" ng-click=""><s:message code="dstbCloseStore.add.excelFormUploadErrorInfo"/></a>
          </td>
        </tr>
        </tbody>
      </table>

      <div class="mt10 oh">
        <%-- 조회 --%>
        <button type="button" class="btn_blue fr" id="btnSearch" ng-click="search();">
          <s:message code="cmm.search"/></button>
      </div>

      <ul class="txtSty3 mt10">
        <li class="red"><s:message code="dstbCloseStore.add.txt1"/></li>
      </ul>

      <div class="mt40 tr">
        <div class="tr">
          <%-- 저장 --%>
          <button type="button" class="btn_skyblue ml5" id="btnSave" ng-click="saveDstbCloseStoreAdd()">
            <s:message code="cmm.save"/></button>
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
            <%--<wj-flex-grid-column header="<s:message code="cmm.chk"/>"                             binding="gChk"                width="40"  align="center" ></wj-flex-grid-column>--%>
            <wj-flex-grid-column header="<s:message code="dstbCloseStore.add.seq"/>" binding="seq" width="0" align="center" is-read-only="true" visible="false"></wj-flex-grid-column>
            <wj-flex-grid-column header="<s:message code="dstbCloseStore.add.prodClassNm"/>" binding="prodClassNm" width="100" align="left" is-read-only="true"></wj-flex-grid-column>
            <wj-flex-grid-column header="<s:message code="dstbCloseStore.add.prodCd"/>" binding="prodCd" width="100" align="center" is-read-only="true"></wj-flex-grid-column>
            <wj-flex-grid-column header="<s:message code="dstbCloseStore.add.prodNm"/>" binding="prodNm" width="150" align="left" is-read-only="true"></wj-flex-grid-column>
            <wj-flex-grid-column header="<s:message code="dstbCloseStore.add.mgrSplyUprc"/>" binding="mgrSplyUprc" width="70" align="right" max-length=10 is-read-only="false" data-type="Number" format="n0"></wj-flex-grid-column>
            <wj-flex-grid-column header="<s:message code="dstbCloseStore.add.prevMgrUnitQty"/>" binding="prevMgrUnitQty" width="70" align="right" is-read-only="true" data-type="Number" format="n0" aggregate="Sum"></wj-flex-grid-column>
            <wj-flex-grid-column header="<s:message code="dstbCloseStore.add.prevMgrEtcQty"/>" binding="prevMgrEtcQty" width="70" align="right" is-read-only="true" data-type="Number" format="n0" aggregate="Sum"></wj-flex-grid-column>
            <wj-flex-grid-column header="<s:message code="dstbCloseStore.add.prevMgrTotQty"/>" binding="prevMgrTotQty" width="70" align="right" is-read-only="true" visible="false"></wj-flex-grid-column>
            <wj-flex-grid-column header="<s:message code="dstbCloseStore.add.mgrUnitQty"/>" binding="mgrUnitQty" width="70" align="right" max-length=8 data-type="Number" format="n0" aggregate="Sum"></wj-flex-grid-column>
            <wj-flex-grid-column header="<s:message code="dstbCloseStore.add.mgrEtcQty"/>" binding="mgrEtcQty" width="70" align="right" max-length=8 data-type="Number" format="n0" aggregate="Sum"></wj-flex-grid-column>
            <wj-flex-grid-column header="<s:message code="dstbCloseStore.add.mgrTotQty"/>" binding="mgrTotQty" width="70" align="right" is-read-only="true" visible="false"></wj-flex-grid-column>
            <wj-flex-grid-column header="<s:message code="dstbCloseStore.add.mgrAmt"/>" binding="mgrAmt" width="70" align="right" is-read-only="true" visible="false" data-type="Number" format="n0"></wj-flex-grid-column>
            <wj-flex-grid-column header="<s:message code="dstbCloseStore.add.mgrVat"/>" binding="mgrVat" width="70" align="right" is-read-only="true" visible="false" data-type="Number" format="n0"></wj-flex-grid-column>
            <wj-flex-grid-column header="<s:message code="dstbCloseStore.add.mgrTot"/>" binding="mgrTot" width="70" align="right" is-read-only="true" data-type="Number" format="n0" aggregate="Sum"></wj-flex-grid-column>
            <wj-flex-grid-column header="<s:message code="dstbCloseStore.add.saleUprc"/>" binding="saleUprc" width="70" align="right" is-read-only="true"></wj-flex-grid-column>
            <wj-flex-grid-column header="<s:message code="dstbCloseStore.add.poUnitFg"/>" binding="poUnitFg" width="70" align="center" is-read-only="true"></wj-flex-grid-column>
            <wj-flex-grid-column header="<s:message code="dstbCloseStore.add.poUnitQty"/>" binding="poUnitQty" width="70" align="right" is-read-only="true"></wj-flex-grid-column>
            <wj-flex-grid-column header="<s:message code="dstbCloseStore.add.splyUprc"/>" binding="splyUprc" width="70" align="right" is-read-only="true" data-type="Number" format="n0"></wj-flex-grid-column>
            <wj-flex-grid-column header="<s:message code="dstbCloseStore.add.hqSafeStock"/>" binding="hqSafeStockUnitQty" width="70" align="right" is-read-only="true" data-type="Number" format="n0"></wj-flex-grid-column>
            <wj-flex-grid-column header="<s:message code="dstbCloseStore.add.hqSafeStock"/>" binding="hqSafeStockEtcQty" width="70" align="right" is-read-only="true" data-type="Number" format="n0"></wj-flex-grid-column>
            <wj-flex-grid-column header="<s:message code="dstbCloseStore.add.hqCurrQty"/>" binding="hqCurrUnitQty" width="70" align="right" is-read-only="true" data-type="Number" format="n0"></wj-flex-grid-column>
            <wj-flex-grid-column header="<s:message code="dstbCloseStore.add.hqCurrQty"/>" binding="hqCurrEtcQty" width="70" align="right" is-read-only="true" data-type="Number" format="n0"></wj-flex-grid-column>
            <wj-flex-grid-column header="<s:message code="dstbCloseStore.add.storeCurrQty"/>" binding="storeCurrUnitQty" width="70" align="right" is-read-only="true" data-type="Number" format="n0"></wj-flex-grid-column>
            <wj-flex-grid-column header="<s:message code="dstbCloseStore.add.storeCurrQty"/>" binding="storeCurrEtcQty" width="70" align="right" is-read-only="true" data-type="Number" format="n0"></wj-flex-grid-column>
            <wj-flex-grid-column header="<s:message code="dstbCloseStore.add.remark"/>" binding="remark" width="200" align="left" max-length=300></wj-flex-grid-column>
            <wj-flex-grid-column header="<s:message code="dstbCloseStore.add.poMinQty"/>" binding="poMinQty" width="70" align="right" is-read-only="true" visible="false"></wj-flex-grid-column>
            <wj-flex-grid-column header="<s:message code="dstbCloseStore.add.vatFg"/>" binding="vatFg01" width="70" align="right" is-read-only="true" visible="false"></wj-flex-grid-column>
            <wj-flex-grid-column header="<s:message code="dstbCloseStore.add.envst0011"/>" binding="envst0011" width="70" align="right" is-read-only="true" visible="false"></wj-flex-grid-column>

          </wj-flex-grid>
        </div>
        <%--//위즈모 테이블--%>
      </div>
      <%-- 페이지 리스트 --%>
      <div class="pageNum mt20">
        <%-- id --%>
        <ul id="dstbCloseStoreAddCtrlPager" data-size="10">
        </ul>
      </div>
      <%--//페이지 리스트--%>
    </div>
  </div>
</wj-popup>


<script type="text/javascript">

  /** 분배마감 추가등록 그리드 controller */
  app.controller('dstbCloseStoreAddCtrl', ['$scope', '$http', function ($scope, $http) {
    // 상위 객체 상속 : T/F 는 picker
    angular.extend(this, new RootController('dstbCloseStoreAddCtrl', $scope, $http, true));

    // grid 초기화 : 생성되기전 초기화되면서 생성된다
    $scope.initGrid = function (s, e) {
      // s.allowMerging = wijmo.grid.AllowMerging.AllHeaders;
      // 그리드 포맷 핸들러
      s.formatItem.addHandler(function (s, e) {
        if (e.panel === s.cells) {
          var col  = s.columns[e.col];
          var item = s.rows[e.row].dataItem;
          if (col.binding === "mgrEtcQty") { // 입수에 따라 주문수량 컬럼 readonly 컨트롤
            // console.log(item);
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
          // 주문수량 수정시 금액,VAT,합계 계산하여 보여준다.
          if (col.binding === "mgrUnitQty" || col.binding === "mgrEtcQty") {
            var item        = s.rows[e.row].dataItem;
            $scope.calcAmt(item);
          }
        }

        s.collectionView.commitEdit();
      });

      // add the new GroupRow to the grid's 'columnFooters' panel
      s.columnFooters.rows.push(new wijmo.grid.GroupRow());
      // add a sigma to the header to show that this is a summary row
      s.bottomLeftCells.setCellData(0, 0, '합계');

      // 헤더머지
      s.allowMerging  = 2;
      s.itemFormatter = function (panel, r, c, cell) {
        if (panel.cellType === wijmo.grid.CellType.ColumnHeader) {
          //align in center horizontally and vertically
          panel.rows[r].allowMerging    = true;
          panel.columns[c].allowMerging = true;
          wijmo.setCss(cell, {
            display    : 'table',
            tableLayout: 'fixed'
          });
          cell.innerHTML = '<div class=\"wj-header\">' + cell.innerHTML + '</div>';
          wijmo.setCss(cell.children[0], {
            display      : 'table-cell',
            verticalAlign: 'middle',
            textAlign    : 'center'
          });
        }
        // 로우헤더 의 RowNum 표시 ( 페이징/비페이징 구분 )
        else if (panel.cellType === wijmo.grid.CellType.RowHeader) {
          // GroupRow 인 경우에는 표시하지 않는다.
          if (panel.rows[r] instanceof wijmo.grid.GroupRow) {
            cell.textContent = '';
          } else {
            if (!isEmpty(panel._rows[r]._data.rnum)) {
              cell.textContent = (panel._rows[r]._data.rnum).toString();
            } else {
              cell.textContent = (r + 1).toString();
            }
          }
        }
        // readOnly 배경색 표시
        else if (panel.cellType === wijmo.grid.CellType.Cell) {
          var col = panel.columns[c];
          if (col.isReadOnly) {
            wijmo.addClass(cell, 'wj-custom-readonly');
          }
        }
      }
    };


    // 금액 계산
    $scope.calcAmt = function (item) {
      var mgrSplyUprc = parseInt(item.mgrSplyUprc);
      var poUnitQty   = parseInt(item.poUnitQty);
      var vat01       = parseInt(item.vatFg01);
      var envst0011   = parseInt(item.envst0011);

      var unitQty    = parseInt(nvl(item.mgrUnitQty, 0)) * parseInt(item.poUnitQty);
      var etcQty     = parseInt(nvl(item.mgrEtcQty, 0));
      var totQty     = parseInt(unitQty + etcQty);
      var tempMgrAmt = Math.round(totQty * mgrSplyUprc / poUnitQty);
      var mgrAmt     = tempMgrAmt - Math.round(tempMgrAmt * vat01 * envst0011 / 11);
      var mgrVat     = Math.round(tempMgrAmt * vat01 / (10 + envst0011));
      var mgrTot     = parseInt(mgrAmt + mgrVat);

      item.mgrTotQty = totQty; // 총수량
      item.mgrAmt    = mgrAmt; // 금액
      item.mgrVat    = mgrVat; // VAT
      item.mgrTot    = mgrTot; // 합계
    };


    // 다른 컨트롤러의 broadcast 받기
    $scope.$on("dstbCloseStoreAddCtrl", function (event, data) {

      // 그리드 초기화
      var cv          = new wijmo.collections.CollectionView([]);
      cv.trackChanges = true;
      $scope.data     = cv;

      if (!$.isEmptyObject(data)) {
        $scope.reqDate = data.reqDate;
        $scope.slipFg  = data.slipFg;
        $scope.wjDstbCloseStoreAddLayer.show(true);
        $("#addProdSubTitle").html(' (' + messages["dstbCloseStore.add.reqDate"] + ' : ' + getFormatDate($scope.reqDate, '-') + ')');
      }
      else { // 페이징처리에서 broadcast 호출시
        $scope.searchDstbCloseStoreAddList();
      }

      // 기능수행 종료 : 반드시 추가
      event.preventDefault();
    });

    // 조회
    $scope.search = function () {
      if ($("#dstbCloseStoreAddSelectStoreCd").val() === "") {
        $scope._popMsg(messages["dstbCloseStore.add.require.selectStore"]); // 매장을 선택해 주세요.
        return false;
      }
      $scope.dstbCloseStoreDateCheck();
    };

    // 주문가능 여부 체크
    $scope.dstbCloseStoreDateCheck = function () {
      $scope.storeCd = $("#dstbCloseStoreAddSelectStoreCd").val();
      var params     = {};
      params.reqDate = $scope.reqDate;
      params.storeCd = $scope.storeCd;

      // ajax 통신 설정
      $http({
        method : 'POST', //방식
        url    : '/iostock/order/dstbCloseStore/dstbCloseStoreAdd/getOrderFg.sb', /* 통신할 URL */
        params : params, /* 파라메터로 보낼 데이터 */
        headers: {'Content-Type': 'application/json; charset=utf-8'} //헤더
      }).then(function successCallback(response) {
        if ($scope.httpStatusCheck(response)) {
          if (!$.isEmptyObject(response.data.data)) {
            $scope.orderFg  = response.data.data.orderFg;
            var orderFgText = messages["dstbCloseStore.add.orderPossibleFg"] + ' : ';
            if ($scope.orderFg === 0) orderFgText += messages["dstbCloseStore.add.possible"];
            else orderFgText += messages["dstbCloseStore.add.impossible"];
            $("#orderFgSubTitle").html(orderFgText);
          }
          $scope.searchDstbCloseStoreAddList();
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

    // 분배가능상품 리스트 조회
    $scope.searchDstbCloseStoreAddList = function () {
      // 파라미터
      var params       = {};
      params.reqDate   = $scope.reqDate;
      params.slipFg    = $scope.slipFg;
      params.storeCd   = $scope.storeCd;
      params.listScale = 50;

      // 조회 수행 : 조회URL, 파라미터, 콜백함수
      $scope._inquiryMain("/iostock/order/dstbCloseStore/dstbCloseStoreAdd/list.sb", params);
    };

    // 분배 상품 저장
    $scope.saveDstbCloseStoreAdd = function () {
      var params = [];
      for (var i = 0; i < $scope.flex.collectionView.itemsEdited.length; i++) {
        var item = $scope.flex.collectionView.itemsEdited[i];

        if (item.mgrTotQty !== null && item.mgrTotQty !== "0" && (parseInt(item.mgrTotQty) < parseInt(item.poMinQty))) {
          $scope._popMsg(messages["dstbCloseStore.add.not.minMgrQty"]); // 분배수량은 최소주문수량 이상 입력하셔야 합니다.
          return false;
        }
        if (item.mgrEtcQty !== null && (parseInt(item.mgrEtcQty) >= parseInt(item.poUnitQty))) {
          $scope._popMsg(messages["dstbCloseStore.add.not.mgrEtcQty"]); // 낱개수량은 입수량보다 작아야 합니다.
          return false;
        }
        if (item.mgrTot !== null && (parseInt(item.mgrTot) > 9999999999)) {
          $scope._popMsg(messages["dstbCloseStore.add.not.overMgrTot"]); // 분배금액이 너무 큽니다.
          return false;
        }

        item.status    = "U";
        item.reqDate   = $scope.reqDate;
        item.slipFg    = $scope.slipFg;
        item.storeCd   = $scope.storeCd;
        item.empNo     = "0000";
        item.storageCd = "001";
        item.hqBrandCd = "00"; // TODO 브랜드코드 가져오는건 우선 하드코딩으로 처리. 2018-09-13 안동관
        params.push(item);
      }

      $scope._save("/iostock/order/dstbCloseStore/dstbCloseStoreAdd/save.sb", params, function () {
        $scope.saveAddProdCallback()
      });
    };

    // 저장 후 콜백 서치 함수
    $scope.saveAddProdCallback = function () {
      $scope.searchDstbCloseStoreAddList();

      var dstbCloseStoreScope = agrid.getScope('dstbCloseStoreCtrl');
      dstbCloseStoreScope.searchDstbCloseStoreList();
    };

    // 매장선택 모듈 팝업 사용시 정의
    // 함수명 : 모듈에 넘기는 파라미터의 targetId + 'Show'
    // _broadcast : 모듈에 넘기는 파라미터의 targetId + 'Ctrl'
    $scope.dstbCloseStoreAddSelectStoreShow = function () {
      $scope._broadcast('dstbCloseStoreAddSelectStoreCtrl');
    };

    // 매장 선택시 그리드 초기화
    $scope.fnGridClear = function () {
      var cv          = new wijmo.collections.CollectionView([]);
      cv.trackChanges = true;
      $scope.data     = cv;
      cv.refresh();
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
