package kr.co.solbipos.iostock.loan.virtualAccount.web;

import kr.co.common.data.enums.Status;
import kr.co.common.data.structure.DefaultMap;
import kr.co.common.data.structure.Result;
import kr.co.common.service.session.SessionService;
import kr.co.common.utils.grid.ReturnUtil;
import kr.co.common.utils.spring.StringUtil;
import kr.co.solbipos.application.session.auth.service.SessionInfoVO;
import kr.co.solbipos.iostock.loan.virtualAccount.service.VirtualAccountService;
import kr.co.solbipos.iostock.loan.virtualAccount.service.VirtualAccountVO;
// API VO
import kr.co.solbipos.iostock.loan.virtualAccount.service.ApiVirtualAccountRegisterVO;
import kr.co.solbipos.iostock.loan.virtualAccount.service.ApiVirtualAccountRegisterReceiveVO;
import kr.co.solbipos.application.session.user.enums.OrgnFg;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RequestBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

import java.io.*;
import java.io.IOException;
import java.net.HttpURLConnection;
import java.net.URL;
import com.fasterxml.jackson.databind.ObjectMapper;

import static kr.co.common.utils.DateUtil.currentDateString;
import static kr.co.common.utils.DateUtil.currentDateTimeString;
import static kr.co.common.utils.HttpUtils.getClientIp;
import static kr.co.common.utils.grid.ReturnUtil.returnJson;

/**
 * @Class Name : VirtualAccountController.java
 * @Description : 수불관리 > 주문관리 > 가상계좌내역
 * @Modification Information
 * @
 * @  수정일      수정자              수정내용
 * @ ----------  ---------   -------------------------------
 * @ 2024.07.24  김설아      최초생성
 *
 * @author 솔비포스 개발본부 WEB개발팀 김설아
 * @since 2024.07.24
 * @version 1.0
 *
 *  Copyright (C) by SOLBIPOS CORP. All right reserved.
 */
@Controller
@RequestMapping("/iostock/loan/virtualAccount")
public class VirtualAccountController {

    private final SessionService sessionService;
    private final VirtualAccountService virtualAccountService;

    /** API */
    public static final String target_URL = "https://stg-spl.kcp.co.kr/gw/hub/v1/payment"; // 개발서버
//    public static final String target_URL = "https://spl.kcp.co.kr/gw/hub/v1/payment"; // 운영서버
    // 결제수단
    public static final String pay_method = "VCNT";
    // 화폐단위(원화)
    public static final String currency = "410";
    // 가상계좌 발급타입
    public static final String va_txtype = "41100000";
    /** //API */

    /**
     * Constructor Injection
     */
    @Autowired
    public VirtualAccountController(SessionService sessionService, VirtualAccountService virtualAccountService) {
        this.sessionService = sessionService;
        this.virtualAccountService = virtualAccountService;
    }

    /**
     * 페이지 이동
     *
     * @param request
     * @param response
     * @param model
     */
    @RequestMapping(value = "/virtualAccount/list.sb", method = RequestMethod.GET)
    public String virtualAccountView(HttpServletRequest request, HttpServletResponse response, Model model) {

        SessionInfoVO sessionInfoVO = sessionService.getSessionInfo(request);

        // 가상계좌 키값 리스트 조회
        VirtualAccountVO virtualAccountVO = new VirtualAccountVO();
        List<DefaultMap<String>> virtualAccountKeyColList = virtualAccountService.getVirtualAccountKeyColList(virtualAccountVO, sessionInfoVO);

        String site_cd = virtualAccountKeyColList.get(0).getStr("siteCd");
        String kcp_cert_info = virtualAccountKeyColList.get(0).getStr("kcpCertInfo");

        model.addAttribute("site_cd", site_cd);
        model.addAttribute("kcp_cert_info", kcp_cert_info);

        System.out.println("WEB_VIRTUAL_ACCOUNT >>> site_cd : " + site_cd);
        System.out.println("WEB_VIRTUAL_ACCOUNT >>> kcp_cert_info : " + kcp_cert_info);

        return "iostock/loan/virtualAccount/virtualAccount";
    }

