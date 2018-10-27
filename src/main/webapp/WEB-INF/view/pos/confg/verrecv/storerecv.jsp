<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="f" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var="menuCd" value="${sessionScope.sessionInfo.currentMenu.resrceCd}"/>
<c:set var="menuNm" value="${sessionScope.sessionInfo.currentMenu.resrceNm}"/>
<c:set var="baseUrl" value="/pos/confg/verRecv/storeRecv/"/>

<div class="subCon">
  <%-- 탭 --%>
  <ul class="subTab mb20">
    <li><a href="#" id="verrecv"><s:message code="verRecv.verrecv" /></a></li>
    <li><a href="#" id="storerecv" class="on"><s:message code="verRecv.storerecv" /></a></li>
    <li><a href="#" id="verstore"><s:message code="verRecv.verstore" /></a></li>
  </ul>

  <div class="searchBar flddUnfld">
    <a href="#" class="open">${menuNm}</a>
  </div>
  <table class="searchTbl">
    <colgroup>
      <col class="w15" />
      <col class="w35" />
      <col class="w15" />
      <col class="w35" />
    </colgroup>
    <tbody>
      <tr>
        <%-- 본사코드 --%>
        <th><s:message code="verRecv.hqOfficeCd" /></th>
        <td>
          <input type="text" id="hqOfficeCd" name="hqOfficeCd" class="sb-input" maxlength="7" size="50">
        </td>
        <%-- 본사명 --%>
        <th><s:message code="verRecv.hqOfficeNm" /></th>
        <td>
          <input type="text" id="hqOfficeNm" name="hqOfficeNm" class="sb-input" maxlength="16" size="50">
        </td>
      </tr>
      <tr>
        <%-- 매장코드 --%>
        <th><s:message code="verRecv.storeCd" /></th>
        <td>
          <input type="text" id="storeCd" name="storeCd" class="sb-input" maxlength="5" size="50">
        </td>
        <%-- 매장명 --%>
        <th><s:message code="verRecv.storeNm" /></th>
        <td>
          <input type="text" id="storeNm" name="storeNm" class="sb-input" maxlength="16" size="50">
        </td>
      </tr>
      <tr>
        <%--최종버전 --%>
        <th><s:message code="verRecv.lastVer" /></th>
        <td>
          <input type="text" id="lastVer" name="lastVer" class="sb-input" maxlength="30" size="50">
        </td>
        <th></th>
        <td></td>
      </tr>
    </tbody>
  </table>
  <%-- 조회 --%>
  <div class="mt10 pdb20 oh">
    <button id="btnSearch" class="btn_blue fr"><s:message code="cmm.search" /></button>
  </div>

  <div class="mt20 oh sb-select dkbr">
    <%-- 엑셀다운로드 버튼 //TODO --%>
    <%--
    <div class="w150px fl"></div>
    <button id="btnExcel" class="btn_skyblue fr"><s:message code="cmm.excel.down" /></button>
    --%>
  </div>

  <%-- 위즈모 테이블 --%>
  <div class="wj-TblWrapBr mt10" style="height:400px;">
    <div id="theGrid1" class="pd20" style="height:390px;"></div>
  </div>

  <%-- 페이지 리스트 --%>
  <div class="pageNum mt20">
    <ul id="page" data-size="10">
    </ul>
  </div>
</div>

