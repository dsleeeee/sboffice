package kr.co.solbipos.sale.anals.versusPeriod.cls.service.impl;

import java.util.List;

import kr.co.common.service.popup.impl.PopupMapper;
import kr.co.common.utils.CmmUtil;
import kr.co.solbipos.application.common.service.StoreVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.common.data.structure.DefaultMap;
import kr.co.common.service.message.MessageService;
import kr.co.common.utils.spring.StringUtil;
import kr.co.solbipos.application.session.auth.service.SessionInfoVO;
import kr.co.solbipos.sale.anals.versusPeriod.cls.service.VersusPeriodClassService;
import kr.co.solbipos.sale.anals.versusPeriod.cls.service.VersusPeriodClassVO;

@Service("VersusPeriodClassService")
public class VersusPeriodClassServiceImpl implements VersusPeriodClassService {
    private final VersusPeriodClassMapper versusPeriodClassMapper;
    private final PopupMapper popupMapper;
    private final MessageService messageService;

    @Autowired
    public VersusPeriodClassServiceImpl(VersusPeriodClassMapper versusPeriodClassMapper, PopupMapper popupMapper, MessageService messageService) {
    	this.versusPeriodClassMapper = versusPeriodClassMapper;
    	this.popupMapper = popupMapper;
        this.messageService = messageService;
    }


    /** 대비기간매출분석 - 분류상품별 리스트 조회 */
    @Override
    public List<DefaultMap<String>> getVersusPeriodClassList(VersusPeriodClassVO versusPeriodClassVO, SessionInfoVO sessionInfoVO) {

		versusPeriodClassVO.setOrgnFg(sessionInfoVO.getOrgnFg().getCode());
		versusPeriodClassVO.setHqOfficeCd(sessionInfoVO.getHqOfficeCd());
		versusPeriodClassVO.setEmpNo(sessionInfoVO.getEmpNo());

        if(!StringUtil.getOrBlank(versusPeriodClassVO.getStoreCd()).equals("")) {
            StoreVO storeVO = new StoreVO();
            storeVO.setArrSplitStoreCd(CmmUtil.splitText(versusPeriodClassVO.getStoreCd(), 3900));
            versusPeriodClassVO.setStoreCdQuery(popupMapper.getSearchMultiStoreRtn(storeVO));
        }

        return versusPeriodClassMapper.getVersusPeriodClassList(versusPeriodClassVO);
    }

    /** 대비기간매출분석 - 분류상품별 리스트 상세 조회 */
	@Override
	public List<DefaultMap<String>> getVersusPeriodClassDtlList(VersusPeriodClassVO versusPeriodClassVO, SessionInfoVO sessionInfoVO) {

		versusPeriodClassVO.setOrgnFg(sessionInfoVO.getOrgnFg().getCode());
		versusPeriodClassVO.setHqOfficeCd(sessionInfoVO.getHqOfficeCd());
		versusPeriodClassVO.setEmpNo(sessionInfoVO.getEmpNo());

        if(!StringUtil.getOrBlank(versusPeriodClassVO.getStoreCd()).equals("")) {
            StoreVO storeVO = new StoreVO();
            storeVO.setArrSplitStoreCd(CmmUtil.splitText(versusPeriodClassVO.getStoreCd(), 3900));
            versusPeriodClassVO.setStoreCdQuery(popupMapper.getSearchMultiStoreRtn(storeVO));
        }

		return versusPeriodClassMapper.getVersusPeriodClassDtlList(versusPeriodClassVO);
	}

    /** 대비기간매출분석 - 분류상품별 리스트(엑셀) 상세 조회 */
	@Override
	public List<DefaultMap<String>> getVersusPeriodClassDtlExcelList(VersusPeriodClassVO versusPeriodClassVO, SessionInfoVO sessionInfoVO) {

		versusPeriodClassVO.setOrgnFg(sessionInfoVO.getOrgnFg().getCode());
		versusPeriodClassVO.setHqOfficeCd(sessionInfoVO.getHqOfficeCd());
		versusPeriodClassVO.setEmpNo(sessionInfoVO.getEmpNo());

        if(!StringUtil.getOrBlank(versusPeriodClassVO.getStoreCd()).equals("")) {
            StoreVO storeVO = new StoreVO();
            storeVO.setArrSplitStoreCd(CmmUtil.splitText(versusPeriodClassVO.getStoreCd(), 3900));
            versusPeriodClassVO.setStoreCdQuery(popupMapper.getSearchMultiStoreRtn(storeVO));
        }

		return versusPeriodClassMapper.getVersusPeriodClassDtlExcelList(versusPeriodClassVO);
	}
	/** 대비기간매출분석 - 분류상품별 리스트 상세 차트 조회 */
	@Override
	public List<DefaultMap<String>> getVersusPeriodClassDtlChartList(VersusPeriodClassVO versusPeriodClassVO, SessionInfoVO sessionInfoVO) {

		versusPeriodClassVO.setOrgnFg(sessionInfoVO.getOrgnFg().getCode());
		versusPeriodClassVO.setHqOfficeCd(sessionInfoVO.getHqOfficeCd());
		versusPeriodClassVO.setEmpNo(sessionInfoVO.getEmpNo());

        if(!StringUtil.getOrBlank(versusPeriodClassVO.getStoreCd()).equals("")) {
            StoreVO storeVO = new StoreVO();
            storeVO.setArrSplitStoreCd(CmmUtil.splitText(versusPeriodClassVO.getStoreCd(), 3900));
            versusPeriodClassVO.setStoreCdQuery(popupMapper.getSearchMultiStoreRtn(storeVO));
        }

		return versusPeriodClassMapper.getVersusPeriodClassDtlChartList(versusPeriodClassVO);
	}

	/** 대비기간매출분석 - 브랜드 코드 조회조건 */
	@Override
	public List<DefaultMap<String>> getBrandCdList(VersusPeriodClassVO versusPeriodClassVO, SessionInfoVO sessionInfoVO) {
		versusPeriodClassVO.setHqOfficeCd(sessionInfoVO.getHqOfficeCd());

		return versusPeriodClassMapper.getBrandCdList(versusPeriodClassVO);
	}


}
