<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="menuCd" value="${sessionScope.sessionInfo.currentMenu.resrceCd}"/>
<c:set var="menuNm" value="${sessionScope.sessionInfo.currentMenu.resrceNm}"/>
<c:set var="baseUrl" value="/iostock/vendr/orderStockInfo/orderStockInfo/"/>

<div class="subCon">
  <div ng-controller="orderStockInfoCtrl">
    <div class="searchBar flddUnfld">
      <a href="#" class="open">${menuNm}</a>
    </div>
    <table class="searchTbl">
      <colgroup>
        <col class="w15"/>
        <col class="w35"/>
        <col class="w15"/>
        <col class="w35"/>
      </colgroup>
      <tbody>
      <tr>
        <%-- 조회일자 --%>
        <th><s:message code="cmm.search.date"/></th>
        <td colspan="3">
          <div class="sb-select">
            <span class="txtIn"><input id="srchStartDate" class="w120px"></span>
            <span class="rg">~</span>
            <span class="txtIn"><input id="srchEndDate" class="w120px"></span>
          </div>
        </td>
      </tr>
      <tr>
        <%-- 발주번호 --%>
        <th><s:message code="orderStockInfo.slipNo"/></th>
        <td>
          <input type="text" id="srchSlipNo" name="srchSlipNo" ng-model="slipNo" class="sb-input w100" maxlength="8"/>
        </td>
        <%-- 거래처 --%>
        <th><s:message code="orderStockInfo.vendr"/></th>
        <td>
          <%-- 거래처선택 모듈 멀티 선택 사용시 include
               param 정의 : targetId - angular 콘트롤러 및 input 생성시 사용할 타켓id
          --%>
          <jsp:include page="/WEB-INF/view/iostock/vendr/vendrOrder/selectVendrM.jsp" flush="true">
            <jsp:param name="targetId" value="orderStockInfoSelectVendr"/>
          </jsp:include>
          <%--// 거래처선택 모듈 싱글 선택 사용시 include --%>
        </td>
      </tr>
      </tbody>
    </table>

    <div class="mt10 pdb20 oh bb">
      <%-- 조회 --%>
      <button class="btn_blue fr" id="btnSearch" ng-click="_pageView('orderStockInfoCtrl', 1)">
        <%--<button class="btn_blue fr" id="btnSearch" ng-click="fnSearch()">--%>
        <s:message code="cmm.search"/></button>
    </div>

    <div class="wj-TblWrap" style="height: 350px;">

      <div class="w100 mt10">
        <div class="wj-TblWrapBr">
          <%--위즈모 테이블--%>
          <div class="wj-gridWrap" style="height: 250px;">
            <wj-flex-grid
              autoGenerateColumns="false"
              selection-mode="Row"
              items-source="data"
              control="flex"
              initialized="initGrid(s,e)"
              is-read-only="true"
              item-formatter="_itemFormatter">

              <!-- define columns -->
              <wj-flex-grid-column header="<s:message code="orderStockInfo.slipNo"/>" binding="slipNo" width="80" align="center" is-read-only="true"></wj-flex-grid-column>
              <wj-flex-grid-column header="<s:message code="orderStockInfo.orderDate"/>" binding="orderDate" width="80" align="center" is-read-only="true" format="date"></wj-flex-grid-column>
              <wj-flex-grid-column header="<s:message code="orderStockInfo.vendr"/>" binding="vendrNm" width="120" align="left" is-read-only="true"></wj-flex-grid-column>
              <wj-flex-grid-column header="<s:message code="orderStockInfo.procFg"/>" binding="procFg" width="70" align="center" is-read-only="true" data-map="procFgMap"></wj-flex-grid-column>
              <wj-flex-grid-column header="<s:message code="orderStockInfo.slipFg"/>" binding="slipFg" width="50" align="center" is-read-only="true" data-map="slipFgMap"></wj-flex-grid-column>
              <wj-flex-grid-column header="<s:message code="orderStockInfo.inCnt"/>" binding="inCnt" width="70" align="right" is-read-only="true"></wj-flex-grid-column>
              <wj-flex-grid-column header="<s:message code="orderStockInfo.dtlCnt"/>" binding="dtlCnt" width="70" align="right" is-read-only="true"></wj-flex-grid-column>
              <wj-flex-grid-column header="<s:message code="orderStockInfo.inLastDate"/>" binding="inLastDate" width="80" align="center" is-read-only="true" format="date"></wj-flex-grid-column>
              <wj-flex-grid-column header="<s:message code="orderStockInfo.orderAmt"/>" binding="orderAmt" width="70" align="right" is-read-only="true" aggregate="Sum"></wj-flex-grid-column>
              <wj-flex-grid-column header="<s:message code="orderStockInfo.orderVat"/>" binding="orderVat" width="70" align="right" is-read-only="true" aggregate="Sum"></wj-flex-grid-column>
              <wj-flex-grid-column header="<s:message code="orderStockInfo.orderTot"/>" binding="orderTot" width="70" align="right" is-read-only="true" aggregate="Sum"></wj-flex-grid-column>
              <wj-flex-grid-column header="<s:message code="orderStockInfo.inAmt"/>" binding="inAmt" width="70" align="right" is-read-only="true" aggregate="Sum"></wj-flex-grid-column>
              <wj-flex-grid-column header="<s:message code="orderStockInfo.inVat"/>" binding="inVat" width="70" align="right" is-read-only="true" aggregate="Sum"></wj-flex-grid-column>
              <wj-flex-grid-column header="<s:message code="orderStockInfo.inTot"/>" binding="inTot" width="70" align="right" is-read-only="true" aggregate="Sum"></wj-flex-grid-column>
              <wj-flex-grid-column header="<s:message code="orderStockInfo.inSlipNo"/>" binding="inSlipNo" width="0" align="right" is-read-only="true" visible="false"></wj-flex-grid-column>

            </wj-flex-grid>
            <%-- ColumnPicker 사용시 include --%>
            <jsp:include page="/WEB-INF/view/layout/columnPicker.jsp" flush="true">
              <jsp:param name="pickerTarget" value="orderStockInfoCtrl"/>
            </jsp:include>
            <%--// ColumnPicker 사용시 include --%>
          </div>
          <%--//위즈모 테이블--%>
        </div>
      </div>

      <div style="clear: both"></div>

      <div class="w100 mt10" ng-controller="orderStockInfoDtlCtrl">
        <div class="wj-TblWrapBr">
          <%--위즈모 테이블--%>
          <div class="wj-gridWrap" style="height: 250px;">
            <wj-flex-grid
              autoGenerateColumns="false"
              selection-mode="Row"
              items-source="data"
              control="flex"
              initialized="initGrid(s,e)"
              is-read-only="true"
              item-formatter="_itemFormatter">

              <!-- define columns -->
              <wj-flex-grid-column header="<s:message code="orderStockInfo.dtl.prodCd"/>" binding="prodCd" width="80" align="center" is-read-only="true"></wj-flex-grid-column>
              <wj-flex-grid-column header="<s:message code="orderStockInfo.dtl.prodNm"/>" binding="prodNm" width="150" align="left" is-read-only="true"></wj-flex-grid-column>
              <wj-flex-grid-column header="<s:message code="orderStockInfo.dtl.inCnt"/>" binding="inCnt" width="70" align="right" is-read-only="true"></wj-flex-grid-column>
              <wj-flex-grid-column header="<s:message code="orderStockInfo.dtl.inLastDate"/>" binding="inLastDate" width="80" align="center" is-read-only="true" format="date"></wj-flex-grid-column>
              <wj-flex-grid-column header="<s:message code="orderStockInfo.dtl.orderTotQty"/>" binding="orderTotQty" width="40" align="right" is-read-only="true" aggregate="Sum"></wj-flex-grid-column>
              <wj-flex-grid-column header="<s:message code="orderStockInfo.dtl.orderAmt"/>" binding="orderAmt" width="70" align="right" is-read-only="true" aggregate="Sum"></wj-flex-grid-column>
              <wj-flex-grid-column header="<s:message code="orderStockInfo.dtl.orderVat"/>" binding="orderVat" width="70" align="right" is-read-only="true" aggregate="Sum"></wj-flex-grid-column>
              <wj-flex-grid-column header="<s:message code="orderStockInfo.dtl.orderTot"/>" binding="orderTot" width="70" align="right" is-read-only="true" aggregate="Sum"></wj-flex-grid-column>
              <wj-flex-grid-column header="<s:message code="orderStockInfo.dtl.inTotQty"/>" binding="inTotQty" width="40" align="right" is-read-only="true" aggregate="Sum"></wj-flex-grid-column>
              <wj-flex-grid-column header="<s:message code="orderStockInfo.dtl.inAmt"/>" binding="inAmt" width="70" align="right" is-read-only="true" aggregate="Sum"></wj-flex-grid-column>
              <wj-flex-grid-column header="<s:message code="orderStockInfo.dtl.inVat"/>" binding="inVat" width="70" align="right" is-read-only="true" aggregate="Sum"></wj-flex-grid-column>
              <wj-flex-grid-column header="<s:message code="orderStockInfo.dtl.inTot"/>" binding="inTot" width="70" align="right" is-read-only="true" aggregate="Sum"></wj-flex-grid-column>

            </wj-flex-grid>
            <%-- ColumnPicker 사용시 include --%>
            <jsp:include page="/WEB-INF/view/layout/columnPicker.jsp" flush="true">
              <jsp:param name="pickerTarget" value="orderStockInfoDtlCtrl"/>
            </jsp:include>
            <%--// ColumnPicker 사용시 include --%>
          </div>
          <%--//위즈모 테이블--%>
        </div>
      </div>
    </div>
  </div>
