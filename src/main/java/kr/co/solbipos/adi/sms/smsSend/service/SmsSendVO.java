package kr.co.solbipos.adi.sms.smsSend.service;

import kr.co.solbipos.application.common.service.PageVO;

/**
 * @Class Name : SmsSendVO.java
 * @Description : 부가서비스 > SMS관리 > SMS전송
 * @Modification Information
 * @
 * @  수정일      수정자              수정내용
 * @ ----------  ---------   -------------------------------
 * @ 2021.06.10  김설아      최초생성
 *
 * @author 솔비포스 개발본부 WEB개발팀 김설아
 * @since 2021.06.10
 * @version 1.0
 *
 *  Copyright (C) by SOLBIPOS CORP. All right reserved.
 */
public class SmsSendVO extends PageVO {

    private static final long serialVersionUID = 4567094904301269212L;

    /**
     * 소속구분
     * M : 시스템
     * A : 대리점
     * H : 본사
     * S : 매장, 가맹점
     */
    private String orgnFg;

    /** 소속코드 */
    private String orgnCd;

    /** 본사코드 */
    private String hqOfficeCd;

    /** 매장코드 */
    private String storeCd;

    /** 매장명 */
    private String storeNm;

    /** 업체코드 */
    private String agencyCd;

    /** 사용자ID */
    private String userId;

    /** 잔여수량 */
    private String smsQty;

    /** 잔여금액 */
    private String smsAmt;

    /** 제목 */
    private String title;

    /** 내용 */
    private String content;

    /** 예약여부 */
    private String reserveYn;

    /** 수신자 소속코드 */
    private String rrOrgnCd;

    /** 수신자 소속구분 */
    private String rrOrgnFg;

    /** 수신자ID */
    private String rrUserId;

    /** 송신자 소속코드 */
    private String ssOrgnCd;

    /** 송신자 소속구분 */
    private String ssOrgnFg;

    /** 송신자ID */
    private String ssUserId;

    /** 메세지타입 */
    private String msgType;

    /** 송신주체 소속코드 */
    private String smsOgnCd;

    /** 회원관리주체 소속코드 */
    private String cstOgnCd;

    /** 회원번호 */
    private String cstNo;

    /** 전송일시 */
    private String sendDate;

    /** 보내는사람 번호 */
    private String callback;

    /** 받는사람 번호 */
    private String phoneNumber;

    /** 전송할 컨텐츠 개수 */
    private String contentCount;

    /** 전송할 컨텐츠(파일명^컨텐츠타입^컨텐츠서브타입) */
    private String contentData;

    /** 사원번호 */
    private String empNo;

    /** 사원명 */
    private String empNm;

    /** 휴대폰번호 */
    private String mpNo;

    /** SMS수신여부 */
    private String smsRecvYn;

    /** 재직구분 */
    private String serviceFg;

    /** 팝업 구분 */
    private String pageGubun;

    /** 소속구분 */
    private String srchOrgnFg;

    /** 전송이력시퀀스 */
    private String smsSendSeq;

    /** 전송건수 */
    private String smsSendCount;

    /** 조회한 회원수 */
    private String smsSendListCnt;

    /** 메세지별 건당금액 */
    private String msgOneAmt;

    /** 자료생성구분 */
    private String addFg;

    /** 파일경로 */
    private String fileUrl;

    /** 파일명 */
    private String fileNm;

    /** 원본파일명 */
    private String fileOrgNm;

    /** 관리요청번호 */
    private String certId;

    /** 발신번호구분 */
    private String telFg;

    /** 신청자 구분 */
    private String addSmsFg;

    /** 신청자 이름 */
    private String addSmsUserNm;

    /** 신청자 연락처 */
    private String addSmsTelNo;

    /** 파일경로1 */
    private String fileUrl1;

    /** 파일명1 */
    private String fileNm1;

    /** 원본파일명1 */
    private String fileOrgNm1;

    /** 파일경로2 */
    private String fileUrl2;

    /** 파일명2 */
    private String fileNm2;

    /** 원본파일명2 */
    private String fileOrgNm2;

    /** 파일경로3 */
    private String fileUrl3;

