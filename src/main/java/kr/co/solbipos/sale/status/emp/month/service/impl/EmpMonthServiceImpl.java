package kr.co.solbipos.sale.status.emp.month.service.impl;

import kr.co.common.data.structure.DefaultMap;
import kr.co.common.service.message.MessageService;
import kr.co.common.utils.spring.StringUtil;
import kr.co.solbipos.application.session.auth.service.SessionInfoVO;
import kr.co.solbipos.sale.status.emp.day.service.EmpDayVO;
import kr.co.solbipos.sale.status.emp.month.service.EmpMonthService;
import kr.co.solbipos.sale.status.emp.month.service.EmpMonthVO;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("EmpMonthService")
public class EmpMonthServiceImpl implements EmpMonthService {
    private final EmpMonthMapper empMonthMapper;
    private final MessageService messageService;

    @Autowired
    public EmpMonthServiceImpl(EmpMonthMapper empMonthMapper, MessageService messageService) {
    	this.empMonthMapper = empMonthMapper;
        this.messageService = messageService;
    }

    /** 판매자별 매출 -월별 리스트 조회  */
    @Override
    public List<DefaultMap<String>> getEmpMonthList(EmpMonthVO empMonthVO, SessionInfoVO sessionInfoVO) {
  
    	empMonthVO.setHqOfficeCd(sessionInfoVO.getHqOfficeCd());
    	
        if(!StringUtil.getOrBlank(empMonthVO.getStoreCd()).equals("")) {
        	empMonthVO.setArrStoreCd(empMonthVO.getStoreCd().split(","));
        }
    	
        // 판매자별 쿼리 변수
        String sQuery1 = "";
        String sQuery2 = "";
        
        List<DefaultMap<String>> empNo = empMonthMapper.getEmpMebList(empMonthVO);

        for(int i = 0; i < empNo.size(); i++) {
        	String j = empNo.get(i).get("nmcodeCd");
        	String k = empNo.get(i).get("storeCd");
        	sQuery1 +=", SUM(A.REAL_SALE_AMT" + i + ") AS REAL_SALE_AMT" + i +  "\n";
        	sQuery1 +=", SUM(A.BILL_CNT" + i + ") AS BILL_CNT" + i +  "\n";
        	sQuery2 +=", CASE WHEN TSDE.STORE_CD =" + "'"+k+"'" + " AND TSDE.EMP_NO = " + "'"+j+"'" + " THEN SUM(TSDE.REAL_SALE_AMT) ELSE NULL END AS REAL_SALE_AMT" + i +  "\n";
        	sQuery2 +=", CASE WHEN TSDE.STORE_CD =" + "'"+k+"'" + " AND TSDE.EMP_NO = " + "'"+j+"'" + " THEN SUM(TSDE.BILL_CNT) ELSE NULL END AS BILL_CNT" + i +  "\n";      	
        }
        
        empMonthVO.setsQuery1(sQuery1);
        empMonthVO.setsQuery2(sQuery2);
        
        return empMonthMapper.getEmpMonthList(empMonthVO);
    }
    
    /** 판매자별 매출 -판매자 리스트 조회  */
    @Override
    public List<DefaultMap<String>> getEmpMebList(EmpMonthVO empMonthVO, SessionInfoVO sessionInfoVO) {
  
    	empMonthVO.setHqOfficeCd(sessionInfoVO.getHqOfficeCd());
    	
        if(!StringUtil.getOrBlank(empMonthVO.getStoreCd()).equals("")) {
        	empMonthVO.setArrStoreCd(empMonthVO.getStoreCd().split(","));
        }
        
        return empMonthMapper.getEmpMebList(empMonthVO);
    }
}
