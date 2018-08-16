<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="f" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var="menuCd" value="${sessionScope.sessionInfo.currentMenu.resrceCd}"/>
<c:set var="menuNm" value="${sessionScope.sessionInfo.currentMenu.resrceNm}"/>
<c:set var="orgnFg" value="${sessionScope.sessionInfo.orgnFg}"/>
<c:set var="hqOfficeCd" value="${sessionScope.sessionInfo.orgnCd}"/>
<c:set var="storeCd" value="${sessionScope.sessionInfo.storeCd}"/>

<div class="subCon">
  <div class="searchBar">
    <a href="javscript:;" class="open">${menuNm}</a>
  </div>
  <table class="searchTbl">
    <colgroup>
      <col class="w15" />
      <col class="w35" />
      <col class="w15" />
      <col class="w35" />
    </colgroup>
    <tbody>

    <c:if test="${orgnFg == 'MASTER'}">
      <tr>
        <%-- 본사코드 --%>
        <th><s:message code="storeManage.hqOfficeCd" /></th>
        <td><input type="text" id="srchHqOfficeCd" class="sb-input w100" maxlength="5" /></td>
        <%-- 본사명 --%>
        <th><s:message code="storeManage.hqOfficeNm" /></th>
        <td><input type="text" id="srchHqOfficeNm" class="sb-input w100" maxlength="15" /></td>
      </tr>
    </c:if>

      <tr>
        <%-- 매장코드 --%>
        <th><s:message code="storeManage.storeCd" /></th>
        <td><input type="text" id="srchStoreCd" class="sb-input w100" maxlength="7"/></td>
        <%-- 매장명 --%>
        <th><s:message code="storeManage.storeNm" /></th>
        <td><input type="text" id="srchStoreNm" class="sb-input w100" maxlength="15"/></td>
      </tr>
      <tr>
        <%-- 사업자번호 --%>
        <th><s:message code="storeManage.bizNo" /></th>
        <td><input type="text" id="srchBizNo" class="sb-input w100" maxlength="10" placeholder="<s:message code='storeManage.bizNo.comment' />"/></td>
        <%-- 용도 --%>
        <th><s:message code="storeManage.clsFg" /></th>
        <td>
          <div class="sb-select">
              <div id="srchClsFg"></div>
          </div>
        </td>
      </tr>
      <tr>
        <%-- 상태 --%>
        <th><s:message code="storeManage.sysStatFg" /></th>
        <td>
          <div class="sb-select">
              <div id="srchSysStatFg"></div>
          </div>
        </td>
        <td></td>
        <td></td>
        <%-- 매장구분 --%>
        <%--
        <th><s:message code="storeManage.sysStatFg" /></th>
        <td><input type="text" class="sb-input w100" /></td>
        --%>
      </tr>
    </tbody>
  </table>

  <%-- 조회 --%>
  <div class="mt10 pdb20 oh bb">
    <button class="btn_blue fr" id="btnSearch"><s:message code="cmm.search" /></button>
  </div>

  <div class="wj-TblWrap mt20">
    <div class="w35 fl">
      <div class="wj-TblWrapBr mr10 pd20" style="height:700px;">
        <div class="sb-select dkbr mb10 oh">
          <%-- 페이지스케일 --%>
          <div id="listScaleBox" class="w130 fl"></div>
          <div class="fr">
            <%-- 전체펼치기 --%>
            <button class="btn_skyblue" id="btnExpand"><s:message code="cmm.all.expand" /></button>
            <%-- 전체접기 --%>
            <button class="btn_skyblue" id="btnFold"><s:message code="cmm.all.fold" /></button>
          </div>
        </div>
        <div id="theGrid" style="height:550px;"></div>

        <%-- 페이지리스트 --%>
        <div class="pageNum mt20">
          <%-- id --%>
          <ul id="page" data-size="10">
          </ul>
        </div>

      </div>
    </div>

    <%-- 매장 정보 조회(수정), 신규 등록--%>
    <c:import url="/WEB-INF/view/store/manage/storeManage/storeManageDetail.jsp">
      <c:param name="menuCd" value="${menuCd}"/>
      <c:param name="menuNm" value="${menuNm}"/>
    </c:import>

    <%-- 매장 환경설정 --%>
    <c:import url="/WEB-INF/view/store/manage/storeManage/storeConfigManage.jsp">
      <c:param name="menuCd" value="${menuCd}"/>
      <c:param name="menuNm" value="${menuNm}"/>
    </c:import>

  </div>
