package kr.co.solbipos.membr.info.regist.service.impl;

import kr.co.common.data.structure.DefaultMap;
import kr.co.solbipos.membr.info.grade.service.MembrClassVO;
import kr.co.solbipos.membr.info.regist.service.CreditStoreVO;
import kr.co.solbipos.membr.info.regist.service.RegistVO;
import kr.co.solbipos.store.hq.hqmanage.service.HqManageVO;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @Class Name : RegistMapper.java
 * @Description : 회원관리 > 회원정보 > 회원정보관리
 * @Modification Information
 * @
 * @  수정일      수정자              수정내용
 * @ ----------  ---------   -------------------------------
 * @ 2018.05.01  정용길      최초생성
 *
 * @author NHN한국사이버결제 KCP 정용길
 * @since 2018.05.01
 * @version 1.0
 *
 *  Copyright (C) by SOLBIPOS CORP. All right reserved.
 */
@Mapper
@Repository
public interface RegistMapper {

    /**
     * 등록 매장 리스트 조회
     *
     * @return
     */
    List<DefaultMap<String>> selectRgstrStore(HqManageVO hqManageVO);

    /**
     * 회원등급 리스트 조회
     * @param membrClassVO
     * @return
     */
    List<DefaultMap<String>> selectMemberClassList(MembrClassVO membrClassVO);

    /**
     * 회원정보 리스트 조회
     *
     * @param registVO
     * @param <E>
     * @return
     */
    <E> List<E> selectMembers(RegistVO registVO);

    /**
     * 회원정보 조회
     *
     * @param registVO
     * @return
     */
    RegistVO selectMember(RegistVO registVO);

    /**
     * 회원정보 저장
     *
     * @param registVO
     * @return
     */
    int insertRegistMember(RegistVO registVO);

    /**
     * 회원정보 수정
     *
     * @param registVO
     * @return
     */
    int updateMember(RegistVO registVO);

    /**
     * 회원정보 삭제
     *
     * @param registVO
     * @return
     */
    int deleteMember(RegistVO registVO);

    /**
     * 회원카드 등록
     *
     * @param registVO
     * @return
     */
    int insertMembrCard(RegistVO registVO);

    /**
     * 회원카드 수정
     *
     * @param registVO
     * @return
     */
    int updateMembrCard(RegistVO registVO);


    /**
     * 등록된 후불회원 적용매장 조회
     * @param registVO
     * @return
     */
    String getCurrentCreditStore(RegistVO registVO);

    /**
     * 후불회원 적용매장 삭제
     * @param creditStoreVO
     * @return
     */
    int deleteCreditStore(CreditStoreVO creditStoreVO);

    /**
     * 후불회원 적용매장 등록
     * @param creditStoreVO
     * @return
     */
    int registCreditStore(CreditStoreVO creditStoreVO);
}
