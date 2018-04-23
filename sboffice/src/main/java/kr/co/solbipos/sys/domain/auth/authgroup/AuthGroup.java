package kr.co.solbipos.sys.domain.auth.authgroup;

import kr.co.solbipos.application.domain.cmm.Cmm;
import kr.co.solbipos.enums.UseYn;
import kr.co.solbipos.sys.enums.TargetAllFg;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * 시스템관리 - 권한관리 - 권한 그룹 관리
 * @author 조병준
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class AuthGroup extends Cmm {

    private static final long serialVersionUID = 1L;

    /** 그룹 코드 */
    private String grpCd;

    /** 그룹 명 */
    private String grpNm;

    /** 전체 적용 구분 */
    private TargetAllFg targetAllFg;

    /** 대상 소속 */
    private String targetOrgn;

    /** 비고 */
    private String remark;

    /** 사용여부 */
    private UseYn useYn;

    /** 사용자 아이디 */
    private String userId;
    
}
