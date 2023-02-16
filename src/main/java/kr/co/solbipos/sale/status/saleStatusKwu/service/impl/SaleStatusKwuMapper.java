package kr.co.solbipos.sale.status.saleStatusKwu.service.impl;

import kr.co.common.data.structure.DefaultMap;
import kr.co.solbipos.sale.status.saleStatusKwu.service.SaleStatusKwuVO;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @Class Name : SaleStatusKwuMapper.java
 * @Description : 광운대 > 리포트 > 매출현황2
 * @Modification Information
 * @
 * @  수정일      수정자              수정내용
 * @ ----------  ---------   -------------------------------
 * @ 2023.02.14  김설아      최초생성
 *
 * @author 솔비포스 개발본부 WEB개발팀 김설아
 * @since 2023.02.14
 * @version 1.0
 *
 *  Copyright (C) by SOLBIPOS CORP. All right reserved.
 */
@Mapper
@Repository
public interface SaleStatusKwuMapper {

    /** 매출현황2 - 조회 */
    List<DefaultMap<Object>> getSaleStatusKwuList(SaleStatusKwuVO saleStatusKwuVO);
}