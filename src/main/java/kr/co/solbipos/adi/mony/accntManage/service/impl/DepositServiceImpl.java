package kr.co.solbipos.adi.mony.accntManage.service.impl;

import kr.co.common.data.structure.DefaultMap;
import kr.co.solbipos.adi.mony.accntManage.service.DepositService;
import kr.co.solbipos.application.com.griditem.enums.GridDataFg;
import kr.co.solbipos.application.session.auth.service.SessionInfoVO;
import kr.co.solbipos.application.session.user.enums.OrgnFg;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

import static kr.co.common.utils.DateUtil.currentDateTimeString;


/**
 * @Class Name : DepositServiceImpl.java
 * @Description : 부가서비스 > 금전처리 > 계정관리
 * @Modification Information
 * @
 * @  수정일      수정자              수정내용
 * @ ----------  ---------   -------------------------------
 * @ 2018.10.12  김지은      최초생성
 *
 * @author 솔비포스 차세대개발실 김지은
 * @since 2018. 10.12
 * @version 1.0
 *
 * @Copyright (C) by SOLBIPOS CORP. All right reserved.
 */
@Service
public class DepositServiceImpl implements DepositService{

    private final DepositMapper mapper;

    /** Constructor Injection */
    @Autowired
    public DepositServiceImpl(DepositMapper mapper) {
        this.mapper = mapper;
    }

    /** 계정 조회 */
    @Override
    public List<DefaultMap<String>> getDepositAccntList(AccntVO accntVO, SessionInfoVO sessionInfoVO) {

        OrgnFg userOrgnFg = sessionInfoVO.getOrgnFg();

        accntVO.setOrgnFg(userOrgnFg);

        if(userOrgnFg == OrgnFg.HQ) { // 본사
            accntVO.setHqOfficeCd(sessionInfoVO.getHqOfficeCd());
        } else if(userOrgnFg == OrgnFg.STORE) { // 매장
            accntVO.setStoreCd(sessionInfoVO.getStoreCd());
        }

        return mapper.getDepositAccntList(accntVO);
    }

    /** 계정 정보 저장 */
    @Override
    public int saveDepositAccntList(AccntVO[] accntVOs, SessionInfoVO sessionInfoVO) {

        int resultCnt = 0;
        String dt = currentDateTimeString();

        for(AccntVO accntVO : accntVOs) {

            accntVO.setOrgnFg(sessionInfoVO.getOrgnFg());

            OrgnFg userOrgnFg = sessionInfoVO.getOrgnFg();

            if(userOrgnFg == OrgnFg.HQ) {
                accntVO.setHqOfficeCd(sessionInfoVO.getHqOfficeCd());
            } else if(userOrgnFg == OrgnFg.STORE) {
                accntVO.setStoreCd(sessionInfoVO.getStoreCd());
            }

            accntVO.setRegDt(dt);
            accntVO.setRegId(sessionInfoVO.getUserId());
            accntVO.setModDt(dt);
            accntVO.setModId(sessionInfoVO.getUserId());

            if(accntVO.getStatus() == GridDataFg.INSERT) {
                resultCnt += mapper.insertDepositAccntList(accntVO);
            } else if (accntVO.getStatus() == GridDataFg.UPDATE) {
                resultCnt += mapper.updateDepositAccntList(accntVO);
            } else if (accntVO.getStatus() == GridDataFg.DELETE) {
                resultCnt += mapper.deleteDepositAccntList(accntVO);
            }
        }
        return resultCnt;
    }
}
