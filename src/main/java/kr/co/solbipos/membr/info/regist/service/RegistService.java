package kr.co.solbipos.membr.info.regist.service;

import kr.co.common.data.structure.DefaultMap;
import kr.co.solbipos.application.session.auth.service.SessionInfoVO;
import kr.co.solbipos.membr.anals.credit.service.CreditStoreVO;
import org.apache.poi.ss.formula.udf.DefaultUDFFinder;

import java.util.List;
import java.util.Map;

/**
 * @Class Name : RegistService.java
 * @Description : 회원관리 > 회원정보 > 회원정보관리
 * @Modification Information
 * @
 * @  수정일      수정자              수정내용
 * @ ----------  ---------   -------------------------------
 * @ 2018.05.01  정용길      최초생성
 * @ 2018.11.09  김지은      회원정보관리 수정
 *
 * @author NHN한국사이버결제 KCP 정용길
 * @since 2018.05.01
 * @version 1.0
 *
 *  Copyright (C) by SOLBIPOS CORP. All right reserved.
 */
public interface RegistService {

    /**
     * 등록 매장 리스트 조회
     *
     * @return
     */
    List<DefaultMap<String>> getRegistStore(SessionInfoVO sessionInfoVO);

    /**
     * 회원 등급 리스트 조회
     * @param sessionInfoVO
     * @return
     */
    List<DefaultMap<String>> getMembrClassList(SessionInfoVO sessionInfoVO);

    /**
     * 회원정보 리스트 조회
     *
     * @param registVO
     * @param sessionInfoVO
     * @return
     */
    List<DefaultMap<String>> getMemberList(RegistVO registVO, SessionInfoVO sessionInfoVO);

    /**
     * 회원정보 조회
     *
     * @param registVO
     * @return
     */
    DefaultMap<String> getMemberInfo(RegistVO registVO);

    /**
     * 회원정보 등록
     *
     * @param registVO
     * @return
     */
    int registMemberInfo(RegistVO registVO, SessionInfoVO sessionInfoVO);

    /**
     * 회원정보 수정
     *
     * @param registVO
     * @return
     */
    int updateMemberInfo(RegistVO registVO, SessionInfoVO sessionInfoVO );

    /**
     * 회원정보 삭제
     *
     * @param registVO
     * @return
     */
    int deleteMemberInfo(RegistVO registVO , SessionInfoVO sessionInfoVO );


    /**
     * 후불 회원 등록 매장 조회
     * @param creditStoreVO
     * @return
     */
    List<DefaultMap<String>> getCreditStoreLists(CreditStoreVO creditStoreVO, SessionInfoVO sessionInfoVO);

    /**
     * 후불회원 매장등록
     * @param creditStoreVOs
     * @return
     */
    int registCreditStore(CreditStoreVO[] creditStoreVOs, SessionInfoVO sessionInfoVO);

    /**
     * 후불회원 매장삭제
     * @param creditStoreVOs
     * @return
     */
    int deleteCreditStore(CreditStoreVO[] creditStoreVOs, SessionInfoVO sessionInfoVO);

}
