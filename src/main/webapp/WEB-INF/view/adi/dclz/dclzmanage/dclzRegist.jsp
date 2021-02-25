<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var="orgnFg" value="${sessionScope.sessionInfo.orgnFg}" />
<c:set var="empList" value="${empList}" />

<wj-popup control="wjDclzRegistLayer" show-trigger="Click" hide-trigger="Click" style="display: none;width:750px;">
    <div class="wj-dialog wj-dialog-columns title" ng-controller="dclzRegistCtrl">

        <%-- header --%>
        <div class="wj-dialog-header wj-dialog-header-font">
            <s:message code="dclzManage.reg.nm" />
            <a href="#" class="wj-hide btn_close" ng-click="close()"></a>
        </div>

        <%-- body --%>
        <div class="wj-dialog-body">
            <div>
                <table class="tblType01">
                    <colgroup>
                        <col class="w25" />
                        <col class="w75" />
                    </colgroup>
                    <tbody>
                    <%-- 영업일자 --%>
                    <tr>
                        <th><s:message code="dclzManage.sale.date" /></th>
                        <td>
                            <div class="sb-select">
                                <span class="txtIn"><input id="saleDate" ng-model="saleDate" class="w120px"></span>
                            </div>
                        </td>
                    </tr>
                    <%-- 사원 --%>
                    <tr>
                        <th><s:message code="dclzManage.empNm" /></th>
                        <td>
                            <div class="sb-select fl w180px">
                                <wj-combo-box
                                        id="empNo"
                                        ng-model="empNo"
                                        items-source="_getComboData('empNoCombo')"
                                        display-member-path="name"
                                        selected-value-path="value"
                                        is-editable="false"
                                        initialized="_initComboBox(s)"
                                        control="empNoCombo">
                                </wj-combo-box>
                            </div>
                        </td>
                    </tr>
                    <%-- 출근일시 --%>
                    <tr>
                        <th><s:message code="dclzManage.empin" /></th>
                        <td>
                            <div class="sb-select fl" style="padding-right: 10px;">
                                <span class="txtIn"><input id="empInDt" class="w120px"></span>
                            </div>
                            <div class="sb-select fl" style="width:65px;">
                                <wj-combo-box
                                        id="empInDtHh"
                                        ng-model="empInDtHh"
                                        items-source="_getComboData('empInDtHhCombo')"
                                        display-member-path="name"
                                        selected-value-path="value"
                                        is-editable="false"
                                        control="empInDtHhCombo"
                                        initialized="_initComboBox(s)">
                                </wj-combo-box>
                            </div>
                            <div class="fl pd5" style="padding-right: 15px;">
                                <label>시 </label>
                            </div>
                            <div class="sb-select fl" style="width:65px;">
                                <wj-combo-box
                                        id="empInDtMm"
                                        ng-model="empInDtMm"
                                        items-source="_getComboData('empInDtMmCombo')"
                                        display-member-path="name"
                                        selected-value-path="value"
                                        is-editable="false"
                                        control="empInDtMmCombo"
                                        initialized="_initComboBox(s)">
                                </wj-combo-box>
                            </div>
                            <div class="fl pd5" style="padding-right: 15px;">
                                <label>분 </label>
                            </div>
                            <div class="sb-select fl" style="width:65px;">
                                <wj-combo-box
                                        id="empInDtSs"
                                        ng-model="empInDtSs"
                                        items-source="_getComboData('empInDtSsCombo')"
                                        display-member-path="name"
                                        selected-value-path="value"
                                        is-editable="false"
                                        control="empInDtSsCombo"
                                        initialized="_initComboBox(s)">
                                </wj-combo-box>
                            </div>
                            <div class="fl pd5" style="padding-right: 15px;">
                                <label>초 </label>
                            </div>
                        </td>
                    </tr>
                    <%-- 퇴근일시 --%>
                    <tr>
                        <th><s:message code="dclzManage.empout" /></th>
                        <td>
                            <div class="sb-select fl" style="padding-right: 10px;">
                                <span class="txtIn"><input id="empOutDt" class="w120px"></span>
                            </div>
                            <div class="sb-select fl" style="width:65px;">
                                <wj-combo-box
                                        id="empOutDtHh"
                                        ng-model="empOutDtHh"
                                        items-source="_getComboData('empOutDtHhCombo')"
                                        display-member-path="name"
                                        selected-value-path="value"
                                        is-editable="false"
                                        control="empOutDtHhCombo"
                                        initialized="_initComboBox(s)">
                                </wj-combo-box>
                            </div>
                            <div class="fl pd5" style="padding-right: 15px;">
                                <label>시 </label>
                            </div>
                            <div class="sb-select fl" style="width:65px;">
                                <wj-combo-box
                                        id="empOutDtMm"
                                        ng-model="empOutDtMm"
                                        items-source="_getComboData('empOutDtMmCombo')"
                                        display-member-path="name"
                                        selected-value-path="value"
                                        is-editable="false"
                                        control="empOutDtMmCombo"
                                        initialized="_initComboBox(s)">
                                </wj-combo-box>
                            </div>
                            <div class="fl pd5" style="padding-right: 15px;">
                                <label>분 </label>
                            </div>
                            <div class="sb-select fl" style="width:65px;">
                                <wj-combo-box
                                        id="empOutDtSs"
                                        ng-model="empOutDtSs"
                                        items-source="_getComboData('empOutDtSsCombo')"
                                        display-member-path="name"
                                        selected-value-path="value"
                                        is-editable="false"
                                        control="empOutDtSsCombo"
                                        initialized="_initComboBox(s)">
                                </wj-combo-box>
                            </div>
                            <div class="fl pd5" style="padding-right: 15px;">
                                <label>초 </label>
                            </div>
                        </td>
                    </tr>
                    <%-- 비고 --%>
                    <tr>
                        <th><s:message code="dclzManage.remark" /></th>
                        <td>
                            <input type="text" id="remark" ng-model="remark" class="sb-input w100" />
                        </td>
                    </tr>
                    </tbody>
                </table>
            </div>
            <%-- 버튼 영역 --%>
            <div class="btnSet2">
                <span><a href="#" class="btn_blue" id="btnReg" ng-click="regist()"><s:message code="cmm.save" /></a></span>
                <span><a href="#" class="btn_blue" id="btnDel" ng-click="delete()"><s:message code="cmm.del" /></a></span>
                <span><a href="#" class="btn_blue" id="btnClose" ng-click="close()"><s:message code="cmm.close" /></a></span>
            </div>
            <%-- hidden value 영역 --%>
            <input type="hidden" id="hdStoreCd" />
            <input type="hidden" id="hdEmpInDate" />
            <input type="hidden" id="hdInFg" />
            <input type="hidden" id="saveType" />
        </div>
    </div>
</wj-popup>

<script type="text/javascript">
    var orgnFg = "${orgnFg}";
    var empList = ${empList};
</script>

<script type="text/javascript" src="/resource/solbipos/js/adi/dclz/dclzmanage/dclzRegist.js?ver=20210210.10" charset="utf-8"></script>