<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="f" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%-- 팝업 부분 설정 - width 는 강제 해주어야함.. 해결방법? 확인 필요 : 20180829 노현수 --%>
<wj-popup control="prodDetailLayer" show-trigger="Click" hide-trigger="Click" fade-in="false" fade-out="false" style="display: none;width:800px;">
    <div class="wj-dialog wj-dialog-columns" ng-controller="prodDetailCtrl">
        <div class="wj-dialog-header wj-dialog-header-font">
            <s:message code="prod.layer.info" />
            <a href="#" class="wj-hide btn_close"></a>
        </div>
        <div class="wj-dialog-body sc2" style="height: 600px;">
            <p class="s14 bk mb5"><s:message code="prod.basicInfo" /></p>
            <table class="tblType01">
                <colgroup>
                    <col class="w15" />
                    <col class="w35" />
                    <col class="w15" />
                    <col class="w35" />
                </colgroup>
                <tbody>
                <tr>
                    <%-- 상품이미지 //TODO --%>
                    <th rowspan="3"><s:message code="prod" /><br /><s:message code="image" />
                    </th>
                    <td rowspan="3">
                        <%--등록한 상품이 없는 경우--%>
                        <span class="goodsNo">IMAGE</span>
                        <!--
                        <span class="goodsYes"><img src="img/sample.jpg" alt="" /></span> <%--등록한 상품이 있는 경우--%>
                        -->
                    </td>
                    <%--단가구분 //TODO --%>
                    <th>
                        <s:message code="prod.prodTypeFg" /></div>
                    </th>
                    <td id="_prodTypeFgNm">
                        {{prodDetail.prodTypeFgNm}}
                    </td>
                </tr>
                <tr>
                    <%--상품코드--%>
                    <th>
                        <s:message code="prod.prodCd" /></div>
                    </th>
                    <td id="_prodCd">
                        {{prodDetail.prodCd}}
                    </td>
                </tr>
                <tr>
                    <%--상품명--%>
                    <th>
                        <s:message code="prod.prodNm" />
                    </th>
                    <td id="_prodNm">
                        {{prodDetail.prodNm}}
                    </td>
                </tr>
                <tr>
                    <%--상품분류--%>
                    <th><s:message code="prod.prodClass" /></th>
                    <td id="_prodClassCdNm">
                        {{prodDetail.prodClassCdNm}}
                    </td>
                    <%--거래처 //TODO --%>
                    <th>
                        <s:message code="prod.vendr" />
                    </th>
                    <td id="_vendr">

                    </td>
                </tr>
                <tr>
                    <%--판매상품여부--%>
                    <th><s:message code="prod.saleProdYn" /></th>
                    <td id="_saleProdYn">
                        {{prodDetail.saleProdYnNm}}
                    </td>
                    <%--원산지--%>
                    <th>
                        <s:message code="prod.orgplceCd" />
                    </th>
                    <td id="_orgplceCd">
                        {{prodDetail.orgplceCd}}
                    </td>
                </tr>
                <tr>
                    <%--최초판매단가--%>
                    <th>
                        <s:message code="prod.firstSaleUprc" />
                    </th>
                    <td id="_saleUprc">
                        {{prodDetail.saleUprc}}
                    </td>
                    <%--원가단가--%>
                    <th>
                        <s:message code="prod.costUprc" />
                    </th>
                    <td id="_costUprc">
                        {{prodDetail.costUprc}}
                    </td>
                </tr>
                <tr>
                    <%--주문상품구분--%>
                    <th>
                        <s:message code="prod.poProdFg" />
                    </th>
                    <td id="_poProdFg">
                        {{prodDetail.poProdFgNm}}
                    </td>
                    <%--주문단위--%>
                    <th>
                        <s:message code="prod.poUnitFg" />
                    </th>
                    <td id="_poUnitFg">
                        {{prodDetail.poUnitFgNm}}
                    </td>
                </tr>
                <tr>
                    <%--최소주문--%>
                    <th>
                        <s:message code="prod.poMinQty" />
                    </th>
                    <td id="_poMinQty">
                        {{prodDetail.poMinQty}}
                    </td>
                    <th></th>
                    <td></td>
                </tr>
                </tbody>
            </table>
            <p class="s14 bk mt20 mb5"><s:message code="prod.addInfo" /></p>
            <table class="tblType01">
                <colgroup>
                    <col class="w15" />
                    <col class="w35" />
                    <col class="w15" />
                    <col class="w35" />
                </colgroup>
                <tbody>
                <tr>
                    <%--과세여부--%>
                    <th>
                        <s:message code="prod.vatFg" />
                    </th>
                    <td id="_vatFg">
                        {{prodDetail.vatFgNm}}
                    </td>
                    <%--재고관리여부--%>
                    <th>
                        <s:message code="prod.stockProdYn" />
                    </th>
                    <td id="_stockProdYn">
                        {{prodDetail.stockProdYnNm}}
                    </td>
                </tr>
                <tr>
                    <%--사용여부--%>
                    <th>
                        <s:message code="useYn" />
                    </th>
                    <td id="_useYn">
                        {{prodDetail.useYnNm}}
                    </td>
                    <%--안전재고--%>
                    <th>
                        <s:message code="prod.safeStockQty" />
                    </th>
                    <td id="_safeStockQty">
                        {{prodDetail.safeStockQty}}
                    </td>
                </tr>
                <tr>
                    <%--품절여부 //TODO --%>
                    <th>
                        <s:message code="prod.soldOutYn" />
                    </th>
                    <td id="_soldOutYn">
                      {{prodDetail.soldOutYnNm}}
                    </td>
                    <%--초기재고 //TODO --%>
                    <th>
                        <s:message code="prod.defaultStock" />
                    </th>
                    <td id="_defaultStock">
                        
                    </td>
                </tr>
                <tr>
                    <%--저장품코드 //TODO --%>
                    <th>
                        <s:message code="prod.saveProdCd" />
                    </th>
                    <td><a href="#" class="link" id="_saveProdCd"></a></td>
                    <%--세트상품구분//TODO --%>
                    <th>
                        <s:message code="prod.setProdFg" />
                    </th>
                    <td id="_setProdFg">
                        {{prodDetail.setProdFgNm}}
                    </td>
                </tr>
                <tr>
                    <%--환급적용여부--%>
                    <th>
                        <s:message code="prod.refApplyYn" />
                    </th>
                    <td id="_refApplyYn">
                        {{prodDetail.refApplyYnNm}}
                    </td>
                    <th></th>
                    <td></td>
                </tr>
                </tbody>
            </table>
            <%--비고--%>
            <p class="s14 bk mt20 mb5"><s:message code="remark" /></p>
            <table class="tblType01">
                <colgroup>
                    <col class="w100" />
                </colgroup>
                <tbody>
                <tr>
                    <th class="gr lh20" id="_remark">
                        {{prodDetail.remark}}
                    </th>
                </tr>
                </tbody>
            </table>

            <%-- 할인 / 적립 --%>
            <p class="s14 bk mt20 mb5"><s:message code="prod.dcAndSaveInfo" /></p>
            <table class="tblType01">
                <colgroup>
                    <col width="15%" />
                    <col width="85%" />
                </colgroup>
                <tbody>
                <tr>
                    <%--할인 //TODO --%>
                    <th><s:message code="prod.dc" /></th>
                    <td id="_dc"></td>
                </tr>
                <tr>
                    <%--적립 //TODO --%>
                    <th><s:message code="prod.save" /></th>
                    <td id="_save"></td>
                </tr>
                </tbody>
            </table>
            <p class="s14 bk mt20 mb5"><s:message code="prod.unitstInfo" /></p>
            <table class="tblType01 mb20">
                <colgroup>
                    <col class="w15" />
                    <col class="w85" />
                </colgroup>
                <tbody id="_linkedProdInfo">
                </tbody>
            </table>
        </div>
        <div class="wj-dialog-footer">
            <button class="btn wj-hide-apply btn_blue"><s:message code="cmm.edit" /></button>
            <button class="btn wj-hide-cancel btn_blue"><s:message code="cmm.close" /></button>
        </div>
    </div>
</wj-popup>
<script type="text/javascript" src="/resource/solbipos/js/base/prod/prod/popUpProdDetail.js?ver=20181112.01" charset="utf-8"></script>
