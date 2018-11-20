<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix="f" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%-- 팝업 부분 설정 - width 는 강제 해주어야함.. 해결방법? 확인 필요 : 20180829 노현수 --%>
<wj-popup control="prodDetailLayer" show-trigger="Click" hide-trigger="Click" style="display: none;width:800px;">
  <div class="wj-dialog wj-dialog-columns" ng-controller="prodDetailCtrl">
    <div class="wj-dialog-header wj-dialog-header-font">
      <s:message code="prod.layer.info"/>
      <a href="#" class="wj-hide btn_close"></a>
    </div>
    <div class="wj-dialog-body sc2" style="height: 600px;">
      <h3 class="h3_tbl brt"><s:message code="prod.title.basicInfo"/></h3>
      <div class="tblBr">
        <table class="tblType01">
          <colgroup>
            <col class="w15"/>
            <col class="w35"/>
            <col class="w15"/>
            <col class="w35"/>
          </colgroup>
          <tbody>
          <tr>
            <%-- 상품이미지 //TODO --%>
            <th rowspan="3"><s:message code="prod"/><br/><s:message code="image"/>
            </th>
            <td rowspan="3">
              <%--등록한 상품이 없는 경우--%>
              <span class="goodsNo"><s:message code="image"/> 등록 준비중 입니다</span>
              <%--등록한 상품이 있는 경우--%>
              <%--<span class="goodsYes"><img src="img/sample.jpg" alt="" /></span>--%>
            </td>
            <%--단가구분 //TODO --%>
            <th>
              <s:message code="prod.prodTypeFg"/>
            </th>
            <td>
              <wj-combo-box
                ng-model="prodDetail.prodTypeFg"
                ng-hide="true"
                text="_prodTypeFg"
                items-source="_getComboData('prodTypeFgComboData')"
                display-member-path="name"
                selected-value-path="value"
                is-editable="false">
              </wj-combo-box>
              {{_prodTypeFg}}
            </td>
          </tr>
          <tr>
            <%--상품코드--%>
            <th>
              <s:message code="prod.prodCd"/>
            </th>
            <td id="_prodCd">
              {{prodDetail.prodCd}}
            </td>
          </tr>
          <tr>
            <%--상품명--%>
            <th>
              <s:message code="prod.prodNm"/>
            </th>
            <td id="_prodNm">
              {{prodDetail.prodNm}}
            </td>
          </tr>
          <tr>
            <%--상품분류--%>
            <th><s:message code="prod.prodClass"/></th>
            <td id="_prodClassCdNm">
              {{prodDetail.prodClassCdNm}}
            </td>
            <%--거래처 //TODO --%>
            <th>
              <s:message code="prod.vendr"/>
            </th>
            <td id="_vendr">
              <s:message code="prod.vendr"/> 등록은 준비중 입니다.
            </td>
          </tr>
          <tr>
            <%--판매상품여부--%>
            <th><s:message code="prod.saleProdYn"/></th>
            <td>
              <wj-combo-box
                ng-model="prodDetail.saleProdYnNm"
                ng-hide="true"
                text="_saleProdYn"
                items-source="_getComboData('saleProdYnComboData')"
                display-member-path="name"
                selected-value-path="value"
                is-editable="false">
              </wj-combo-box>
              {{_saleProdYn}}
            </td>
            <%--원산지--%>
            <th>
              <s:message code="prod.orgplceCd"/>
            </th>
            <td id="_orgplceCd">
              <s:message code="prod.orgplceCd"/> 등록은 준비중 입니다.
            </td>
          </tr>
          <tr>
            <%--판매단가--%>
            <th>
              <s:message code="prod.saleUprc"/>
            </th>
            <td id="_saleUprc">
              {{prodDetail.saleUprc}}
            </td>
              <%-- 봉사료 포함 여부 --%>
              <th><s:message code="prod.prodTipYn"/></th>
              <td>
                <wj-combo-box
                  ng-model="prodDetail.prodTipYn"
                  ng-hide="true"
                  text="_prodTipYn"
                  items-source="_getComboData('prodTipYnComboData')"
                  display-member-path="name"
                  selected-value-path="value"
                  is-editable="false">
                </wj-combo-box>
                {{_prodTipYn}}
              </td>
          </tr>
          <tr>
            <%--과세여부--%>
            <th>
              <s:message code="prod.vatFg"/>
            </th>
            <td>
              <wj-combo-box
                ng-model="prodDetail.vatFg"
                ng-hide="true"
                text="_vatFg"
                items-source="_getComboData('vatFgComboData')"
                display-member-path="name"
                selected-value-path="value"
                is-editable="false">
              </wj-combo-box>
              {{_vatFg}}
            </td>
            <%--사용여부--%>
            <th>
              <s:message code="useYn"/>
            </th>
            <td>
              <wj-combo-box
                ng-model="prodDetail.useYn"
                ng-hide="true"
                text="_useYn"
                items-source="_getComboData('useYnComboData')"
                display-member-path="name"
                selected-value-path="value"
                is-editable="false">
              </wj-combo-box>
              {{_useYn}}
            </td>
          </tr>
          </tbody>
        </table>
      </div>
      <%-- 상품부가정보 --%>
      <h3 class="h3_tbl"><s:message code="prod.title.addInfo"/></h3>
      <div class="tblBr">
        <table class="tblType01">
          <colgroup>
            <col class="w15"/>
            <col class="w35"/>
            <col class="w15"/>
            <col class="w35"/>
          </colgroup>
          <tbody>
          <tr>
            <%--재고관리여부--%>
            <th>
              <s:message code="prod.stockProdYn"/>
            </th>
            <td>
              <wj-combo-box
                ng-model="prodDetail.stockProdYn"
                ng-hide="true"
                text="_stockProdYn"
                items-source="_getComboData('useYnComboData')"
                display-member-path="name"
                selected-value-path="value"
                is-editable="false">
              </wj-combo-box>
              {{_stockProdYn}}
            </td>
            <%--품절여부 //TODO --%>
            <th>
              <s:message code="prod.soldOutYn"/>
            </th>
            <td id="_soldOutYn">
              <%--{{prodDetail.soldOutYnNm}}--%>
            </td>
          </tr>
          <tr>
            <%--저장품코드 //TODO --%>
            <th>
              <s:message code="prod.saveProdCd"/>
            </th>
            <td><a href="#" class="link" id="_saveProdCd"></a></td>
            <%--세트상품구분//TODO --%>
            <th>
              <s:message code="prod.setProdFg"/>
            </th>
            <td>
              <wj-combo-box
                ng-model="prodDetail.setProdFg"
                ng-hide="true"
                text="_setProdFg"
                items-source="_getComboData('setProdFgComboData')"
                display-member-path="name"
                selected-value-path="value"
                is-editable="false">
              </wj-combo-box>
              {{_setProdFg}}
            </td>
          </tr>
          <tr>
            <%--사이드상품여부--%>
            <th><s:message code="prod.sideProdYn"/></th>
            <td>
              <wj-combo-box
                ng-model="prodDetail.sideProdYn"
                ng-hide="true"
                text="_sideProdYn"
                items-source="_getComboData('useYnComboData')"
                display-member-path="name"
                selected-value-path="value"
                is-editable="false">
              </wj-combo-box>
              {{_sideProdYn}}
            </td>
            <%--포인트적립여부--%>
            <th>
              <s:message code="prod.pointSaveYn"/>
            </th>
            <td>
              <wj-combo-box
                ng-model="prodDetail.pointSaveYn"
                ng-hide="true"
                text="_pointSaveYn"
                items-source="_getComboData('useYnComboData')"
                display-member-path="name"
                selected-value-path="value"
                is-editable="false">
              </wj-combo-box>
              {{_pointSaveYn}}
            </td>
          </tr>
          </tbody>
        </table>
      </div>
      <%-- 발주정보 --%>
      <h3 class="h3_tbl"><s:message code="prod.title.orderInfo"/></h3>
      <div class="tblBr">
        <table class="tblType01">
          <colgroup>
            <col class="w15"/>
            <col class="w35"/>
            <col class="w15"/>
            <col class="w35"/>
          </colgroup>
          <tbody>
          <tr>
            <%--공급단가--%>
            <th>
              <s:message code="prod.splyUprc"/>
            </th>
            <td id="_splyUprc">
              {{prodDetail.splyUprc}}
            </td>
            <%--공급단가사용여부--%>
            <th>
              <s:message code="prod.splyUprc"/><br><s:message code="cmm.useYn"/>
            </th>
            <td>
              <wj-combo-box
                ng-model="prodDetail.splyUprcUseYn"
                ng-hide="true"
                text="_splyUprcUseYn"
                items-source="_getComboData('splyUprcUseYnComboData')"
                display-member-path="name"
                selected-value-path="value"
                is-editable="false">
              </wj-combo-box>
              {{_splyUprcUseYn}}
            </td>
          </tr>
          <tr>
            <%--원가단가--%>
            <th>
              <s:message code="prod.costUprc"/>
            </th>
            <td id="_costUprc">
              {{prodDetail.costUprc}}
            </td>
            <%--최종판매단가--%>
            <th>
              <s:message code="prod.lastCostUprc"/>
            </th>
            <td id="_lastCostUprc">
              {{prodDetail.lastCostUprc}}
            </td>
          </tr>
          <tr>
            <%--주문상품구분--%>
            <th><s:message code="prod.poProdFg"/></th>
            <td>
              <wj-combo-box
                ng-model="prodDetail.poProdFg"
                ng-hide="true"
                text="_poProdFg"
                items-source="_getComboData('poProdFgComboData')"
                display-member-path="name"
                selected-value-path="value"
                is-editable="false">
              </wj-combo-box>
              {{_poProdFg}}
            </td>
            <%--주문단위--%>
            <th><s:message code="prod.poUnitFg"/></th>
            <td>
              <wj-combo-box
                ng-model="prodDetail.poUnitFg"
                ng-hide="true"
                text="_poUnitFg"
                items-source="_getComboData('poUnitFgComboData')"
                display-member-path="name"
                selected-value-path="value"
                is-editable="false">
              </wj-combo-box>
              {{_poUnitFg}}
            </td>
          </tr>
          <tr>
            <%--발주단위수량--%>
            <th><s:message code="prod.poUnitQty"/></th>
            <td>
              {{prodDetail.poUnitQty}}
            </td>
            <%--최소주문--%>
            <th><s:message code="prod.poMinQty"/></th>
            <td>
              {{prodDetail.poMinQty}}
            </td>
          </tr>
          <tr>
            <%--초기재고 //TODO --%>
            <th>
              <s:message code="prod.defaultStock"/>
            </th>
            <td id="_defaultStock">
              {{prodDetail.defaultStock}}
            </td>
            <%--안전재고--%>
            <th><s:message code="prod.safeStockQty"/></th>
            <td>
              {{prodDetail.safeStockQty}}
            </td>
          </tr>
          </tbody>
        </table>
      </div>
      <%-- 비고 --%>
      <h3 class="h3_tbl" ng-if="prodDetail.remark !== ''"><s:message code="prod.title.remark"/></h3>
      <div class="tblBr" ng-if="prodDetail.remark !== ''">
        <table class="tblType01">
          <colgroup>
            <col class="w100"/>
          </colgroup>
          <tbody>
          <tr>
            <th class="gr lh20" id="_remark">
              {{prodDetail.remark}}
            </th>
          </tr>
          </tbody>
        </table>
      </div>
      <%-- 할인/적립정보 --%>
      <h3 class="h3_tbl" ng-if="prodDetail.pointSaveYn === 'Y'"><s:message code="prod.title.dcAndSaveInfo"/></h3>
      <div class="tblBr" ng-if="prodDetail.pointSaveYn === 'Y'">
        <table class="tblType01">
          <colgroup>
            <col width="15%"/>
            <col width="85%"/>
          </colgroup>
          <tbody>
          <tr>
            <%--할인 //TODO --%>
            <th><s:message code="prod.dc"/></th>
            <td id="_dc">
              할인정보 준비중 입니다.
            </td>
          </tr>
          <tr>
            <%--적립 //TODO --%>
            <th><s:message code="prod.save"/></th>
            <td id="_save">
              적립정보 준비중 입니다.
            </td>
          </tr>
          </tbody>
        </table>
      </div>
      <%-- 연결상품정보 --%>
      <h3 class="h3_tbl"><s:message code="prod.title.unitstInfo"/></h3>
      <div class="tblBr">
        <table class="tblType01">
          <colgroup>
            <col class="w15"/>
            <col class="w85"/>
          </colgroup>
          <tbody id="_linkedProdInfo">
          <tr>
            <th class="gr lh20">
              연결상품정보 준비중 입니다.
            </th>
          </tr>
          </tbody>
        </table>
      </div>
    </div>
    <div class="wj-dialog-footer">
      <button class="btn wj-hide-apply btn_blue"><s:message code="cmm.edit"/></button>
      <button class="btn wj-hide-cancel btn_blue"><s:message code="cmm.close"/></button>
    </div>
  </div>
</wj-popup>
<script type="text/javascript" src="/resource/solbipos/js/base/prod/prod/prodDetailView.js?ver=20181120.01" charset="utf-8"></script>
