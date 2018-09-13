<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix="f" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
#group div {
    font-family:inherit;
    font-weight:inherit;
    font-size:inherit;
    color:inherit;
}
#prod div {
    font-family:inherit;
    font-weight:inherit;
    font-size:inherit;
    color:inherit;
}
</style>
<script>
var urlParams = (function(url) {
  var result = new Object();
  var idx = url.lastIndexOf('?');

  if (idx > 0) {
    var params = url.substring(idx + 1).split('&');

    for (var i = 0; i < params.length; i++) {
      idx = params[i].indexOf('=');

      if (idx > 0) {
        result[params[i].substring(0, idx)] = params[i].substring(idx + 1);
      }
    }
  }

  return result;
})(window.location.href);

// Default resources are included in grapheditor resources
mxLoadResources = false;

// urlParams is null when used for embedding
window.urlParams = window.urlParams || {};

window.MAX_REQUEST_SIZE = window.MAX_REQUEST_SIZE  || 10485760;

window.RESOURCES_PATH = window.RESOURCES_PATH || '/resource/graph/resources';
window.RESOURCE_BASE = window.RESOURCE_BASE || window.RESOURCES_PATH + '/message';
window.STYLE_PATH = window.STYLE_PATH || '/resource/graph/styles';
window.CSS_PATH = window.CSS_PATH || '/resource/graph/styles';
window.IMAGE_PATH = window.IMAGE_PATH || '/resource/graph/images';
//window.CONFIG_PATH = window.CONFIG_PATH || '/resource/graph/config';

window.TOUCHKEY_OPEN_URL = window.TOUCHKEY_OPEN_URL || '/base/prod/touchKey/touchKey/list.sb';
window.TOUCHKEY_SAVE_URL = window.TOUCHKEY_SAVE_URL || '/base/prod/touchKey/touchKey/save.sb';

window.mxBasePath = window.mxBasePath || '/resource/vendor/mxgraph/src';
window.mxLanguage = window.mxLanguage || urlParams['lang'];
window.mxLanguages = window.mxLanguages || ['ko'];

window.PRODS = ${prods};

window.MAX_GROUP_ROW = '${maxGroupRow}' || '2';

</script>
<script type="text/javascript" src="/resource/vendor/mxgraph/mxClient.js" charset="utf-8"></script>
<!--script type="text/javascript" src="/resource/vendor/mxgraph/mxClient.min.js"></script-->
<script type="text/javascript" src="/resource/graph/sanitizer/sanitizer.min.js" charset="utf-8"></script>
<script type="text/javascript" src="/resource/graph/js/TouchKey.js" charset="utf-8"></script>
<script type="text/javascript" src="/resource/graph/js/TouchKeyGroup.js" charset="utf-8"></script>
<script type="text/javascript" src="/resource/graph/js/TouchKeyButton.js" charset="utf-8"></script>

    <%--서브컨텐츠--%>
    <div class="subCon2">
      <%--테이블속성, 테이블관리, 판매터치키 page에만 쓰임--%>
      <div class="touchKeyWrap oh">
        <%--left--%>
        <div class="w30 fl">
          <%--상품--%>
          <div class="updownSet oh mb10">
            <span class="fl bk lh30"><s:message code="touchKey.class"/></span>
            <div class="txtIn">
              <div class="sb-select dkbr fl w120">
                <div id="selectClass"></div>
              </div>
            </div>
          </div>
          <div class="cfgWrap2">
            <%--위즈모 테이블--%>
            <div id="theGrid"></div>
            <%--//위즈모 테이블--%>
          </div>
          <%--//상품--%>
        </div>
        <%--//left--%>
        <%--right--%>
        <div class="w45 fl ml20">
          <%--미리보기--%>
          <div class="updownSet oh mb10">
            <span class="fl bk lh30"><s:message code="touchKey.preview"/></span>
            <button class="btn_skyblue" id="btnInit"><s:message code="cmm.init"/></button>
            <button class="btn_skyblue" id="btnSave"><s:message code="cmm.save"/></button>
          </div>
          <div class="prev2">
            <%--그룹 영역 시작--%>
            <div class="touchGroupWrap h180" id="groupWrap">
              <%--2줄 "h120", 3줄 "h180" 사용 --%>
              <div class="touchGroup h180" id="group" tabindex="-1">
                <%--터치키가 들어가는 위치 --%>
              </div>
            </div>
            <%--//그룹 영역 끝--%>
            <%--상품 영역 시작--%>
            <div class="touchProdsWrap" id="prodWrap">
              <div class="touchProds" id="prod" tabindex="-1">
                <%--터치키가 들어가는 위치 --%>
              </div>
            </div>
            <%--//상품 영역 끝--%>
          </div>
          <%--//미리보기--%>
        </div>
        <%--//right--%>
        <div class="w25 fl ml10" style="width: 120px;">
          <%-- 상단 그룹 페이지 버튼 영역 시작 --%>
          <div id="divGroupBtn" style="height: 150px;">
            <p class="touchBtn hPo1" id="groupNav">
              <a href="javascript:void(0);" class="fl" id="grp"><s:message code="cmm.pre"/></a>
              <a href="javascript:void(0);" class="fl" id="grn"><s:message code="cmm.next"/></a>
            </p>
          </div>
          <%--//상단 그룹 페이지 버튼 영역 끝 --%>
          <div class="oh mt10" id="keyStyle" style="display:none;">
            <span class="s12 fl lh30 bk"><s:message code="touchKey.font"/></span>
            <div class="sb-select txtIn fl w100">
              <div id="fontColor"></div>
            </div>
            <div class="sb-select txtIn fl w100 mt5">
              <div id="fontSize"></div>
            </div>
            <span class="s12 fl lh30 bk mt5"><s:message code="touchKey.fill"/></span>
            <div class="sb-select txtIn w100">
              <div id="fillColor"></div>
            </div>
          </div>
          <div id="divProdBtn" class="fl">
            <p class="touchBtn hPo2" id="prodNav">
              <a href="javascript:void(0);" class="fl" id="prp"><s:message code="cmm.pre"/></a>
              <a href="javascript:void(0);" class="fl" id="prn"><s:message code="cmm.next"/></a>
            </p>
          </div>
        </div>
      </div>

    </div>
    <%--//서브컨텐츠--%>

<script>
(function() {
  var touchkeyInit = Touchkey.prototype.init;
  Touchkey.prototype.init = function() {
    touchkeyInit.apply(this, arguments);
  };
  
  if (!mxClient.isBrowserSupported()) {
    // Displays an error message if the browser is not supported.
    mxUtils.error('Browser is not supported!', 200, false);
  }
  else {
    // Adds required resources (disables loading of fallback properties, this can only
    // be used if we know that all keys are defined in the language specific file)
    mxResources.loadDefaultBundle = false;
    var bundle = mxResources.getDefaultBundle(RESOURCE_BASE, mxLanguage)
        || mxResources.getSpecialBundle(RESOURCE_BASE, mxLanguage);

    // Fixes possible asynchronous requests
    mxUtils.getAll(
      [ bundle, STYLE_PATH + '/touchKey.xml' ],
      function(xhr) {
        // Adds bundle text to resources
        mxResources.parse(xhr[0].getText());

        // Configures the default graph theme
        var themes = new Object();
        themes[Graph.prototype.defaultThemeName] = xhr[1].getDocumentElement();

        // Main
        var touchkey = new Touchkey(themes);
      },
      function() {
        document.body.innerHTML = '<center style="margin-top:10%;">Error loading resource files. Please check browser console.</center>';
      });
  }
})();
</script>
