package kr.co.solbipos.sale.com.popup.service.impl;

import kr.co.common.data.domain.CustomComboVO;
import kr.co.common.data.structure.DefaultMap;
import kr.co.common.service.message.MessageService;
import kr.co.common.utils.spring.StringUtil;
import kr.co.solbipos.application.session.auth.service.SessionInfoVO;
import kr.co.solbipos.sale.com.popup.service.SaleComPopupService;
import kr.co.solbipos.sale.com.popup.service.SaleComPopupVO;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("SaleComPopupService")
public class SaleComPopupServiceImpl implements SaleComPopupService {
    private final SaleComPopupMapper saleComPopupMapper;
    private final MessageService messageService;

    @Autowired
    public SaleComPopupServiceImpl(SaleComPopupMapper saleCompoPupMapper, MessageService messageService) {
    	this.saleComPopupMapper = saleCompoPupMapper;
        this.messageService = messageService;
    }


    /** 매출공통팝업 - 테이블별 매출현황 팝업(실매출 클릭) */
    @Override
    public List<DefaultMap<String>> getTablePopList(SaleComPopupVO saleComPopupVO, SessionInfoVO sessionInfoVO) {
    	
    	saleComPopupVO.setHqOfficeCd(sessionInfoVO.getHqOfficeCd());

		return saleComPopupMapper.getTablePopList(saleComPopupVO);
    }
    
    /** 매출공통팝업 - 상품매출내역 팝업(수량 클릭) */
    @Override
    public List<DefaultMap<String>> getProdPopList(SaleComPopupVO saleComPopupVO, SessionInfoVO sessionInfoVO) {
    	
    	saleComPopupVO.setHqOfficeCd(sessionInfoVO.getHqOfficeCd());
    	
        if(!StringUtil.getOrBlank(saleComPopupVO.getStoreCd()).equals("")) {
        	saleComPopupVO.setArrStoreCd(saleComPopupVO.getStoreCd().split(","));
        }

    	if(saleComPopupVO.getChkPop().equals("tablePop")) {
    		return saleComPopupMapper.getProdPopList(saleComPopupVO);
    	}else if(saleComPopupVO.getChkPop().equals("empPop")) {
    		return saleComPopupMapper.getEmpPopList(saleComPopupVO);
    	}
        return null;
    }
    
    /** 매출공통팝업 - 승인현황(매장현황) 팝업(매장명 클릭) */
    @Override
    public List<DefaultMap<String>> getApprPopList(SaleComPopupVO saleComPopupVO, SessionInfoVO sessionInfoVO) {
    	
    	saleComPopupVO.setHqOfficeCd(sessionInfoVO.getHqOfficeCd());
    	
        if(!StringUtil.getOrBlank(saleComPopupVO.getStoreCd()).equals("")) {
        	saleComPopupVO.setArrStoreCd(saleComPopupVO.getStoreCd().split(","));
        }

    	if(saleComPopupVO.getChkPop().equals("cardApprPop")) {				//카드
    		return saleComPopupMapper.getCardApprPopList(saleComPopupVO);
    	}else if(saleComPopupVO.getChkPop().equals("cashApprPop")) {		//현금
    		return saleComPopupMapper.getCashApprPopList(saleComPopupVO);
    	}else if(saleComPopupVO.getChkPop().equals("paycoApprPop")) {		//payco
    		return saleComPopupMapper.getPaycoApprPopList(saleComPopupVO);
    	}else if(saleComPopupVO.getChkPop().equals("mpayApprPop")) {		//Mpay
    		return saleComPopupMapper.getMpayApprPopList(saleComPopupVO);
    	}else if(saleComPopupVO.getChkPop().equals("mcouponApprPop")) {		//Mcoupon
    		return saleComPopupMapper.getMcouponApprPopList(saleComPopupVO);
    	}else if(saleComPopupVO.getChkPop().equals("partnerApprPop")) {		//제휴카드
    		return saleComPopupMapper.getPartnerApprPopList(saleComPopupVO);
    	}else if(saleComPopupVO.getChkPop().equals("ncardApprPop")) {		//비매출카드
    		return saleComPopupMapper.getNcardApprPopList(saleComPopupVO);
    	}else if(saleComPopupVO.getChkPop().equals("ncashApprPop")) {		//비매출현금
    		return saleComPopupMapper.getNcashApprPopList(saleComPopupVO);
    	}
    	
        return null;
    }
}