    /** 파일명3 */
    private String fileNm3;

    /** 원본파일명3 */
    private String fileOrgNm3;

    public String getOrgnFg() { return orgnFg; }

    public void setOrgnFg(String orgnFg) { this.orgnFg = orgnFg; }

    public String getOrgnCd() { return orgnCd; }

    public void setOrgnCd(String orgnCd) { this.orgnCd = orgnCd; }

    public String getHqOfficeCd() { return hqOfficeCd; }

    public void setHqOfficeCd(String hqOfficeCd) { this.hqOfficeCd = hqOfficeCd; }

    public String getStoreCd() { return storeCd; }

    public void setStoreCd(String storeCd) { this.storeCd = storeCd; }

    public String getStoreNm() { return storeNm; }

    public void setStoreNm(String storeNm) { this.storeNm = storeNm; }

    public String getAgencyCd() { return agencyCd; }

    public void setAgencyCd(String agencyCd) { this.agencyCd = agencyCd; }

    public String getUserId() { return userId; }

    public void setUserId(String userId) { this.userId = userId; }

    public String getSmsQty() { return smsQty; }

    public void setSmsQty(String smsQty) {  this.smsQty = smsQty; }

    public String getSmsAmt() { return smsAmt; }

    public void setSmsAmt(String smsAmt) {  this.smsAmt = smsAmt; }

    public String getTitle() { return title; }

    public void setTitle(String title) { this.title = title; }

    public String getContent() { return content; }

    public void setContent(String content) { this.content = content; }

    public String getReserveYn() { return reserveYn; }

    public void setReserveYn(String reserveYn) { this.reserveYn = reserveYn; }

    public String getRrOrgnCd() { return rrOrgnCd; }

    public void setRrOrgnCd(String rrOrgnCd) { this.rrOrgnCd = rrOrgnCd; }

    public String getRrOrgnFg() { return rrOrgnFg; }

    public void setRrOrgnFg(String rrOrgnFg) { this.rrOrgnFg = rrOrgnFg; }

    public String getRrUserId() { return rrUserId; }

    public void setRrUserId(String rrUserId) { this.rrUserId = rrUserId; }

    public String getSsOrgnCd() { return ssOrgnCd; }

    public void setSsOrgnCd(String ssOrgnCd) { this.ssOrgnCd = ssOrgnCd; }

    public String getSsOrgnFg() { return ssOrgnFg; }

    public void setSsOrgnFg(String ssOrgnFg) { this.ssOrgnFg = ssOrgnFg; }

    public String getSsUserId() { return ssUserId; }

    public void setSsUserId(String ssUserId) { this.ssUserId = ssUserId; }

    public String getMsgType() { return msgType; }

    public void setMsgType(String msgType) { this.msgType = msgType; }

    public String getSmsOgnCd() { return smsOgnCd; }

    public void setSmsOgnCd(String smsOgnCd) { this.smsOgnCd = smsOgnCd; }

    public String getCstOgnCd() { return cstOgnCd; }

    public void setCstOgnCd(String cstOgnCd) { this.cstOgnCd = cstOgnCd; }

    public String getCstNo() { return cstNo; }

    public void setCstNo(String cstNo) { this.cstNo = cstNo; }

    public String getSendDate() { return sendDate; }

    public void setSendDate(String sendDate) { this.sendDate = sendDate; }

    public String getCallback() { return callback; }

    public void setCallback(String callback) { this.callback = callback; }

    public String getPhoneNumber() { return phoneNumber; }

    public void setPhoneNumber(String phoneNumber) { this.phoneNumber = phoneNumber; }

    public String getContentCount() { return contentCount; }

    public void setContentCount(String contentCount) { this.contentCount = contentCount; }

    public String getContentData() { return contentData; }

    public void setContentData(String contentData) { this.contentData = contentData; }

    public String getEmpNo() { return empNo; }

    public void setEmpNo(String empNo) { this.empNo = empNo; }

    public String getEmpNm() { return empNm; }

    public void setEmpNm(String empNm) { this.empNm = empNm; }

    public String getMpNo() { return mpNo; }

