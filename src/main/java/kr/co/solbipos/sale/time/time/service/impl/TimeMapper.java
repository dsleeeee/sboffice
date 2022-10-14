package kr.co.solbipos.sale.time.time.service.impl;

import kr.co.common.data.structure.DefaultMap;
import kr.co.solbipos.sale.time.time.service.TimeVO;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @Class Name : TimeMapper.java
 * @Description : 맘스터치 > 시간대별매출 > 시간대별 일 매출
 * @Modification Information
 * @
 * @  수정일      수정자              수정내용
 * @ ----------  ---------   -------------------------------
 * @ 2022.10.12  권지현      최초생성
 *
 * @author 솔비포스 개발본부 WEB개발팀 권지현
 * @since 2022.10.12
 * @version 1.0
 *
 *  Copyright (C) by SOLBIPOS CORP. All right reserved.
 */
@Mapper
@Repository
public interface TimeMapper {

    /** 상품별 매출 순위 */
    List<DefaultMap<Object>> getTimeList(TimeVO timeVO);
    List<DefaultMap<Object>> getTimeExcelList(TimeVO timeVO);
}