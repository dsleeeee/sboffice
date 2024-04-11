package kr.co.solbipos.base.price.splyPrice.service;

import kr.co.solbipos.application.common.service.PageVO;

/**
 * @Class Name : SplyPriceVO.java
 * @Description : 기초관리 - 가격관리 - 공급가관리
 * @Modification Information
 * @
 * @  수정일      수정자              수정내용
 * @ ----------  ---------   -------------------------------
 * @ 2024.04.04  이다솜       최초생성
 *
 * @author 솔비포스 개발본부 WEB개발팀 이다솜
 * @since 2024.04.04
 * @version 1.0
 *
 *  Copyright (C) by SOLBIPOS CORP. All right reserved.
 */
public class SplyPriceVO extends PageVO {

    /** 본사코드 */
    private String hqOfficeCd;

    /** 매장코드 */
    private String storeCd;

    /** 매장코드 */
    private String[] storeCdList;

    /** 조회매장 */
    private String storeCds;

    /** 매장코드 */
    private String[] saveStoreCdList;

    /** 조회매장 */
    private String saveStoreCds;

    /** 상품코드 */
    private String prodCd;

    /** 상품명 */
    private String prodNm;

    /** 상품분류코드 */
    private String prodClassCd;

    /** 사용자 아이디 */
    private String userId;

    /** 사용자별 브랜드코드(상품) */
    private String[] userProdBrandList;

    /** 사용자별 브랜드코드(상품) */
    private String userProdBrands;

    /** 상품브랜드코드 */
    private String prodHqBrandCd;

    /** 사용자별 브랜드코드(매장) */
    private String[] userBrandList;

    /** 사용자별 브랜드코드(매장) */
    private String userBrands;

    /** 매장브랜드코드 */
    private String storeHqBrandCd;

    /** 전매장적용 구분 */
    private String applyFg;

    /** 매장(멀티) 조회를 위한 쿼리 문자열*/
    private String storeCdQuery;

    /** 공급단가 */
    private String splyUprc;

    /** 세션ID */
    private String sessionId;

    /** 결과검증내용 */
    private String result;

    /** 순번 */
    private int seq;

    /** 가격관리구분 */
    private String prcCtrlFg;

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

    public String[] getSaveStoreCdList() {
        return saveStoreCdList;
    }

    public void setSaveStoreCdList(String[] saveStoreCdList) {
        this.saveStoreCdList = saveStoreCdList;
    }

    public String getSaveStoreCds() {
        return saveStoreCds;
    }

    public void setSaveStoreCds(String saveStoreCds) {
        this.saveStoreCds = saveStoreCds;
    }

    public String getProdCd() {
        return prodCd;
    }

    public void setProdCd(String prodCd) {
        this.prodCd = prodCd;
    }

    public String getProdNm() {
        return prodNm;
    }

    public void setProdNm(String prodNm) {
        this.prodNm = prodNm;
    }

    public String getProdClassCd() {
        return prodClassCd;
    }

    public void setProdClassCd(String prodClassCd) {
        this.prodClassCd = prodClassCd;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String[] getUserProdBrandList() {
        return userProdBrandList;
    }

    public void setUserProdBrandList(String[] userProdBrandList) {
        this.userProdBrandList = userProdBrandList;
    }

    public String getUserProdBrands() {
        return userProdBrands;
    }

    public void setUserProdBrands(String userProdBrands) {
        this.userProdBrands = userProdBrands;
    }

    public String getProdHqBrandCd() {
        return prodHqBrandCd;
    }

    public void setProdHqBrandCd(String prodHqBrandCd) {
        this.prodHqBrandCd = prodHqBrandCd;
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

    public String getStoreHqBrandCd() {
        return storeHqBrandCd;
    }

    public void setStoreHqBrandCd(String storeHqBrandCd) {
        this.storeHqBrandCd = storeHqBrandCd;
    }

    public String getApplyFg() {
        return applyFg;
    }

    public void setApplyFg(String applyFg) {
        this.applyFg = applyFg;
    }

    public String getStoreCdQuery() {
        return storeCdQuery;
    }

    public void setStoreCdQuery(String storeCdQuery) {
        this.storeCdQuery = storeCdQuery;
    }

    public String getSplyUprc() {
        return splyUprc;
    }

    public void setSplyUprc(String splyUprc) {
        this.splyUprc = splyUprc;
    }

    public String getSessionId() {
        return sessionId;
    }

    public void setSessionId(String sessionId) {
        this.sessionId = sessionId;
    }

    public String getResult() {
        return result;
    }

    public void setResult(String result) {
        this.result = result;
    }

    public int getSeq() {
        return seq;
    }

    public void setSeq(int seq) {
        this.seq = seq;
    }

    public String getPrcCtrlFg() {
        return prcCtrlFg;
    }

    public void setPrcCtrlFg(String prcCtrlFg) {
        this.prcCtrlFg = prcCtrlFg;
    }
}
