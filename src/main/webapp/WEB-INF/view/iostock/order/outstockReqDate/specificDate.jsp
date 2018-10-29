<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="menuCd" value="${sessionScope.sessionInfo.currentMenu.resrceCd}"/>
<c:set var="menuNm" value="${sessionScope.sessionInfo.currentMenu.resrceNm}"/>
<c:set var="baseUrl" value="/iostock/order/outstockReqDate/specificDate/"/>


<div id="specificView" class="subCon" style="display: none;" ng-controller="specificCtrl">
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
      <%-- 매장코드 --%>
      <th><s:message code="outstockReqDate.storeCd"/></th>
      <td>
        <%-- 매장선택 모듈 멀티 선택 사용시 include --%>
        <jsp:include page="/WEB-INF/view/iostock/order/outstockReqDate/selectShopM.jsp" flush="true">
          <jsp:param name="targetId" value="speSelectStore"/>
        </jsp:include>
        <%--// 매장선택 모듈 멀티 선택 사용시 include --%>
      </td>
    </tr>
    </tbody>
  </table>

  <div class="mt10 pdb20 oh bb">
    <%-- 조회 --%>
    <button class="btn_blue fr" id="btnSearch" ng-click="_pageView('specificCtrl',1)"><s:message code="cmm.search"/></button>
  </div>

  <div class="w100">
    <div class="mt20 oh sb-select dkbr">
      <%-- 페이지 스케일  --%>
      <wj-combo-box
        class="w100px fl"
        id="listScaleBox"
        ng-model="listScale"
        items-source="_getComboData('listScaleBox')"
        display-member-path="name"
        selected-value-path="value"
        is-editable="false"
        initialized="_initComboBox(s)">
      </wj-combo-box>
      <%--// 페이지 스케일  --%>
      <div class="tr">
        <%-- 신규등록 --%>
        <button class="btn_skyblue" ng-click="newSpecificDate()"><s:message code="cmm.new.add"/></button>
        <%-- 저장 --%>
        <button class="btn_skyblue" ng-click="saveSpecificDate()"><s:message code="cmm.save"/></button>
        <%-- 삭제 --%>
        <button class="btn_skyblue" ng-click="deleteSpecificDate()"><s:message code="cmm.del"/></button>
      </div>
    </div>

    <%--위즈모 테이블--%>
    <div class="wj-gridWrap mt10" style="height: 400px;">
      <wj-flex-grid
        autoGenerateColumns="false"
        selection-mode="Row"
        items-source="data"
        control="flex"
        initialized="initGrid(s,e)"
        is-read-only="false"
        item-formatter="_itemFormatter">

        <!-- define columns -->
        <wj-flex-grid-column header="<s:message code="cmm.chk"/>" binding="gChk" width="40" align="center"></wj-flex-grid-column>
        <wj-flex-grid-column header="<s:message code="outstockReqDate.storeCd"/>" binding="storeCd" width="70" align="center" is-read-only="true"></wj-flex-grid-column>
        <wj-flex-grid-column header="<s:message code="outstockReqDate.storeNm"/>" binding="storeNm" width="*" align="left" is-read-only="true"></wj-flex-grid-column>
        <wj-flex-grid-column header="<s:message code="cmm.owner.nm"/>" binding="ownerNm" width="60" align="center" is-read-only="true"></wj-flex-grid-column>
        <wj-flex-grid-column header="<s:message code="outstockReqDate.sysStatFg"/>" binding="sysStatFg" width="50" align="center" data-map="sysStatFgMap" is-read-only="true"></wj-flex-grid-column>
        <wj-flex-grid-column header="<s:message code="outstockReqDate.specificDate"/>" binding="specificDate" width="100" align="center" format="date" is-read-only="true"></wj-flex-grid-column>
        <wj-flex-grid-column header="<s:message code="outstockReqDate.specificDateRemark"/>" binding="specificDateRemark" width="*" align="left" is-read-only="false"></wj-flex-grid-column>
        <wj-flex-grid-column header="<s:message code="outstockReqDate.outstockReqYn"/>" binding="outstockReqYn" width="70" align="center" data-map="outstockReqYnMap" is-read-only="false"></wj-flex-grid-column>

      </wj-flex-grid>
      <%-- ColumnPicker 사용시 include --%>
      <jsp:include page="/WEB-INF/view/layout/columnPicker.jsp" flush="true">
        <jsp:param name="pickerTarget" value="specificCtrl"/>
      </jsp:include>
      <%--// ColumnPicker 사용시 include --%>
    </div>
    <%--//위즈모 테이블--%>
  </div>

  <%-- 페이지 리스트 --%>
  <div class="pageNum mt20">
    <%-- id --%>
    <ul id="specificCtrlPager" data-size="10">
    </ul>
  </div>
  <%--//페이지 리스트--%>
