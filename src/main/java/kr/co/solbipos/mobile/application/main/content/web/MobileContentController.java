package kr.co.solbipos.mobile.application.main.content.web;

import kr.co.common.data.structure.DefaultMap;
import kr.co.common.service.session.SessionService;
import kr.co.solbipos.application.common.enums.MainSrchFg;
import kr.co.solbipos.application.common.service.ResrceInfoBaseVO;
import kr.co.solbipos.application.session.auth.service.SessionInfoVO;
import kr.co.solbipos.mobile.application.main.content.service.MobileContentService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;
import java.util.Map;

import static org.springframework.util.ObjectUtils.isEmpty;

/**
 * @Class Name : MobileContentController.java
 * @Description : 어플리케이션 > 메인 > 내용
 * @Modification Information
 * @
 * @  수정일      수정자              수정내용
 * @ ----------  ---------   -------------------------------
 * @ 2021.03.10  이다솜      최초생성
 *
 * @author 솔비포스 WEB개발팀 이다솜
 * @since 2021.03.10
 * @version 1.0
 * @see
 *
 * @Copyright (C) by SOLBIPOS CORP. All right reserved.
 */

@Controller
@RequestMapping(value = "/mobile/application/main/content")
public class MobileContentController {

    private final Logger LOGGER = LoggerFactory.getLogger(this.getClass());

    private final MobileContentService mobileContentService;
    private final SessionService sessionService;

    /** Constructor Injection */
    @Autowired
    public MobileContentController(MobileContentService mobileContentService, SessionService sessionService) {
        this.mobileContentService = mobileContentService;
        this.sessionService = sessionService;
    }

    /**
     * 메인페이지 (유저권한타입 : 시스템(SYSTEM))
     *
     * @param request
     * @param response
     * @param model
     * @return
     */
    @RequestMapping(value = "sys.sb", method = RequestMethod.GET)
    public String mainSYSTEM(HttpServletRequest request, HttpServletResponse response, Model model) {

        SessionInfoVO sessionInfoVO = sessionService.getSessionInfo(request);

        /** 공지사항 more 페이지이동 권한체크 */
        String board_auth = "N";
        // 세션 권한이 사용할 수 있는 메뉴 목록
        List<ResrceInfoBaseVO> menuList = sessionInfoVO.getMenuData();
        // url 값 비교
        for (ResrceInfoBaseVO resrceInfoBaseVO : menuList) {
            String authUrl = resrceInfoBaseVO.getUrl();
            if ( !isEmpty(authUrl) ) {
                // 등록된 URL 에 파라미터가 있는 경우 파라미터 제거
                if ( authUrl.contains("?") ) {
                    authUrl = authUrl.substring(0, authUrl.indexOf("?"));
                }
                if ( authUrl.equals("/adi/board/board/01/list.sb") ) {
                    board_auth = "Y";
                }
            }
        }
        model.addAttribute("board_auth", board_auth);

        /** 총 매장수(전체, 오픈, 폐점, 중지, 데모) */
        List<DefaultMap<String>> storeCntList = mobileContentService.getStoreCntList(sessionInfoVO);
        model.addAttribute("storeCntList", storeCntList);
//        System.out.println("storeCntList : "+storeCntList);

        /** 총 포스수(전체, 오픈, 폐점, 중지, 데모) */
        List<DefaultMap<String>> posCntList = mobileContentService.getPosCntList(sessionInfoVO);
        model.addAttribute("posCntList", posCntList);

        /** 주간매출(매장수/포스수) */
        List<DefaultMap<String>> weekSaleList = mobileContentService.getWeekSaleList(sessionInfoVO);
        model.addAttribute("weekSaleList", weekSaleList);

        /** 공지사항 */
        List<DefaultMap<String>> noticeList = mobileContentService.getNoticeList(sessionInfoVO);
        model.addAttribute("noticeList", noticeList);

        /** 주간 POS 설치현황(신규설치/재설치) */
        List<DefaultMap<String>> weekPosInstList = mobileContentService.getWeekPosInstList(sessionInfoVO);
        model.addAttribute("weekPosInstList", weekPosInstList);

        /** 날씨 */

        /** 주간 POS 설치 상위 대리점 */
        List<DefaultMap<String>> weekPosInstTopList = mobileContentService.getWeekPosInstTopList(sessionInfoVO);
        model.addAttribute("weekPosInstTopList", weekPosInstTopList);


//        String pUserPwd = EncUtil.setEncSHA256("ckp" + "0000");  // 포스 패스워드

        return "mobile/application/main/systemMain";
    }

