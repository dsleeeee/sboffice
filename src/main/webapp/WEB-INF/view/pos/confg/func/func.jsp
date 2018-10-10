<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="f" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var="menuCd" value="${sessionScope.sessionInfo.currentMenu.resrceCd}"/>
<c:set var="menuNm" value="${sessionScope.sessionInfo.currentMenu.resrceNm}"/>
<c:set var="baseUrl" value="/pos/confg/func/func/" />

<div class="subCon">

  <div class="wj-TblWrap mb40">
    <!--left-->
    <div class="w50 fl" style="width: 30%">
      <div class="wj-TblWrapBr mr10 pd20" style="height: 580px;">
        <div class="updownSet oh mb10">
          <span class="fl bk lh30"><s:message code='func.funFg' /></span>
      </div>
        <%-- 기능구분 --%>
        <div id="theGrid1"></div>
      </div>
    </div>
    <div class="w50 fr" style="width: 70%">
      <div class="wj-TblWrapBr ml10 pd20" style="height: 580px;">
        <div class="updownSet oh mb10">
          <span class="fl bk lh30">기능 <span id="funcName"></span></span>
          <%--버튼 --%>
          <button class="btn_up" id="btnUp" style="display: none;">
            <s:message code="cmm.up" />
          </button>
          <button class="btn_down" id="btnDown" style="display: none;">
            <s:message code="cmm.down" />
          </button>
          <button class="btn_skyblue" id="btnAdd" style="display: none;">
            <s:message code="cmm.add" />
          </button>
          <button class="btn_skyblue" id="btnDel" style="display: none;">
            <s:message code="cmm.delete" />
          </button>
          <button class="btn_skyblue" id="btnSave" style="display: none;">
            <s:message code="cmm.save" />
          </button>
        </div>
        <%-- 기능구분 상세 --%>
        <div id="theGrid2" style="height: 495px;"></div>
      </div>
    </div>
  </div>
</div>

<script>

var funcFgList  = ${fnkeyFgList};
var funcList    = [];
var selectData;

var storeKind   = ${ccu.getCommCodeExcpAll("057")};
var posFg       = ${ccu.getCommCodeExcpAll("027")};
var useYn       = ${ccu.getCommCodeExcpAll("067")};

var storeKindDataMap   = new wijmo.grid.DataMap(storeKind, 'value', 'name');
var posFgDataMap     = new wijmo.grid.DataMap(posFg, 'value', 'name');

<%-- CollectionView --%>
var funcFgCView = new wijmo.collections.CollectionView(funcFgList);

<%-- Header --%>
var hData1 =
  [
    {binding:"nmcodeCd", header:"<s:message code='func.funFgCd' />"},
    {binding:"nmcodeNm", header:"<s:message code='func.funFg' />"}
  ];

var hData2 =
  [
    {binding:"gChk", header:"<s:message code='func.chk' />", allowMerging:true, dataType:wijmo.DataType.Boolean, width:40},
    {binding:"fnkeyNo", header:"<s:message code='func.fnkeyNo' />", maxLength:4, allowMerging:true, isReadOnly:true, width:'*'},
    {binding:"fnkeyNm", header:"<s:message code='func.fnkeyNm' />", maxLength:20, allowMerging:true, width:'*'},
    {binding:"storeFg", header:"<s:message code='func.storeFg' />", dataMap:storeKindDataMap, allowMerging:true, width:'*'},
    {binding:"posFg", header:"<s:message code='func.posFg' />", dataMap:posFgDataMap, allowMerging:true, width:'*'},
    {binding:"posiAdjYn", header:"<s:message code='func.posiAdjYn' />", allowMerging:true, dataType:wijmo.DataType.Boolean, width:70},
    {binding:"colPosi", header:"<s:message code='func.colPosi' />", allowMerging:true, visible:false},
    {binding:"rowPosi", header:"<s:message code='func.rowPosi' />", allowMerging:true, visible:false},
    {binding:"width", header:"<s:message code='func.width' />", allowMerging:true, visible:false},
    {binding:"height", header:"<s:message code='func.height' />", allowMerging:true, visible:false},
    {binding:"fnkeyUseYn0", header:"<s:message code='func.useYn' />", dataType:wijmo.DataType.Boolean, width:40},
    {binding:"imgFileNm0", header:"<s:message code='func.imgFileNm' />", maxLength:50, width:'*'},
    {binding:"fnkeyUseYn1", header:"<s:message code='func.useYn' />", dataType:wijmo.DataType.Boolean, width:40},
    {binding:"imgFileNm1", header:"<s:message code='func.imgFileNm' />", maxLength:50, width:'*'},
    {binding:"useYn", header:"<s:message code='func.useYn' />", dataType:wijmo.DataType.Boolean, width:40},
    {binding:"dispSeq", header:"<s:message code='func.dispSeq' />"}
  ];

