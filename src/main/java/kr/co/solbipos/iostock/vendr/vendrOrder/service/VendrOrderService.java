package kr.co.solbipos.iostock.vendr.vendrOrder.service;

import kr.co.common.data.structure.DefaultMap;
import kr.co.solbipos.application.session.auth.service.SessionInfoVO;
import kr.co.solbipos.iostock.cmmExcelUpload.excelUpload.service.ExcelUploadVO;

import java.util.List;

public interface VendrOrderService {
    /** 거래처 발주등록 - 거래처 발주등록 리스트 조회 */
    List<DefaultMap<String>> getVendrOrderList(VendrOrderVO vendrOrderVO, SessionInfoVO sessionInfoVO);

    /** 거래처 발주등록 - 발주정보 상세 조회 */
    DefaultMap<String> getSlipInfo(VendrOrderVO vendrOrderVO, SessionInfoVO sessionInfoVO);

    /** 거래처 발주등록 - 발주정보 저장 */
    DefaultMap<String> saveVendrOrderDtl(VendrOrderVO vendrOrderVO, SessionInfoVO sessionInfoVO);

    /** 거래처 발주등록 - 발주정보 삭제 */
    int deleteVendrOrderDtl(VendrOrderVO vendrOrderVO, SessionInfoVO sessionInfoVO);

    /** 거래처 발주등록 - 발주정보 진행상태 변경 */
    int saveProcFg(VendrOrderVO vendrOrderVO, SessionInfoVO sessionInfoVO);

    /** 거래처 발주등록 - 발주상품 리스트 조회 */
    List<DefaultMap<String>> getVendrOrderProdList(VendrOrderVO vendrOrderVO, SessionInfoVO sessionInfoVO);

    /** 거래처 발주등록 - 진행구분 조회 */
    DefaultMap<String> getProcFgCheck(VendrOrderVO vendrOrderVO, SessionInfoVO sessionInfoVO);

    /** 거래처 발주등록 - 발주상품 추가/변경 등록 리스트 조회 */
    List<DefaultMap<String>> getVendrOrderProdRegList(VendrOrderVO vendrOrderVO, SessionInfoVO sessionInfoVO);

    /** 거래처 발주등록 - 발주상품 추가/변경 등록 리스트 저장 */
    int saveVendrOrderProdReg(VendrOrderVO[] vendrOrderVOs, SessionInfoVO sessionInfoVO);

    /** 엑셀업로드 */
    int excelUpload(ExcelUploadVO excelUploadVO, SessionInfoVO sessionInfoVO);





    /** 거래처 발주등록 - 거래처 선택모듈 리스트 조회 */
    List<DefaultMap<String>> getVendrList(VendrOrderVO vendrOrderVO, SessionInfoVO sessionInfoVO);

}