    /**
     * 메인페이지 (유저권한타입 : 총판/대리점(AGENCY))
     *
     * @param request
     * @param response
     * @param model
     * @return
     */
    @RequestMapping(value = "agency.sb", method = RequestMethod.GET)
    public String mainAGENCY(HttpServletRequest request, HttpServletResponse response, Model model) {

        SessionInfoVO sessionInfoVO = sessionService.getSessionInfo(request);

        /** 공지사항 more 페이지이동 권한체크 */
        String board_auth = "N";
        // 세션 권한이 사용할 수 있는 메뉴 목록
        List<ResrceInfoBaseVO> menuList = sessionInfoVO.getMenuData();
        // url 값 비교
        for (ResrceInfoBaseVO resrceInfoBaseVO : menuList) {
            String authUrl = resrceInfoBaseVO.getUrl();
            if ( !isEmpty(authUrl) ) {
                // 등록된 URL 에 파라미터가 있는 경우 파라미터 제거
                if ( authUrl.contains("?") ) {
                    authUrl = authUrl.substring(0, authUrl.indexOf("?"));
                }
                if ( authUrl.equals("/adi/board/board/01/list.sb") ) {
                    board_auth = "Y";
                }
            }
        }
        model.addAttribute("board_auth", board_auth);

        /** 총 매장수(전체, 오픈, 폐점, 중지, 데모) */
        List<DefaultMap<String>> storeCntList = mobileContentService.getStoreCntList(sessionInfoVO);
        model.addAttribute("storeCntList", storeCntList);

        /** 총 포스수(전체, 오픈, 폐점, 중지, 데모) */
        List<DefaultMap<String>> posCntList = mobileContentService.getPosCntList(sessionInfoVO);
        model.addAttribute("posCntList", posCntList);

        /** 주간매출(매장수/포스수) */
        List<DefaultMap<String>> weekSaleList = mobileContentService.getWeekSaleList(sessionInfoVO);
        model.addAttribute("weekSaleList", weekSaleList);

        /** 공지사항 */
        List<DefaultMap<String>> noticeList = mobileContentService.getNoticeList(sessionInfoVO);
        model.addAttribute("noticeList", noticeList);

        /** 주간 POS 설치현황(신규설치/재설치) */
        List<DefaultMap<String>> weekPosInstList = mobileContentService.getWeekPosInstList(sessionInfoVO);
        model.addAttribute("weekPosInstList", weekPosInstList);

        /** 날씨 */

        /** 주간 매출 상위 가맹점 */
        List<DefaultMap<String>> weekSaleAgencyTopList = mobileContentService.getWeekSaleAgencyTopList(sessionInfoVO);
        model.addAttribute("weekSaleAgencyTopList", weekSaleAgencyTopList);


        /** 가상로그인시 세션ID 설정 */
        if ( request.getParameter("sid") != null && request.getParameter("sid").length() > 0 ) {
            model.addAttribute("sid", request.getParameter("sid"));
        }

        return "mobile/application/main/agencyMain";
    }