<%-- 그리드 생성 --%>
var grid1 = wgrid.genGrid("#theGrid1", hData1);
var grid2 = wgrid.genGrid("#theGrid2", hData2);

grid1.itemsSource     = funcFgCView;
grid1.isReadOnly      = true;

grid2.isReadOnly      = false;
grid2.allowMerging    = wijmo.grid.AllowMerging.ColumnHeaders;

<%-- merge할 헤더 추가 --%>
for (var i = 0; i < 1; i++) {
  var hr = new wijmo.grid.Row();
  grid2.columnHeaders.rows.push(hr);
}

<%-- merge --%>
for (var row = 0; row < grid2.columnHeaders.rows.length; row++) {
  grid2.columnHeaders.rows[row].allowMerging = true;
  for (var col = 0; col < grid2.columns.length; col++) {
    if ((row == 0 && col == 0) || row == 1 && col == 0 ) {
      grid2.columnHeaders.setCellData(row, col, "<s:message code='cmm.chk' />");
    }
    if ((row == 0 && col == 1) || row == 1 && col == 1 ) {
      grid2.columnHeaders.setCellData(row, col, "<s:message code='func.fnkeyNo' />");
    }
    if ((row == 0 && col == 2) || row == 1 && col == 2 ) {
      grid2.columnHeaders.setCellData(row, col, "<s:message code='func.fnkeyNm' />");
    }
    if ((row == 0 && col == 3) || row == 1 && col == 3 ) {
      grid2.columnHeaders.setCellData(row, col, "<s:message code='func.storeFg' />");
    }
    if ((row == 0 && col == 4) || row == 1 && col == 4 ) {
      grid2.columnHeaders.setCellData(row, col, "<s:message code='func.posFg' />");
    }
    if ((row == 0 && col == 5) || row == 1 && col == 5 ) {
      grid2.columnHeaders.setCellData(row, col, "<s:message code='func.posiAdjYn' />");
    }
    if ((row == 0 && col == 6) || row == 1 && col == 6 ) {
      grid2.columnHeaders.setCellData(row, col, "<s:message code='func.colPosi' />");
    }
    if ((row == 0 && col == 7) || row == 1 && col == 7 ) {
      grid2.columnHeaders.setCellData(row, col, "<s:message code='func.rowPosi' />");
    }
    if ((row == 0 && col == 8) || row == 1 && col == 8 ) {
      grid2.columnHeaders.setCellData(row, col, "<s:message code='func.width' />");
    }
    if ((row == 0 && col == 9) || row == 1 && col == 9 ) {
      grid2.columnHeaders.setCellData(row, col, "<s:message code='func.height' />");
    }
    if ((row == 0 && col == 10) || row == 0 && col == 11 ) {
      grid2.columnHeaders.setCellData(row, col, "<s:message code='func.comm' />");
    }
    if ((row == 0 && col == 12) || row == 0 && col == 13 ) {
      grid2.columnHeaders.setCellData(row, col, "<s:message code='func.food' />");
    }
    if ((row == 0 && col == 14) || row == 1 && col == 14 ) {
      grid2.columnHeaders.columns[col].visible = false; // merge컬럼 숨김
    }
    if ((row == 0 && col == 15) || row == 1 && col == 15 ) {
      grid2.columnHeaders.columns[col].visible = false;
    }
  }
}

