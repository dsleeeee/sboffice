<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix="f" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var="orgnFg" value="${sessionScope.sessionInfo.orgnFg}" />

<wj-popup id="wjProductDtlLayer" control="wjProductDtlLayer" show-trigger="Click" hide-trigger="Click" style="display:none;width:900px;">
    <div id="productDtlLayer" class="wj-dialog wj-dialog-columns title" ng-controller="productDtlCtrl">

        <%-- header --%>
        <div class="wj-dialog-header wj-dialog-header-font">
            <label id="popDtlTitle"></label>&nbsp;<s:message code="product.prodList"/>
            <a href="" class="wj-hide btn_close" ng-click="closeDtl()"></a>
        </div>

        <div class="wj-dialog-body sc2" style="height: 600px;">
            <label id="lblPDProductDateTitle" class="s14 bk mb5 fl"></label>
            <table class="tblType01" style="position: relative;">
                <colgroup>
                    <col class="w15"/>
                    <col class="w35"/>
                    <col class="w15"/>
                    <col class="w35"/>
                </colgroup>
                <tbody>
                    <tr>
                        <%-- 생산등록/폐기등록 제목 --%>
                        <th><label id="lblPDTitleTitle"></label><em class="imp">*</em></th>
                        <td colspan="3">
                          <input type="text" id="txtPDTitle" ng-model="txtPDTitle" class="sb-input w100" maxlength="33"/>
                        </td>
                    </tr>
                </tbody>
            </table>

            <ul class="txtSty3 mt10">
                <li class="red"><s:message code="product.dtl.txt1"/></li>
            </ul>

            <div class="mt20 tr">
                <%-- 상품추가 --%>
                <button type="button" class="btn_skyblue ml5" id="btnDtlAddProd" ng-click="addProd()" ng-if="btnDtlAddProd">
                  <s:message code="adj.dtl.addProd"/></button>
                <%-- 저장 --%>
                <button type="button" class="btn_skyblue ml5" id="btnDtlSave" ng-click="saveProductDtl('')" ng-if="btnDtlSave">
                  <s:message code="cmm.save"/></button>
                <%-- 확정 --%>
                <button type="button" class="btn_skyblue ml5" id="btnDtlConfirm" ng-click="confirmProduct()" ng-if="btnDtlConfirm">
                  <s:message code="adj.dtl.confirm"/></button>
            </div>

            <div class="w100 mt10 mb20">
               <%--위즈모 테이블--%>
               <div class="wj-gridWrap" style="height: 400px; overflow-x: hidden; overflow-y: hidden;">
                   <wj-flex-grid
                           autoGenerateColumns="false"
                           selection-mode="Row"
                           items-source="data"
                           control="flex"
                           initialized="initGrid(s,e)"
                           is-read-only="false"
                           item-formatter="_itemFormatter"
                           ime-enabled="true">

                         <!-- define columns -->
                         <wj-flex-grid-column header="<s:message code="cmm.chk"/>" binding="gChk" width="30" align="center"></wj-flex-grid-column>
                         <wj-flex-grid-column header="<s:message code="product.prodCd"/>" binding="prodCd" width="100" align="center" is-read-only="true"></wj-flex-grid-column>
                         <wj-flex-grid-column header="<s:message code="product.prodNm"/>" binding="prodNm" width="150" align="left" is-read-only="true"></wj-flex-grid-column>
                         <wj-flex-grid-column header="<s:message code="product.barcdCd"/>" binding="barcdCd" width="100" align="center" is-read-only="true"></wj-flex-grid-column>
                         <wj-flex-grid-column header="<s:message code="product.saleUprc"/>" binding="saleUprc" width="70" align="right" is-read-only="true"></wj-flex-grid-column>
                         <wj-flex-grid-column header="<s:message code="product.costUprc"/>" binding="costUprc" width="70" align="right" is-read-only="true"></wj-flex-grid-column>
                         <wj-flex-grid-column header="<s:message code="product.poUnitQty"/>" binding="poUnitQty" width="70" align="right" is-read-only="true"></wj-flex-grid-column>
                         <wj-flex-grid-column header="<s:message code="product.currQty"/>" binding="currQty" width="70" align="right" is-read-only="true"></wj-flex-grid-column>

                         <wj-flex-grid-column header="<s:message code="product.productWeight"/>" binding="productWeight" width="100" align="right" max-length=8 data-type="Number" format="n0" aggregate="Sum"></wj-flex-grid-column>
                         <wj-flex-grid-column header="<s:message code="product.productSaleUprc"/>" binding="productSaleUprc" width="100" align="right" max-length=8 data-type="Number" format="n0" aggregate="Sum"></wj-flex-grid-column>
                         <wj-flex-grid-column header="<s:message code="product.productQty"/>" binding="productQty" width="100" align="right" max-length=8 data-type="Number" format="n0" aggregate="Sum"></wj-flex-grid-column>
                         <wj-flex-grid-column header="<s:message code="product.productAmt"/>" binding="productAmt" width="100" align="right" is-read-only="true" aggregate="Sum"></wj-flex-grid-column>
                         <wj-flex-grid-column header="<s:message code="product.remark"/>" binding="remark" width="200" align="left" max-length=300></wj-flex-grid-column>
                         <wj-flex-grid-column header="<s:message code="product.prodStatus"/>" binding="productProdStatus" width="0" align="center" is-read-only="true" visible="false"></wj-flex-grid-column>

                     </wj-flex-grid>
               </div>
               <%--//위즈모 테이블--%>
            </div>

            <%-- 페이지 리스트 --%>
              <div class="pageNum mt20">
                <%-- id --%>
                <ul id="productDtlCtrlPager" data-size="10">
                </ul>
              </div>
            <%--//페이지 리스트--%>

            <input type="hidden" id="hdDtlProductDate" />
            <input type="hidden" id="hdDtlProductFg" />
            <input type="hidden" id="hdDtlSeqNo" />

        </div>
    </div>
</wj-popup>

<script type="text/javascript">
    var orgnFg = "${orgnFg}";

    // POS에서 접속한 경우, 왼쪽 메뉴영역은 접어두기.
    var referrer = document.referrer;
    if(referrer.indexOf("userId") > 0 && referrer.indexOf("resrceCd") > 0 && referrer.indexOf("accessCd") ){
        $(".menuControl").trigger("click");
    }

</script>

<script type="text/javascript" src="/resource/solbipos/js/stock/product/product/productDtl.js?ver=20220706.01" charset="utf-8"></script>