    /**
     * 메인페이지 (유저권한타입 : 본사(HEDOFC))
     *
     * @param request
     * @param response
     * @param model
     * @return
     */
    @RequestMapping(value = "hq.sb", method = RequestMethod.GET)
    public String mainHEDOFC(HttpServletRequest request, HttpServletResponse response, Model model) {

        SessionInfoVO sessionInfoVO = sessionService.getSessionInfo(request);

        /** 공지사항 more 페이지이동 권한체크 */
        String board_auth = "N";
        // 세션 권한이 사용할 수 있는 메뉴 목록
        List<ResrceInfoBaseVO> menuList = sessionInfoVO.getMenuData();
        // url 값 비교
        for (ResrceInfoBaseVO resrceInfoBaseVO : menuList) {
            String authUrl = resrceInfoBaseVO.getUrl();
            if ( !isEmpty(authUrl) ) {
                // 등록된 URL 에 파라미터가 있는 경우 파라미터 제거
                if ( authUrl.contains("?") ) {
                    authUrl = authUrl.substring(0, authUrl.indexOf("?"));
                }
                if ( authUrl.equals("/adi/board/board/01/list.sb") ) {
                    board_auth = "Y";
                }
            }
        }
        model.addAttribute("board_auth", board_auth);

        /** 매출현황 날짜 select box */
        List<Map<String,String>> dateSelList1 = mobileContentService.getDateSelList(MainSrchFg.TYPE1);
        model.addAttribute("dateSelList1", dateSelList1);
        List<Map<String,String>> dateSelList2 = mobileContentService.getDateSelList(MainSrchFg.TYPE2);
        model.addAttribute("dateSelList2", dateSelList2);

        /** 총 매장수(전체, 오픈, 폐점, 중지, 데모) */
        List<DefaultMap<String>> storeCntList = mobileContentService.getStoreCntList(sessionInfoVO);
        model.addAttribute("storeCntList", storeCntList);

        /** 총 포스수(전체, 오픈, 폐점, 중지, 데모) */
        List<DefaultMap<String>> posCntList = mobileContentService.getPosCntList(sessionInfoVO);
        model.addAttribute("posCntList", posCntList);

        /** 공지사항 */
        List<DefaultMap<String>> noticeList = mobileContentService.getNoticeList(sessionInfoVO);
        model.addAttribute("noticeList", noticeList);

        /** 매출현황 일별(1주) */
//        List<DefaultMap<String>> saleWeekList = contentService.getSaleWeekList(sessionInfoVO);
//        model.addAttribute("saleWeekList", saleWeekList);

        /** 매출현황 요일별(1개월) */
//        List<DefaultMap<String>> saleMonthList = contentService.getSaleMonthList(sessionInfoVO);
//        model.addAttribute("saleMonthList", saleMonthList);

        /** 매출현황 월별(1년) */
//        List<DefaultMap<String>> saleYearList = contentService.getSaleYearList(sessionInfoVO);
//        model.addAttribute("saleYearList", saleYearList);

        /** 매출 상위 상품 오늘 */
//        List<DefaultMap<String>> saleProdDayList = contentService.getSaleProdDayList(sessionInfoVO);
//        model.addAttribute("saleProdDayList", saleProdDayList);

        /** 매출 상위 상품 1주일 */
//        List<DefaultMap<String>> saleProdWeekList = contentService.getSaleProdWeekList(sessionInfoVO);
//        model.addAttribute("saleProdWeekList", saleProdWeekList);

        /** 매출 상위 상품 1개월 */
//        List<DefaultMap<String>> saleProdMonthList = contentService.getSaleProdMonthList(sessionInfoVO);
//        model.addAttribute("saleProdMonthList", saleProdMonthList);

        /** 매출 상위 가맹점 오늘 */
        List<DefaultMap<String>> saleStoreDayList = mobileContentService.getSaleStoreDayList(sessionInfoVO);
        model.addAttribute("saleStoreDayList", saleStoreDayList);

        /** 매출 상위 가맹점 1주일 */
        List<DefaultMap<String>> saleStoreWeekList = mobileContentService.getSaleStoreWeekList(sessionInfoVO);
        model.addAttribute("saleStoreWeekList", saleStoreWeekList);

        /** 매출 상위 가맹점 1개월 */
        List<DefaultMap<String>> saleStoreMonthList = mobileContentService.getSaleStoreMonthList(sessionInfoVO);
        model.addAttribute("saleStoreMonthList", saleStoreMonthList);

        /** 날씨 */


        /** 가상로그인시 세션ID 설정 */
        if ( request.getParameter("sid") != null && request.getParameter("sid").length() > 0 ) {
            model.addAttribute("sid", request.getParameter("sid"));
        }

        return "mobile/application/main/hedofcMain"; // 그래프
//        return "application/main/hedofcMain_test"; // 이미지
    }


