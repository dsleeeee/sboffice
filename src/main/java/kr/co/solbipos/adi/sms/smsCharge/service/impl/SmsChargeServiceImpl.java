package kr.co.solbipos.adi.sms.smsCharge.service.impl;

import kr.co.common.data.structure.DefaultMap;
import kr.co.common.utils.spring.StringUtil;
import kr.co.common.utils.jsp.CmmEnvUtil;
import kr.co.solbipos.application.session.auth.service.SessionInfoVO;
import kr.co.solbipos.adi.sms.smsCharge.service.SmsChargeService;
import kr.co.solbipos.adi.sms.smsCharge.service.SmsChargeVO;
import kr.co.solbipos.adi.sms.smsChargeHist.service.impl.SmsChargeHistMapper;
import kr.co.solbipos.adi.sms.smsChargeHist.service.SmsChargeHistVO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import kr.co.solbipos.application.com.griditem.enums.GridDataFg;

import java.util.List;

import static kr.co.common.utils.DateUtil.currentDateTimeString;

/**
 * @Class Name : SmsChargeServiceImpl.java
 * @Description : 부가서비스 > SMS관리 > SMS충전/KCP PG
 * @Modification Information
 * @
 * @  수정일      수정자              수정내용
 * @ ----------  ---------   -------------------------------
 * @ 2021.06.09  김설아      최초생성
 *
 * @author 솔비포스 개발본부 WEB개발팀 김설아
 * @since 2021.06.09
 * @version 1.0
 *
 *  Copyright (C) by SOLBIPOS CORP. All right reserved.
 */
@Service("smsChargeService")
@Transactional
public class SmsChargeServiceImpl implements SmsChargeService {
    private final SmsChargeMapper smsChargeMapper;
    private final SmsChargeHistMapper smsChargeHistMapper; // SMS충전내역
    private final Logger LOGGER = LoggerFactory.getLogger(this.getClass());

    /**
     * Constructor Injection
     */
    @Autowired
    public SmsChargeServiceImpl(SmsChargeMapper smsChargeMapper, SmsChargeHistMapper smsChargeHistMapper) {
        this.smsChargeMapper = smsChargeMapper;
        this.smsChargeHistMapper = smsChargeHistMapper; // SMS충전내역
    }

    /** 충전결제 저장 */
    @Override
    public int getSmsChargeSaveInsert(SmsChargeVO smsChargeVO) {

        int procCnt = 0;
        String currentDt = currentDateTimeString();

        // 현재 잔여금액
        String smsBaseAmt = smsChargeMapper.getSmsBaseAmtSelect(smsChargeVO);

        LOGGER.info("충전결제 >>> 현재 잔여금액 : " + smsBaseAmt);

        // SmsChargeHistVO
        SmsChargeHistVO smsChargeHistVO = new SmsChargeHistVO();
        smsChargeHistVO.setRegDt(currentDt);
        smsChargeHistVO.setRegId(smsChargeVO.getUserId());
        smsChargeHistVO.setModDt(currentDt);
        smsChargeHistVO.setModId(smsChargeVO.getUserId());

        smsChargeHistVO.setSelectOrgnCd(smsChargeVO.getOrgnCd());
        smsChargeHistVO.setChargeDate(smsChargeVO.getChargeDate());
        smsChargeHistVO.setChargeTime(smsChargeVO.getChargeTime());
        smsChargeHistVO.setPgresource(smsChargeVO.getPgresource());
        smsChargeHistVO.setChargeAmt(smsChargeVO.getChargeAmt()); // 충전금액
        smsChargeHistVO.setSuccessYn(smsChargeVO.getSuccessYn());
        smsChargeHistVO.setControlno(smsChargeVO.getControlno());
        smsChargeHistVO.setApprovalnum(smsChargeVO.getApprovalnum());
        smsChargeHistVO.setResultcode(smsChargeVO.getResultcode());
        smsChargeHistVO.setResultmessage(smsChargeVO.getResultmessage());
        smsChargeHistVO.setBaseChargeAmt(smsBaseAmt); // 기초충전금액

        LOGGER.info("충전결제 >>> 충전할 충전금액 : " + smsChargeVO.getChargeAmt());

        procCnt = smsChargeHistMapper.getSmsChargeRegistSaveInsert(smsChargeHistVO);

        // 잔여금액
        int smsAmt = Integer.parseInt(smsChargeHistVO.getBaseChargeAmt()) + Integer.parseInt(smsChargeHistVO.getChargeAmt());
        smsChargeHistVO.setSmsAmt(String.valueOf(smsAmt));

        LOGGER.info("충전결제 >>> 수정될 잔여금액 : " + smsBaseAmt);

        // 잔여금액 저장 insert
        procCnt = smsChargeHistMapper.getSmsQtySaveInsert(smsChargeHistVO);

        return procCnt;
    }

    /** 결제취소 저장 */
    @Override
    public int getSmsChargeSaveUpdate(SmsChargeVO smsChargeVO) {

        int procCnt = 0;
        String currentDt = currentDateTimeString();

        smsChargeVO.setModDt(currentDt);
        smsChargeVO.setModId(smsChargeVO.getUserId());

        procCnt = smsChargeMapper.getSmsChargeSaveUpdate(smsChargeVO);

        // 현재 잔여금액
        String smsBaseAmt = smsChargeMapper.getSmsBaseAmtSelect(smsChargeVO);

        LOGGER.info("결제취소 >>> 현재 잔여금액 : " + smsBaseAmt);

        // 충전금액
        String smsChargeAmt = smsChargeMapper.getSmsChargeAmtSelect(smsChargeVO);

        LOGGER.info("결제취소 >>> 충전했던 충전금액 : " + smsChargeAmt);

        // SmsChargeHistVO
        SmsChargeHistVO smsChargeHistVO = new SmsChargeHistVO();
        smsChargeHistVO.setRegDt(currentDt);
        smsChargeHistVO.setRegId(smsChargeVO.getUserId());
        smsChargeHistVO.setModDt(currentDt);
        smsChargeHistVO.setModId(smsChargeVO.getUserId());

        smsChargeHistVO.setSelectOrgnCd(smsChargeVO.getOrgnCd());

        // 잔여금액
        int smsAmt = Integer.parseInt(smsBaseAmt) - Integer.parseInt(smsChargeAmt);
        smsChargeHistVO.setSmsAmt(String.valueOf(smsAmt));

        LOGGER.info("결제취소 >>> 수정될 잔여금액 : " + smsBaseAmt);

        // 잔여금액 저장 insert
        procCnt = smsChargeHistMapper.getSmsQtySaveInsert(smsChargeHistVO);

        return procCnt;
    }
}