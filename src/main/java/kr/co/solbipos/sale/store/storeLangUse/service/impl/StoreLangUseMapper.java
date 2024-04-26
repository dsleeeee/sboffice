package kr.co.solbipos.sale.store.storeLangUse.service.impl;

import kr.co.common.data.structure.DefaultMap;
import kr.co.solbipos.sale.store.storeLangUse.service.StoreLangUseVO;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @Class Name : StoreLangUseMapper.java
 * @Description : 맘스터치 > 매장분석 > 다국어사용현황
 * @Modification Information
 * @
 * @  수정일      수정자              수정내용
 * @ ----------  ---------   -------------------------------
 * @ 2024.04.25  김유승       최초생성
 *
 * @author 솔비포스 WEB개발팀 김유승
 * @since 2024.04.25
 * @version 1.0
 *
 *  Copyright (C) by SOLBIPOS CORP. All right reserved.
 */
@Mapper
@Repository
public interface StoreLangUseMapper {

    /** 다국어사용현황 조회 */
    List<DefaultMap<String>> getStoreLangUseList(StoreLangUseVO storeLangUseVO);
}
