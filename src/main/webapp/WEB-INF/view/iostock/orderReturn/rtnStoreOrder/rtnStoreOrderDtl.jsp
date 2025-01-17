<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="menuCd" value="${sessionScope.sessionInfo.currentMenu.resrceCd}"/>
<c:set var="menuNm" value="${sessionScope.sessionInfo.currentMenu.resrceNm}"/>
<c:set var="baseUrl" value="/iostock/orderReturn/rtnStoreOrder/rtnStoreOrderDtl/"/>

<wj-popup id="wjRtnStoreOrderDtlLayer" control="wjRtnStoreOrderDtlLayer" show-trigger="Click" hide-trigger="Click" style="display:none;width:1000px;height:750px;">
  <div id="rtnStoreOrderDtlLayer" class="wj-dialog wj-dialog-columns" ng-controller="rtnStoreOrderDtlCtrl">
    <div class="wj-dialog-header wj-dialog-header-font">
      <span id="spanDtlTitle"></span>
      <a href="#" class="wj-hide btn_close"></a>
    </div>
    <div class="wj-dialog-body sc2" style="height: 700px;">
      <table class="tblType01">
        <colgroup>
          <col class="w15"/>
          <col class="w35"/>
          <col class="w15"/>
          <col class="w35"/>
        </colgroup>
        <tbody>
        <tr>
          <th><s:message code="rtnStoreOrder.remark"/></th>
          <td colspan="3">
            <input type="text" id="dtlHdRemark" name="dtlHdRemark" ng-model="dtlHdRemark" class="sb-input w100"/>
          </td>
        </tr>
        </tbody>
      </table>

      <div class="tr mt10">
      	<%--출고창고 --%>
        <p class="s14 bk fl mr5 lh30" <c:if test="${storageEnvstVal == '0'}">style="display: none;"</c:if> >
          <s:message code="rtnStoreOrder.dtl.outStorage"/>
        </p>
        <span class="txtIn w150px sb-select fl mr5" <c:if test="${storageEnvstVal == '0'}">style="display: none;"</c:if> >
          <wj-combo-box
            id="saveDtlRtnOutStorageCd"
            ng-model="save.dtl.rtnOutStorageCd"
            items-source="_getComboData('saveDtlRtnOutStorageCd')"
            display-member-path="name"
            selected-value-path="value"
            is-editable="false"
            initialized="_initComboBox(s)"
            selected-index-changed="selectedIndexChanged(s)"
            >
          </wj-combo-box>
        </span>
        <p id="dtlStoreLoanInfo" class="fl s14 bk lh30"></p>
        <%-- 상품추가/변경 --%>
        <button type="button" id="btnAddProd" class="btn_skyblue ml5" ng-click="addProd()" ng-if="btnAddProd"><s:message code="rtnStoreOrder.addProd"/></button>
        <%-- 저장 --%>
        <button type="button" id="btnDtlSave" class="btn_skyblue ml5" ng-click="saveRtnStoreOrderDtl('save')" ng-if="btnDtlSave"><s:message code="cmm.save"/></button>
        <%-- 확정 --%>
        <button type="button" id="btnConfirm" class="btn_skyblue ml5" ng-click="saveRtnStoreOrderDtl('confirm')" ng-if="btnConfirm"><s:message code="rtnStoreOrder.dtl.confirm"/></button>
      </div>
      <div style="clear: both;"></div>

      <div class="w100 mt10 mb20">
        <%--위즈모 테이블--%>
        <div class="wj-gridWrap" style="height: 450px; overflow-y: hidden; overflow-x: hidden;">
          <wj-flex-grid
            autoGenerateColumns="false"
            selection-mode="Row"
            items-source="data"
            control="flex"
            initialized="initGrid(s,e)"
            is-read-only="false"
            item-formatter="_itemFormatter"
            frozen-columns="2"
            ime-enabled="true">

            <!-- define columns -->
            <wj-flex-grid-column header="<s:message code="rtnStoreOrder.dtl.prodCd"/>" 			binding="prodCd" 			width="100" align="center" 	is-read-only="true"></wj-flex-grid-column>
            <wj-flex-grid-column header="<s:message code="rtnStoreOrder.dtl.prodNm"/>" 			binding="prodNm" 			width="150" align="left" 	is-read-only="true"></wj-flex-grid-column>
            <wj-flex-grid-column header="<s:message code="rtnStoreOrder.dtl.orderSplyUprc"/>" 	binding="orderSplyUprc" 	width="60" 	align="right" 	is-read-only="true"  data-type="Number" format="n0"></wj-flex-grid-column>
            <wj-flex-grid-column header="<s:message code="rtnStoreOrder.dtl.prevOrderTotQty"/>" binding="prevOrderTotQty" 	width="60" 	align="right" 	is-read-only="true"  visible="false"></wj-flex-grid-column>
            <wj-flex-grid-column header="<s:message code="rtnStoreOrder.dtl.unitQty"/>" 		binding="orderUnitQty" 		width="60" 	align="right" 	is-read-only="false"  aggregate="Sum"></wj-flex-grid-column>
            <wj-flex-grid-column header="<s:message code="rtnStoreOrder.dtl.etcQty"/>" 			binding="orderEtcQty" 		width="60" 	align="right" 	is-read-only="false"  aggregate="Sum"></wj-flex-grid-column>
            <wj-flex-grid-column header="<s:message code="rtnStoreOrder.dtl.orderUnitQty"/>" 	binding="orderTotQty" 		width="0" 	align="right" 	is-read-only="true"  visible="false"></wj-flex-grid-column>
            <wj-flex-grid-column header="<s:message code="rtnStoreOrder.dtl.orderAmt"/>" 		binding="orderAmt" 			width="60" 	align="right" 	is-read-only="true"  data-type="Number" format="n0" aggregate="Sum"></wj-flex-grid-column>
            <wj-flex-grid-column header="<s:message code="rtnStoreOrder.dtl.orderVat"/>" 		binding="orderVat" 			width="60" 	align="right" 	is-read-only="true"  data-type="Number" format="n0" aggregate="Sum"></wj-flex-grid-column>
            <wj-flex-grid-column header="<s:message code="rtnStoreOrder.dtl.orderTot"/>" 		binding="orderTot" 			width="60" 	align="right" 	is-read-only="true"  data-type="Number" format="n0" aggregate="Sum"></wj-flex-grid-column>
            <wj-flex-grid-column header="<s:message code="rtnStoreOrder.dtl.poUnitFg"/>" 		binding="poUnitFg" 			width="60" 	align="center" 	is-read-only="true"  data-map="poUnitFgMap"></wj-flex-grid-column>
            <wj-flex-grid-column header="<s:message code="rtnStoreOrder.dtl.poUnitQty"/>" 		binding="poUnitQty" 		width="50" 	align="right" 	is-read-only="true"></wj-flex-grid-column>
            <wj-flex-grid-column header="<s:message code="rtnStoreOrder.dtl.remark"/>" 			binding="remark" 			width="150" align="left" 	max-length=300></wj-flex-grid-column>
            <wj-flex-grid-column header="<s:message code="rtnStoreOrder.dtl.poMinQty"/>" 		binding="poMinQty" 			width="0" 	align="right" 	is-read-only="true"  visible="false"></wj-flex-grid-column>
            <wj-flex-grid-column header="<s:message code="rtnStoreOrder.dtl.vatFg"/>" 			binding="vatFg01" 			width="0" 	align="right" 	is-read-only="true"  visible="false"></wj-flex-grid-column>
            <wj-flex-grid-column header="<s:message code="rtnStoreOrder.dtl.envst0011"/>" 		binding="envst0011" 		width="0" 	align="right" 	is-read-only="true"  visible="false"></wj-flex-grid-column>          

          </wj-flex-grid>
        </div>
        <%--//위즈모 테이블--%>

      </div>
    </div>
  </div>
</wj-popup>

<script type="text/javascript">
  // [1241 창고사용여부] 환경설정값
  var storageEnvstVal = "${storageEnvstVal}";
</script>

<script type="text/javascript" src="/resource/solbipos/js/iostock/orderReturn/rtnStoreOrder/rtnStoreOrderDtl.js?ver=20250102.01" charset="utf-8"></script>
