package kr.co.solbipos.base.prod.prod.service.impl;

import kr.co.common.data.structure.DefaultMap;
import kr.co.solbipos.base.prod.prod.service.ProdVO;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @Class Name : ProdMapper.java
 * @Description : 기초관리 - 상품관리 - 상품조회
 * @Modification Information
 * @
 * @  수정일      수정자              수정내용
 * @ ----------  ---------   -------------------------------
 * @ 2018.08.06  장혁수       최초생성
 * @ 2018.10.19  노현수       상품조회 관련 변경
 *
 * @author NHN한국사이버결제 KCP 장혁수
 * @since 2018. 08.06
 * @version 1.0
 *
 *  Copyright (C) by SOLBIPOS CORP. All right reserved.
 */
@Mapper
@Repository
public interface ProdMapper {

    /**
     * 상품 조회
     * @param prodVO
     * @return List
     */
    List<DefaultMap<String>> getProdList(ProdVO prodVO);

    /**
     * 상품 조회(엑셀다운로드용)
     * @param prodVO
     * @return List
     */
    List<DefaultMap<String>> getProdExcelList(ProdVO prodVO);

    /**
     * 상품 상세 조회
     * @param prodVO
     * @return DefaultMap
     */
    DefaultMap<String> getProdDetail(ProdVO prodVO);

    /**
     * 연결상품 조회
     * @param prodVO
     * @return List
     */
    List<DefaultMap<String>> getLinkedProdList(ProdVO prodVO);

    /** 상품정보 저장 */
    int saveProductInfo(ProdVO prodVO);

    /** 본사에서는 프로시저 호출에 사용할 상품의 존재여부를 미리 체크함 */
    int getProdExistInfo(ProdVO prodVO);

    /** 상품코드 조회 */
    String getProdCd(ProdVO prodVO);

    /** prefix 상품코드 조회*/
    String getPrefixProdCd(ProdVO prodVO);

    /** 본사 상품정보 등록시 매장 상품정보에 등록 */
    String insertHqProdToStoreProd(ProdVO prodVO);

    /** 본사 상품정보 수정시 매장 상품정보 수정 */
    String updateHqProdToStoreProd(ProdVO prodVO);

    /** 상품 적용/미적용 매장 조회 */
    List<DefaultMap<String>> getStoreList(ProdVO prodVO);

    /** 상품 적용 매장 등록 */
    int insertProdStore(ProdVO prodVO);

    /** 상품 판매가 저장 */
    int saveSalePrice(ProdVO prodVO);

    /** 상품 판매가 변경 히스토리 등록 */
    int saveSalePriceHistory(ProdVO prodVO);

    /** 상품등록 본사통제여부가 본사인 경우, 본사 상품 등록시 매장 상품 등록 */
    int insertProdStoreDetail(ProdVO prodVO);

    /** 상품판매가 본사통제여부가 본사인 경우, 본사 판매가 등록시 매장 판매가 등록 */
    String saveStoreSalePrice(ProdVO prodVO);

    /** 상품 적용 매장 삭제 */
    int deleteProdStore(ProdVO prodVO);

    /** 상품 매장 적용 삭제시, 해당 상품의 USE_YN 값 변경 */
    int deleteProdStoreDetail(ProdVO prodVO);

    /** 판매가 변경 히스토리 등록 count 조회 */
    int getRegistProdCount(ProdVO prodVO);

    /** 매장 상품 판매가 변경 히스토리 등록 */
    int updateStoreSaleUprcHistory(ProdVO prodVO);

    /** 매장 상품 판매가 변경 */
    int updateStoreSaleUprc(ProdVO prodVO);

    /** 상품코드 중복체크*/
    int getProdCdCnt(ProdVO prodVO);

    /** 바코드 중복체크*/
    List<DefaultMap<String>> chkBarCd(ProdVO prodVO);

    /** 상품 바코드 존재 여부 확인 */
    int getProdBarCdCnt(ProdVO prodVO);

    /** 상품 적용 매장 등록시, 본사의 상품의 바코드 매장으로 등록 */
    int insertProdBarcdStoreDetail(ProdVO prodVO);

    /** 본사 상품 등록시, 본사 상품의 바코드 등록 */
    int saveProdBarcd(ProdVO prodVO);

    /** 바코드가 공백일경우 기존 바코드 정보 삭제 */
    int deleteProdBarcd(ProdVO prodVO);

    /** 바코드가 공백일경우 기존 바코드 정보 삭제(매장것도 삭제) */
    int deleteProdBarcdStore(ProdVO prodVO);

    /** 매장 상품의 바코드 등록 프로시저 */
    int saveProdBarcdStore(ProdVO prodVO);

    /** 본사상품 매장 등록 시, 해당 상품을 사용하는 매장에도  사이드 그룹 추가 */
    String insertSdselGrpToStore (ProdVO prodVO);

    /** 본사상품 매장 등록 시, 해당 상품을 사용하는 매장에도  사이드 분류 추가 */
    String insertSdselClassToStore (ProdVO prodVO);

