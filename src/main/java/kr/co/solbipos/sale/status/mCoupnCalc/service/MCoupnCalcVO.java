package kr.co.solbipos.sale.status.mCoupnCalc.service;

import kr.co.solbipos.application.common.service.PageVO;

/**
 * @Class Name : MCoupnCalcVO.java
 * @Description : 맘스터치 > 매출분석2 > 모바일쿠폰 정산
 * @Modification Information
 * @
 * @  수정일      수정자              수정내용
 * @ ----------  ---------   -------------------------------
 * @ 2023.07.18  이다솜      최초생성
 *
 * @author 솔비포스 개발본부 WEB개발팀 이다솜
 * @since 2023.07.18
 * @version 1.0
 *
 *  Copyright (C) by SOLBIPOS CORP. All right reserved.
 */
public class MCoupnCalcVO extends PageVO {

    private static final long serialVersionUID = 7052153185756387887L;

    /**
     * 소속구분
     * M : 시스템
     * A : 대리점
     * H : 본사
     * S : 매장, 가맹점
     */
    private String orgnFg;

    /** 본사코드 */
    private String hqOfficeCd;

    /** 매장코드 */
    private String storeCd;

    /** 매장코드 */
    private String[] storeCdList;

    /** 조회매장 */
    private String storeCds;

    /** 팀별 */
    private String momsTeam;

    /** AC점포별 */
    private String momsAcShop;

    /** 지역구분 */
    private String momsAreaFg;

    /** 상권 */
    private String momsCommercial;

    /** 점포유형 */
    private String momsShopType;

    /** 매장관리타입 */
    private String momsStoreManageType;

    /** 그룹코드 */
    private String branchCd;

    /** 사용자별 브랜드코드 */
    private String[] userBrandList;

    /** 사용자별 브랜드코드 */
    private String userBrands;

    /** 조회 시작 일자 */
    private String startDate;

    /** 조회 종료 일자 */
    private String endDate;

    /** 매장브랜드코드 */
    private String storeHqBrandCd;

    /** 포스번호 */
    private String posNo;

    /** 모바일쿠폰 코드 */
    private String mcoupnCd;

    /** 사원번호 */
    private String empNo;

    /** 승인구분(판매구분) */
    private String saleFg;

    /** 승인처리([모바일쿠폰승인구분] 1:POS 2:CAT) */
    private String apprProcFg;

    /** 승인처리([현금영수증승인구분] 1:POS 2:CAT 3:일반) */
    private String cashBillApprProcFg;

    /** 여러 포스값 */
    private String[] arrPosNo;

    /** 매장(멀티) 조회를 위한 쿼리 문자열*/
    private String storeCdQuery;

    /** 매장그룹 */
    private String momsStoreFg01;

    public String getOrgnFg() {
        return orgnFg;
    }

    public void setOrgnFg(String orgnFg) {
        this.orgnFg = orgnFg;
    }

    public String getHqOfficeCd() {
        return hqOfficeCd;
    }

    public void setHqOfficeCd(String hqOfficeCd) {
        this.hqOfficeCd = hqOfficeCd;
    }

    public String getStoreCd() {
        return storeCd;
    }

    public void setStoreCd(String storeCd) {
        this.storeCd = storeCd;
    }

    public String[] getStoreCdList() {
        return storeCdList;
    }

    public void setStoreCdList(String[] storeCdList) {
        this.storeCdList = storeCdList;
    }

    public String getStoreCds() {
        return storeCds;
    }

    public void setStoreCds(String storeCds) {
        this.storeCds = storeCds;
    }

    public String getMomsTeam() {
        return momsTeam;
    }

    public void setMomsTeam(String momsTeam) {
        this.momsTeam = momsTeam;
    }

    public String getMomsAcShop() {
        return momsAcShop;
    }

    public void setMomsAcShop(String momsAcShop) {
        this.momsAcShop = momsAcShop;
    }

    public String getMomsAreaFg() {
        return momsAreaFg;
    }

    public void setMomsAreaFg(String momsAreaFg) {
        this.momsAreaFg = momsAreaFg;
    }

    public String getMomsCommercial() {
        return momsCommercial;
    }

    public void setMomsCommercial(String momsCommercial) {
        this.momsCommercial = momsCommercial;
    }

    public String getMomsShopType() {
        return momsShopType;
    }

    public void setMomsShopType(String momsShopType) {
        this.momsShopType = momsShopType;
    }

    public String getMomsStoreManageType() {
        return momsStoreManageType;
    }

    public void setMomsStoreManageType(String momsStoreManageType) {
        this.momsStoreManageType = momsStoreManageType;
    }

    public String getBranchCd() {
        return branchCd;
    }

    public void setBranchCd(String branchCd) {
        this.branchCd = branchCd;
    }

    public String[] getUserBrandList() {
        return userBrandList;
    }

    public void setUserBrandList(String[] userBrandList) {
        this.userBrandList = userBrandList;
    }

    public String getUserBrands() {
        return userBrands;
    }

    public void setUserBrands(String userBrands) {
        this.userBrands = userBrands;
    }

    @Override
    public String getStartDate() {
        return startDate;
    }

    @Override
    public void setStartDate(String startDate) {
        this.startDate = startDate;
    }

    @Override
    public String getEndDate() {
        return endDate;
    }

    @Override
    public void setEndDate(String endDate) {
        this.endDate = endDate;
    }

    public String getStoreHqBrandCd() {
        return storeHqBrandCd;
    }

    public void setStoreHqBrandCd(String storeHqBrandCd) {
        this.storeHqBrandCd = storeHqBrandCd;
    }

    public String getPosNo() {
        return posNo;
    }

    public void setPosNo(String posNo) {
        this.posNo = posNo;
    }

    public String getMcoupnCd() {
        return mcoupnCd;
    }

    public void setMcoupnCd(String mcoupnCd) {
        this.mcoupnCd = mcoupnCd;
    }

    public String getEmpNo() {
        return empNo;
    }

    public void setEmpNo(String empNo) {
        this.empNo = empNo;
    }

    public String getSaleFg() {
        return saleFg;
    }

    public void setSaleFg(String saleFg) {
        this.saleFg = saleFg;
    }

    public String getApprProcFg() {
        return apprProcFg;
    }

    public void setApprProcFg(String apprProcFg) {
        this.apprProcFg = apprProcFg;
    }

    public String getCashBillApprProcFg() {
        return cashBillApprProcFg;
    }

    public void setCashBillApprProcFg(String cashBillApprProcFg) {
        this.cashBillApprProcFg = cashBillApprProcFg;
    }

    public String[] getArrPosNo() {
        return arrPosNo;
    }

    public void setArrPosNo(String[] arrPosNo) {
        this.arrPosNo = arrPosNo;
    }

    public String getStoreCdQuery() {
        return storeCdQuery;
    }

    public void setStoreCdQuery(String storeCdQuery) {
        this.storeCdQuery = storeCdQuery;
    }

    public String getMomsStoreFg01() { return momsStoreFg01; }

    public void setMomsStoreFg01(String momsStoreFg01) { this.momsStoreFg01 = momsStoreFg01; }
}