    public void setMpNo(String mpNo) { this.mpNo = mpNo; }

    public String getSmsRecvYn() { return smsRecvYn; }

    public void setSmsRecvYn(String smsRecvYn) { this.smsRecvYn = smsRecvYn; }

    public String getServiceFg() { return serviceFg; }

    public void setServiceFg(String serviceFg) { this.serviceFg = serviceFg; }

    public String getPageGubun() { return pageGubun; }

    public void setPageGubun(String pageGubun) { this.pageGubun = pageGubun; }

    public String getSrchOrgnFg() { return srchOrgnFg; }

    public void setSrchOrgnFg(String srchOrgnFg) { this.srchOrgnFg = srchOrgnFg; }

    public String getSmsSendSeq() { return smsSendSeq; }

    public void setSmsSendSeq(String smsSendSeq) { this.smsSendSeq = smsSendSeq; }

    public String getSmsSendCount() { return smsSendCount; }

    public void setSmsSendCount(String smsSendCount) { this.smsSendCount = smsSendCount; }

    public String getSmsSendListCnt() { return smsSendListCnt; }

    public void setSmsSendListCnt(String smsSendListCnt) { this.smsSendListCnt = smsSendListCnt; }

    public String getMsgOneAmt() { return msgOneAmt; }

    public void setMsgOneAmt(String msgOneAmt) { this.msgOneAmt = msgOneAmt; }

    public String getAddFg() { return addFg; }

    public void setAddFg(String addFg) { this.addFg = addFg; }

    public String getFileUrl() { return fileUrl; }

    public void setFileUrl(String fileUrl) { this.fileUrl = fileUrl; }

    public String getFileNm() { return fileNm; }

    public void setFileNm(String fileNm) { this.fileNm = fileNm; }

    public String getFileOrgNm() { return fileOrgNm; }

    public void setFileOrgNm(String fileOrgNm) { this.fileOrgNm = fileOrgNm; }

    public String getCertId() { return certId; }

    public void setCertId(String certId) { this.certId = certId; }

    public String getTelFg() { return telFg; }

    public void setTelFg(String telFg) { this.telFg = telFg; }

    public String getAddSmsFg() { return addSmsFg; }

    public void setAddSmsFg(String addSmsFg) { this.addSmsFg = addSmsFg; }

    public String getAddSmsUserNm() { return addSmsUserNm; }

    public void setAddSmsUserNm(String addSmsUserNm) { this.addSmsUserNm = addSmsUserNm; }

    public String getAddSmsTelNo() { return addSmsTelNo; }

    public void setAddSmsTelNo(String addSmsTelNo) { this.addSmsTelNo = addSmsTelNo; }

    public String getFileUrl1() { return fileUrl1; }

    public void setFileUrl1(String fileUrl1) { this.fileUrl1 = fileUrl1; }

    public String getFileNm1() { return fileNm1; }

    public void setFileNm1(String fileNm1) { this.fileNm1 = fileNm1; }

    public String getFileOrgNm1() { return fileOrgNm1; }

    public void setFileOrgNm1(String fileOrgNm1) { this.fileOrgNm1 = fileOrgNm1; }

    public String getFileUrl2() { return fileUrl2; }

    public void setFileUrl2(String fileUrl2) { this.fileUrl2 = fileUrl2; }

    public String getFileNm2() { return fileNm2; }

    public void setFileNm2(String fileNm2) { this.fileNm2 = fileNm2; }

    public String getFileOrgNm2() { return fileOrgNm2; }

    public void setFileOrgNm2(String fileOrgNm2) { this.fileOrgNm2 = fileOrgNm2; }

    public String getFileUrl3() { return fileUrl3; }

    public void setFileUrl3(String fileUrl3) { this.fileUrl3 = fileUrl3; }

    public String getFileNm3() { return fileNm3; }

    public void setFileNm3(String fileNm3) { this.fileNm3 = fileNm3; }

    public String getFileOrgNm3() { return fileOrgNm3; }

    public void setFileOrgNm3(String fileOrgNm3) { this.fileOrgNm3 = fileOrgNm3; }
}