</div>

<script>

var selectedStore;  <%-- 매장정보 수정시, 선택 매장 --%>

var clsFg             = ${ccu.getCommCodeSelect("003")};
var sysStatFg         = ${ccu.getCommCodeSelect("005")};

var clsFgDataMap      = new wijmo.grid.DataMap(clsFg, 'value', 'name');
var sysStatFgDataMap  = new wijmo.grid.DataMap(sysStatFg, 'value', 'name');

var srchClsFg         = wcombo.genCommonBox("#srchClsFg", clsFg);
var srchSysStatFg     = wcombo.genCommonBox("#srchSysStatFg", sysStatFg);

<%-- header --%>
var hData =
  [
    {binding:"hqOfficeCdNm", header:"<s:message code='storeManage.hqOffice' />", visible:false},
    {binding:"hqOfficeCd", header:"<s:message code='storeManage.hqOfficeCd' />", visible:false},
    {binding:"hqOfficeNm", header:"<s:message code='storeManage.hqOfficeNm' />", visible:false},
    {binding:"storeCd", header:"<s:message code='storeManage.storeCd' />", width:80},
    {binding:"storeNm", header:"<s:message code='storeManage.storeNm' />", width:80},
    {binding:"clsFg", header:"<s:message code='storeManage.clsFg' />", dataMap:clsFgDataMap, width:"*"},
    {binding:"sysStatFg", header:"<s:message code='storeManage.sysStatFg' />", dataMap:sysStatFgDataMap, width:"*"},
    {binding:"sysOpenDate", header:"<s:message code='storeManage.sysOpenDate' />", width:"*"}
  ];

var grid          = wgrid.genGrid("#theGrid", hData);

grid.allowMerging = "Cells";

var ldata         = ${ccu.getListScale()};
var listScaleBox  = wcombo.genCommonBox("#listScaleBox", ldata);


<%-- 그리드 포맷 --%>
grid.formatItem.addHandler(function(s, e) {
  if (e.panel == s.cells) {
    var col = s.columns[e.col];
    var item = s.rows[e.row].dataItem;
    if( col.binding == "storeNm" && item.storeCd != null) {
      wijmo.addClass(e.cell, 'wijLink');
    }
  }
});

<%-- 펼침 버튼 클릭 --%>
/*
$("#btnExpand").click(function(){
  grid.collapseToLevel(100000);
});
*/

<%-- 접기 버튼 클릭 --%>
/*
$("#btnFold").click(function(){
  grid.collapseToLevel(0);
});
*/

<%-- 조회 버튼 클릭 --%>
$("#btnSearch").click(function(){
  search(1);
});

<%-- 페이징 --%>
$(document).on("click", ".page", function() {
  search($(this).data("value"));
});