</div>


<%-- 특정일 신규등록 레이어 --%>
<c:import url="/WEB-INF/view/iostock/order/outstockReqDate/specificDateRegist.jsp">
  <c:param name="menuCd" value="${menuCd}"/>
  <c:param name="menuNm" value="${menuNm}"/>
</c:import>

<script type="text/javascript">

  /** 특정일 그리드 controller */
  app.controller('specificCtrl', ['$scope', '$http', function ($scope, $http) {
    // 상위 객체 상속 : T/F 는 picker
    angular.extend(this, new RootController('specificCtrl', $scope, $http, true));

    $scope._setComboData("listScaleBox", gvListScaleBoxData);
    var sysStatFg = ${ccu.getCommCode("005")};

    // grid 초기화 : 생성되기전 초기화되면서 생성된다
    $scope.initGrid = function (s, e) {
      // picker 사용시 호출 : 미사용시 호출안함
      $scope._makePickColumns("specificCtrl");

      // 그리드 DataMap 설정
      $scope.sysStatFgMap     = new wijmo.grid.DataMap(sysStatFg, 'value', 'name');
      $scope.outstockReqYnMap = new wijmo.grid.DataMap([
        {id: "Y", name: messages["outstockReqDate.outstockReqYnY"]},
        {id: "N", name: messages["outstockReqDate.outstockReqYnN"]},
      ], 'id', 'name');

      // 그리드 링크 효과
      s.formatItem.addHandler(function (s, e) {
        if (e.panel == s.cells) {
          var col = s.columns[e.col];
          // if (col.binding === "storeCd") {
          //   wijmo.addClass(e.cell, 'wijLink');
          //   wijmo.addClass(e.cell, 'wj-custom-readonly');
          // }

          if (col.format === "date") {
            e.cell.innerHTML = getFormatDate(e.cell.innerText);
          }
          else if (col.format === "dateTime") {
            e.cell.innerHTML = getFormatDateTime(e.cell.innerText);
          }
        }
      });

    };

    // 다른 컨트롤러의 broadcast 받기
    $scope.$on("specificCtrl", function (event, data) {
      $scope.searchspecificDateList();
      // 기능수행 종료 : 반드시 추가
      event.preventDefault();
    });

    // 특정일 그리드 조회
    $scope.searchspecificDateList = function () {
      // 파라미터
      var params     = {};
      params.storeCd = $("#speSelectStoreCd").val();
      // params.listScale = 15;
      // params.listScale = listScaleBoxSpecific.selectedValue;
      // params.curr = 1;
      // 조회 수행 : 조회URL, 파라미터, 콜백함수
      $scope._inquiryMain("/iostock/order/outstockReqDate/specificDate/list.sb", params);
    };

    // 특정일 신규등록
    $scope.newSpecificDate = function () {
      $scope._broadcast('speDateRegistCtrl');
    };

    // 특정일 저장
    $scope.saveSpecificDate = function () {
      var params = [];
      for (var i = 0; i < $scope.flex.collectionView.itemsEdited.length; i++) {
        $scope.flex.collectionView.itemsEdited[i].status = "U";
        params.push($scope.flex.collectionView.itemsEdited[i]);
      }
      $scope._save("/iostock/order/outstockReqDate/specificDate/save.sb", params, function () {
        $scope.searchspecificDateList()
      });
    };

    // 특정일 삭제
    $scope.deleteSpecificDate = function () {
      // 삭제 하시겠습니까?
      var msg = messages["cmm.choo.delete"];
      s_alert.popConf(msg, function () {
        var params = [];
        for (var i = 0; i < $scope.flex.collectionView.itemsEdited.length; i++) {
          $scope.flex.collectionView.itemsEdited[i].status = "U";
          params.push($scope.flex.collectionView.itemsEdited[i]);
        }
        $scope._save("/iostock/order/outstockReqDate/specificDate/delete.sb", params, function () {
          $scope.searchspecificDateList()
        });
      });
    };

    // 매장선택 모듈 팝업 사용시 정의
    // 함수명 : 모듈에 넘기는 파라미터의 targetId + 'Show'
    // _broadcast : 모듈에 넘기는 파라미터의 targetId + 'Ctrl'
    $scope.speSelectStoreShow = function () {
      $scope._broadcast('speSelectStoreCtrl');
    };

  }]);

  $(document).ready(function () {
    <%-- 엑셀 다운로드 버튼 클릭 --%>
    $("#btnExcel").click(function () {
      var name = "${menuNm}";
      name     = name + " 테스트";
      // wexcel.down(gridStoreLoan, name, name + ".xlsx");
    });
  });

</script>
<%--<script type="text/javascript" src="/resource/solbipos/js/iostock/loan/storeLoan.js?ver=2018082101" charset="utf-8"></script>--%>


