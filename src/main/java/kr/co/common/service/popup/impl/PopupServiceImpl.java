package kr.co.common.service.popup.impl;

import kr.co.common.data.domain.AgencyVO;
import kr.co.common.data.domain.HqOfficeVO;
import kr.co.common.data.domain.VanVO;
import kr.co.common.data.structure.DefaultMap;
import kr.co.common.service.message.MessageService;
import kr.co.common.service.popup.PopupService;
import kr.co.common.utils.jsp.CmmEnvUtil;
import kr.co.common.utils.spring.StringUtil;
import kr.co.solbipos.application.session.auth.service.SessionInfoVO;
import kr.co.solbipos.application.session.user.enums.OrgnFg;
import kr.co.solbipos.base.prod.info.service.ProductClassVO;
import kr.co.solbipos.base.prod.prod.service.ProdVO;
import kr.co.solbipos.base.prod.prod.service.enums.PriceEnvFg;
import kr.co.solbipos.store.manage.storemanage.service.StoreManageVO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @Class Name : PopupServiceImpl.java
 * @Description : 공통 팝업 관련
 * @Modification Information
 * @
 * @  수정일      수정자              수정내용
 * @ ----------  ---------   -------------------------------
 * @ 2018. 10.24  김지은      최초생성
 *
 * @author 솔비포스 차세대개발실 김지은
 * @since 2018. 10.24
 * @version 1.0
 *
 * @Copyright (C) by SOLBIPOS CORP. All right reserved.
 */
@Service
public class PopupServiceImpl implements PopupService{

    private final Logger LOGGER = LoggerFactory.getLogger(this.getClass());

    private final PopupMapper popupMapper;
    private final MessageService messageService;
    private final CmmEnvUtil cmmEnvUtil;

    /** Constructor Injection */
    @Autowired
    public PopupServiceImpl(PopupMapper popupMapper, MessageService messageService, CmmEnvUtil cmmEnvUtil) {
        this.popupMapper = popupMapper;
        this.messageService = messageService;
        this.cmmEnvUtil = cmmEnvUtil;
    }

    /** 벤사 목록 조회 */
    @Override
    public List<DefaultMap<String>> getVanList(VanVO vanVO) {
        return popupMapper.getVanList(vanVO);
    }

    /** 대리점 목록 조회 */
    @Override
    public List<DefaultMap<String>> getAgencyList(AgencyVO agencyVO) {
        return popupMapper.getAgencyList(agencyVO);
    }

    /** 본사 목록 조회 */
    @Override
    public List<DefaultMap<String>> getHqList(HqOfficeVO hqOfficeVO) {
        return popupMapper.getHqList(hqOfficeVO);
    }

    /** 매장 목록 조회 */
    @Override
    public List<DefaultMap<String>> getStoreList(StoreManageVO storeManageVO) {
        return popupMapper.getStoreList(storeManageVO);
    }

    /** 상품분류 트리 조회 */
    @Override
    public List<ProductClassVO> getProdClassTree(ProdVO prodVO, SessionInfoVO sessionInfoVO) {
        // 소속구분 설정
        String orgnFg = sessionInfoVO.getOrgnFg().getCode();
        prodVO.setOrgnFg(orgnFg);
        prodVO.setHqOfficeCd(sessionInfoVO.getHqOfficeCd());
        prodVO.setStoreCd(sessionInfoVO.getStoreCd());

        return popupMapper.getProdClassTree(prodVO);
    }

    /** 상품분류 플랫 조회 */
    @Override
    public String getProdClassCdNm(ProdVO prodVO, SessionInfoVO sessionInfoVO) {
        // 소속구분 설정
        String orgnFg = sessionInfoVO.getOrgnFg().getCode();
        prodVO.setOrgnFg(orgnFg);
        prodVO.setHqOfficeCd(sessionInfoVO.getHqOfficeCd());
        prodVO.setStoreCd(sessionInfoVO.getStoreCd());

        return popupMapper.getProdClassCdNm(prodVO);
    }

    /** 상품 조회 */
    @Override
    public List<DefaultMap<String>> getProductList(ProdVO prodVO, SessionInfoVO sessionInfoVO) {

        // 소속구분 설정
        String hqOfficeCd = sessionInfoVO.getHqOfficeCd();
        String storeCd = sessionInfoVO.getStoreCd();

        if(StringUtil.isEmpty(storeCd)) prodVO.setOrgnFg(OrgnFg.HQ.getCode());
        else                            prodVO.setOrgnFg(OrgnFg.STORE.getCode());

        prodVO.setHqOfficeCd(hqOfficeCd);
        prodVO.setStoreCd(storeCd);

        return popupMapper.getProductList(prodVO);
    }
}
