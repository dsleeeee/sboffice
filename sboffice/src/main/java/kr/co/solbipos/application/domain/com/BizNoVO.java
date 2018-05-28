package kr.co.solbipos.application.domain.com;

import kr.co.solbipos.application.domain.cmm.CmmVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * 사업자번호 유효성검사 <br>
 *
 * @author 노현수
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class BizNoVO extends CmmVO {

    private static final long serialVersionUID = 7527886695969858538L;

    /** 사업자번호 */
    private String bizNo;

}
