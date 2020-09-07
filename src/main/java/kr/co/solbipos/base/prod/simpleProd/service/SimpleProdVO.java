package kr.co.solbipos.base.prod.simpleProd.service;

import kr.co.solbipos.application.common.service.PageVO;
import kr.co.solbipos.base.prod.prod.service.enums.ProdNoEnvFg;

/**
 * @Class Name : SimpleProdVO.java
 * @Description : 기초관리 > 상품관리 > 간편상품등록
 * @Modification Information
 * @
 * @  수정일      수정자              수정내용
 * @ ----------  ---------   -------------------------------
 * @ 2020.08.26  김설아      최초생성
 *
 * @author 솔비포스 개발본부 백엔드PT 김설아
 * @since 2020.08.26
 * @version 1.0
 *
 *  Copyright (C) by SOLBIPOS CORP. All right reserved.
 */
public class SimpleProdVO extends PageVO {

    private static final long serialVersionUID = 4567094904301269212L;

    /**
     * 소속구분
     * M : 시스템
     * A : 대리점
     * H : 본사
     * S : 매장, 가맹점
     */
    private String orgnFg;

    /** 회원소속코드 */
    private String membrOrgnCd;

    /** 조회매장 */
    private String storeCd;

    /** 상품코드 */
    private String prodCd;

    /** 상품명 */
    private String prodNm;

    /** 상품분류코드 */
    private String prodClassCd;

    /** 바코드 */
    private String barCd;

    /** 결과검증내용 */
    private String result;

    /** 공급단가 */
    private Double splyUprc;

    /** 원가단가 */
    private Double costUprc;

    /** 세션ID */
    private String sessionId;

    /** 순번 */
    private int seq;

    /** */
    private ProdNoEnvFg prodNoEnv;

    /** 상품유형구분 */
    private String prodTypeFg;

    /** 발주상품구분 */
    private String poProdFg;

    /** 과세여부구분 */
    private String vatFg;

    /** 판매단가 */
    private String saleUprc;

    /** 상품명 중복체크 */
    private String chkProdNm;

    /** 포인트적립여부 */
    private String pointSaveYn;

    /** 상품봉사료여부 */
    private String prodTipYn;

    /** 판매상품여부 */
    private String saleProdYn;

    /** 재고상품여부 */
    private String stockProdYn;

    /** 사이드상품여부 */
    private String sideProdYn;

    /** 세트상품구분 */
    private String setProdFg;

    /** 최종원가단가 */
    private Double lastCostUprc;

    /** 공급단가사용여부 */
    private String splyUprcUseYn;

    /** 발주단위수량 */
    private Integer poUnitQty;

    /** 발주최소수량 */
    private Integer poMinQty;

    /** 안전재고수량 */
    private Integer safeStockQty;

    /** 사용여부 */
    private String useYn;

    public String getOrgnFg() { return orgnFg; }

    public void setOrgnFg(String orgnFg) { this.orgnFg = orgnFg; }

    public String getMembrOrgnCd() { return membrOrgnCd; }

    public void setMembrOrgnCd(String membrOrgnCd) { this.membrOrgnCd = membrOrgnCd; }

    public String getStoreCd() { return storeCd; }

    public void setStoreCd(String storeCd) { this.storeCd = storeCd; }

    public String getProdCd() { return prodCd; }

    public void setProdCd(String prodCd) { this.prodCd = prodCd; }

    public String getProdNm() { return prodNm; }

    public void setProdNm(String prodNm) { this.prodNm = prodNm; }

    public String getProdClassCd() { return prodClassCd; }

    public void setProdClassCd(String prodClassCd) { this.prodClassCd = prodClassCd; }

    public String getBarCd() { return barCd; }

    public void setBarCd(String barCd) { this.barCd = barCd; }

    public String getResult() { return result; }

    public void setResult(String result) { this.result = result; }

    public Double getSplyUprc() { return splyUprc; }

    public void setSplyUprc(Double splyUprc) { this.splyUprc = splyUprc; }

    public Double getCostUprc() { return costUprc; }

    public void setCostUprc(Double costUprc) { this.costUprc = costUprc; }

    public String getSessionId() { return sessionId; }

    public void setSessionId(String sessionId) { this.sessionId = sessionId; }

    public int getSeq() { return seq; }

    public void setSeq(int seq) { this.seq = seq; }

    public ProdNoEnvFg getProdNoEnv() {
        return prodNoEnv;
    }

    public void setProdNoEnv(ProdNoEnvFg prodNoEnv) {
        this.prodNoEnv = prodNoEnv;
    }

    public String getProdTypeFg() { return prodTypeFg; }

    public void setProdTypeFg(String prodTypeFg) {
        this.prodTypeFg = prodTypeFg;
    }

    public String getPoProdFg() {
        return poProdFg;
    }

    public void setPoProdFg(String poProdFg) {
        this.poProdFg = poProdFg;
    }

    public String getVatFg() { return vatFg; }

    public void setVatFg(String vatFg) {
        this.vatFg = vatFg;
    }

    public String getSaleUprc() { return saleUprc; }

    public void setSaleUprc(String saleUprc) {
        this.saleUprc = saleUprc;
    }

    public String getChkProdNm() { return chkProdNm; }

    public void setChkProdNm(String chkProdNm) {
        this.chkProdNm = chkProdNm;
    }

    public String getPointSaveYn() { return pointSaveYn; }

    public void setPointSaveYn(String pointSaveYn) {
        this.pointSaveYn = pointSaveYn;
    }

    public String getProdTipYn() { return prodTipYn; }

    public void setProdTipYn(String prodTipYn) {
        this.prodTipYn = prodTipYn;
    }

    public String getSaleProdYn() { return saleProdYn; }

    public void setSaleProdYn(String saleProdYn) {
        this.saleProdYn = saleProdYn;
    }

    public String getStockProdYn() { return stockProdYn; }

    public void setStockProdYn(String stockProdYn) {
        this.stockProdYn = stockProdYn;
    }

    public String getSideProdYn() { return sideProdYn; }

    public void setSideProdYn(String sideProdYn) {
        this.sideProdYn = sideProdYn;
    }

    public String getSetProdFg() { return setProdFg; }

    public void setSetProdFg(String setProdFg) {
        this.setProdFg = setProdFg;
    }

    public Double getLastCostUprc() { return lastCostUprc; }

    public void setLastCostUprc(Double lastCostUprc) {
        this.lastCostUprc = lastCostUprc;
    }

    public String getSplyUprcUseYn() { return splyUprcUseYn; }

    public void setSplyUprcUseYn(String splyUprcUseYn) {
        this.splyUprcUseYn = splyUprcUseYn;
    }

    public Integer getPoUnitQty() { return poUnitQty; }

    public void setPoUnitQty(Integer poUnitQty) { this.poUnitQty = poUnitQty; }

    public Integer getPoMinQty() { return poMinQty; }

    public void setPoMinQty(Integer poMinQty) { this.poMinQty = poMinQty; }

    public Integer getSafeStockQty() { return safeStockQty; }

    public void setSafeStockQty(Integer safeStockQty) { this.safeStockQty = safeStockQty; }

    public String getUseYn() { return useYn; }

    public void setUseYn(String useYn) { this.useYn = useYn; }
}