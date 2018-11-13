<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="menuCd" value="${sessionScope.sessionInfo.currentMenu.resrceCd}"/>
<c:set var="menuNm" value="${sessionScope.sessionInfo.currentMenu.resrceNm}"/>
<c:set var="baseUrl" value="/stock/disuse/hqDisuse/hqDisuseRegist/"/>

<wj-popup id="wjHqDisuseRegistLayer" control="wjHqDisuseRegistLayer" show-trigger="Click" hide-trigger="Click" style="display:none;width:900px;">
  <div id="hqDisuseRegistLayer" class="wj-dialog wj-dialog-columns" ng-controller="hqDisuseRegistCtrl">
    <div class="wj-dialog-header wj-dialog-header-font">
      <s:message code="hqDisuse.reg.registTitle"/>
      <a href="#" class="wj-hide btn_close"></a>
    </div>
    <div class="wj-dialog-body sc2" style="height: 600px;">
      <p id="registSubTitle" class="s14 bk mb5 fl"></p>

      <table class="tblType01" style="position: relative;">
        <colgroup>
          <col class="w15"/>
          <col class="w35"/>
          <col class="w15"/>
          <col class="w35"/>
        </colgroup>
        <tbody>
        <tr>
          <%-- 폐기제목 --%>
          <th><s:message code="hqDisuse.reg.disuseTitle"/><em class="imp">*</em></th>
          <td colspan="3">
            <input type="text" id="disuseTitle" name="disuseTitle" ng-model="disuseTitle" class="sb-input w100" maxlength="33" data-check="0,10"/>
          </td>
        </tr>
        <tr>
          <%-- 상품코드 --%>
          <th><s:message code="hqDisuse.reg.prodCd"/></th>
          <td>
            <input type="text" id="srchProdCd" name="srchProdCd" ng-model="prodCd" class="sb-input w100" maxlength="13"/>
          </td>
          <%-- 상품명 --%>
          <th><s:message code="hqDisuse.reg.prodNm"/></th>
          <td>
            <input type="text" id="srchProdNm" name="srchProdNm" ng-model="prodNm" class="sb-input w100" maxlength="50"/>
          </td>
        </tr>
        <tr>
          <%-- 바코드 --%>
          <th><s:message code="hqDisuse.reg.barcd"/></th>
          <td>
            <input type="text" id="srchBarcdCd" name="srchBarcdCd" ng-model="barcdCd" class="sb-input w100" maxlength="40"/>
          </td>
          <%-- 상품분류 --%>
          <th><s:message code="hqDisuse.reg.prodClass"/></th>
          <td>
            <input type="text" id="srchProdClass" name="prodClass" ng-model="prodClass" class="sb-input w100" maxlength="40"/>
          </td>
        </tr>
        <tr>
          <%-- 폐기구분 --%>
          <th><s:message code="hqDisuse.reg.disuseFg"/></th>
          <td>
            <div class="sb-select">
              <span class="txtIn w150px">
                <wj-combo-box
                  id="srchDisuseFg"
                  ng-model="disuseFg"
                  ng-disabled="readDisuseFg"
                  items-source="_getComboData('srchDisuseFg')"
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
          <td colspan="4">
            <a href="#" class="btn_grayS" ng-click=""><s:message code="hqDisuse.reg.excelFormDownload"/></a>
            <a href="#" class="btn_grayS" ng-click=""><s:message code="hqDisuse.reg.excelFormUpload"/></a>
            <a href="#" class="btn_grayS" ng-click=""><s:message code="hqDisuse.reg.textFormUpload"/></a>
            <a href="#" class="btn_grayS" ng-click=""><s:message code="cmm.excel.down"/></a>
            <a href="#" class="btn_grayS" ng-click=""><s:message code="hqDisuse.reg.excelFormUploadErrorInfo"/></a>
            <a href="#" class="btn_grayS" ng-click="valueCheck()">valuecheck</a>
          </td>
        </tr>
        </tbody>
      </table>

      <div class="mt10 oh">
        <%-- 조회 --%>
        <button type="button" class="btn_blue fr" id="btnSearch" ng-click="fnSearch();">
          <s:message code="cmm.search"/></button>
      </div>

      <ul class="txtSty3 mt10">
        <li class="red"><s:message code="hqDisuse.reg.txt1"/></li>
        <li class="red"><s:message code="hqDisuse.reg.txt2"/></li>
        <li class="red"><s:message code="hqDisuse.reg.txt3"/></li>
      </ul>

      <table class="tblType01 mt10 tc" style="position: relative;">
        <colgroup>
          <col class="w70"/>
          <col class="w30"/>
        </colgroup>
        <tbody>
        <tr>
          <%-- 상품코드/바코드 --%>
          <th class="tc">
            <s:message code="hqDisuse.reg.prodCd"/>/<s:message code="hqDisuse.reg.barcd"/></th>
          <%-- 추가수량 --%>
          <th class="tc"><s:message code="hqDisuse.reg.addQty"/></th>
        </tr>
        <tr>
          <td>
            <input type="text" id="prodBarcdCd" name="prodBarcdCd" ng-model="prodBarcdCd" class="sb-input tc" maxlength="40" style="width: 250px;" ng-keydown="searchProdKeyEvt($event)"/>
            <%-- 찾기 --%>
            <a href="#" class="btn_grayS" ng-click="prodFindPop()"><s:message code="hqDisuse.reg.prodFind"/></a>
            <span class="chk txtIn lh30 ml5" style="top: -2px;">
              <input type="checkbox" name="autoAddChk" id="autoAddChk" ng-model="autoAddChk"/>
              <label for="autoAddChk"><s:message code="hqDisuse.reg.autoAdd"/></label>
            </span>
          </td>
          <td>
            <input type="text" id="addQty" name="addQty" ng-model="addQty" class="sb-input tc" maxlength="10" style="width: 100px;" ng-keydown="addQtyKeyEvt($event)"/>
            <%-- 추가 --%>
            <a href="#" class="btn_grayS" ng-click="fnAddQty()"><s:message code="hqDisuse.reg.add"/></a>
          </td>
        </tr>
        </tbody>
      </table>

      <div class="mt20 tr">
        <div class="oh sb-select">
          <%-- 페이지 스케일  --%>
          <wj-combo-box
            class="w100px fl"
            id="regListScaleBox"
            ng-model="listScale"
            items-source="_getComboData('regListScaleBox')"
            display-member-path="name"
            selected-value-path="value"
            is-editable="false"
            initialized="_initComboBox(s)">
          </wj-combo-box>
          <%--// 페이지 스케일  --%>

          <%-- 저장 --%>
          <button type="button" class="btn_skyblue ml5" id="btnRegSave" ng-click="saveHqDisuseRegist()">
            <s:message code="cmm.save"/></button>
        </div>
      </div>

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
            <wj-flex-grid-column header="<s:message code="cmm.chk"/>" binding="gChk" width="30" align="center"></wj-flex-grid-column>
            <wj-flex-grid-column header="<s:message code="hqDisuse.reg.prodCd"/>" binding="prodCd" width="100" align="center" is-read-only="true"></wj-flex-grid-column>
            <wj-flex-grid-column header="<s:message code="hqDisuse.reg.prodNm"/>" binding="prodNm" width="150" align="left" is-read-only="true"></wj-flex-grid-column>
            <wj-flex-grid-column header="<s:message code="hqDisuse.reg.barcdCd"/>" binding="barcdCd" width="100" align="center" is-read-only="true"></wj-flex-grid-column>
            <wj-flex-grid-column header="<s:message code="hqDisuse.reg.saleUprc"/>" binding="saleUprc" width="70" align="right" is-read-only="true"></wj-flex-grid-column>
            <wj-flex-grid-column header="<s:message code="hqDisuse.reg.costUprc"/>" binding="costUprc" width="70" align="right" is-read-only="true"></wj-flex-grid-column>
            <wj-flex-grid-column header="<s:message code="hqDisuse.reg.poUnitQty"/>" binding="poUnitQty" width="70" align="right" is-read-only="true"></wj-flex-grid-column>
            <wj-flex-grid-column header="<s:message code="hqDisuse.reg.currQty"/>" binding="currQty" width="70" align="right" is-read-only="true"></wj-flex-grid-column>
            <wj-flex-grid-column header="<s:message code="hqDisuse.reg.disuseQty"/>" binding="disuseQty" width="70" align="right" max-length=8 data-type="Number" format="n0" aggregate="Sum"></wj-flex-grid-column>
            <wj-flex-grid-column header="<s:message code="hqDisuse.reg.disuseAmt"/>" binding="disuseAmt" width="0" align="right" is-read-only="true" visible="false"></wj-flex-grid-column>
            <wj-flex-grid-column header="<s:message code="hqDisuse.reg.remark"/>" binding="remark" width="200" align="left" max-length=300></wj-flex-grid-column>
            <wj-flex-grid-column header="<s:message code="hqDisuse.reg.disuseProdStatus"/>" binding="disuseProdStatus" width="0" align="center" is-read-only="true" visible="false"></wj-flex-grid-column>

          </wj-flex-grid>
        </div>
        <%--//위즈모 테이블--%>
      </div>
      <%-- 페이지 리스트 --%>
      <div class="pageNum mt20">
        <%-- id --%>
        <ul id="hqDisuseRegistCtrlPager" data-size="10">
        </ul>
      </div>
      <%--//페이지 리스트--%>
    </div>
  </div>
