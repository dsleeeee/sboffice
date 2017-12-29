package kr.co.solbipos.application.domain.resource;

import kr.co.solbipos.application.domain.BaseDomain;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper = false)
public class ResrceInfoBase extends BaseDomain {

    private static final long serialVersionUID = 1L;
    
    /** 리소스 코드 */
    private String resrceCd;

    /** 상위 리소스 */
    private String pResrce;

    /** 리소스 명 */
    private String resrceNm;

    /** URL */
    private String url;

    /** 활성화 여부 */
    private boolean activation = false;
}
