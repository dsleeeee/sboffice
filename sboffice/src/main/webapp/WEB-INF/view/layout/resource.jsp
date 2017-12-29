<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- <link rel="stylesheet" href="/resource/solbipos/css/ui.css" /> -->
<link rel="stylesheet" type="text/css" href="/resource/solbipos/css/core.css"/>
<link rel="stylesheet" type="text/css" href="/resource/solbipos/css/menu.css"/>
<link rel="stylesheet" type="text/css" href="/resource/solbipos/css/component.css"/>
<link rel="stylesheet" type="text/css" href="/resource/vender/wijmo/css/wijmo.min.css" />
<link rel="stylesheet" type="text/css" href="/resource/vender/awesome-font/css/font-awesome.min.css" />

<!-- <link rel="stylesheet" type="text/css" href="/resource/solbipos/css/jquery-ui.datepicker.min.css"/> -->

<c:choose>
  <c:when test="${isPopPage == true}">
<link rel="stylesheet" type="text/css" href="/resource/solbipos/css/pop_up.css"/>
  </c:when>
  <c:otherwise>
<link rel="stylesheet" type="text/css" href="/resource/solbipos/css/pages.css"/>
  </c:otherwise>
</c:choose>

<!-- <script>window.locale = "${requestScope.locale}" || "${pageContext.request.locale}";</script> -->

<script src="/resource/solbipos/js/jquery-1.11.1.min.js"></script>
<script src="/resource/solbipos/js/jquery-ui.datepicker.min.js"></script>
<script src="/resource/solbipos/js/common.js"></script>
<script src="/resource/solbipos/js/gridcomm.js"></script>

<script src="http://cdn.wijmo.com/5.latest/controls/wijmo.min.js"></script>
<script src="http://cdn.wijmo.com/5.latest/controls/wijmo.grid.min.js"></script>
<script src="http://cdn.wijmo.com/5.latest/controls/wijmo.input.min.js"></script>