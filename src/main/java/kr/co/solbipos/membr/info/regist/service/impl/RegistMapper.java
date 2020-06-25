package kr.co.solbipos.membr.info.regist.service.impl;

import kr.co.common.data.structure.DefaultMap;
import kr.co.solbipos.membr.anals.postpaid.service.PostpaidStoreVO;
import kr.co.solbipos.membr.info.grade.service.MembrClassVO;
import kr.co.solbipos.membr.info.regist.service.MemberMappingVO;
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
 * @ 2018.11.09  김지은      회원정보관리 수정
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
    List<DefaultMap<String>> getRegistStore(HqManageVO hqManageVO);

    /**
     * 회원등급 리스트 조회
     * @param membrClassVO
     * @return
     */
    List<DefaultMap<String>> getMemberClassList(MembrClassVO membrClassVO);

    /**
     * 회원정보 리스트 조회
     *
     * @param registVO
     * @return
     */
    List<DefaultMap<String>> getMemberList(RegistVO registVO);

    /**
     * 회원정보 조회
     *
     * @param registVO
     * @return
     */
    DefaultMap<String> getMemberInfo(RegistVO registVO);


    /** 회원번호 채번 */
    String getNewMemberNo(RegistVO registVO);

    /**
     * 회원정보 저장
     *
     * @param registVO
     * @return
     */
    int registMemberInfo(RegistVO registVO);

    /** 선불회원 등록 */
    int registMemberPrepaid(RegistVO registVO);

    /**
     * 회원정보 수정
     *
     * @param registVO
     * @return
     */
    int updateMemberInfo(RegistVO registVO);

    /**
     * 회원정보 삭제
     *
     * @param registVO
     * @return
     */
    int deleteMemberInfo(RegistVO registVO);

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
     * 후불 회원 등록 매장 조회
     * @param postpaidStoreVO
     * @return
     */
    List<DefaultMap<String>> getRegStoreList(PostpaidStoreVO postpaidStoreVO);

    /**
     * 후불 회원 미등록 매장 조회
     * @param postpaidStoreVO
     * @return
     */
    List<DefaultMap<String>> getNoRegStoreList(PostpaidStoreVO postpaidStoreVO);

    /**
     * 후불회원 적용매장 삭제
     * @param postpaidStoreVO
     * @return
     */
    int deletePostpaidStore(PostpaidStoreVO postpaidStoreVO);

    /**
     * 후불회원 적용매장 등록
     * @param postpaidStoreVO
     * @return
     */
    int registPostpaidStore(PostpaidStoreVO postpaidStoreVO);

    /** 회원 거래처 매핑 코드 조회 */
    List<DefaultMap<String>> getMappingCompany(MemberMappingVO memberMappingVO);

    /** 회원 거래처 매핑코드 등록 및 저장 */
    int registMemberMappingCode(RegistVO registVO);

    /** 회원 거래처 매핑 팝업 - 회원 거래처 매핑 조회 */
    List<DefaultMap<String>> getMemberVendorMappingList(RegistVO registVO);

    /** 회원정보 등록,수정시 본사코드 A0007만 */
    int registPoslinkPtn(RegistVO registVO);

    /** 회원정보 등록,수정시 본사코드 A0007만 */
    int registSposBillPtn(RegistVO registVO);

    DefaultMap<String> getMemberSelect(RegistVO registVO);

    List<DefaultMap<String>> getCardList(RegistVO registVO);
}