</wj-popup>


<script type="text/javascript">

  /** 폐기관리 등록 그리드 controller */
  app.controller('hqDisuseRegistCtrl', ['$scope', '$http', '$compile', function ($scope, $http, $compile) {
    // 상위 객체 상속 : T/F 는 picker
    angular.extend(this, new RootController('hqDisuseRegistCtrl', $scope, $http, true));

    $scope._setComboData("regListScaleBox", gvListScaleBoxData);

    $scope._setComboData("srchDisuseFg", [
      {"name": messages["cmm.all"], "value": ""},
      {"name": messages["hqDisuse.reg.disuseFgN"], "value": "N"},
      {"name": messages["hqDisuse.reg.disuseFgY"], "value": "Y"},
    ]);

    // grid 초기화 : 생성되기전 초기화되면서 생성된다
    $scope.initGrid = function (s, e) {
      s.cellEditEnded.addHandler(function (s, e) {
        if (e.panel === s.cells) {
          var col = s.columns[e.col];
          // 폐기수량 수정시 금액,VAT,합계 계산하여 보여준다.
          if (col.binding === "disuseQty") {
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
      var costUprc  = parseInt(item.costUprc);
      var disuseQty = parseInt(nvl(item.disuseQty, 0));
      var disuseAmt = parseInt(disuseQty) * parseInt(costUprc);

      item.disuseQty = disuseQty;   // 폐기수량
      item.disuseAmt = disuseAmt; // 폐기금액
    };


    // 다른 컨트롤러의 broadcast 받기
    $scope.$on("hqDisuseRegistCtrl", function (event, data) {

      // 그리드 초기화
      var cv          = new wijmo.collections.CollectionView([]);
      cv.trackChanges = true;
      $scope.data     = cv;

      if (!$.isEmptyObject(data)) {
        $scope._setPagingInfo('curr', 1); // 페이지번호 1로 세팅

        $scope.disuseDate = data.disuseDate;
        $scope.seqNo      = data.seqNo;
        $scope.callParent = data.callParent;

        // 상품찾기 변수값들 초기화
        $scope.addQty      = '';
        $scope.prodBarcdCd = '';
        $scope.autoAddChk  = false;
        $scope.disuseTitle = '';

        // 신규등록이면 폐기구분 disabled 시킨다.
        if ($scope.callParent === "hqDisuse") {
          $scope.readDisuseFg = true;
        }
        else {
          $scope.readDisuseFg = false;
        }

        $scope.procFgCheck(); // 폐기진행구분 체크
      }
      else { // 페이징처리에서 broadcast 호출시
        $scope.searchHqDisuseRegistList();
      }

      // 기능수행 종료 : 반드시 추가
      event.preventDefault();
    });


    // 폐기진행구분 체크 및 폐기제목 조회
    $scope.procFgCheck = function () {
      var params        = {};
      params.disuseDate = $scope.disuseDate;
      params.seqNo      = $scope.seqNo;

      // ajax 통신 설정
      $http({
        method : 'POST', //방식
        url    : '/stock/disuse/hqDisuse/hqDisuseRegist/procFgCheck.sb', /* 통신할 URL */
        params : params, /* 파라메터로 보낼 데이터 */
        headers: {'Content-Type': 'application/json; charset=utf-8'} //헤더
      }).then(function successCallback(response) {
        if ($scope._httpStatusCheck(response)) {
          // 진행구분이 폐기등록이 아니면 상품추가/변경 불가
          if (!$.isEmptyObject(response.data.data)) {
            if (response.data.data.procFg != "" && response.data.data.procFg != "0") {
              $scope._popMsg(messages["hqDisuse.reg.not.procEnd"]);
              return false;
            }
            $scope.disuseTitle = response.data.data.disuseTitle;
          }
        }
      }, function errorCallback(response) {
        // called asynchronously if an error occurs
        // or server returns response with an error status.
        if (response.data.message) {
          $scope._popMsg(response.data.message);
        } else {
          $scope._popMsg(messages['cmm.error']);
        }
        return false;
      }).then(function () {
        // "complete" code here
        $scope.wjHqDisuseRegistLayer.show(true);
        $("#registSubTitle").html(messages["hqDisuse.reg.disuseDate"] + ' : ' + getFormatDate($scope.disuseDate, '-'));
      });
    };


    // 폐기상품 리스트 조회
    $scope.searchHqDisuseRegistList = function () {
      // 파라미터
      var params        = {};
      params.disuseDate = $scope.disuseDate;
      params.seqNo      = $scope.seqNo;
      params.prodCd     = $scope.prodCd;
      params.prodNm     = $scope.prodNm;
      params.barcdCd    = $scope.barcdCd;
      params.disuseFg   = $scope.disuseFg;
      params.listScale  = $scope.listScale;

      // 조회 수행 : 조회URL, 파라미터, 콜백함수
      $scope._inquirySub("/stock/disuse/hqDisuse/hqDisuseRegist/list.sb", params);
    };


    // 조회버튼으로 조회시
    $scope.fnSearch = function () {
      if ($scope.flex.collectionView.itemsEdited.length > 0 || $scope.flex.collectionView.itemsAdded.length > 0) {
        var msg = messages["hqDisuse.reg.searchMsg"]; // 저장되지 않은 자료가 있습니다. 조회하시겠습니까?
        s_alert.popConf(msg, function () {
          $scope._setPagingInfo('curr', 1); // 페이지번호 1로 세팅
          $scope.searchHqDisuseRegistList();
        });
      }
      else {
        $scope._setPagingInfo('curr', 1); // 페이지번호 1로 세팅
        $scope.searchHqDisuseRegistList();
      }
    };


    // 폐기 상품 저장
    $scope.saveHqDisuseRegist = function () {
      if (nvl($scope.disuseTitle, '') === '') {
        var msg = messages["hqDisuse.reg.disuseTitle"] + messages["cmm.require.text"]; // 폐기제목을 입력하세요.
        $scope._popMsg(msg);
        return false;
      }
      var params = [];
      // 추가된 상품 가져오기
      for (var i = 0; i < $scope.flex.collectionView.itemsAdded.length; i++) {
        var item = $scope.flex.collectionView.itemsAdded[i];

        // 체크박스가 체크되어 있으면서 기존에 등록되어 있던 상품은 삭제한다.
        if (item.gChk === true && item.disuseProdStatus === 'U') {
          item.status = "D";
        }
        else {
          item.status = "U";
        }
        item.disuseDate  = $scope.disuseDate;
        item.seqNo       = $scope.seqNo;
        item.disuseTitle = $scope.disuseTitle;
        item.storageCd   = "001";
        item.hqBrandCd   = "00"; // TODO 브랜드코드 가져오는건 우선 하드코딩으로 처리. 2018-09-13 안동관

        params.push(item);
      }

      // 수정된 상품 가져오기
      for (var i = 0; i < $scope.flex.collectionView.itemsEdited.length; i++) {
        var item = $scope.flex.collectionView.itemsEdited[i];

        // 체크박스가 체크되어 있으면서 기존에 등록되어 있던 상품은 삭제한다.
        if (item.gChk === true && item.disuseProdStatus === 'U') {
          item.status = "D";
        }
        else {
          item.status = "U";
        }
        item.disuseDate  = $scope.disuseDate;
        item.seqNo       = $scope.seqNo;
        item.disuseTitle = $scope.disuseTitle;
        item.storageCd   = "001";
        item.hqBrandCd   = "00"; // TODO 브랜드코드 가져오는건 우선 하드코딩으로 처리. 2018-09-13 안동관

        params.push(item);
      }

      $scope._save("/stock/disuse/hqDisuse/hqDisuseRegist/save.sb", params, function () {
        $scope.saveRegistCallback()
      });
    };


    // 저장 후 콜백 서치 함수
    $scope.saveRegistCallback = function () {
      // 신규 요청등록인 경우
      if ($scope.callParent === "hqDisuse") {
        var hqDisuseScope = agrid.getScope('hqDisuseCtrl');
        hqDisuseScope.searchHqDisuseList();
      }
      // 주문 상품상세내역 페이지에서 호출한 경우
      else if ($scope.callParent === "hqDisuseDtl") {
        var hqDisuseScope = agrid.getScope('hqDisuseCtrl');
        hqDisuseScope.searchHqDisuseList();

        var hqDisuseDtlScope = agrid.getScope('hqDisuseDtlCtrl');
        hqDisuseDtlScope._setPagingInfo('curr', 1); // 페이지번호 1로 세팅
        hqDisuseDtlScope.searchHqDisuseDtlList();
      }

      $scope.wjHqDisuseRegistLayer.hide(true);
    };


    // 상품코드/바코드 input 박스에서 keyDown시
    $scope.searchProdKeyEvt = function (event) {
      if (event.keyCode === 13) { // 이벤트가 enter 이면
        var searchFg = true;

        // 조회된 상품중에 해당 상품코드/바코드가 있는지 검색
        for (var i = 0; i < $scope.flex.collectionView.items.length; i++) {
          var item = $scope.flex.collectionView.items[i];
          if (item.prodCd === $scope.prodBarcdCd || item.barcdCd === $scope.prodBarcdCd) {
            searchFg = false; // 그리드에 이미 해당 상품이 있는 경우 서버 조회 하지않도록 변수값 false 로 변경
          }
        }

        if (searchFg) {
          // 파라미터
          var params         = {};
          params.disuseDate  = $scope.disuseDate;
          params.seqNo       = $scope.seqNo;
          params.prodBarcdCd = $scope.prodBarcdCd;
          params.listScale   = 1; // 상품 하나만 조회해야 하므로 listScale 1로 줌.
          params.curr        = 1;

          var url = "/stock/disuse/hqDisuse/hqDisuseRegist/getProdInfo.sb";
          $scope._postJSONQuery.withOutPopUp(url, params, function (response) {
            if ($.isEmptyObject(response.data.data)) {
              $scope._popMsg(messages["cmm.empty.data"]);
            }
            else {
              $scope.addRow(response.data.data);
              if ($("#autoAddChk").prop("checked")) {
                $scope.modifyDisuseQty(1);
              }
              else {
                $scope.addQty = 1;
                $("#addQty").select();
              }
            }
          });
        }
        else {
          if ($("#autoAddChk").prop("checked")) {
            $scope.modifyDisuseQty(1);
          }
          else {
            $scope.addQty = 1;
            $("#addQty").select();
          }
        }
      }
    };


    // 그리드의 상품을 찾아서 폐기수 수정
    $scope.modifyDisuseQty = function (addQty) {
      for (var i = 0; i < $scope.flex.collectionView.items.length; i++) {
        var item = $scope.flex.collectionView.items[i];
        if (item.prodCd === $scope.prodBarcdCd || item.barcdCd === $scope.prodBarcdCd) {
          $scope.flex.collectionView.editItem(item);

          item.disuseQty = parseInt(nvl(item.disuseQty, 0)) + parseInt(addQty);

          $scope.calcAmt(item);
          $scope.flex.collectionView.commitEdit();
        }
      }

      // 자동추가가 체크되어 있는 경우 focus 를 계속 상품코드/바코드 입력하는곳에 둔다.
      if ($("#autoAddChk").prop("checked")) {
        $scope.addQty = '';
        $("#prodBarcdCd").select();
      }
    };


    // 추가버튼 클릭시
    $scope.fnAddQty = function () {
      var qty = $scope.addQty;
      $scope.modifyDisuseQty(qty);
    };


    // 추가수량 input 박스에서 keyDown시
    $scope.addQtyKeyEvt = function (event) {
      if (event.keyCode === 13) {
        $scope.fnAddQty();
      }
    };


    // grid 의 row 추가
    $scope.addRow = function (params) {
      var flex = $scope.flex;
      if (!flex.collectionView) {
        flex.itemsSource = new wijmo.collections.CollectionView();
      }
      flex.collectionView.trackChanges = true;
      var newRow                       = flex.collectionView.addNew();
      newRow.status                    = 'U';
      for (var prop in params) {
        newRow[prop] = params[prop];
      }
      flex.collectionView.commitNew();
    };



    /* 2018-11-13 안동관. input 값 체크 함수.
       input에 data-check="0,10" 이런식으로 주면 byte 길이 체크하여 0보다 작거나 10보다 크면 해당 input에 팝업 뜨도록 함.
       앞에 number 나 char 등을 주면 값체크하도록 로직 추가 할 수 있음.
     */
    $scope.valueCheck = function () {
      var rtnFg = true;

      var inputEle = angular.element('input');
      var value    = '';
      var checkArr = '';
      for (var i = 0, l = inputEle.length; i < l; i++) {
        var el = angular.element(inputEle[i]);
        if (el.attr('data-check')) {
          value    = inputEle[i].value;
          checkArr = el.attr('data-check').split(',');

          if (value.getByteLengthForOracle() < checkArr[0] || value.getByteLengthForOracle() > checkArr[1]) {

            // $scope._popMsg('문자열의 길이를 조정해주세요.(한글은 3Byte로 계산됩니다.)');
            // alert('문자열의 길이를 조정해주세요.(한글은 3Byte로 계산됩니다.) 최대:' + checkArr[1]);
            if(!el.attr('uib-popover-html')) {
              var popMsg = '<p class="s12" style="line-height:14px;">문자열의 길이를 조정해주세요.<br>(한글은 3Byte로 계산됩니다.)<br>최대 : '+checkArr[1]+'</p>';
              el.attr('uib-popover-html', "'"+popMsg+"'");
              el.attr('popover-placement', 'bottom-left');
              el.attr('popover-is-open', true);

              el.on('click', function(event) {
                if($(this).attr('uib-popover-html')) {
                  $(this).removeAttr('uib-popover-html');
                  $(this).removeAttr('popover-placement');
                  $(this).removeAttr('popover-is-open');
                  $(this).off('click');
                }
              });

              $compile(el)($scope);
            }

            // el.select();
            rtnFg = false;
            break;
          }
        }
      }

      return rtnFg;
    }




  }]);

</script>
