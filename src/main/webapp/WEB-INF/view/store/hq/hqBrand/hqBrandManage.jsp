<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="f" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var="menuCd" value="${sessionScope.sessionInfo.currentMenu.resrceCd}"/>
<c:set var="menuNm" value="${sessionScope.sessionInfo.currentMenu.resrceNm}"/>
<c:set var="orgnFg" value="${sessionScope.sessionInfo.orgnFg}" />
<c:set var="orgnCd" value="${sessionScope.sessionInfo.orgnCd}" />
<c:set var="orgnNm" value="${sessionScope.sessionInfo.orgnNm}" />

<div class="subCon">
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
        <th><s:message code="hqBrand.hqOfficeCd" /></th>
        <td>
          <div class="sb-select" >
            <div id="srchHqOfficeCd" class="sb-input w100"></div>
          </div>
        </td>
        <%-- 본사명 --%>
        <th><s:message code="hqBrand.hqOfficeNm" /></th>
        <td>
          <div class="sb-select" >
            <div id="srchHqOfficeNm" class="sb-input w100"></div>
          </div>
        </td>
      </tr>

      <tr>
        <%-- 브랜드코드 --%>
        <th><s:message code="hqBrand.hqBrandCd" /></th>
        <td>
          <div class="sb-select">
            <div id="srchHqBrandCd" class="sb-input w100"></div>
          </div>
        </td>
        <%-- 브랜드명 --%>
        <th><s:message code="hqBrand.hqBrandNm" /></th>
        <td>
          <div class="sb-select">
            <div id="srchHqBrandNm" class="sb-input w100"></div>
          </div>
        </td>
      </tr>
      <tr>
        <%-- 사용여부 --%>
        <th><s:message code="hqBrand.useYn" /></th>
        <td>
          <div class="sb-select">
            <div id="srchUseYn" class="sb-input w100"></div>
          </div>
        </td>
        <th></th>
        <td></td>
      </tr>

    </tbody>
  </table>

  <div class="mt10 pdb20 oh bb">
    <%-- 조회 --%>
    <button class="btn_blue fr" id="btnSearch"><s:message code="cmm.search" /></button>
  </div>

  <div class="mt20 oh sb-select dkbr">
    <%--페이지 스케일 --%>
    <div id="listScaleBox" class="w130px fl"></div>
    <div class="tr">
      <%-- 브랜드신규등록 --%>
      <button class="btn_skyblue" id="btnAdd"><s:message code="hqBrand.newBrand" /></button>
      <%-- 삭제 --%>
      <button class="btn_skyblue" id="btnDel"><s:message code="cmm.delete" /></button>
      <%-- 저장 --%>
      <button class="btn_skyblue" id="btnSave"><s:message code="cmm.save" /></button>
    </div>
  </div>

  <%-- 위즈모 테이블 --%>
  <div class="wj-TblWrap mt10">
    <div id="thegrid" style="height:450px;"></div>
  </div>

  <%-- 페이지 리스트 --%>
  <div class="pageNum mt20">
    <%-- id --%>
    <ul id="page" data-size="10">
    </ul>
  </div>
</div>