<%-- 그리드 포맷 --%>
grid1.formatItem.addHandler(function(s, e) {
  if (e.panel == s.cells) {
    var col = s.columns[e.col];
    var item = s.rows[e.row].dataItem;
    if( col.binding == "nmcodeCd" ) {
      wijmo.addClass(e.cell, 'wijLink');
    }
  }
});

grid2.formatItem.addHandler(function(s, e) {
  if (e.panel == s.cells) {
    var col = s.columns[e.col];
    var item = s.rows[e.row].dataItem;
    if( col.binding == "fnkeyNo" ) {
      wijmo.addClass(e.cell, 'wijLink');
    }
  }
});

<%-- 그리드 선택 이벤트 --%>
grid1.addEventListener(grid1.hostElement, 'mousedown', function(e) {
  var ht = grid1.hitTest(e);
  if( ht.cellType == wijmo.grid.CellType.Cell) {
    var col = ht.panel.columns[ht.col];
    if( col.binding == "nmcodeCd") {
      selectData = grid1.rows[ht.row].dataItem;
      srchFuncData(selectData);
    }
  }
});

grid2.addEventListener(grid2.hostElement, 'mousedown', function(e) {
  var ht = grid2.hitTest(e);
  if( ht.cellType == wijmo.grid.CellType.Cell) {
    var col = ht.panel.columns[ht.col];
    if( col.binding == "fnkeyNo") {
      selectedFnkey = grid2.rows[ht.row].dataItem;
      showStoreLayer();
      wijmo.grid.FlexGrid.refreshAll();
    }
  }
});


<%-- 그리드2 데이터 조회 --%>
function srchFuncData(rowData) {
  var param = {};

  param.fnkeyFg = rowData.nmcodeCd;

  $.postJSON("${baseUrl}" + "funcList.sb", param, function(result) {

    $("#funcName").text(rowData.nmcodeNm);
    $("button").show();

    if(result.status === "FAIL") {
      s_alert.pop(result.message);
      return;
    }
    var list = result.data.list;
    grid2.itemsSource = new wijmo.collections.CollectionView(list);
    grid2.itemsSource.trackChanges = true;
    grid2.itemsSource.canSort = true;

    if(list.length === undefined || list.length == 0) {
      s_alert.pop(result.message);
      return;
    }

    <%-- 그리드2 데이터 수정 옵션 --%>
    grid2.beginningEdit.addHandler(function (s, e) {

      var col   = s.columns[e.col];
      var item  = s.rows[e.row].dataItem;

      <%-- 위치조정여부 Y시에만 열위치, 줄위치, 폭, 높이 입력 가능  --%>
//      if( col.binding == "colPosi" || col.binding == "rowPosi" || col.binding == "width" || col.binding == "height") {
//        if(item.posiAdjYn == "Y" || item.posiAdjYn == true){
//          e.cancel = false;
//        }else{
//          e.cancel = true;
//        }
//      }
      <%-- 일반 사용 Y일때만 일반 이미지명 입력 가능 --%>
      if( col.binding == "imgFileNm0") {
        if(item.fnkeyUseYn0 == true){
          e.cancel = false;
        }else{
          e.cancel = true;
        }
      }
      <%-- 외식 사용 Y일때만 외식 이미지명 입력 가능 --%>
      if( col.binding == "imgFileNm1") {
        if(item.fnkeyUseYn1 == true){
          e.cancel = false;
        }else{
          e.cancel = true;
        }
      }
    });
  }
  , function (result) {
      s_alert.pop(result.message);
  });
}

<%-- validation --%>
<%--
grid2.cellEditEnded.addHandler(function (s, e){
  var col = s.columns[e.col];
  if(col.maxLength){
    var val = s.getCellData(e.row, e.col);
    // 숫자만
    if(col.binding == "fnkeyNo" || col.binding == "colPosi" || col.binding == "rowPosi" || col.binding == "width" || col.binding == "height") {
      if(val.match(/[^0-9]/)){
        s_alert.pop(col.header+"<s:message code='cmm.require.number'/>");
        s.setCellData(e.row, e.col, val.replace(/[^0-9]/g,""));
      }
    }
  }
});
--%>

