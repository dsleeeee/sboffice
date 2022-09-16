package kr.co.solbipos.sale.card.cardCredit.service;

import kr.co.common.data.structure.DefaultMap;
import kr.co.solbipos.application.session.auth.service.SessionInfoVO;

import java.util.List;

/**
 * @Class Name : CardCreditService.java
 * @Description : 광운대 > 신용카드입금관리 > 신용카드입금관리
 * @Modification Information
 * @
 * @  수정일      수정자              수정내용
 * @ ----------  ---------   -------------------------------
 * @ 2022.09.08  김설아      최초생성
 *
 * @author 솔비포스 개발본부 WEB개발팀 김설아
 * @since 2022.09.08
 * @version 1.0
 *
 *  Copyright (C) by SOLBIPOS CORP. All right reserved.
 */
public interface CardCreditService {

    /** 신용카드입금관리 - 조회 */
    List<DefaultMap<Object>> getCardCreditList(CardCreditVO cardCreditVO, SessionInfoVO sessionInfoVO);

    /** 신용카드입금관리 - 저장 */
    int getCardCreditSave(CardCreditVO[] cardCreditVOs, SessionInfoVO sessionInfoVO);
}