    /** 본사상품 매장 등록 시, 해당 상품을 사용하는 매장에도  사이드 선택상품 추가 */
    String insertSdselProdToStore (ProdVO prodVO);

    /** 매장 적용 상품 조회 */
    List<DefaultMap<String>> getStoreProdRegList(ProdVO prodVO);

    /** 매장 미적용 상품 조회 */
    List<DefaultMap<String>> getStoreProdNoRegList(ProdVO prodVO);

    /** 본사 상품 등록시, 본사 상품의 상품분류 등록 */
    String insertClsHqToStore(ProdVO prodVO);

    /** 본사 상품 등록시, 본사 상품의 상품분류 수정 */
    String updateClsHqToStore(ProdVO prodVO);

    /** 상품 이미지 저장시 파일여부 체크 */
    String getProdImageFileSaveCheck(ProdVO ProdVO);

    /** 상품 신규등록,수정 팝업 - 상품 이미지 저장 insert */
    int getProdImageFileSaveInsert(ProdVO ProdVO);

    /** 상품 신규등록,수정 팝업 - 상품 이미지 저장 update */
    int getProdImageFileSaveUpdate(ProdVO ProdVO);

    /** 상품 신규등록,수정 팝업 - 상품 이미지 저장 delete */
    int getProdImageFileSaveDelete(ProdVO ProdVO);

    /** 상품 이미지 삭제시 파일명 가져오기 */
    String getProdImageFileSaveImgFileNm(ProdVO ProdVO);

    /** 미적용 상품 거래처 조회 팝업 - 조회 */
    List<DefaultMap<String>> getSearchNoProdVendrList(ProdVO prodVO);

    /** 브랜드 콤보박스 리스트 조회 */
    List<DefaultMap<String>> getBrandComboList(ProdVO prodVO);

    /** 거래처 삭제 */
    int getVendorProdSaveUpdate(ProdVO prodVO);

    /** 거래처 저장 */
    int getVendorProdSaveInsert(ProdVO prodVO);

    /** 사이드메뉴관리의 선택상품에 등록된 상품인지 조회 */
    List<DefaultMap<Object>> getSideProdChk(ProdVO prodVO);


    /** 본사환경설정 [1111 사이드상품자동생성] 조회 */
    String getHqEnvCodeSide(ProdVO prodVO);

    /** 사이드메뉴관리의 선택상품에 등록된 상품 리스트 */
    String getHqSdselProd(ProdVO prodVO);

    /** 매장 상품저장시 등록매장 테이블에도 저장 */
    int insertHqProdStoreTotal(ProdVO prodVO);
    int insertHqProdStore(ProdVO prodVO);

    /** 본사 상품등록시 선택한 사이드메뉴에 걸린 상품 매장에 저장 */
    int insertHqSdselProdStoreTotal(ProdVO prodVO);

    /** 본사 상품등록시 선택한 사이드메뉴에 걸린 상품 바코드 매장에 저장 */
    int insertHqSdselProdStoreBarcdTotal(ProdVO prodVO);

    /** 본사 상품등록시 선택한 사이드메뉴에 걸린 상품 분류 매장에 저장 */
    int insertHqSdselProdStoreClassTotal(ProdVO prodVO);
    int insertHqSdselProdStoreClass(ProdVO prodVO);

    /** 프린터 리스트 조회 */
    List<DefaultMap<String>> getKitchenprintList(ProdVO prodVO);

    /** 프린트 연결 */
    int kitchenprintLink(ProdVO prodVO);

    /** 브랜드 리스트 조회(선택 콤보박스용) */
    List<DefaultMap<Object>> getBrandList(ProdVO prodVO);

    /** 브랜드 리스트 조회(선택 콤보박스용, 선택한 상품에서 현재 사용중인 브랜드 + 사용여부 'Y'인 브랜드) */
    List<DefaultMap<Object>> getBrandList2(ProdVO prodVO);

    /** 세트구성상품 팝업 - 구성내역 리스트 조회 */
    List<DefaultMap<String>> getSetConfigProdList(ProdVO prodVO);

    /** 세트구성상품 팝업 - 상품 리스트 조회 */
    List<DefaultMap<String>> getSrchSetConfigProdList(ProdVO prodVO);

    /** 세트구성상품 팝업 - 상품 새 표기순번 조회 */
    String getSetConfigProdDispSeq(ProdVO prodVO);

    /** 세트구성상품 팝업 - 구성내역 상품등록 */
    int insertSetConfigProd(ProdVO prodVO);

    /** 세트구성상품 팝업 - 구성내역 상품수정 */
    int updateSetConfigProd(ProdVO prodVO);

    /** 세트구성상품 팝업 - 구성내역 상품삭제 */
    int deleteSetConfigProd(ProdVO prodVO);

    /** 선택메뉴 조회 팝업 */
    List<DefaultMap<String>> getSearchSdselGrpList(ProdVO prodVO);
}