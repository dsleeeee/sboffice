package kr.co.solbipos.store.manage.storeview.service;

import kr.co.common.data.structure.DefaultMap;
import kr.co.solbipos.application.session.auth.service.SessionInfoVO;

import java.util.List;

/**
* @Class Name : StoreViewService.java
* @Description : 가맹점 관리 > 매장관리 > 매장정보조회
* @Modification Information
* @
* @  수정일      수정자              수정내용
* @ ----------  ---------   -------------------------------
* @ 2018.08.07  김영근      최초생성
*
* @author nhn kcp 개발2팀 김영근
* @since 2018. 08.07
* @version 1.0
*
*  Copyright (C) by SOLBIPOS CORP. All right reserved.
*/
public interface StoreViewService {

    /** 매장정보 목록 조회 */
    List<DefaultMap<String>> getStoreViewList(StoreViewVO storeViewVO, SessionInfoVO sessionInfoVO);
}
