package kr.co.solbipos.base.prod.touchkey.service;

import java.util.List;
import kr.co.solbipos.application.common.service.CmmVO;
import kr.co.solbipos.base.common.enums.InFg;
import lombok.Builder;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * @Class Name : TouchClassVO.java
 * @Description : 기초관리 - 상품관리 - 판매터치키등록
 * @Modification Information
 * @
 * @  수정일      수정자              수정내용
 * @ ----------  ---------   -------------------------------
 * @ 2015.05.01  조병준      최초생성
 *
 * @author NHN한국사이버결제 KCP 조병준
 * @since 2018. 05.01
 * @version 1.0
 * @see
 *
 *  Copyright (C) by SOLBIPOS CORP. All right reserved.
 */
@Data
@Builder
@EqualsAndHashCode(callSuper = false)
public class TouchClassVO extends CmmVO {

    private static final long serialVersionUID = 1L;

    /** 매장코드 */
    private String storeCd;

    /** 터치키분류코드 */
    private String tukeyGrpCd;
    
    /** 터치키분류코드 */
    private String tukeyClassCd;

    /** 터치키분류명 */
    private String tukeyClassNm;

    /** 페이지번호 */
    private Long pageNo;

    /** X */
    @Builder.Default private Long x = 0L;

    /** Y */
    @Builder.Default private Long y = 0L;

    /** 폭 */
    @Builder.Default private Long width = 0L;

    /** 높이 */
    @Builder.Default private Long height = 0L;

    /** 입력구분 H:본사, S:매장 */
    private InFg inFg;

    /** 폰트크기 */
    @Builder.Default private Long fontSize = 10L;

    /** 폰트색 */
    @Builder.Default private String fontColor = "#000000";

    /** 채움색 */
    @Builder.Default private String fillColor = "#000000";

    /** 등록일시 */
    private String regDt;

    /** 등록아이디 */
    private String regId;

    /** 수정일시 */
    private String modDt;

    /** 수정아이디 */
    private String modId;
    
    /** 테이블들 */
    private List<TouchVO> touchs;

}
