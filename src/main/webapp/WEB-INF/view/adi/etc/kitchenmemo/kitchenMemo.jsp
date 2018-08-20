<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="f" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var="menuCd" value="${sessionScope.sessionInfo.currentMenu.resrceCd}"/>
<c:set var="menuNm" value="${sessionScope.sessionInfo.currentMenu.resrceNm}"/>
<c:set var="baseUrl" value="/adi/etc/kitchenmemo/kitchenmemo/" />

<div class="subCon">
  <div class="updownSet oh">
    <span class="fl bk lh30">${menuNm}</span>
    <div class="txtIn">
      <button class="btn_skyblue" id="addBtn">
        <s:message code="cmm.add" />
      </button>
      <button class="btn_skyblue" id="deleteBtn">
        <s:message code="cmm.delete" />
      </button>
      <button class="btn_skyblue" id="saveBtn">
        <s:message code="cmm.save" />
      </button>
    </div>
  </div>
  <div class="wj-TblWrapBr mt10" style="height: 400px;">
    <div id="theGrid" class="mt10"></div>
  </div>
</div>

<script>
$(document).ready(function(){
  var memoFgData = new wijmo.grid.DataMap([{id:"1", name:"주문"},{id:"2", name:"메뉴"}], 'id', 'name');
  var useYnData  = new wijmo.grid.DataMap([{id:"Y", name:"Y"},{id:"N", name:"N"}], 'id', 'name');
  var rdata = 
    [
      {binding:"gChk", header:"<s:message code='kitchenMemo.chk' />", dataType:wijmo.DataType.Boolean, width:40},
      {binding:"kitchnMemoCd", header:"<s:message code='kitchenMemo.kitchnMemoCd' />", maxLength:3, width:"*"},
      {binding:"kitchnMemoNm", header:"<s:message code='kitchenMemo.kitchnMemoNm' />", maxLength:30, width:"*"},
      {binding:"memoFg", header:"<s:message code='kitchenMemo.memoFg' />", dataMap:memoFgData, width:"*"},
      {binding:"useYn", header:"<s:message code='kitchenMemo.useYn' />", dataMap:useYnData, width:"*"}
    ];
  
  var kitchenMemoList = ${kitchenMemoList};
  
  <%-- 그리드 div, column data, 화면명, 화면 그리드 순서 --%>
  var grid             = wgrid.genGrid("#theGrid", rdata);
  var kitchenMemo      = new wijmo.collections.CollectionView(kitchenMemoList);
  kitchenMemo.trackChanges = true;
  
  grid.itemsSource     = kitchenMemo;
  grid.isReadOnly      = false;
  
  <%-- 데이터 수정시 코드는 수정 불가 --%>
  grid.beginningEdit.addHandler(function (s, e) {
    <%-- 조회된 데이터는 kitchnMemoCd 수정 불가능 --%>
    if(grid.rows[e.row].dataItem.regId == undefined || grid.rows[e.row].dataItem.regId == ""){
      e.cancel = false;
    }else{
      if(e.col != 1){
        e.cancel = false;
      }else{
        e.cancel = true;
      }
    }
  });
  
  <%-- validation --%>
  grid.cellEditEnded.addHandler(function (s, e){
    var col = s.columns[e.col];
    if(col.maxLength){
      var val = s.getCellData(e.row, e.col);
      if (val.length > col.maxLength) { <%-- 자리수 체크 --%>
        s_alert.pop(col.header+"는(은) 최대 "+col.maxLength+ "자리 입력 가능합니다.");
      }
      if(col.binding == "kitchnMemoCd") { <%-- 숫자만 --%>
        if(val.match(/[^0-9]/)){
          s_alert.pop(col.header+"<s:message code='cmm.require.number'/>");
          s.setCellData(e.row, e.col, val.replace(/[^0-9]/g,""));
        }
      }
    }
  });
  
  <%-- 추가 --%>
  $("#addBtn").click(function( e ){
    var newItem = grid.collectionView.addNew();
    newItem.chk = false;
    grid.collectionView.commitNew();
  });
  
  <%-- 삭제 --%>
  $("#deleteBtn").click(function( e ){
    for(var i = kitchenMemo.items.length-1; i >= 0; i-- ){
      var item = kitchenMemo.items[i];
      if(item.chk){
        kitchenMemo.removeAt(i);
      }
    }
  });
  
  <%-- 저장 --%>
  $("#saveBtn").click(function( e ){

    var paramArr = new Array();
    
    for(var i=0; i<grid.collectionView.itemsEdited.length; i++){
      grid.collectionView.itemsEdited[i].status = "U";
      paramArr.push(grid.collectionView.itemsEdited[i]);
    }
    for(var i=0; i<grid.collectionView.itemsAdded.length; i++){
      grid.collectionView.itemsAdded[i].status = "I";
      paramArr.push(grid.collectionView.itemsAdded[i]);
    }
    for(var i=0; i<grid.collectionView.itemsRemoved.length; i++){
      grid.collectionView.itemsRemoved[i].status = "D";
      paramArr.push(grid.collectionView.itemsRemoved[i]);
    }

    $.postJSON("${baseUrl}" + "save.sb", JSON.stringify(paramArr), function(result) {
      s_alert.pop("<s:message code='cmm.saveSucc' />");
      grid.collectionView.clearChanges();
    },
    function(result) {
      s_alert.pop(result.message);
    });
    
  });
});
</script>