<%-- up 버튼 클릭 --%>
$("#btnUp").click(function(e){
  for(var i = 0; i < grid2.collectionView.itemCount; i++ ){
    var item = grid2.collectionView.items[i];
    if(i > 0 && (item.gChk == true)){
      if(grid2.collectionView.items[i-1].gChk != true){
        var tmpItem = grid2.collectionView.items[i-1];
        grid2.collectionView.items[i-1] = grid2.collectionView.items[i];
        grid2.collectionView.items[i] = tmpItem;
        grid2.collectionView.commitEdit();
        grid2.collectionView.refresh();
      }
    }
  }
});

<%-- down 버튼 클릭 --%>
$("#btnDown").click(function(e){
  for(var i = grid2.itemsSource.itemCount-1; i >= 0; i-- ){
    var item = grid2.collectionView.items[i];
    if((i < grid2.itemsSource.itemCount-1) && item.gChk){
      if(!grid2.collectionView.items[i+1].gChk){
        var tmpItem = grid2.collectionView.items[i+1];
        grid2.collectionView.items[i+1] = grid2.collectionView.items[i];
        grid2.collectionView.items[i] = tmpItem;
        grid2.collectionView.commitEdit();
        grid2.collectionView.refresh();
      }
    }
  }
});

<%-- 추가 버튼 클릭 --%>
$("#btnAdd").click(function(e){
  grid2.collectionView.newItemCreator = function() {
    return {
      fnkeyNo: '자동채번',
      posiAdjYn: false,
      fnkeyFunUseYn0: false,
      fnkeyFunUseYn1: false,
      useYn: true
    }
  };
  var newItem = grid2.collectionView.addNew();
  newItem.fnkeyNo = "자동채번";
  grid2.collectionView.commitNew();
});

<%-- 삭제 버튼 클릭 --%>
$("#btnDel").click(function(e){
  for(var i = grid2.itemsSource.itemCount-1; i >= 0; i-- ){
    var item = grid2.itemsSource.items[i];
    if(item.gChk){
      grid2.itemsSource.removeAt(i);
    }
  }
});

<%-- 저장 버튼 클릭 --%>
$("#btnSave").click(function(e){

  for(var i = 0; i < grid2.collectionView.itemCount; i ++) {  // dispSeq 재설정
    grid2.collectionView.editItem(grid2.collectionView.items[i]);
    grid2.collectionView.items[i].dispSeq = (i+1);
    grid2.collectionView.commitEdit();
  }

  var paramArr = new Array();

  for(var i=0; i<grid2.collectionView.itemsEdited.length; i++){
    grid2.collectionView.itemsEdited[i].status = "U";
    paramArr.push(grid2.collectionView.itemsEdited[i]);
  }
  for(var i=0; i<grid2.collectionView.itemsAdded.length; i++){
    grid2.collectionView.itemsAdded[i].status = "I";
    grid2.collectionView.itemsAdded[i].fnkeyFg = selectData.nmcodeCd;
    paramArr.push(grid2.collectionView.itemsAdded[i]);
  }
  for(var i=0; i<grid2.collectionView.itemsRemoved.length; i++){
    grid2.collectionView.itemsRemoved[i].status = "D";
    paramArr.push(grid2.collectionView.itemsRemoved[i]);
  }

  if(paramArr.length <= 0) {
    s_alert.pop("<s:message code='cmm.not.modify'/>");
    return;
  }

  $.postJSONArray("${baseUrl}" + "save.sb", paramArr, function(result) {
    s_alert.pop("<s:message code='cmm.saveSucc' />");
    grid2.collectionView.clearChanges();
  },
  function(result) {
    s_alert.pop(result.message);
  });

});
</script>

<%-- 매장선택 --%>
<c:import url="/WEB-INF/view/pos/confg/func/store.jsp">
  <c:param name="menuCd" value="${menuCd}"/>
  <c:param name="menuNm" value="${menuNm}"/>
  <c:param name="baseUrl" value="${baseUrl}"/>
</c:import>


