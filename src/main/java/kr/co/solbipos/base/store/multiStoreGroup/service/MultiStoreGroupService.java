package kr.co.solbipos.base.store.multiStoreGroup.service;

import kr.co.common.data.structure.DefaultMap;
import kr.co.solbipos.application.session.auth.service.SessionInfoVO;
import kr.co.solbipos.base.store.storeType.service.StoreTypeVO;

import java.util.List;

/**
 * @Class Name : MultiStoreGroupService.java
 * @Description : 기초관리 - 매장관리 - 다중매장그룹관리
 * @Modification Information
 * @
 * @  수정일      수정자              수정내용
 * @ ----------  ---------   -------------------------------
 * @ 2021.07.28  이다솜       최초생성
 *
 * @author 솔비포스 개발본부 WEB개발팀 이다솜
 * @since 2021.07.28
 * @version 1.0
 *
 *  Copyright (C) by SOLBIPOS CORP. All right reserved.
 */
public interface MultiStoreGroupService {

    /** 그룹조회 */
    List<DefaultMap<Object>> getMultiStoreGroup(MultiStoreGroupVO multiStoreGroupVO, SessionInfoVO sessionInfoVO);

    /** 그룹저장 */
    int saveMultiStoreGroup(MultiStoreGroupVO[] multiStoreGroupVOs, SessionInfoVO sessionInfoVO);





    /** 매장조회 */
    List<DefaultMap<Object>> getStoreList(MultiStoreGroupVO multiStoreGroupVO, SessionInfoVO sessionInfoVO);

}
