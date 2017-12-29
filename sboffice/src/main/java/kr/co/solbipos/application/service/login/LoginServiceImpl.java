package kr.co.solbipos.application.service.login;

import static kr.co.solbipos.utils.DateUtil.*;
import static org.springframework.util.ObjectUtils.*;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import kr.co.solbipos.application.domain.login.LoginHist;
import kr.co.solbipos.application.domain.login.SessionInfo;
import kr.co.solbipos.application.domain.resource.ResrceInfo;
import kr.co.solbipos.application.enums.login.LoginOrigin;
import kr.co.solbipos.application.enums.login.LoginResult;
import kr.co.solbipos.application.persistance.login.LoginMapper;
import kr.co.solbipos.service.session.SessionService;
import kr.co.solbipos.utils.DateUtil;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class LoginServiceImpl implements LoginService {

    @Autowired
    LoginMapper loginMapper;

    @Autowired
    SessionService sessionService;

    @Override
    public SessionInfo selectWebUser(SessionInfo sessionInfo) {
        return loginMapper.selectWebUser(sessionInfo);
    }

    /**
     * 로그인 성공 여부
     * 
     * @param sessionInfo
     * @param webUser
     * @return
     */
    private LoginResult loginProcess(SessionInfo sessionInfo, SessionInfo webUser) {
        
        /** 
         * 존재하는 id 인지 체크
         * */
        if (isEmpty(webUser)) {
            return LoginResult.NOT_EXISTS_ID;
        }

        /** 
         * 패스워드 체크
         * */
        if (!loginPasswordCheck(sessionInfo, webUser)) {
            return LoginResult.PASSWORD_ERROR;
        }

        return LoginResult.SUCCESS;
    }

    /**
     * 패스워드 체크
     * 
     * @param sessionInfo 로그인 페이지에서 입력된 로그인 유져 정보
     * @param webUser 입력된 ID로 조회된 유져 정보
     * @return
     */
    private boolean loginPasswordCheck(SessionInfo sessionInfo, SessionInfo webUser) {

        if (isEmpty(sessionInfo) || isEmpty(webUser)) {
            log.warn("password check object null...");
            return false;
        }

        String loginPw = sessionInfo.getUserPwd();
        String userPw = webUser.getUserPwd();

        if (loginPw.equals(userPw)) {
            return true;
        }

        return false;
    }


    @Override
    public SessionInfo login(SessionInfo sessionInfo) {

        SessionInfo si = selectWebUser(sessionInfo);

        LoginResult result = loginProcess(sessionInfo, si);

        // 로그인 결과
        si.setLoginResult(result);
        // 조회된 패스워드 초기화
        si.setUserPwd("");
        
        // 로그인 시도 기록
        loginHist(si);
        
        return si;
    }

    @Override
    public boolean logout(HttpServletRequest request, HttpServletResponse response) {
        sessionService.deleteSessionInfo(request, response);
        return true;
    }

    /**
      * 로그인 시도 결과를 히스토리 저장
      * 
      * @param sessionInfo
      * @return
      */
    public int loginHist(SessionInfo sessionInfo) {

        LoginHist loginHist = new LoginHist();

        // 로그인 결과
        loginHist.setStatCd(sessionInfo.getLoginResult());
        
        loginHist.setUserId(sessionInfo.getUserId());
        loginHist.setLoginOrgn(LoginOrigin.WEB);
        loginHist.setBrwsrInfo(sessionInfo.getBrwsrInfo());
        loginHist.setLoginIp(sessionInfo.getLoginIp());
        loginHist.setLoginDate(currentDateString());
        loginHist.setLoginDt(currentTimeString());

        return loginHist(loginHist);
    }

    @Override
    public int loginHist(LoginHist loginHist) {
        return loginMapper.insertLoginHist(loginHist);
    }

    @Override
    public <E> List<E> selectLoginHist(LoginHist loginHist) {
        return loginMapper.selectLoginHist(loginHist);
    }

    @Override
    public List<ResrceInfo> selectAuthMenu(SessionInfo sessionInfo) {
        return loginMapper.selectAuthMenu(sessionInfo);
    }

}


