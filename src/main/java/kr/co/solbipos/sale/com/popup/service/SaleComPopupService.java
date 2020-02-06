package kr.co.solbipos.sale.com.popup.service;

import kr.co.common.data.structure.DefaultMap;
import kr.co.solbipos.application.session.auth.service.SessionInfoVO;

import java.util.List;

public interface SaleComPopupService {
	/** 매출공통팝업 - 테이블별 매출현황 팝업(실매출 클릭) 리스트 조회 */
    List<DefaultMap<String>> getTablePopList(SaleComPopupVO saleComPopupVO, SessionInfoVO sessionInfoVO);
        
	/** 매출공통팝업 - 상품매출내역 팝업(수량 클릭) 리스트 조회 */
    List<DefaultMap<String>> getProdPopList(SaleComPopupVO saleComPopupVO, SessionInfoVO sessionInfoVO);
    
	/** 매출공통팝업 - 승인현황(매장현황) 팝업(매장명 클릭) 리스트 조회 */
    List<DefaultMap<String>> getApprPopList(SaleComPopupVO saleComPopupVO, SessionInfoVO sessionInfoVO);
    
}
