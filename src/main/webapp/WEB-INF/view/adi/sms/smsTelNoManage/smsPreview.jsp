<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="f" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<wj-popup control="wjSmsPreviewLayer" show-trigger="Click" hide-trigger="Click" style="display:none; width:600px;">

    <div class="wj-dialog wj-dialog-columns" ng-controller="smsPreviewCtrl">
        <%-- header --%>
        <div class="wj-dialog-header wj-dialog-header-font">
            <s:message code="smsPreview.info"/>
            <a href="#" class="wj-hide btn_close" ng-click="close()"></a>
        </div>

        <%-- body --%>
        <div class="wj-dialog-body">
            <%-- 이미지 --%>
            <img id="imgPreview" style="width:100%;"/>
        </div>
        <%-- //body --%>
    </div>

</wj-popup>

<script type="text/javascript" src="/resource/solbipos/js/adi/sms/smsTelNoManage/smsPreview.js?ver=20241121.01" charset="utf-8"></script>