package kr.co.solbipos.base.prod.kioskKeyMap.service;

import kr.co.common.data.structure.DefaultMap;
import kr.co.solbipos.application.session.auth.service.SessionInfoVO;
import kr.co.solbipos.base.prod.kioskOption.service.KioskOptionVO;
import kr.co.solbipos.base.prod.prod.service.ProdVO;
import kr.co.solbipos.base.prod.prodImg.service.ProdImgVO;
import kr.co.solbipos.base.prod.sidemenu.service.SideMenuSelProdVO;

import java.util.List;

/**
 * @Class Name : KioskKeyMapService.java
 * @Description : 기초관리 - 상품관리 - 키오스크키맵관리
 * @Modification Information
 * @
 * @  수정일      수정자              수정내용
 * @ ----------  ---------   -------------------------------
 * @ 2020.09.03  이다솜       최초생성
 *
 * @author 솔비포스 개발본부 백엔드PT 이다솜
 * @since 2020. 09.03
 * @version 1.0
 *
 *  Copyright (C) by SOLBIPOS CORP. All right reserved.
 */
public interface KioskKeyMapService {

    /** 키오스크용 포스 조회 */
    List<DefaultMap<String>> getKioskPosList(KioskKeyMapVO kioskKeyMapVO, SessionInfoVO sessionInfoVO);

    /** 키오스크 카테고리(분류) 조회 */
    List<DefaultMap<Object>> getKioskCategory(KioskKeyMapVO kioskKeyMapVO, SessionInfoVO sessionInfoVO);

    /** 키오스크 카테고리(분류) 저장 */
    int saveKioskCategory(KioskKeyMapVO[] kioskKeyMapVOs, SessionInfoVO sessionInfoVO);

    /** 키오스크 키맵 조회 */
    List<DefaultMap<Object>> getKioskKeyMap(KioskKeyMapVO kioskKeyMapVO, SessionInfoVO sessionInfoVO);

    /** 키오스크 키맵 수정 */
    int updateKioskKeyMap(KioskKeyMapVO[] kioskKeyMapVOs, SessionInfoVO sessionInfoVO);

    /** 키오스크 상품 조회 */
    List<DefaultMap<String>> getKioskProdList(KioskKeyMapVO kioskKeyMapVO, SessionInfoVO sessionInfoVO);

    /** 키오스크 키맵 등록 */
    int saveKioskKeyMap(KioskKeyMapVO[] kioskKeyMapVOs, SessionInfoVO sessionInfoVO);

}