package kr.co.solbipos.service.code;

import kr.co.solbipos.application.domain.sample.CommonCode;

/**
 * 공통 코드 관련 서비스
 * 
 * @author 정용길
 *
 */
public interface CmmCodeService {

    /**
     * 레디스에 해당 공통 리스트를 업데이트
     * 
     * @param code
     * @return true : 업데이트 성공, false : 업데이트 실패 이지만 레디스 문제 이므로 해당 코드 사용은 문제 없음
     */
    boolean updateCodeList(CommonCode code);

    /**
     * 레디스에 공통코드 리스트 추가
     * 
     * @param code
     * @throws Exception
     */
    void setCodeList(CommonCode code) throws Exception;

    /**
     * 레디스에서 공통 리스트를 가져옴
     * 
     * @param comCdFg 공통코드 key
     * @return
     * @throws Exception
     */
    CommonCode getCodeList(String comCdFg) throws Exception;

    /**
     * 레디스에 해당 공통 리스트가 있는지 확인
     * 
     * @param comCdFg
     * @return true : 해당 코드 있음, false : 해당 코드 없음
     */
    boolean hasCode(String comCdFg);
}
