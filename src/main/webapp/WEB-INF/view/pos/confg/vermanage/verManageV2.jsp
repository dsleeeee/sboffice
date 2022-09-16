<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="f" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var="menuCd" value="${sessionScope.sessionInfo.currentMenu.resrceCd}"/>
<c:set var="menuNm" value="${sessionScope.sessionInfo.currentMenu.resrceNm}"/>
<c:set var="orgnFg" value="${sessionScope.sessionInfo.orgnFg}"/>
<c:set var="hqOfficeCd" value="${sessionScope.sessionInfo.hqOfficeCd}" />

<div class="subCon" ng-controller="verManageV2Ctrl" id="verManageV2View">
  <div class="searchBar">
    <a href="#" class="open fl">
      <c:if test="${orgnFg != 'HQ'}">${menuNm}</c:if>
      <c:if test="${orgnFg == 'HQ'}"><s:message code="verHq.verManageV2" /></c:if>
    </a>
    <%-- 조회 --%>
    <div class="mr15 fr" style="display:block;position: relative;margin-top: 6px;">
      <button class="btn_blue fr" id="btnSearch" ng-click="_pageView('verManageV2Ctrl', 1)">
        <s:message code="cmm.search" />
      </button>
    </div>
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
        <%-- 버전일련번호 --%>
        <th><s:message code="verManage.verSerNo" /></th>
        <td>
          <input type="text" id="srchVerSerNo" class="sb-input w100" ng-model="verSerNo" onkeyup="fnNxBtnSearch();" />
        </td>
        <%-- 버전적용명 --%>
        <th><s:message code="verManage.verSerNm" /></th>
        <td>
          <input type="text" id="srchVerSerNm" class="sb-input w100" ng-model="verSerNm" onkeyup="fnNxBtnSearch();" />
        </td>
      </tr>
      <tr style="display: none;">
        <%-- 프로그램구분 --%>
        <th><s:message code="verManage.progFg" /></th>
        <td>
          <div class="sb-select">
            <wj-combo-box
              id="srchProgFg"
              ng-model="progFg"
              control="srchProgFgCombo"
              items-source="_getComboData('srchProgFgCombo')"
              display-member-path="name"
              selected-value-path="value"
              is-editable="false">
            </wj-combo-box>
          </div>
        </td>
        <th>
        </th>
        <td></td>
      </tr>
    </tbody>
  </table>

  <div class="mt20 oh sb-select dkbr">

    <%-- 페이지 스케일  --%>
    <wj-combo-box
            class="w100px fl"
            id="listScaleBox"
            ng-model="listScaleVer"
            items-source="_getComboData('listScaleBox')"
            display-member-path="name"
            selected-value-path="value"
            is-editable="false"
            initialized="initComboBox(s)">
    </wj-combo-box>
    <c:if test="${orgnFg == 'MASTER'}">
      <%-- 신규버전등록 --%>
      <button class="btn_skyblue ml5 fr" id="btnRegist" ng-click="registVersion()">
        <s:message code="verManage.regist.new" />
      </button>
    </c:if>
  </div>

  <%-- 버전관리 그리드 --%>
  <div class="w100 mt10 mb20">
    <div class="wj-gridWrap" style="height:370px; overflow-x: hidden; overflow-y: hidden;">
      <wj-flex-grid
              control="flex"
              autoGenerateColumns="false"
              selection-mode="Row"
              initialized="initGrid(s,e)"
              items-source="data"
              item-formatter="_itemFormatter">

        <!-- define columns -->
        <wj-flex-grid-column header="<s:message code="cmm.chk"/>" binding="gChk" width="90" visible="false"></wj-flex-grid-column>
        <wj-flex-grid-column header="<s:message code="verManage.verSerNo"/>" binding="verSerNo" align="center" width="160" is-read-only="true"></wj-flex-grid-column>
        <wj-flex-grid-column header="<s:message code="verManage.fileDesc"/>" binding="fileDesc" align="left" width="*" is-read-only="true"></wj-flex-grid-column>
        <wj-flex-grid-column header="<s:message code="verManage.progFg"/>" binding="progFg" data-map="progFgDataMap" width="120" align="center" is-read-only="true" ></wj-flex-grid-column>
        <wj-flex-grid-column header="<s:message code="verManage.contain.pgm"/>" binding="pgmYn" data-map="containYnDataMap"  align="center" width="90" is-read-only="true"></wj-flex-grid-column>
        <wj-flex-grid-column header="<s:message code="verManage.contain.db"/>" binding="dbYn" data-map="containYnDataMap" align="center" width="90" is-read-only="true"></wj-flex-grid-column>
        <wj-flex-grid-column header="<s:message code="verManage.contain.img"/>" binding="imgYn"  data-map="containYnDataMap"  align="center" width="90" is-read-only="true"></wj-flex-grid-column>
        <wj-flex-grid-column header="<s:message code="verManage.fileSize"/>" binding="fileSize"  width="120" align="right" is-read-only="true" ></wj-flex-grid-column>
        <wj-flex-grid-column header="<s:message code="verManage.regCnt"/>" binding="regCnt" align="center" width="90"  is-read-only="true"></wj-flex-grid-column>
        <wj-flex-grid-column header="<s:message code="verManage.recvCnt"/>" binding="recvCnt" align="center" width="90"  is-read-only="true"></wj-flex-grid-column>
        <wj-flex-grid-column header="<s:message code="verManage.useYn"/>" binding="useYn" data-map="useYnDataMap" align="center" width="90"  is-read-only="true"></wj-flex-grid-column>

      </wj-flex-grid>
    </div>
  </div>

  <%-- 페이지 리스트 --%>
  <div class="pageNum mt20">
    <%-- id --%>
    <ul id="verManageV2CtrlPager" data-size="10">
    </ul>
  </div>
  <%--//페이지 리스트--%>
</div>
<script>
  var containYn   = ${ccu.getCommCodeExcpAll("058")};
  var progFg      = ${ccu.getCommCodeExcpAll("059")};
  var useYn       = ${ccu.getCommCodeExcpAll("067")};
  var clsFg       = ${ccu.getCommCodeExcpAll("059")};
  var sysStatFg   = ${ccu.getCommCodeExcpAll("005")};
  var hqList = ${ccu.getHqOfficeList()};
  var hqOfficeCd = "${hqOfficeCd}";

</script>
<script type="text/javascript" src="/resource/solbipos/js/pos/confg/verManage/verManageV2.js?ver=20220822.01" charset="utf-8"></script>

<!-- 관리자 화면인 경우만 아래 화면 import -->
<!-- 본사 화면인 경우 탭 화면으로 구성되어 있어 이미 [POS 버전관리]화면에서 import 하고 있으므로, 중복을 방지하여 오류 안나게 처리 -->
<c:if test="${orgnFg == 'MASTER'}">
  <%-- 버전 상세정보 레이어 --%>
  <c:import url="/WEB-INF/view/pos/confg/vermanage/verInfoDtl.jsp">
  </c:import>
  <%-- 매장추가 레이어 --%>
  <c:import url="/WEB-INF/view/pos/confg/vermanage/storeAdd.jsp">
  </c:import>
  <%-- 버전 등록 및 수정 --%>
  <c:import url="/WEB-INF/view/pos/confg/vermanage/verRegist.jsp">
  </c:import>
</c:if>