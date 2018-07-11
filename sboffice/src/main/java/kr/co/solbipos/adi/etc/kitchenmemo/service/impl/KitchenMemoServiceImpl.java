package kr.co.solbipos.adi.etc.kitchenmemo.service.impl;

import static kr.co.common.utils.DateUtil.currentDateTimeString;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import kr.co.common.service.session.SessionService;
import kr.co.solbipos.adi.etc.kitchenmemo.service.KitchenMemoService;
import kr.co.solbipos.adi.etc.kitchenmemo.service.KitchenMemoVO;
import kr.co.solbipos.application.com.griditem.enums.GridDataFg;
import kr.co.solbipos.application.session.auth.service.SessionInfoVO;

/**
* @Class Name : KitchenMemoServiceImpl.java
* @Description : 부가서비스 > 주방메모관리
* @Modification Information
* @
* @  수정일      수정자              수정내용
* @ ----------  ---------   -------------------------------
* @ 2018.06.01  김지은      최초생성
*
* @author 솔비포스 차세대개발실 김지은
* @since 2018. 05.01
* @version 1.0
* @see
*
*  Copyright (C) by SOLBIPOS CORP. All right reserved.
*/
@Service("kitchenMemoService")
public class KitchenMemoServiceImpl implements KitchenMemoService {

    @Autowired
    SessionService sessionService;

    @Autowired
    KitchenMemoMapper kichenMemoMapper;

    @Override
    public <E> List<E> selectKitchenMemo(SessionInfoVO sessionInfoVO) {
        return kichenMemoMapper.selectKitchenMemo(sessionInfoVO);
    }

    @Override
    public int save(KitchenMemoVO[] kitchenMemoVOs, SessionInfoVO sessionInfoVO) {

        int procCnt = 0;
        String insertDt = currentDateTimeString();

        for(KitchenMemoVO kitchenMemoVO : kitchenMemoVOs){
            kitchenMemoVO.setStoreCd(sessionInfoVO.getOrgnCd());
            kitchenMemoVO.setRegId(sessionInfoVO.getUserId());
            kitchenMemoVO.setRegDt(insertDt);
            kitchenMemoVO.setModId(sessionInfoVO.getUserId());
            kitchenMemoVO.setModDt(insertDt);

            if(kitchenMemoVO.getStatus() == GridDataFg.INSERT) {
                procCnt += kichenMemoMapper.insertKitchenMemo(kitchenMemoVO);
            }
            else if(kitchenMemoVO.getStatus() == GridDataFg.UPDATE) {
                procCnt += kichenMemoMapper.updateKitchenMemo(kitchenMemoVO);
            }
            else if(kitchenMemoVO.getStatus() == GridDataFg.DELETE) {
                procCnt += kichenMemoMapper.deleteKitchenMemo(kitchenMemoVO);
            }
        }
        return procCnt;
    }

    @Override
    public int selectKitchenMemoCnt(KitchenMemoVO kitchenMemoVO) {

        SessionInfoVO sessionInfoVO = sessionService.getSessionInfo();

        kitchenMemoVO.setStoreCd(sessionInfoVO.getOrgnCd());
        kitchenMemoVO.setRegId(sessionInfoVO.getUserId());
        kitchenMemoVO.setModId(sessionInfoVO.getUserId());

        return kichenMemoMapper.selectKitchenMemoCnt(kitchenMemoVO);
    }
}
