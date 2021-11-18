package kr.co.solbipos.mobile.sale.status.voucherNo.service.impl;

import kr.co.solbipos.mobile.sale.status.voucherNo.service.MobileVoucherNoVO;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

/**
 * @Class Name : MobileVoucherNoMapper.java
 * @Description : (모바일) 매출현황 > 최종교환권번호
 * @Modification Information
 * @
 * @  수정일      수정자              수정내용
 * @ ----------  ---------   -------------------------------
 * @ 2021.11.16  이다솜      최초생성
 *
 * @author 솔비포스 개발본부 WEB개발팀 이다솜
 * @since 2021.11.16
 * @version 1.0
 *
 *  Copyright (C) by SOLBIPOS CORP. All right reserved.
 */
@Mapper
@Repository
public interface MobileVoucherNoMapper {

    /** 최종교환권번호 조회 */
    String getVoucherNo(MobileVoucherNoVO mobileVoucherNoVO);
}
