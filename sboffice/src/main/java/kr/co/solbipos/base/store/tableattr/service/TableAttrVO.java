package kr.co.solbipos.base.store.tableattr.service;

import kr.co.solbipos.application.common.service.CmmVO;
import kr.co.solbipos.base.store.tableattr.enums.AttrCd;
import kr.co.solbipos.base.store.tableattr.enums.TblTypeFg;
import kr.co.solbipos.base.store.tableattr.enums.TextalignFg;
import kr.co.solbipos.base.store.tableattr.enums.TextvalignFg;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

/**
 * @Class Name : TableAttrVO.java
 * @Description : 기초관리 > 매장관리 > 테이블속성
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
@AllArgsConstructor
@NoArgsConstructor
@EqualsAndHashCode(callSuper = false)
public class TableAttrVO extends CmmVO {

    private static final long serialVersionUID = 1L;

    /** 매장코드 */
    private String storeCd;

    /** 테이블유형구분 */
    private TblTypeFg tblTypeFg;

    /** 속성코드 */
    private AttrCd attrCd;

    /** 속성명 */
    private String attrNm;

    /** X */
    @Builder.Default private Long x = 0L;

    /** Y */
    @Builder.Default private Long y = 0L;

    /** 폭 */
    @Builder.Default private Long width = 0L;

    /** 높이 */
    @Builder.Default private Long height = 0L;

    /** 텍스트수평정렬구분 */
    @Builder.Default private TextalignFg textalignFg = TextalignFg.CENTER;

    /** 텍스트수직정렬구분 */
    @Builder.Default private TextvalignFg textvalignFg = TextvalignFg.MIDDLE;

    /** 이미지명 */
    private String imgNm;

    /** 폰트명 */
    @Builder.Default private String fontNm = "NotoR";

    /** 폰트크기 */
    @Builder.Default private Long fontSize = 10L;

    /** 폰트스타일구분 */
    @Builder.Default private String fontStyleFg = "0";

    /** 폰트색 */
    @Builder.Default private String fontColor = "#000000";

    /** 사용여부 */
    private String useYn;

    /** 등록일시 */
    private String regDt;

    /** 등록아이디 */
    private String regId;

    /** 수정일시 */
    private String modDt;

    /** 수정아이디 */
    private String modId;

}
