<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%-- 왼쪽  메뉴(Tree) 의 별도 id로 셋팅을 위해 wijmo.css -> style.css 순서로 소스 순서 고정 - with Designer --%>
<link href="/resource/solbipos/css/cmm/wijmo.css" rel="stylesheet" type="text/css"/>
<link href="/resource/solbipos/css/cmm/style.css" rel="stylesheet" type="text/css" media="all"/>

<link rel="stylesheet" type="text/css" href="/resource/vender/awesome-font/css/font-awesome.min.css" />

<script src="/resource/solbipos/js/jquery-1.11.1.min.js"></script>
<script src="/resource/vender/prefixfree/prefixfree.js"></script>

<script src="/resource/vender/wijmo/js/wijmo.min.js"></script>
<script src="/resource/vender/wijmo/js/grid/wijmo.grid.min.js"></script>
<script src="/resource/vender/wijmo/js/grid/wijmo.grid.xlsx.min.js"></script>
<script src="/resource/vender/wijmo/js/output/wijmo.xlsx.min.js"></script>
<script src="/resource/vender/wijmo/js/input/wijmo.input.min.js"></script>
<script src="/resource/vender/wijmo/js/nav/wijmo.nav.min.js"></script>
<%-- wijmo xlsx 와 관련됨 --%>
<script src="/resource/vender/jszip/js/jszip.js"></script>
<script src="/resource/vender/wijmo/js/chart/wijmo.chart.js"></script>
<script src="/resource/vender/wijmo/js/chart/wijmo.chart.animation.js"></script>

<!-- <script src="/resource/vender/spin/spin.js"></script> -->

<script src="/resource/solbipos/js/common.js"></script>
<script src="/resource/solbipos/js/gridcomm.js"></script>
<script src="/resource/solbipos/js/gencomm.js"></script>
<script src="/resource/solbipos/js/alert.js"></script>
<script src="/resource/solbipos/js/paging.js"></script>

