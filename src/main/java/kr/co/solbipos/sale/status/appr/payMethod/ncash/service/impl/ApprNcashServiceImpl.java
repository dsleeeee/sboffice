package kr.co.solbipos.sale.status.appr.payMethod.ncash.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.common.data.structure.DefaultMap;
import kr.co.common.service.message.MessageService;
import kr.co.solbipos.application.session.auth.service.SessionInfoVO;
import kr.co.solbipos.sale.status.appr.payMethod.ncash.service.ApprNcashService;
import kr.co.solbipos.sale.status.appr.payMethod.ncash.service.ApprNcashVO;

@Service("apprNcashService")
public class ApprNcashServiceImpl implements ApprNcashService {
    private final ApprNcashMapper apprNcashMapper;
    private final MessageService messageService;

    @Autowired
    public ApprNcashServiceImpl(ApprNcashMapper apprNcashMapper, MessageService messageService) {
        this.apprNcashMapper = apprNcashMapper;
        this.messageService = messageService;
    }


    
    /** 신용카드 승인현황 - 리스트 조회 */
	@Override
	public List<DefaultMap<String>> getApprNcashList(ApprNcashVO apprNcashVO, SessionInfoVO sessionInfoVO) {
		apprNcashVO.setHqOfficeCd(sessionInfoVO.getHqOfficeCd());
		
		if (apprNcashVO.getPosNo() != null && !"".equals(apprNcashVO.getPosNo())) {
			String[] arrPosNo = apprNcashVO.getPosNo().split(",");
			if (arrPosNo.length > 0) {
    			if (arrPosNo[0] != null && !"".equals(arrPosNo[0])) {
    				apprNcashVO.setArrPosNo(arrPosNo);
//        				apprNcashVO.setArrStorePos(arrPosNo);
    			}
    		}
    	} else {
    		String[] arrStoreCd = apprNcashVO.getStoreCd().split(",");
    		if (arrStoreCd.length > 0) {
    			if (arrStoreCd[0] != null && !"".equals(arrStoreCd[0])) {
    				apprNcashVO.setArrStoreCd(arrStoreCd);
    			}
    		}
    	}
		
		return apprNcashMapper.getApprNcashList(apprNcashVO);
	}
}