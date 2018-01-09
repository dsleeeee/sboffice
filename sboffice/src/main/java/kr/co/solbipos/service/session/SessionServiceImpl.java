package kr.co.solbipos.service.session;

import static kr.co.solbipos.utils.spring.StringUtil.*;
import static org.springframework.util.StringUtils.*;
import java.util.concurrent.TimeUnit;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.ObjectUtils;
import org.springframework.web.util.WebUtils;
import kr.co.solbipos.application.domain.login.SessionInfo;
import kr.co.solbipos.application.service.login.LoginService;
import kr.co.solbipos.service.cmm.CmmMenuService;
import kr.co.solbipos.service.redis.RedisConnService;
import kr.co.solbipos.system.Prop;
import kr.co.solbipos.system.RedisCustomTemplate;
import kr.co.solbipos.utils.HttpUtils;
import lombok.extern.slf4j.Slf4j;

/**
 * @author 정용길
 *
 */
@Slf4j
@Service
public class SessionServiceImpl implements SessionService {

    @Autowired
    Prop prop;

    @Autowired
    RedisConnService redisConnService;

    @Autowired
    LoginService loginService;

    @Autowired
    CmmMenuService cmmMenuService;

    @Autowired
    private RedisCustomTemplate<String, SessionInfo> redisCustomTemplate;

    private static final String SESSION_KEY = "SBSESSIONID";

    @Override
    public String setSessionInfo(HttpServletRequest request, HttpServletResponse response,
            SessionInfo sessionInfo) {
        String sessionId = generateUUID();

        // sessionId 세팅
        sessionInfo.setSessionId(sessionId);
        // 권한 있는 메뉴 저장
        sessionInfo.setAuthMenu(loginService.selectAuthMenu(sessionInfo));
        // 고정 메뉴 리스트 저장
        sessionInfo.setFixMenu(cmmMenuService.selectFixingMenu(sessionInfo));
        // 즐겨찾기 메뉴 리스트 저장
        sessionInfo.setBkmkMenu(cmmMenuService.selectBkmkMenu(sessionInfo));
        // 메뉴 데이터 만들기
        sessionInfo.setMenuData(cmmMenuService.makeMenu(sessionInfo.getAuthMenu()));

        // redis에 세션 세팅
        setSessionInfo(sessionId, sessionInfo);

        // 쿠키 생성
        makeCookie(sessionId, response);
        return sessionId;
    }

    /**
     * 레디스에 sessionInfo 객체 세팅
     * 
     * @param sessionId
     * @param sessionInfo
     */
    private void setSessionInfo(String sessionId, SessionInfo sessionInfo) {
        if (redisConnService.isAvailable()) {
            try {
                redisCustomTemplate.set(redisCustomTemplate.makeKey(sessionId), sessionInfo,
                        prop.sessionTimeout, TimeUnit.MINUTES);
            } catch (Exception e) {
                log.error("Redis server not available!! setSessionInfo {}", e);
                redisConnService.disable();
            }
        }
    }

    @Override
    public String setSessionInfo(SessionInfo sessionInfo) {
        String sessionId = sessionInfo.getSessionId();
        // redis에 세션 세팅
        setSessionInfo(sessionId, sessionInfo);
        return sessionId;
    }

    @Override
    public SessionInfo getSessionInfo(String sessionId) {
        SessionInfo sessionInfo = null;
        if (redisConnService.isAvailable()) {
            try {
                sessionInfo = redisCustomTemplate.get(redisCustomTemplate.makeKey(sessionId));
                if (!ObjectUtils.isEmpty(sessionInfo)) {
                    // 세션 타임 연장
                    redisCustomTemplate.expire(redisCustomTemplate.makeKey(sessionId),
                            prop.sessionTimeout, TimeUnit.MINUTES);
                }
            } catch (Exception e) {
                log.error("Redis server not available!! getSessionInfo {}", e);
                redisConnService.disable();
            }
        }
        return sessionInfo;
    }

    @Override
    public SessionInfo getSessionInfo(HttpServletRequest request) {

        Cookie cookie = WebUtils.getCookie(request, SESSION_KEY);
        String sessionId = cookie == null ? request.getParameter(SESSION_KEY) : cookie.getValue();

        // HttpSession session = request.getSession();
        // String sessionId = session.getId();

        SessionInfo sessionInfo = getSessionInfo(sessionId);
        return sessionInfo;
    }

    @Override
    public SessionInfo getSessionInfo(SessionInfo sessionInfo) {
        String sessionId = sessionInfo.getSessionId();
        if (ObjectUtils.isEmpty(sessionId)) {
            return null;
        } else {
            return getSessionInfo(sessionId);
        }
    }

    @Override
    public boolean isValidSession(HttpServletRequest request) {
        SessionInfo sessionInfo = getSessionInfo(request);

        // 세션 객체가 없는 경우
        if (isEmpty(sessionInfo)) {
            return false;
        }
        // 세션 객체는 있지만 필수값들이 없는 경우
        else {
            if (isEmpty(sessionInfo.getUserId()) && isEmpty(sessionInfo.getAuthMenu())) {
                return false;
            }
        }

        return true;
    }

    @Override
    public boolean isValidSession(String sessionId) {
        return getSessionInfo(sessionId) != null;
    }

    @Override
    public void deleteSessionInfo(String sessionId) {
        if (redisConnService.isAvailable()) {
            try {
                redisCustomTemplate.delete(redisCustomTemplate.makeKey(sessionId));
            } catch (Exception e) {
                log.error("Redis server not available!! deleteSessionInfo {}", e);
                redisConnService.disable();
            }
        }
    }

    @Override
    public void deleteSessionInfo(HttpServletRequest request, HttpServletResponse response) {
        if (!ObjectUtils.isEmpty(request)) {
            SessionInfo sessionInfo = getSessionInfo(request);
            if (!ObjectUtils.isEmpty(sessionInfo)) {

                // redis
                String sessionId = sessionInfo.getSessionId();
                deleteSessionInfo(sessionId);

                // cookie
                deleteCookie(request, response);
            }
        }
    }

    @Override
    public void deleteSessionInfo(SessionInfo sessionInfo) {
        if (!ObjectUtils.isEmpty(sessionInfo)) {
            deleteSessionInfo(sessionInfo.getSessionId());
        }
    }

    /**
     * 쿠키에 session id 삭제
     * 
     * @param request
     * @param response
     */
    private void deleteCookie(HttpServletRequest request, HttpServletResponse response) {
        Cookie cookie = WebUtils.getCookie(request, SESSION_KEY);
        if (cookie != null) {
            cookie.setMaxAge(0);
            cookie.setPath("/");
            /*
            if (prop.profile.indexOf("local") == -1) {
                cookie.setDomain(prop.domain);
            }
            */
            response.addCookie(cookie);
        }
    }

    /**
     * 쿠키 session id 생성
     * 
     * @param sessionId
     * @param response
     */
    private void makeCookie(String sessionId, HttpServletResponse response) {
        Cookie cookie = new Cookie(SESSION_KEY, sessionId);
        cookie.setPath("/");
        /*
        if (prop.profile.indexOf("local") == -1) {
            cookie.setDomain(prop.domain);
        }
        */
        cookie.setMaxAge(-1);
        response.addCookie(cookie);
    }

}


