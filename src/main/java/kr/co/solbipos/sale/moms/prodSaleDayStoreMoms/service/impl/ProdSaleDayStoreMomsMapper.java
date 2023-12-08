package kr.co.solbipos.sale.moms.prodSaleDayStoreMoms.service.impl;

import kr.co.common.data.structure.DefaultMap;
import kr.co.solbipos.sale.moms.prodSaleDayStoreMoms.service.ProdSaleDayStoreMomsVO;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @Class Name : ProdSaleDayStoreMomsMapper.java
 * @Description : 맘스터치 > 간소화화면 > 상품매출일별(매장)
 * @Modification Information
 * @
 * @  수정일      수정자              수정내용
 * @ ----------  ---------   -------------------------------
 * @ 2023.12.07  김설아      최초생성
 *
 * @author 솔비포스 개발본부 WEB개발팀 김설아
 * @since 2023.12.07
 * @version 1.0
 *
 *  Copyright (C) by SOLBIPOS CORP. All right reserved.
 */
@Mapper
@Repository
public interface ProdSaleDayStoreMomsMapper {

    /** 상품매출일별(매장) - 조회 */
    List<DefaultMap<Object>> getProdSaleDayStoreMomsList(ProdSaleDayStoreMomsVO prodSaleDayStoreMomsVO);

    /** 상품매출일별(매장) - 엑셀다운로드 조회 */
    List<DefaultMap<Object>> getProdSaleDayStoreMomsExcelList(ProdSaleDayStoreMomsVO prodSaleDayStoreMomsVO);
}