    /**
     * 가상계좌 입금 생성 팝업 - 가상계좌 발급 (API 저장)
     *
     * @param
     * @param request
     * @param response
     * @param model
     * @return  Object
     * @author  김설아
     * @since   2024. 07. 24.
     */
    @RequestMapping(value = "/virtualAccountRegister/getVirtualAccountRegisterApiSave.sb", method = RequestMethod.POST)
    @ResponseBody
    public Result getVirtualAccountRegisterApiSave(@RequestBody VirtualAccountVO virtualAccountVO, HttpServletRequest request,
                                           HttpServletResponse response, Model model) {

        System.out.println("WEB_VIRTUAL_ACCOUNT >>> 가상계좌 >>> API sb 진입");

        SessionInfoVO sessionInfoVO = sessionService.getSessionInfo(request);

        int result = 0;
        String currentDate = currentDateString();
        String currentDt = currentDateTimeString();
        String loginIp = getClientIp(request);

        //GET 방식 HTTPS
        HttpURLConnection conn = null;
        ObjectMapper mapper = new ObjectMapper();

        // KCP API 호출(가상계좌 발급)
        ApiVirtualAccountRegisterVO apiVirtualAccountRegisterVO = new ApiVirtualAccountRegisterVO();
        apiVirtualAccountRegisterVO.setSite_cd(virtualAccountVO.getSite_cd()); // NHN KCP 발급 사이트코드
        apiVirtualAccountRegisterVO.setKcp_cert_info(virtualAccountVO.getKcp_cert_info()); // KCP PG-API 인증서정보(직렬화)
        apiVirtualAccountRegisterVO.setPay_method(pay_method); // 결제수단
        apiVirtualAccountRegisterVO.setCust_ip(loginIp); // 요청자 IP
        apiVirtualAccountRegisterVO.setAmount(virtualAccountVO.getAmount()); // 총 금액
        apiVirtualAccountRegisterVO.setVa_mny(virtualAccountVO.getVa_mny()); // 가상계좌 발급금액
        apiVirtualAccountRegisterVO.setCurrency(currency); // 화폐단위(원화)
        apiVirtualAccountRegisterVO.setOrdr_idxx(virtualAccountVO.getOrdr_idxx()); // 상점관리 주문번호
        apiVirtualAccountRegisterVO.setGood_name(virtualAccountVO.getGood_name()); // 상품명
        apiVirtualAccountRegisterVO.setBuyr_name(virtualAccountVO.getBuyr_name()); // 주문자 명
        apiVirtualAccountRegisterVO.setBuyr_mail(virtualAccountVO.getBuyr_mail()); // 주문자 E-Mail
        apiVirtualAccountRegisterVO.setBuyr_tel2(virtualAccountVO.getBuyr_tel2()); // 주문자 휴대폰번호
        apiVirtualAccountRegisterVO.setVa_txtype(va_txtype); // 가상계좌 발급타입
        apiVirtualAccountRegisterVO.setVa_bankcode(virtualAccountVO.getVa_bankcode()); // 발급할 계좌의 은행코드
        apiVirtualAccountRegisterVO.setVa_name(virtualAccountVO.getVa_name()); // 입금자명
        apiVirtualAccountRegisterVO.setVa_date(virtualAccountVO.getVa_date()); // 입금 마감시각
        apiVirtualAccountRegisterVO.setVa_receipt_gubn(virtualAccountVO.getVa_receipt_gubn()); // 현금영수증 발행용도
        apiVirtualAccountRegisterVO.setVa_taxno(virtualAccountVO.getVa_taxno()); // 현금영수증 식별번호

        virtualAccountVO.setPay_method(pay_method); // 결제수단
        virtualAccountVO.setCust_ip(loginIp); // 요청자 IP
        virtualAccountVO.setCurrency(currency); // 화폐단위(원화)
        virtualAccountVO.setVa_txtype(va_txtype); // 가상계좌 발급타입
        virtualAccountVO.setReqDate(currentDate);
        virtualAccountVO.setRegDt(currentDt);

        // 가상계좌 등록순번 조회
        String reqSeq = virtualAccountService.getVirtualAccountReqSeq(virtualAccountVO);
        virtualAccountVO.setReqSeq(reqSeq);

        // 가상계좌 발급 저장 Insert
        result = virtualAccountService.getVirtualAccountRegisterSaveInsert(virtualAccountVO, sessionInfoVO);

        // KCP API 응답(가상계좌 발급)
        ApiVirtualAccountRegisterReceiveVO apiVirtualAccountRegisterReceiveVO = new ApiVirtualAccountRegisterReceiveVO();

        DefaultMap<Object> resultMap = new DefaultMap<Object>();

        try {
            // 객체를 JSON 타입의 String으로 변환
            String jsonString = mapper.writeValueAsString(apiVirtualAccountRegisterVO);

            System.out.println("WEB_VIRTUAL_ACCOUNT >>> 가상계좌 >>> API 호출 인자 값 : " + jsonString);

            URL url = new URL(target_URL);
            conn = (HttpURLConnection)url.openConnection();
            conn.setDoOutput(true);
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Content-Type", "application/json");
            conn.setRequestProperty("Accept-Charset", "UTF-8");

            OutputStreamWriter osw = new OutputStreamWriter(conn.getOutputStream(), "UTF-8");
            osw.write(jsonString);
            osw.flush();

            BufferedReader br = null;
            //url -> json으로 던짐
            br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
            StringBuilder sb = new StringBuilder();
            String line = null;
            //string으로 데이터 받음.
            while ((line = br.readLine()) != null) {
                sb.append(line);
            }

            System.out.println("WEB_VIRTUAL_ACCOUNT >>> 가상계좌 >>> API 호출 URL : " + url);
            System.out.println("WEB_VIRTUAL_ACCOUNT >>> 가상계좌 >>> API 응답 인자 값 : " +  sb.toString());

            //json 데이터를 클래스에 넣음.
            apiVirtualAccountRegisterReceiveVO = mapper.readValue(sb.toString(), ApiVirtualAccountRegisterReceiveVO.class);

            resultMap.put("resultCode", apiVirtualAccountRegisterReceiveVO.getRes_cd());
            resultMap.put("resultMessage", apiVirtualAccountRegisterReceiveVO.getRes_msg());

            virtualAccountVO.setRes_cd(apiVirtualAccountRegisterReceiveVO.getRes_cd());
            virtualAccountVO.setRes_msg(apiVirtualAccountRegisterReceiveVO.getRes_msg());
            virtualAccountVO.setTno(apiVirtualAccountRegisterReceiveVO.getTno());
            virtualAccountVO.setAmount(apiVirtualAccountRegisterReceiveVO.getAmount());
            virtualAccountVO.setBankname(apiVirtualAccountRegisterReceiveVO.getBankname());
            virtualAccountVO.setBankcode(apiVirtualAccountRegisterReceiveVO.getBankcode());
            virtualAccountVO.setDepositor(apiVirtualAccountRegisterReceiveVO.getDepositor());
            virtualAccountVO.setAccount(apiVirtualAccountRegisterReceiveVO.getAccount());
            virtualAccountVO.setApp_time(apiVirtualAccountRegisterReceiveVO.getApp_time());
            if(virtualAccountVO.getRes_cd().equals("0000")){
                virtualAccountVO.setDepositFg("1");
            } else {
                virtualAccountVO.setDepositFg("2");
            }
            virtualAccountVO.setResDt(currentDt);

            // 가상계좌 발급 저장 update
            result = virtualAccountService.getVirtualAccountRegisterSaveUpdate(virtualAccountVO, sessionInfoVO);

        } catch (IOException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        System.out.println("WEB_VIRTUAL_ACCOUNT >>> 가상계좌 >>> API sb 끝");

        return returnJson(Status.OK, resultMap);
    }
}