package kr.co.solbipos.sale.day.dayPeriod.service;

import kr.co.solbipos.application.common.service.PageVO;

/**
 * @Class Name : DayPeriodVO.java
 * @Description : 매출관리 > 매출현황 > 기간별매출 > 설정기간별탭
 * @Modification Information
 * @
 * @  수정일      수정자              수정내용
 * @ ----------  ---------   -------------------------------
 * @ 2020.01.23  김설아      최초생성
 *
 * @author 솔비포스 개발본부 백엔드PT 김설아
 * @since 2020.01.23
 * @version 1.0
 *
 *  Copyright (C) by SOLBIPOS CORP. All right reserved.
 */
public class DayPeriodVO extends PageVO {

    private static final long serialVersionUID = 4567094904301269212L;

    /** 회원소속코드 */
    private String membrOrgnCd;

    /** 매장코드 */
    private String[] storeCdList;

    /** 조회매장 */
    private String storeCds;

    /** 조회매장 */
    private String storeCd;

    /** 시간대 */
    private String saleTime;

    /** 코너코드 */
    private String cornrCd;

    /** 권종분류코드 */
    private String payClassCd;

    /** 상품분류코드 */
    private String prodClassCd;

    public String getMembrOrgnCd() {
        return membrOrgnCd;
    }

    public void setMembrOrgnCd(String membrOrgnCd) {
        this.membrOrgnCd = membrOrgnCd;
    }

    public String[] getStoreCdList() {
        return storeCdList;
    }

    public void setStoreCdList(String[] storeCdList) {
        this.storeCdList = storeCdList;
    }

    public String getStoreCds() { return storeCds; }

    public void setStoreCds(String storeCds) { this.storeCds = storeCds; }

    public String getStoreCd() { return storeCd; }

    public void setStoreCd(String storeCd) { this.storeCd = storeCd; }

    public String getSaleTime() { return saleTime; }

    public void setSaleTime(String saleTime) { this.saleTime = saleTime; }

    public String getCornrCd() { return cornrCd; }

    public void setCornrCd(String cornrCd) { this.cornrCd = cornrCd; }

    public String getPayClassCd() { return payClassCd; }

    public void setPayClassCd(String payClassCd) { this.payClassCd = payClassCd; }

    public String getProdClassCd() { return prodClassCd; }

    public void setProdClassCd(String prodClassCd) { this.prodClassCd = prodClassCd; }
}
