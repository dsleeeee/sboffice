package kr.co.common.interceptor;

import kr.co.common.data.enums.Status;
import kr.co.common.exception.AuthenticationException;
import kr.co.common.exception.JsonException;
import kr.co.common.service.cmm.CmmMenuService;
import kr.co.common.service.message.MessageService;
import kr.co.common.service.session.SessionService;
import kr.co.common.utils.CmmUtil;
import kr.co.common.utils.spring.WebUtil;
import kr.co.solbipos.application.common.enums.ResrceFg;
import kr.co.solbipos.application.common.service.ResrceInfoVO;
import kr.co.solbipos.application.session.auth.service.SessionInfoVO;
import kr.co.solbipos.application.session.user.enums.OrgnFg;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.List;

import static org.springframework.util.ObjectUtils.isEmpty;

/**
 * @Class Name : AuthenticationInterceptor.java
 * @Description : 권한관련 Interceptor
 * @Modification Information
 * @
 * @ 수정일       수정자      수정내용
 * @ ----------  ---------  -------------------------------
 * @ 2018.09.04  노현수      부분수정
 *
 * @author 솔비포스 차세대개발실 노현수
 * @since 2018. 05.01
 * @version 1.0
 * @see
 *
 * @Copyright (C) by SOLBIPOS CORP. All right reserved.
 */
public class AuthenticationInterceptor extends HandlerInterceptorAdapter {

    private final Logger LOGGER = LoggerFactory.getLogger(this.getClass());

    private final SessionService sessionService;
    private final CmmMenuService cmmMenuService;
    private final MessageService messageService;

    /** Constructor Injection */
    @Autowired
    public AuthenticationInterceptor(SessionService sessionService, CmmMenuService cmmMenuService, MessageService messageService) {
        this.sessionService = sessionService;
        this.cmmMenuService = cmmMenuService;
        this.messageService = messageService;
    }