<script>

  var selectedBrand;

  $(document).ready(function() {

    var useYn             = ${ccu.getCommCode("067")};
    var useYnDataMap      = new wijmo.grid.DataMap(useYn, 'value', 'name');

    var srchHqOfficeCd    = wcombo.genInput("#srchHqOfficeCd");
    var srchHqOfficeNm    = wcombo.genInput("#srchHqOfficeNm");
    var srchHqBrandCd     = wcombo.genInput("#srchHqBrandCd");
    var srchHqBrandNm     = wcombo.genInput("#srchHqBrandNm");
    var srchUseYn         = wcombo.genCommonBox("#srchUseYn", useYn);

    <%-- Header --%>
    var hData =
      [
      <c:if test="${orgnFg == 'MASTER'}">
        {binding:"hqOfficeCd", header:"<s:message code='hqBrand.hqOfficeCd' />", isReadOnly:true, width:"*"},
        {binding:"hqOfficeNm", header:"<s:message code='hqBrand.hqOfficeNm' />", isReadOnly:true, width:"*"},
      </c:if>
        {binding:"hqBrandCd", header:"<s:message code='hqBrand.hqBrandCd' />", visible:false, width:"*"},
        {binding:"hqBrandNm", header:"<s:message code='hqBrand.hqBrandNm' />", maxLength:15, width:"*"},
        {binding:"useYn", header:"<s:message code='hqBrand.useYn' />", isReadOnly:false, dataMap:useYnDataMap, width:"*"},
      ];

    var grid     = wgrid.genGrid("#thegrid", hData, "${menuCd}", 1, ${clo.getColumnLayout(1)});
    var ldata         = ${ccu.getListScale()};
    var listScaleBox  = wcombo.genCommonBox("#listScaleBox", ldata);

    grid.isReadOnly  = false;
    grid.collectionView.trackChanges = true;

    <%-- 그리드 선택 이벤트 --%>
    grid.addEventListener(grid.hostElement, 'mousedown', function(e) {
      var ht = grid.hitTest(e);
      var row = ht.row;
      if( ht.cellType == wijmo.grid.CellType.Cell) {
        var col = ht.panel.columns[ht.col];
        if( col.binding == "hqOfficeCd" || col.binding == "hqOfficeNm") {
          selectedBrand = grid.rows[ht.row].dataItem;
          if(selectedBrand.regId == undefined) {
            addHqOfficeLayer(row);
          }
        }
      }
    });

    <%-- 브랜드명 수정 --%>
    grid.cellEditEnded.addHandler(function (s, e){
      var col = s.columns[e.col];
      if(col.maxLength){
        var val = s.getCellData(e.row, e.col);
        if (val.length > col.maxLength) {
          s_alert.pop("<s:message code='hqBrand.hqBrandNm'/><s:message code='cmm.regexp' arguments='"+col.maxLength+"'/>");
        }
      }
    });

    <%-- 조회 버튼 클릭 --%>
    $("#btnSearch").click(function(e){
      search(1);
    });

    <%-- 페이징 --%>
    $(document).on("click", ".page", function() {
      search($(this).data("value"));  //TODO 페이징테스트
    });

    <%-- 브랜드 목록 조회 --%>
    function search(index) {
      if(srchHqOfficeCd.text.length > 5) {
        s_alert.pop("<s:message code='hqBrand.hqOfficeCd'/><s:message code='cmm.regexp' arguments='15'/>");
        return;
      }

      if(srchHqOfficeNm.text.length > 15) {
        s_alert.pop("<s:message code='hqBrand.hqOfficeNm'/><s:message code='cmm.regexp' arguments='15'/>");
        return;
      }

      if(srchHqBrandCd.text.length > 5) {
        s_alert.pop("<s:message code='hqBrand.hqBrandCd'/><s:message code='cmm.regexp' arguments='5'/>");
        return;
      }

      if(srchHqBrandNm.text.length > 15 ) {
        s_alert.pop("<s:message code='hqBrand.hqBrandNm'/><s:message code='cmm.regexp' arguments='15'/>");
        return;
      }

      var param = {};
      param.hqOfficeCd  = srchHqOfficeCd.text;
      param.hqOfficeNm  = srchHqOfficeNm.text;
      param.hqBrandCd   = srchHqBrandCd.text;
      param.hqBrandNm   = srchHqBrandCd.text;
      param.useYn       = srchUseYn.selectedValue;
      param.listScale   = listScaleBox.selectedValue;
      param.curr        = index;

      $.postJSON("/store/hq/hqBrand/hqBrandManage/getBrandlist.sb", param, function(result) {
        var list = result.data.list;

        if(list.length === undefined || list.length == 0) {
          s_alert.pop(result.message);
          return;
        }

        grid.itemsSource = new wijmo.collections.CollectionView(list);
        grid.collectionView.trackChanges = true;

        page.make("#page", result.data.page.curr, result.data.page.totalPage);
      },
        function (result) {
          s_alert.pop(result.message);
          return;
        }
      );
    }

    <%-- 브랜드 추가 --%>
    $("#btnAdd").click(function(e){
      grid.collectionView.newItemCreator = function() {
        return {
          <c:if test="${orgnFg != 'MASTER'}">
          hqOfficeCd:"${orgnCd}",
          hqOfficeNm:"${orgnNm}",
          </c:if>
          useYn: 'Y'
        }
      };
      var newItem = grid.collectionView.addNew();
      grid.collectionView.commitNew();
    });

    <%-- 본사 코드 클릭시, 본사 선택 팝업 --%>
    function addHqOfficeLayer(row){
      console.log(row);

      c_hq.init(function(arr){
        console.log(arr);
        if(arr.length > 0) {
          var items = grid.rows[row].dataItem;
          grid.rows[row].dataItem.hqOfficeCd = arr[0].cd;
          grid.rows[row].dataItem.hqOfficeNm = arr[0].nm;
          grid.collectionView.commitEdit();
          grid.collectionView.refresh();
        }
      });
    }

    <%-- 브랜드 삭제 --%>
    $("#btnDel").click(function(e){
      for(var selected = 0; selected < grid.selectedItems.length; selected++ ) {
        var rows = grid.selectedRows[selected];
        var item = rows.dataItem;
        if(item == null) {
          grid.collectionView.cancelNew();
        }
        else {
          grid.collectionView.remove(item);
        }
      }
    });

    <%-- 브랜드 저장 --%>
    $("#btnSave").click(function(e){
      var paramArr = new Array();

      var gridView = grid.collectionView;

      for(var i = 0; i < gridView.items.length; i++) {
        if(gridView.items[i].hqOfficeCd == null || gridView.items[i].hqOfficeCd.length == 0) {
          s_alert.pop("<s:message code='hqBrand.require.hqOfficeCd'/>");
          return;
        }
        if(gridView.items[i].hqOfficeNm == null || gridView.items[i].hqOfficeNm.length == 0) {
          s_alert.pop("<s:message code='hqBrand.require.hqOfficeNm'/>");
          return;
        }
        if(gridView.items[i].hqBrandNm == null || gridView.items[i].hqBrandNm.length == 0) {
          s_alert.pop("<s:message code='hqBrand.require.hqBrandNm'/>");
          return;
        }
      }

      for(var i = 0; i < gridView.itemsAdded.length; i++) {
        gridView.itemsAdded[i].status = 'I';
        paramArr.push(gridView.itemsAdded[i]);
      }
      for(var i = 0; i < gridView.itemsEdited.length; i++) {
        gridView.itemsEdited[i].status = 'U';
        paramArr.push(gridView.itemsEdited[i]);
      }
      for(var i = 0; i < gridView.itemsRemoved.length; i++) {
        gridView.itemsRemoved[i].status = 'D';
        paramArr.push(gridView.itemsRemoved[i]);
      }

      if(paramArr.length <= 0) {
        s_alert.pop("<s:message code='cmm.not.modify'/>");
        return;
      }

      $.postJSONArray("/store/hq/hqBrand/hqBrandManage/save.sb", paramArr, function(result) {
        s_alert.pop("<s:message code='cmm.saveSucc' />");
        gridView.clearChanges();
        search(1);
      },
      function(result) {
        s_alert.pop(result.message);
      });
    });
  });

</script>

<%-- 본사 선택 --%>
<c:import url="/WEB-INF/view/application/layer/hqOffice.jsp">
</c:import>

