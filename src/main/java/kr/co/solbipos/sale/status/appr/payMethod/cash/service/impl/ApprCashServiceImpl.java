package kr.co.solbipos.sale.status.appr.payMethod.cash.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.common.data.structure.DefaultMap;
import kr.co.common.service.message.MessageService;
import kr.co.solbipos.application.session.auth.service.SessionInfoVO;
import kr.co.solbipos.sale.status.appr.payMethod.cash.service.ApprCashService;
import kr.co.solbipos.sale.status.appr.payMethod.cash.service.ApprCashVO;

@Service("apprCashService")
public class ApprCashServiceImpl implements ApprCashService {
    private final ApprCashMapper apprCashMapper;
    private final MessageService messageService;

    @Autowired
    public ApprCashServiceImpl(ApprCashMapper apprCashMapper, MessageService messageService) {
        this.apprCashMapper = apprCashMapper;
        this.messageService = messageService;
    }


    
    /** 신용카드 승인현황 - 리스트 조회 */
	@Override
	public List<DefaultMap<String>> getApprCashList(ApprCashVO apprCashVO, SessionInfoVO sessionInfoVO) {
		apprCashVO.setHqOfficeCd(sessionInfoVO.getHqOfficeCd());
		return apprCashMapper.getApprCashList(apprCashVO);
	}

}
