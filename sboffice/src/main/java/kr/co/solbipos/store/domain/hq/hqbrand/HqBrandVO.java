package kr.co.solbipos.store.domain.hq.hqbrand;

import kr.co.common.data.enums.UseYn;
import kr.co.solbipos.application.domain.cmm.CmmVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * 가맹점관리 > 본사정보 > 브랜드정보관리
 * 
 * @author 김지은
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class HqBrandVO extends CmmVO {

    
    /** 본사코드 */
    private String hqOfficeCd;
    
    /** 본사명 */
    private String hqOfficeNm;
    
    /** 브랜드코드 */
    private String hqBrandCd;
    
    /** 브랜드명 */
    private String hqBrandNm;
    
    /** 사용여부 */
    private UseYn UseYn;
    
}