<%-- 매장 목록 조회 --%>
function search(index) {

  <c:if test="${orgnFg == 'MASTER'}">
    if($("#srchHqOfficeCd").val().length > 5) {
      s_alert.pop("<s:message code='hqManage.hqOfficeCd'/><s:message code='cmm.regexp' arguments='5'/>");
      return;
    }
    if($("#srchHqOfficeNm").val().length > 15) {
      s_alert.pop("<s:message code='hqManage.hqOfficeNm'/><s:message code='cmm.regexp' arguments='15'/>");
      return;
    }
  </c:if>

  if($("#srchStoreCd").val().length > 7) {
    s_alert.pop("<s:message code='storeManage.storeCd'/><s:message code='cmm.regexp' arguments='7'/>");
    return;
  }
  if($("#srchStoreNm").val().length > 15) {
    s_alert.pop("<s:message code='storeManage.storeNm'/><s:message code='cmm.regexp' arguments='15'/>");
    return;
  }
  if($("#srchBizNo").val().length > 15) {
    s_alert.pop("<s:message code='hqManage.bizNo'/><s:message code='cmm.regexp' arguments='15'/>");
    return;
  }

  var param = {};

  if("${orgnFg}" == "MASTER") {
    param.hqOfficeCd = $("#srchHqOfficeCd").val();
    param.hqOfficeNm = $("#srchHqOfficeNm").val();
  } else if("${orgnFg}" == "HQ") {
    param.hqOfficeCd = "${hqOfficeCd}";
    param.hqOfficeNm = "";
  }

  param.storeCd = $("#srchStoreCd").val();
  param.storeNm = $("#srchStoreNm").val();
  param.bizNo = $("#srchBizNo").val();
  param.clsFg = srchClsFg.selectedValue;
  param.sysStatFg = srchSysStatFg.selectedValue;
  param.listScale   = listScaleBox.selectedValue;
  param.curr        = index;

  //console.log(param)

  $.postJSON("/store/manage/storeManage/storeManage/getStoreList.sb", param, function(result) {

    if(result.status === "FAIL") {
      s_alert.pop(result.message);
      return;
    }

    var list = result.data.list;

    console.log(list);

    if(list.length === undefined || list.length == 0) {
      s_alert.pop(result.message);
      grid.itemsSource = new wijmo.collections.CollectionView([]);
      return;
    }

    grid.itemsSource = new wijmo.collections.CollectionView(list, {
      groupDescriptions : [ 'hqOfficeCdNm']
    });

    grid.collapseGroupsToLevel(1);

    <%-- 매장 없는 본사 merge --%>
    for(var i=0; i<grid.itemsSource.items.length; i++){
      if(grid.itemsSource.items[i].storeNm == null) {
        grid.itemsSource.items[i].storeNm = "<s:message code='storeManage.require.regist.store2'/>";
        grid.itemsSource.items[i].storeCd = "<s:message code='storeManage.require.regist.store2'/>";
        grid.itemsSource.items[i].clsFg = "<s:message code='storeManage.require.regist.store2'/>";
        grid.itemsSource.items[i].sysOpenDate = "";
      }
    }

    for(var i=0; i<grid.rows.length; i++) {
     if(grid.rows[i].dataItem.storeNm) {
       grid.rows[i].allowMerging = true;
     }
    }

    <%-- 그리드 선택 이벤트 --%>
    grid.addEventListener(grid.hostElement, 'mousedown', function(e) {
      var ht = grid.hitTest(e);
      if(ht.panel == grid.cells) {
        if (grid.rows[ht.row] instanceof wijmo.grid.GroupRow) {
          var hdOfficeInfo = grid.rows[ht.row].dataItem.items[0];
          newStoreReg(hdOfficeInfo);
        } else {
          var col = ht.panel.columns[ht.col];
          if( col.binding == "storeNm") {
            if(grid.rows[ht.row].dataItem.storeCd != "<s:message code='storeManage.require.regist.store2'/>") {
              selectedStore = grid.rows[ht.row].dataItem;
              showDetail();
            }
          }
        }
      }
    });

    page.make("#page", result.data.page.curr, result.data.page.totalPage);

    $("#noDataArea").show();
    $("#storeInfoViewArea").hide();
    $("#storeEnvInfoArea").hide();
  }
  ,function(){
    s_alert.pop("Ajax Fail");
  });
}

  <%-- 매장 선택시, 상세 정보 조회 --%>
  function showDetail() {
    $("#noDataArea").hide();
    $("#storeEnvInfoArea").hide();
    showStoreDetail();
  }

</script>

<%-- 매장환경조회 팝업 --%>
<c:import url="/WEB-INF/view/store/manage/storeManage/storeEnvSearch.jsp">
  <c:param name="menuCd" value="${menuCd}"/>
  <c:param name="menuNm" value="${menuNm}"/>
</c:import>

<%-- 사업자번호 사용현황 레이어 팝업 --%>
<c:import url="/WEB-INF/view/store/hq/hqManage/bizInfo.jsp">
  <c:param name="menuCd" value="${menuCd}"/>
  <c:param name="menuNm" value="${menuNm}"/>
</c:import>

<%-- 포스 환경설정 : 테이블 그룹셋팅 레이어팝업 --%>
<c:import url="/WEB-INF/view/store/manage/storeManage/storeTabGrpSetting.jsp">
  <c:param name="menuCd" value="${menuCd}"/>
  <c:param name="menuNm" value="${menuNm}"/>
</c:import>

<%-- 포스 환경설정 : 테이블 명칭설정 레이어팝업 --%>
<c:import url="/WEB-INF/view/store/manage/storeManage/storePosNmSetting.jsp">
  <c:param name="menuCd" value="${menuCd}"/>
  <c:param name="menuNm" value="${menuNm}"/>
</c:import>

<%-- 포스 환경설정 : 테이블 설정복사 레이어팝업 --%>
<c:import url="/WEB-INF/view/store/manage/storeManage/posSettingCopy.jsp">
  <c:param name="menuCd" value="${menuCd}"/>
  <c:param name="menuNm" value="${menuNm}"/>
</c:import>

