package kr.co.solbipos.mobile.stock.status.currUnity.service.impl;

import kr.co.common.data.structure.DefaultMap;
import kr.co.solbipos.mobile.stock.status.currUnity.service.MobileCurrUnityVO;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;
/**
 * @Class Name : MobileCurrUnityMapper.java
 * @Description : (모바일)재고현황 > 본사매장통합현재고
 * @Modification Information
 * @
 * @  수정일      수정자              수정내용
 * @ ----------  ---------   -------------------------------
 * @ 2024.07.19  김유승      최초생성
 *
 * @author 솔비포스 WEB개발팀 김유승
 * @since 2024.07.19
 * @version 1.0
 * @see
 *
 * @Copyright (C) by SOLBIPOS CORP. All right reserved.
 */
@Mapper
@Repository
public interface MobileCurrUnityMapper {

    /** 본사매장통합현재고 - 본사매장통합현재고 리스트 조회 */
    List<DefaultMap<String>> getCurrUnityList(MobileCurrUnityVO mobileCurrUnityVO);
    /** 본사매장통합현재고 - 본사매장통합현재고 본사 상세 리스트 조회 */
    List<DefaultMap<String>> getCurrUnityHqDtlList(MobileCurrUnityVO mobileCurrUnityVO);
    /** 본사매장통합현재고 - 본사매장통합현재고 매장 상세 리스트 조회 */
    List<DefaultMap<String>> getCurrUnityStoreDtlList(MobileCurrUnityVO mobileCurrUnityVO);

    /** 본사매장통합현재고 - 본사매장통합현재고 전체 엑셀 리스트 조회 */
    List<DefaultMap<String>> getCurrUnityExcelList(MobileCurrUnityVO mobileCurrUnityVO);
    /** 본사매장통합현재고 - 본사매장통합현재고 본사 상세 전체 엑셀 리스트 조회 */
    List<DefaultMap<String>> getCurrUnityHqDtlExcelList(MobileCurrUnityVO mobileCurrUnityVO);
    /** 본사매장통합현재고 - 본사매장통합현재고 매장 상세 전체 엑셀 리스트 조회 */
    List<DefaultMap<String>> getCurrUnityStoreDtlExcelList(MobileCurrUnityVO mobileCurrUnityVO);
}
