package kr.co.solbipos.sale.dlvr.dlvrRate.service;

import kr.co.common.data.structure.DefaultMap;
import kr.co.solbipos.application.session.auth.service.SessionInfoVO;

import java.util.List;

/**
 * @Class Name : DlvrRateService.java
 * @Description : 맘스터치 > 점포매출 > 배달방문비중
 * @Modification Information
 * @
 * @  수정일      수정자              수정내용
 * @ ----------  ---------   -------------------------------
 * @ 2022.10.14  권지현      최초생성
 *
 * @author 솔비포스 개발본부 WEB개발팀 권지현
 * @since 2022.10.14
 * @version 1.0
 *
 *  Copyright (C) by SOLBIPOS CORP. All right reserved.
 */
public interface DlvrRateService {

    /** 조회 */
    List<DefaultMap<Object>> getDlvrRateList(DlvrRateVO dlvrRateeVO, SessionInfoVO sessionInfoVO);
    List<DefaultMap<Object>> getDlvrRateExcelList(DlvrRateVO dlvrRateeVO, SessionInfoVO sessionInfoVO);

}