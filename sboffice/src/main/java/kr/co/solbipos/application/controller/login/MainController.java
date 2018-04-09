package kr.co.solbipos.application.controller.login;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import kr.co.solbipos.application.domain.login.SessionInfo;
import kr.co.solbipos.application.enums.user.OrgnFg;
import kr.co.solbipos.service.session.SessionService;

/**
 * 
 * @author 정용길
 */
@Controller
public class MainController {

    @Autowired
    SessionService sessionService;

    /**
      * 로그인 후 메인 페이지로 이동
      * 
      * @param request
      * @param response
      * @param model
      * @return
      */
    @RequestMapping(value = "main.sb", method = RequestMethod.GET)
    public String main(HttpServletRequest request, HttpServletResponse response, Model model) {
        
        if (!sessionService.isValidSession(request)) {
            return "redirect:/auth/login.sb";
        }
        
        SessionInfo sessionInfo = sessionService.getSessionInfo(request);
        OrgnFg orgnFg = sessionInfo.getOrgnFg();
        
        /** 
         * 유져 권한 타입<br> 
         * */
        // 시스템 : SYSTEM
        if(orgnFg == OrgnFg.MASTER) {
            return "redirect:"+"/application/main/content/sys.sb";
        }
        // 대리점 : AGENCY
        else if(orgnFg == OrgnFg.AGENCY) {    //TODO URL 추가 필요
            return "redirect:"+"/application/main/content/agency.sb";
        }
        // 본사 : HEDOFC(HEAD OFFICE)
        else if(orgnFg == OrgnFg.HQ) {
            return "redirect:"+"/application/main/content/hq.sb";
        }
        // 가맹점 : MRHST(MEMBER BRANCH STORE)
        else if(orgnFg == OrgnFg.STORE) {
            return "redirect:"+"/application/main/content/store.sb";
        }
        
        return "application/main/mrhstMain";    //TODO 로그인페이지로 이동?
    }
}


