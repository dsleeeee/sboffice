package kr.co.solbipos.adi.sms.smsTelNoManage.service;

import kr.co.common.data.structure.DefaultMap;
import kr.co.solbipos.application.session.auth.service.SessionInfoVO;

import java.util.List;

/**
 * @Class Name : SmsTelNoManageService.java
 * @Description : 부가서비스 > SMS관리 > 발신번호관리
 * @Modification Information
 * @
 * @  수정일      수정자              수정내용
 * @ ----------  ---------   -------------------------------
 * @ 2021.09.15  김설아      최초생성
 *
 * @author 솔비포스 개발본부 WEB개발팀 김설아
 * @since 2021.09.15
 * @version 1.0
 *
 *  Copyright (C) by SOLBIPOS CORP. All right reserved.
 */
public interface SmsTelNoManageService {

    /** 발신번호관리 - 조회 */
    List<DefaultMap<Object>> getSmsTelNoManageList(SmsTelNoManageVO smsTelNoManageVO, SessionInfoVO sessionInfoVO);

    /** 발신번호관리 저장 */
    int getSmsTelNoManageSaveUpdate(SmsTelNoManageVO[] smsTelNoManageVOs, SessionInfoVO sessionInfoVO);
}