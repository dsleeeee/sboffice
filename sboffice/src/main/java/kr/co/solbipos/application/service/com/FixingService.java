package kr.co.solbipos.application.service.com;

import kr.co.solbipos.application.domain.com.FixingVO;

/**
 * 고정메뉴 관리
 *
 * @author 노현수
 */
public interface FixingService {

    /** 고정메뉴 관리 */
    int saveFixing( FixingVO bkmkVO, String userId );

}