</div>

<script type="text/javascript">
  /**
   * get application
   */
  var app = agrid.getApp();

  /** 발주대비 입고현황 그리드 controller */
  app.controller('orderStockInfoCtrl', ['$scope', '$http', function ($scope, $http) {
    // 상위 객체 상속 : T/F 는 picker
    angular.extend(this, new RootController('orderStockInfoCtrl', $scope, $http, true));

    $scope.srchStartDate = wcombo.genDateVal("#srchStartDate", "${sessionScope.sessionInfo.startDate}");
    $scope.srchEndDate   = wcombo.genDateVal("#srchEndDate", "${sessionScope.sessionInfo.endDate}");

    // 그리드 전표구분
    $scope.slipFgMap = new wijmo.grid.DataMap([
      {id: "1", name: "<s:message code='vendrInstock.slipFgIn'/>"},
      {id: "-1", name: "<s:message code='vendrInstock.slipFgRtn'/>"}
    ], 'id', 'name');

    // grid 초기화 : 생성되기전 초기화되면서 생성된다
    $scope.initGrid = function (s, e) {

      var comboParams         = {};
      comboParams.nmcodeGrpCd = "096";
      // 파라미터 (comboFg, comboId, gridMapId, url, params, option)
      $scope._queryCombo("map", "", "procFgMap", null, comboParams, "A"); // 명칭관리 조회시 url 없이 그룹코드만 넘긴다.

      // picker 사용시 호출 : 미사용시 호출안함
      $scope._makePickColumns("orderStockInfoCtrl");

      // 그리드 링크 효과
      s.formatItem.addHandler(function (s, e) {
        if (e.panel === s.cells) {
          var col = s.columns[e.col];
          if (col.binding === "slipNo") { // 전표번호
            wijmo.addClass(e.cell, 'wijLink');
            wijmo.addClass(e.cell, 'wj-custom-readonly');
          }
          // 구분이 반출이면 글씨색을 red 로 변경한다.
          if (col.binding === "slipFg") {
            var item = s.rows[e.row].dataItem;
            if (item.slipFg === -1) {
              wijmo.addClass(e.cell, 'red');
            }
          }

          if (col.format === "date") {
            e.cell.innerHTML = getFormatDate(e.cell.innerText);
          } else if (col.format === "dateTime") {
            e.cell.innerHTML = getFormatDateTime(e.cell.innerText);
          }
        }
      });

      // 그리드 클릭 이벤트
      s.addEventListener(s.hostElement, 'mousedown', function (e) {
        var ht = s.hitTest(e);
        if (ht.cellType === wijmo.grid.CellType.Cell) {
          var col         = ht.panel.columns[ht.col];
          var selectedRow = s.rows[ht.row].dataItem;
          if (col.binding === "slipNo") { // 전표번호
            var params       = {};
            params.slipNo    = selectedRow.slipNo;
            params.inSlipNo  = selectedRow.inSlipNo;
            params.startDate = $scope.searchedStartDate;
            params.endDate   = $scope.searchedEndDate;
            $scope._broadcast('orderStockInfoDtlCtrl', params);
          }
        }
      });

      // add the new GroupRow to the grid's 'columnFooters' panel
      s.columnFooters.rows.push(new wijmo.grid.GroupRow());
      // add a sigma to the header to show that this is a summary row
      s.bottomLeftCells.setCellData(0, 0, '합계');

      // 헤더머지
      s.allowMerging = 2;
      s.columnHeaders.rows.push(new wijmo.grid.Row());
      s.columnHeaders.rows[0].dataItem = {
        slipNo    : messages["orderStockInfo.slipNo"],
        orderDate : messages["orderStockInfo.orderDate"],
        vendrNm   : messages["orderStockInfo.vendr"],
        procFg    : messages["orderStockInfo.procFg"],
        slipFg    : messages["orderStockInfo.slipFg"],
        inCnt     : messages["orderStockInfo.inCnt"],
        dtlCnt    : messages["orderStockInfo.dtlCnt"],
        inLastDate: messages["orderStockInfo.inLastDate"],
        orderAmt  : messages["orderStockInfo.order"],
        orderVat  : messages["orderStockInfo.order"],
        orderTot  : messages["orderStockInfo.order"],
        inAmt     : messages["orderStockInfo.in"],
        inVat     : messages["orderStockInfo.in"],
        inTot     : messages["orderStockInfo.in"],
        inSlipNo  : messages["orderStockInfo.inSlipNo"],
      };

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


    // 다른 컨트롤러의 broadcast 받기
    $scope.$on("orderStockInfoCtrl", function (event, data) {
      $scope.searchOrderStockInfoList();
      // 기능수행 종료 : 반드시 추가
      event.preventDefault();
    });


    // 발주대비 입고현황 리스트 조회
    $scope.searchOrderStockInfoList = function () {
      $scope.searchedStartDate = wijmo.Globalize.format($scope.srchStartDate.value, 'yyyyMMdd');
      $scope.searchedEndDate   = wijmo.Globalize.format($scope.srchEndDate.value, 'yyyyMMdd');

      // 파라미터
      var params       = {};
      params.startDate = $scope.searchedStartDate;
      params.endDate   = $scope.searchedEndDate;
      params.vendrCd   = $("#orderStockInfoSelectVendrCd").val();

      // 조회 수행 : 조회URL, 파라미터, 콜백함수
      $scope._inquiryMain("/iostock/vendr/orderStockInfo/orderStockInfo/list.sb", params, function () {
        // 거래처별 정산 그리드 조회 후 상세내역 그리드 초기화
        var orderStockInfoDtlScope = agrid.getScope('orderStockInfoDtlCtrl');
        orderStockInfoDtlScope.dtlGridDefault();
      });
    };


    // 거래처선택 모듈 팝업 사용시 정의
    // 함수명 : 모듈에 넘기는 파라미터의 targetId + 'Show'
    // _broadcast : 모듈에 넘기는 파라미터의 targetId + 'Ctrl'
    $scope.orderStockInfoSelectVendrShow = function () {
      $scope._broadcast('orderStockInfoSelectVendrCtrl');
    };


    // DB 데이터를 조회해와서 그리드에서 사용할 Combo를 생성한다.
    // comboFg : map - 그리드에 사용할 Combo, combo - ComboBox 생성. 두가지 다 사용할경우 combo,map 으로 하면 둘 다 생성.
    // comboId : combo 생성할 ID
    // gridMapId : grid 에서 사용할 Map ID
    // url : 데이터 조회할 url 정보. 명칭관리 조회시에는 url 필요없음.
    // params : 데이터 조회할 url에 보낼 파라미터
    // option : A - combo 최상위에 전체라는 텍스트를 붙여준다. S - combo 최상위에 선택이라는 텍스트를 붙여준다. A 또는 S 가 아닌 경우는 데이터값만으로 생성
    $scope._queryCombo = function (comboFg, comboId, gridMapId, url, params, option) {
      var comboUrl = "/iostock/volmErr/volmErr/volmErr/getCombo.sb";
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
        if (response.data.status === "OK") {
          // this callback will be called asynchronously
          // when the response is available
          if (!$.isEmptyObject(response.data.data.list)) {
            var list       = response.data.data.list;
            var comboArray = [];
            var comboData  = {};

            if (comboFg.indexOf("combo") >= 0 && nvl(comboId, '') !== '') {
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
              for (var i = 0; i < list.length; i++) {
                comboData      = {};
                comboData.id   = list[i].nmcodeCd;
                comboData.name = list[i].nmcodeNm;
                comboArray.push(comboData);
              }
              $scope[gridMapId] = new wijmo.grid.DataMap(comboArray, 'id', 'name');
            }
          }
        } else if (response.data.status === "FAIL") {
          $scope._popMsg("Ajax Fail By HTTP Request");
        } else if (response.data.status === "SESSION_EXFIRE") {
          $scope._popMsg(response.data.message, function () {
            location.href = response.data.url;
          });
        } else if (response.data.status === "SERVER_ERROR") {
          $scope._popMsg(response.data.message);
        } else {
          var msg = response.data.status + " : " + response.data.message;
          $scope._popMsg(msg);
        }
      }, function errorCallback(response) {
        // called asynchronously if an error occurs
        // or server returns response with an error status.
        $scope._popMsg(messages["cmm.error"]);
        return false;
      }).then(function () {
      });
    };

  }]);


  /** 발주대비 입고현황 상세 그리드 controller */
  app.controller('orderStockInfoDtlCtrl', ['$scope', '$http', '$timeout', function ($scope, $http, $timeout) {
    // 상위 객체 상속 : T/F 는 picker
    angular.extend(this, new RootController('orderStockInfoDtlCtrl', $scope, $http, true));

    // grid 초기화 : 생성되기전 초기화되면서 생성된다
    $scope.initGrid = function (s, e) {

      // picker 사용시 호출 : 미사용시 호출안함
      $scope._makePickColumns("orderStockInfoDtlCtrl");

      // 그리드 링크 효과
      s.formatItem.addHandler(function (s, e) {
        if (e.panel === s.cells) {
          var col = s.columns[e.col];
          if (col.binding === "inTotQty") { // 입고수량
            wijmo.addClass(e.cell, 'wijLink');
            wijmo.addClass(e.cell, 'wj-custom-readonly');
          }

          if (col.format === "date") {
            e.cell.innerHTML = getFormatDate(e.cell.innerText);
          } else if (col.format === "dateTime") {
            e.cell.innerHTML = getFormatDateTime(e.cell.innerText);
          }
        }
      });

      // 그리드 클릭 이벤트
      s.addEventListener(s.hostElement, 'mousedown', function (e) {
        var ht = s.hitTest(e);
        if (ht.cellType === wijmo.grid.CellType.Cell) {
          var col         = ht.panel.columns[ht.col];
          var selectedRow = s.rows[ht.row].dataItem;
          if (col.binding === "inTotQty") { // 입고수량 클릭
            var params       = {};
            params.prodCd    = selectedRow.prodCd;
            params.prodNm    = selectedRow.prodNm;
            params.slipNo    = ($scope.slipNo === messages['orderStockInfo.dtl.notOrderInstock'] ? '' : $scope.slipNo);    // 무발주가 아닌 경우 파라미터 세팅
            params.startDate = ($scope.slipNo === messages['orderStockInfo.dtl.notOrderInstock'] ? $scope.startDate : ''); // 무발주인 경우 파라미터 세팅
            params.endDate   = ($scope.slipNo === messages['orderStockInfo.dtl.notOrderInstock'] ? $scope.endDate : '');   // 무발주인 경우 파라미터 세팅
            $scope._broadcast('prodInstockInfoCtrl', params);
          }
        }
      });

      // add the new GroupRow to the grid's 'columnFooters' panel
      s.columnFooters.rows.push(new wijmo.grid.GroupRow());
      // add a sigma to the header to show that this is a summary row
      s.bottomLeftCells.setCellData(0, 0, '합계');

      // 헤더머지
      s.allowMerging = 2;
      s.columnHeaders.rows.push(new wijmo.grid.Row());
      s.columnHeaders.rows[0].dataItem = {
        prodCd     : messages["orderStockInfo.dtl.prodCd"],
        prodNm     : messages["orderStockInfo.dtl.prodNm"],
        inCnt      : messages["orderStockInfo.dtl.inCnt"],
        inLastDate : messages["orderStockInfo.dtl.inLastDate"],
        orderTotQty: messages["orderStockInfo.dtl.order"],
        orderAmt   : messages["orderStockInfo.dtl.order"],
        orderVat   : messages["orderStockInfo.dtl.order"],
        orderTot   : messages["orderStockInfo.dtl.order"],
        inTotQty   : messages["orderStockInfo.dtl.in"],
        inAmt      : messages["orderStockInfo.dtl.in"],
        inVat      : messages["orderStockInfo.dtl.in"],
        inTot      : messages["orderStockInfo.dtl.in"],
      };

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


    // 다른 컨트롤러의 broadcast 받기
    $scope.$on("orderStockInfoDtlCtrl", function (event, data) {
      $scope.slipNo    = data.slipNo;
      $scope.inSlipNo  = data.inSlipNo;
      $scope.startDate = data.startDate;
      $scope.endDate   = data.endDate;

      $scope.searchOrderStockInfoDtlList();
      // 기능수행 종료 : 반드시 추가
      event.preventDefault();
    });


    // 발주대비 입고현황 상세 리스트 조회
    $scope.searchOrderStockInfoDtlList = function () {
      // 파라미터
      var params       = {};
      params.slipNo    = $scope.slipNo;
      params.inSlipNo  = $scope.inSlipNo;
      params.startDate = $scope.startDate;
      params.endDate   = $scope.endDate;
      // 조회 수행 : 조회URL, 파라미터, 콜백함수
      $scope._inquirySub("/iostock/vendr/orderStockInfo/orderStockInfoDtl/list.sb", params);
    };


    // 상세 그리드 초기화
    $scope.dtlGridDefault = function () {
      $timeout(function () {
        var cv          = new wijmo.collections.CollectionView([]);
        cv.trackChanges = true;
        $scope.data     = cv;
        $scope.flex.refresh();
      }, 10);
    };

  }]);
</script>

<%-- 입고 상세 팝업 레이어 --%>
<c:import url="/WEB-INF/view/iostock/vendr/orderStockInfo/prodInstockInfo.jsp">
  <c:param name="menuCd" value="${menuCd}"/>
  <c:param name="menuNm" value="${menuNm}"/>
</c:import>
