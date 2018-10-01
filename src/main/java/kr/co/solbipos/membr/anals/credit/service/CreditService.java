package kr.co.solbipos.membr.anals.credit.service;


import kr.co.common.data.structure.DefaultMap;
import kr.co.solbipos.application.session.auth.service.SessionInfoVO;
import kr.co.solbipos.membr.anals.credit.service.CreditStoreVO;

import java.util.List;

/**
 * @Class Name : CreditService.java
 * @Description : 회원관리 > 회원분석 > 후불회원
 * @Modification Information
 * @
 * @  수정일      수정자              수정내용
 * @ ----------  ---------   -------------------------------
 * @ 2018.09.20  김지은      최초생성
 *
 * @author 솔비포스 차세대개발실 김지은
 * @since 2018.09.20
 * @version 1.0
 *
 *  Copyright (C) by SOLBIPOS CORP. All right reserved.
 */
public interface CreditService {

    /** 후불 회원 외상, 입금 내역 */
    List<DefaultMap<Object>> getCreditMemberList(CreditStoreVO creditStoreVO, SessionInfoVO sessionInfoVO);

    /** 후불 대상 회원 조회 */
    List<DefaultMap<Object>> getDepositMemberList(CreditStoreVO creditStoreVO, SessionInfoVO sessionInfoVO);

    /** 외상 입금 */
    int saveDeposit(CreditStoreVO creditStoreVO, SessionInfoVO sessionInfoVO);

}
