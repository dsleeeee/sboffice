package kr.co.solbipos.adi.sms.smsCharge.service.impl;

import kr.co.common.data.structure.DefaultMap;
import kr.co.common.utils.spring.StringUtil;
import kr.co.common.utils.jsp.CmmEnvUtil;
import kr.co.solbipos.application.session.auth.service.SessionInfoVO;
import kr.co.solbipos.adi.sms.smsCharge.service.SmsChargeService;
import kr.co.solbipos.adi.sms.smsCharge.service.SmsChargeVO;
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

    /**
     * Constructor Injection
     */
    @Autowired
    public SmsChargeServiceImpl(SmsChargeMapper smsChargeMapper) {
        this.smsChargeMapper = smsChargeMapper;
    }
}