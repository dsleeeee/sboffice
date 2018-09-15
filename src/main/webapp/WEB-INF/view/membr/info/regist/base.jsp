<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="f" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%--right--%>
<div class="w50 fr">
  <div class="wj-TblWrapBr ml10 pd20" style="height:700px;">
    <%-- 선택 정보 --%>
    <h3 class="h3_tbl2 lh30">
      <label id="membrNoNm"></label>
      <%-- 버튼 --%>
      <span class="fr">
        <a href="javascript:;" class="btn_grayS" id="btnNew"><s:message code="webMenu.new"/></a>
        <a href="javascript:;" class="btn_grayS" id="btnDel"><s:message code="cmm.delete"/></a>
        <a href="javascript:;" class="btn_grayS" id="btnSave"><s:message code="cmm.save"/></a>
      </span>
    </h3>
    </br>
    <%-- tab --%>
    <ul class="subTab">
      <li><a href="javascript:;" id="btnInfo" class="on"><s:message code="regist.info"/></a></li>
      <%--<li><a href="javascript:;" id="btnCard"><s:message code="regist.membr.card"/></a></li>--%>
    </ul>
  <%--XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX--%>
  <%--XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX--%>
<<<<<<< HEAD
    <table class="searchTbl2" id="basicInfrm" style="display:none;">
=======
    <table class="searchTbl2" id="baseInfrm" style="display:none;">
>>>>>>> refs/heads/master
      <colgroup>
        <col class="w15" />
        <col class="w35" />
        <col class="w15" />
        <col class="w35" />
      </colgroup>
      <input type="hidden" id="vMembrOrgnCd" />
      <tbody>
        <tr>
          <%-- 회원번호 --%>
          <th><s:message code="regist.membr.no"/><em class="imp">*</em></th>
          <td colspan="3">
            <div class="sb-select">
              <div id="vMembrNo"></div>
            </div>
          </td>
        </tr>
        <tr>
          <%-- 회원명 --%>
          <th><s:message code="regist.membr.nm"/><em class="imp">*</em></th>
          <td>
            <div class="sb-select">
              <div id="vMembrNm"></div>
            </div>
          </td>
          <%-- 회원명(영문) --%>
          <th><s:message code="regist.membr.nm.eng"/></th>
          <td>
            <div class="sb-select">
              <div id="vMembrNmEng"></div>
            </div>
          </td>
        </tr>
        <tr>
          <%-- 등록매장 --%>
          <th><s:message code="regist.reg.store.cd"/><em class="imp">*</em></th>
          <td>
            <div class="sb-select">
              <div id="vRegStore"></div>
            </div>
          </td>
          <%-- 회원등급분류 --%>
          <%--<th><s:message code="regist.membr.class"/><em class="imp">*</em></th>
          <td>
            <div class="sb-select">
              <div id="vClassCd"></div>
            </div>
          </td>--%>
          <th></th><td></td>
        </tr>
        <tr>
          <%-- 회원카드번호 --%>
          <th><s:message code="regist.membr.card.no"/></th>
          <td>
            <div class="sb-select">
              <div id="vMembrCardNo"></div>
            </div>
          </td>
          <%-- 성별 --%>
          <th><s:message code="regist.gender"/></th>
          <td>
            <div class="sb-select">
              <div id="vGender"></div>
            </div>
          </td>
        </tr>
        <tr>
          <%-- 결혼유무 --%>
          <th><s:message code="regist.wedding"/></th>
          <td>
            <div class="sb-select">
              <div id="vWedding"></div>
            </div>
          </td>
          <%-- 생일 --%>
          <th><s:message code="regist.brthd"/></th>
          <td>
            <div class="sb-select">
              <span class="txtIn">
              <div id="vBrthdDt"></div>
              </span>
              </span>
            </div>
          </td>
        </tr>
        <tr>
          <%-- 전화번호 --%>
          <th><s:message code="regist.tel"/></th>
          <td>
            <div class="sb-select">
              <div id="vTel"></div>
            </div>
          </td>
          <%-- 사용유무 --%>
          <th><s:message code="cmm.useYn"/><em class="imp">*</em></th>
          <td>
            <div class="sb-select">
              <div id="vUseYn"></div>
            </div>
          </td>
        </tr>
        <tr>
          <%-- E-Mail --%>
          <th>E-Mail</th>
          <td colspan="3">
            <div class="sb-select">
              <div id="vEmail"></div>
            </div>
          </td>
        </tr>
        <tr>
          <%-- 주소 --%>
          <th><s:message code="cmm.addr"/></th>
          <td colspan="3">
            <%--우편번호찾기 버튼--%>
            <a href="javascript:;" class="btn_grayS ml5 fl">
              <s:message code="cmm.zip.find"/>
            </a>
            <div class="sb-select w50">
              <div id="vAddr1"></div>
            </div>
            </br>
            <div class="sb-select">
              <div id="vAddr2"></div>
            </div>
          </td>
        </tr>
        <tr>
          <%-- 이메일 수신 --%>
          <th><s:message code="regist.email.recv"/><em class="imp">*</em></th>
          <td>
            <div class="sb-select">
              <div id="vEmailRecv"></div>
            </div>
          </td>
          <%-- SMS 수신 --%>
          <th><s:message code="regist.sms.recv"/><em class="imp">*</em></th>
          <td>
            <div class="sb-select">
              <div id="vSmsRecv"></div>
            </div>
          </td>
        </tr>
        <tr>
          <%-- 비고 --%>
          <th><s:message code="cmm.remark"/></th>
          <td colspan="3">
            <div class="sb-select">
              <div id="vRemark"></div>
            </div>
          </td>
        </tr>
      </tbody>
    </table>
  <%--XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX--%>
  <%--XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX--%>
  <table class="searchTbl2" id="membrCardInfo" style="display:none;">
    <colgroup>
      <col class="w15" />
      <col class="w35" />
      <col class="w15" />
      <col class="w35" />
    </colgroup>
    <tbody>
      <tr>
        <th>회원카드</th>
        <td colspan="3"><input type="text" class="sb-input w100" /></td>
      </tr>
    </tbody>
  </table>
  <%--XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX--%>
  <%--XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX--%>
  </div>
</div>
<%--right--%>
<script>
$(document).ready(function() {
<%--test2--%>
});
</script>