<script>

  <%-- 탭 클릭 --%>
  $("#verrecv").click(function(e){
    e.preventDefault();
    location.href = "/pos/confg/verRecv/verRecv/list.sb";
  });

  $("#storerecv").click(function(e){
    e.preventDefault();
    location.href = "/pos/confg/verRecv/storeRecv/list.sb";
  });

  $("#verstore").click(function(e){
    e.preventDefault();
    location.href = "/pos/confg/verRecv/verStore/list.sb";
  });

  <%-- 공통코드 --%>
  var mainYn  = ${cnv.getEnvCodeExcpAll("4021")};
  var posFg   = ${cnv.getEnvCodeExcpAll("4020")};

  var mainYnDataMap   = new wijmo.grid.DataMap(mainYn, 'value', 'name');
  var posFgDataMap    = new wijmo.grid.DataMap(posFg, 'value', 'name');

  <%-- header --%>
  var hData1 =
    [
      {binding:"hqOfficeCd", header:"<s:message code='verRecv.hqOfficeCd' />"},
      {binding:"hqOfficeNm", header:"<s:message code='verRecv.hqOfficeNm' />"},
      {binding:"storeCd", header:"<s:message code='verRecv.storeCd' />"},
      {binding:"storeNm", header:"<s:message code='verRecv.storeNm' />"},
      {binding:"mainYn", header:"<s:message code='verRecv.mainYn' />", dataMap:mainYnDataMap},
      {binding:"posFg", header:"<s:message code='verRecv.posFg' />", dataMap:posFgDataMap},
      {binding:"lastVer", header:"<s:message code='verRecv.lastVer' />"},
      {binding:"lastLoginDt", header:"<s:message code='verRecv.lastLoginDt' />"},
      {binding:"lastLoginIp", header:"<s:message code='verRecv.lastLoginIp' />"}
    ];

  <%-- 그리드 생성 --%>
  var grid1 = wgrid.genGrid("#theGrid1", hData1);

  <%-- 그리드 포맷 --%>
  grid1.formatItem.addHandler(function(s, e) {
    if (e.panel == s.cells) {
      var col = s.columns[e.col];
      var item = s.rows[e.row].dataItem;
      if( col.binding == "storeNm" ) {
        wijmo.addClass(e.cell, 'wijLink');
      }
    }
  });

  <%-- 그리드 선택 이벤트 --%>
  grid1.addEventListener(grid1.hostElement, 'mousedown', function(e) {
    var ht = grid1.hitTest(e);
    if( ht.cellType == wijmo.grid.CellType.Cell) {
      var col = ht.panel.columns[ht.col];
      if( col.binding == "storeNm") {
        showStoreDtl(grid1.rows[ht.row].dataItem);
      }
    }
  });

  <%-- 매장 수신목록 레이어 팝업--%>

  <%-- 조회버튼 클릭 --%>
  $("#btnSearch").click(function(e){
    search(1);
  });

  <%-- 매장목록 조회 --%>
  function search(index) {
    //TODO 조회조건 validation

    var param = {};
    param.hqOfficeCd  = $("#hqOfficeCd").val();
    param.hqOfficeNm  = $("#hqOfficeNm").val();
    param.storeCd     = $("#storeCd").val();
    param.storeNm     = $("#storeNm").val();
    param.lastVer     = $("#lastVer").val();
    param.listScale   = "10";
    param.curr        = index;

    $.postJSON("${baseUrl}" + "list.sb", param, function(result) {
      if(result.status === "FAIL") {
        s_alert.pop(result.message);
        return;
      }
      var list = result.data.list;
      if(list.length === undefined || list.length == 0) {
        s_alert.pop(result.message);
        grid1.itemsSource = new wijmo.collections.CollectionView([]);
        return;
      }
      grid1.itemsSource = list;
      page.make("#page", result.data.page.curr, result.data.page.totalPage);
    },
      function (result) {
        s_alert.pop(result.message);
    });
  }

  <%-- 페이징 --%>
  $(document).on("click", ".page", function() {
    search($(this).data("value"));
  });

  <%-- 엑셀다운로드 --%>
  $("#btnExcel").click(function(e){
    var name = "${menuNm}";
    wexcel.down(grid1, name, name + ".xlsx");
  });

</script>

<%--XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX--%>
<%--XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX--%>
<%--XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX--%>
<%--XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX--%>

<%-- 매장 포스 수신현황 상세  레이어 팝업--%>

<div id="storeDtlDim" class="fullDimmed" style="display:none;"></div>
<div id="storeDtlLayer" class="layer" style="display:none;">
  <div class="layer_inner">
    <div class="title w800px">
      <p class="tit"><s:message code="verRecv.storerecv"/></p>
      <a href="#" class="btn_close"></a>
      <div class="con">
        <p class="s14 bk mb5" id="storeTit"></p>
        <%-- 위즈모테이블 --%>
        <div>
          <div id="theGrid2" class="mt10" style="height:400px;"></div>
        </div>
      </div>
      <div class="btnSet">
        <span><a href="#" id="btnClose" class="btn_gray"><s:message code="cmm.close"/></a></span>
      </div>
    </div>
  </div>
</div>

<script>

  <%-- 공통코드 --%>

  var progFg    = ${ccu.getCommCodeExcpAll("059")};
  var verRecvFg = ${ccu.getCommCodeExcpAll("060")};

  var progFgDataMap     = new wijmo.grid.DataMap(progFg, 'value', 'name');
  var verRecvFgDataMap  = new wijmo.grid.DataMap(verRecvFg, 'value', 'name');

  <%-- Header --%>
  var hData2 =
    [
      {binding:"verSerNo", header:"<s:message code='verRecv.storeCd' />"},
      {binding:"verSerNm", header:"<s:message code='verRecv.storeNm' />"},
      {binding:"progFg", header:"<s:message code='verRecv.progFg' />", dataMap:progFgDataMap},
      {binding:"verRecvFg", header:"<s:message code='verRecv.verRecvFg' />", dataMap:verRecvFgDataMap},
      {binding:"fileNm", header:"<s:message code='verRecv.fileNm' />"},
      {binding:"regDt", header:"<s:message code='verRecv.regDt' />"},
      {binding:"verRecvDt", header:"<s:message code='verRecv.verRecvDt' />"}
    ];

  <%-- 그리드 생성 --%>
  var grid2 = wgrid.genGrid("#theGrid2", hData2, "${menuCd}", 2, ${clo.getColumnLayout(1)});

  <%-- 레이어팝업 호출 --%>
  function showStoreDtl(items) {

    var param = {};

    param.hqOfficeCd = items.hqOfficeCd;
    param.storeCd    = items.storeCd;

    $.postJSON("${baseUrl}" + "storeDtl.sb", param, function(result) {
      grid2.itemsSource = result.data.list;
    },
      function (result) {
        s_alert.pop(result.message);

    });

    var storeTitle = "["+items.storeCd+"] " + items.storeNm;

    $("#storeTit").text(storeTitle);
    $("#storeDtlDim").show();
    $("#storeDtlLayer").show();
  }

  $(".btn_close, #btnClose").click(function(){
    $("#storeDtlDim").hide();
    $("#storeDtlLayer").hide();
  });

</script>