    /**
     * 메인페이지 (유저권한타입 : 매장(MRHST), 가맹점)
     *
     * @param request
     * @param response
     * @param model
     * @return
     */
    @RequestMapping(value = "store.sb", method = RequestMethod.GET)
    public String mainMRHST(HttpServletRequest request, HttpServletResponse response, Model model) {

        SessionInfoVO sessionInfoVO = sessionService.getSessionInfo(request);

        /** 공지사항 more 페이지이동 권한체크 */
        String board_auth = "N";
        // 세션 권한이 사용할 수 있는 메뉴 목록
        List<ResrceInfoBaseVO> menuList = sessionInfoVO.getMenuData();
        // url 값 비교
        for (ResrceInfoBaseVO resrceInfoBaseVO : menuList) {
            String authUrl = resrceInfoBaseVO.getUrl();
            if ( !isEmpty(authUrl) ) {
                // 등록된 URL 에 파라미터가 있는 경우 파라미터 제거
                if ( authUrl.contains("?") ) {
                    authUrl = authUrl.substring(0, authUrl.indexOf("?"));
                }
                if ( authUrl.equals("/adi/board/board/01/list.sb") ) {
                    board_auth = "Y";
                }
            }
        }
        model.addAttribute("board_auth", board_auth);

        /** 매출현황 날짜 select box */
        List<Map<String,String>> dateSelList1 = mobileContentService.getDateSelList(MainSrchFg.TYPE1);
        model.addAttribute("dateSelList1", dateSelList1);
        List<Map<String,String>> dateSelList2 = mobileContentService.getDateSelList(MainSrchFg.TYPE2);
        model.addAttribute("dateSelList2", dateSelList2);

        /** 오늘의 매출건수 */
        List<DefaultMap<String>> daySaleCntList = mobileContentService.getDaySaleCntList(sessionInfoVO);
        model.addAttribute("daySaleCntList", daySaleCntList);

        /** 오늘의 매출금액 */
        List<DefaultMap<String>> daySaleAmtList = mobileContentService.getDaySaleAmtList(sessionInfoVO);
        model.addAttribute("daySaleAmtList", daySaleAmtList);

        /** 공지사항 */
        List<DefaultMap<String>> noticeList = mobileContentService.getNoticeList(sessionInfoVO);
        model.addAttribute("noticeList", noticeList);

        /** 매출현황 일별(1주) */
//        List<DefaultMap<String>> saleWeekList = contentService.getSaleWeekList(sessionInfoVO);
//        model.addAttribute("saleWeekList", saleWeekList);

        /** 매출현황 요일별(1개월) */
//        List<DefaultMap<String>> saleMonthList = contentService.getSaleMonthList(sessionInfoVO);
//        model.addAttribute("saleMonthList", saleMonthList);

        /** 매출현황 월별(1년) */
//        List<DefaultMap<String>> saleYearList = contentService.getSaleYearList(sessionInfoVO);
//        model.addAttribute("saleYearList", saleYearList);

        /** 매출 상위 상품 오늘 */
//        List<DefaultMap<String>> saleProdDayList = contentService.getSaleProdDayList(sessionInfoVO);
//        model.addAttribute("saleProdDayList", saleProdDayList);

        /** 매출 상위 상품 1주일 */
//        List<DefaultMap<String>> saleProdWeekList = contentService.getSaleProdWeekList(sessionInfoVO);
//        model.addAttribute("saleProdWeekList", saleProdWeekList);

        /** 매출 상위 상품 1개월 */
//        List<DefaultMap<String>> saleProdMonthList = contentService.getSaleProdMonthList(sessionInfoVO);
//        model.addAttribute("saleProdMonthList", saleProdMonthList);

        /** 날씨 */


        /** 가상로그인시 세션ID 설정 */
        if ( request.getParameter("sid") != null && request.getParameter("sid").length() > 0 ) {
            model.addAttribute("sid", request.getParameter("sid"));
        }

        return "mobile/application/main/mrhstMain"; // 그래프
//        return "application/main/mrhstMain_test"; // 이미지
    }

}