    /**
     * preHandler : Interceptor 진입시 수행
     *
     * @param request HttpServletRequest
     * @param response HttpServletResponse
     * @param handler Object
     * @Return boolean
     */
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response,
        Object handler) throws Exception {

        String requestURL = request.getRequestURI().toString();
        LOGGER.info("url : {}, accept : {}, ", requestURL, request.getHeader("accept"));

        // 세션 가져오기
        SessionInfoVO sessionInfoVO = sessionService.getSessionInfo(request);
        // 세션 상태
        boolean isSessionValid = true;
        // 세션 객체가 없는 경우
        if ( StringUtils.isEmpty( sessionInfoVO ) ) {
            isSessionValid = false;
        } else {
            // 세션 객체는 있지만 필수값들이 없는 경우
            if ( StringUtils.isEmpty( sessionInfoVO.getUserId() ) && StringUtils.isEmpty( sessionInfoVO.getAuthMenu() ) ) {
                isSessionValid = false;
            }
        }

        /**
         * 세션 종료 처리
         */
        if (!isSessionValid) {
            // 로그 기록. inValidation 처리시 쉽게 알아보기 위함.
            LOGGER.info("AuthenticationInterceptor :: isValidSession :: deleteSessionInfo");
            // 세션 삭제
            sessionService.deleteSessionInfo(request);
            // Json 호출인지 판단하여 별도 메시지 리턴
            if (WebUtil.isJsonRequest(request)) {
                String msg = messageService.get("cmm.session.expire");
                String msg1 = messageService.get("cmm.move.login");
                // 로그 기록
                LOGGER.info("AuthenticationInterceptor :: isJsonRequest :: " + msg);
                throw new JsonException(Status.SESSION_EXFIRE, msg + msg1, "/");
            } else {
                response.sendRedirect("/");
                return false;
            }
        }
        // 권한 메뉴
        List<ResrceInfoVO> authMenus = sessionInfoVO.getAuthMenu();
        // 유져 조회 날짜 저장
        sessionInfoVO = setUserSelectDate(request, sessionInfoVO);

        // 본사, 가맹점 만 storeCd 에 대해서 체크한다.
//        if (sessionInfoVO.getOrgnFg() == OrgnFg.HQ) {
//            checkStoreCd(request, sessionInfoVO);
//        } else
        if (sessionInfoVO.getOrgnFg() == OrgnFg.STORE) {
            String storeCd = request.getParameter("storeCd");
            if (!isEmpty(storeCd)) {
                if (!storeCd.equals(sessionInfoVO.getOrgnCd())) {
                    // 유효하지 않는 매장코드 입니다.
                    String msg = messageService.get("cmm.not.storecd");
                    // 로그 기록
                    LOGGER.info("AuthenticationInterceptor :: " + storeCd + " :: " + msg);
                    throw new AuthenticationException(msg, "/error/403.sb");
                }
            }
        }


        // TODO :: 권한체크는 재작성 예정. 현재 로직은 굉장히 비효율적. 메뉴 단위로 변경하는 것이 좋을듯? : 20180904 노현수
        // 권한 체크
        if (!checkUrl(request, authMenus, requestURL, sessionInfoVO)) {
            LOGGER.error(
                "\n■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■\n"
                    + "not auth : id : {},  url : {}, accept : {}", sessionInfoVO.getUserId(),
                requestURL, request.getHeader("accept")
                    + "\n■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■");

            @SuppressWarnings("unused") String exceptionMsg =
                messageService.get("cmm.access.denied");

            // 권한 없음 처리
            //TODO 개발 진행중 주석처리
            //throw new AuthenticationException(exceptionMsg, "/error/403.sb");
        }

        // jsp > sessionscope 로 쓸수 있게 httpsession 에 세팅
        HttpSession session = request.getSession();
        session.setAttribute("sessionInfo", sessionInfoVO);

        return super.preHandle(request, response, handler);
    }

    /**
     * storecd 의 유효성을 검증한다.<br>
     *
     * @param request
     * @param sessionInfoVO
     */
    private void checkStoreCd(HttpServletRequest request, SessionInfoVO sessionInfoVO) {
        String storeCd = request.getParameter("storeCd");
        if (!isEmpty(storeCd)) {
            if (storeCd.indexOf(",") > -1) {
                if (!CmmUtil.listIndexOf(sessionInfoVO.getArrStoreCdList(), storeCd.split(","))) {
                    // 유효하지 않는 매장코드 입니다.
                    String msg = messageService.get("cmm.not.storecd") + ">>";
                    throw new AuthenticationException(msg, "/error/403.sb");
                }

            } else {
                if (!CmmUtil.listIndexOf(sessionInfoVO.getArrStoreCdList(), storeCd)) {
                    // 유효하지 않는 매장코드 입니다.
                    String msg = messageService.get("cmm.not.storecd") + ">>>";
                    throw new AuthenticationException(msg, "/error/403.sb");
                }
            }
        }
    }

    /**
     * 유져가 조회한 조회 날짜를 세션에 저장
     *
     * @param request HttpServletRequest
     * @param sessionInfoVO SessionInfoVO
     */
    private SessionInfoVO setUserSelectDate(HttpServletRequest request, SessionInfoVO sessionInfoVO) {
        String startDt = request.getParameter("startDt");
        String endDt = request.getParameter("endDt");

        if ( !isEmpty(startDt) ) {
            sessionInfoVO.setStartDt(startDt);
        }
        if ( !isEmpty(endDt) ) {
            sessionInfoVO.setEndDt(endDt);
        }
        if ( !isEmpty(startDt) || !isEmpty(endDt) ) {
            sessionService.setSessionInfo(sessionInfoVO);
        }

        return sessionInfoVO;
    }

    /**
     * 유효 URL 체크
     *
     * @param request HttpServletRequest
     * @param authList List<ResrceInfoVO>
     * @param url String
     * @param sessionInfoVO SessionInfoVO
     * @return boolean
     */
    private boolean checkUrl(HttpServletRequest request, List<ResrceInfoVO> authList, String url,
        SessionInfoVO sessionInfoVO) {

        boolean resultCheck = false;

        if (url.equals("/main.sb")) {
            return true;
        }

        // url 파라미터 제거
        if (url.indexOf("?") > -1) {
            url = url.substring(0, url.indexOf("?"));
        }
        // vo 값 찾기
        ResrceInfoVO searchVO = new ResrceInfoVO();
        searchVO.setUrl(url);
        int index = authList.indexOf(searchVO);

        if ( index >= 0 ) {
            ResrceInfoVO resrceInfoVO = authList.get(index);

            if (RequestMethod.GET.toString().equals(request.getMethod())
                && resrceInfoVO.getResrceFg() == ResrceFg.FUNC) {
                resultCheck = true;
            } else if (RequestMethod.POST.toString().equals(request.getMethod())) {
                return true;
            }

            // 메뉴 일때만 사용 등록과 메뉴 히스토리에 추가함
            if (resrceInfoVO.getResrceFg() == ResrceFg.MENU && RequestMethod.GET.toString()
                .equals(request.getMethod())) {

                // 세션에 사용 메뉴 넣기
                cmmMenuService.addHistMenu(resrceInfoVO, sessionInfoVO);
                // 사용 히스토리 등록
                cmmMenuService.insertMenuUseHist(resrceInfoVO, sessionInfoVO);
                return true;
            }

        }

//        int n = authList.size();
//        boolean resultCheck = false;
//        for (int i = 0; i < n; i++) {
//            ResrceInfoVO resrceInfoVO = authList.get(i);
//            String authUrl = resrceInfoVO.getUrl();
//            if (!isEmpty(authUrl)) {
//                // 등록된 URL 에 파라미터가 있는 경우 파라미터 제거
//                if (authUrl.indexOf("?") > -1) {
//                    authUrl = authUrl.substring(0, authUrl.indexOf("?"));
//                }
//
//                if (authUrl.equals(url)) {
//                    if (RequestMethod.GET.toString().equals(request.getMethod())
//                        && resrceInfoVO.getResrceFg() == ResrceFg.FUNC) {
//                        resultCheck = true;
//                    } else if (RequestMethod.POST.toString().equals(request.getMethod())) {
//                        return true;
//                    }
//
//                    // 메뉴 일때만 사용 등록과 메뉴 히스토리에 추가함
//                    if (resrceInfoVO.getResrceFg() == ResrceFg.MENU && RequestMethod.GET.toString()
//                        .equals(request.getMethod())) {
//
//                        // 세션에 사용 메뉴 넣기
//                        cmmMenuService.addHistMenu(resrceInfoVO, sessionInfoVO);
//                        // 사용 히스토리 등록
//                        cmmMenuService.insertMenuUseHist(resrceInfoVO, sessionInfoVO);
//                        return true;
//                    }
//                }
//            }
//        }
        return resultCheck;
    }

}
