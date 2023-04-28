<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="f" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="orgnFg" value="${sessionScope.sessionInfo.orgnFg}"/>

<style>
    table thead tr th, table tbody tr td { border:1px solid #ddd; }
</style>
<%-- 팝업 부분 설정 - width 는 강제 해주어야함.. 해결방법? 확인 필요 : 20180829 노현수 --%>
<wj-popup control="kioskKeyMapViewLayer" show-trigger="Click" hide-trigger="Click" style="display: none;width:630px;">
    <div class="wj-dialog wj-dialog-columns" ng-controller="kioskKeyMapViewCtrl">
        <div class="wj-dialog-header wj-dialog-header-font">
            <h3 class="fl" style="line-height:50px;"><s:message code="kioskKeyMap.kioskKeyMapView"/></h3>
            <a href="#" class="wj-hide btn_close"></a>
        </div>
        <div class="wj-dialog-body">

            <div class="sb-select" style="width:150px;">
                <wj-combo-box
                        id="tuClsTypeView"
                        ng-model="tuClsTypeView"
                        items-source="_getComboData('tuClsTypeView')"
                        display-member-path="name"
                        selected-value-path="value"
                        is-editable="false"
                        control="tuClsTypeViewCombo"
                        selected-index-changed="changeTuClsType(s)">
                </wj-combo-box>
            </div>

            <table class="searchTbl mt10" style="border:1px solid #ddd; background-color: #d5d5d5">
                <colgroup>
                    <col class="w5"/>
                    <col class="w22"/>
                    <col class="w22"/>
                    <col class="w22"/>
                    <col class="w22"/>
                    <col class="w5"/>
                </colgroup>
                <thead>
                <tr>
                    <th id="thPre" rowspan="2" ng-click="thPre()">◀</th>
                    <th id="th0"><div style="height:10px;width:102px;text-align:center;" id="tuCls0" ng-click="thClick('0')"></div></th>
                    <th id="th1"><div style="height:10px;width:102px;text-align:center;" id="tuCls1" ng-click="thClick('1')"></div></th>
                    <th id="th2"><div style="height:10px;width:102px;text-align:center;" id="tuCls2" ng-click="thClick('2')"></div></th>
                    <th id="th3"><div style="height:10px;width:102px;text-align:center;" id="tuCls3" ng-click="thClick('3')"></div></th>
                    <th id="thNext" rowspan="2" ng-click="thNext()">▶</th>
                </tr>
                <tr>
                    <th id="th4"><div style="height:10px;width:102px;text-align:center;" id="tuCls4" ng-click="thClick('4')"></div></th>
                    <th id="th5"><div style="height:10px;width:102px;text-align:center;" id="tuCls5" ng-click="thClick('5')"></div></th>
                    <th id="th6"><div style="height:10px;width:102px;text-align:center;" id="tuCls6" ng-click="thClick('6')"></div></th>
                    <th id="th7"><div style="height:10px;width:102px;text-align:center;" id="tuCls7" ng-click="thClick('7')"></div></th>
                </tr>
                </thead>
            </table>
            <table class="searchTbl" style="border:1px solid #ddd;">
                <colgroup>
                    <col class="w5"/>
                    <col class="w30"/>
                    <col class="w30"/>
                    <col class="w30"/>
                    <col class="w5"/>
                </colgroup>
                <tbody>
                <tr>
                    <td id="tdPre" rowspan="4" ng-click="tdPre()">◀</td>
                    <td><div style="height:120px;width:164px;text-align:center;" id="tuKey0"></div></td>
                    <td><div style="height:120px;width:164px;text-align:center;" id="tuKey1"></div></td>
                    <td><div style="height:120px;width:164px;text-align:center;" id="tuKey2"></div></td>
                    <td id="tdNext" rowspan="4" ng-click="tdNext()">▶</td>
                </tr>
                <tr>
                    <td><div style="height:120px;width:164px;text-align:center;" id="tuKey3"></div></td>
                    <td><div style="height:120px;width:164px;text-align:center;" id="tuKey4"></div></td>
                    <td><div style="height:120px;width:164px;text-align:center;" id="tuKey5"></div></td>
                </tr>
                <tr>
                    <td><div style="height:120px;width:164px;text-align:center;" id="tuKey6"></div></td>
                    <td><div style="height:120px;width:164px;text-align:center;" id="tuKey7"></div></td>
                    <td><div style="height:120px;width:164px;text-align:center;" id="tuKey8"></div></td>
                </tr>
                <tr>
                    <td><div style="height:120px;width:164px;text-align:center;" id="tuKey9"></div></td>
                    <td><div style="height:120px;width:164px;text-align:center;" id="tuKey10"></div></td>
                    <td><div style="height:120px;width:164px;text-align:center;" id="tuKey11"></div></td>
                </tr>
                </tbody>
            </table>
        </div>
    </div>
</wj-popup>
<script type="text/javascript" src="/resource/solbipos/js/base/prod/kioskKeyMap/kioskKeyMapView.js?ver=20250427.01" charset="utf-8">1</script>
