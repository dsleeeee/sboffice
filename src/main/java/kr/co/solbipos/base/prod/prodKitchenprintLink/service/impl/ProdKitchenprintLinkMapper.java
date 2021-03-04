package kr.co.solbipos.base.prod.prodKitchenprintLink.service.impl;

import kr.co.common.data.structure.DefaultMap;
import kr.co.solbipos.base.prod.prod.service.ProdVO;
import kr.co.solbipos.base.prod.prodKitchenprintLink.service.ProdKitchenprintLinkVO;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @Class Name : ProdKitchenprintLinkMapper.java
 * @Description : 기초관리 > 상품관리 > 상품-매장주방프린터연결
 * @Modification Information
 * @
 * @  수정일      수정자              수정내용
 * @ ----------  ---------   -------------------------------
 * @ 2021.02.09  권지현      최초생성
 *
 * @author 솔비포스 개발본부 백엔드PT 김설아
 * @since 2021.02.09
 * @version 1.0
 *
 *  Copyright (C) by SOLBIPOS CORP. All right reserved.
 */

@Mapper
@Repository
public interface ProdKitchenprintLinkMapper {

    /* 상품 조회 */
    List<DefaultMap<String>> getProdList(ProdKitchenprintLinkVO prodKitchenprintLinkVO);

    /* 연결된 프린터 */
    List<DefaultMap<String>> getLinkedList(ProdKitchenprintLinkVO prodKitchenprintLinkVO);

    /* 연결된 프린터 연결 해제 */
    int unlinkPrter(ProdKitchenprintLinkVO prodKitchenprintLinkVO);

    /* 안연결된 프린터 */
    List<DefaultMap<String>> getUnlinkList(ProdKitchenprintLinkVO prodKitchenprintLinkVO);

    /* 안연결된 프린터 연결 */
    int linkedPrter(ProdKitchenprintLinkVO prodKitchenprintLinkVO);
}