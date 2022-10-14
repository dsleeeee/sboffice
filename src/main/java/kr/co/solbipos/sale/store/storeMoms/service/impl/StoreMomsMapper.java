package kr.co.solbipos.sale.store.storeMoms.service.impl;

import kr.co.common.data.structure.DefaultMap;
import kr.co.solbipos.sale.store.storeMoms.service.StoreMomsVO;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @Class Name : StoreMomsMapper.java
 * @Description : 맘스터치 > 점포매출 > 점포별 매출 현황
 * @Modification Information
 * @
 * @  수정일      수정자              수정내용
 * @ ----------  ---------   -------------------------------
 * @ 2022.10.13  권지현      최초생성
 *
 * @author 솔비포스 개발본부 WEB개발팀 권지현
 * @since 2022.10.13
 * @version 1.0
 *
 *  Copyright (C) by SOLBIPOS CORP. All right reserved.
 */
@Mapper
@Repository
public interface StoreMomsMapper {

    /** 조회 */
    List<DefaultMap<Object>> getStoreMomsList(StoreMomsVO storeMomsVO);
    List<DefaultMap<Object>> getStoreMomsExcelList(StoreMomsVO storeMomsVO);
}