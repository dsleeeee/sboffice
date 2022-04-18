package kr.co.solbipos.adi.alimtalk.alimtalkSendTab.web;

import kr.co.common.data.enums.UseYn;
import kr.co.common.data.structure.DefaultMap;
import kr.co.common.service.session.SessionService;
import kr.co.common.utils.jsp.CmmCodeUtil;
import kr.co.solbipos.application.session.auth.service.SessionInfoVO;
import kr.co.solbipos.adi.alimtalk.alimtalkSendType.service.AlimtalkSendTypeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

import static kr.co.common.utils.grid.ReturnUtil.returnJson;

/**
 * @Class Name : AlimtalkSendTabController.java
 * @Description : 부가서비스 > 알림톡관리 > 알림톡전송(탭)
 * @Modification Information
 * @
 * @  수정일      수정자              수정내용
 * @ ----------  ---------   -------------------------------
 * @ 2022.03.11  김설아      최초생성
 *
 * @author 솔비포스 개발본부 WEB개발팀 김설아
 * @since 2022.03.11
 * @version 1.0
 *
 *  Copyright (C) by SOLBIPOS CORP. All right reserved.
 */
@Controller
@RequestMapping("/adi/alimtalk/alimtalkSendTab")
public class AlimtalkSendTabController {

    private final SessionService sessionService;
    private final AlimtalkSendTypeService alimtalkSendTypeService; // 알림톡 전송유형

    /**
     * Constructor Injection
     */
    @Autowired
    public AlimtalkSendTabController(SessionService sessionService, AlimtalkSendTypeService alimtalkSendTypeService) {
        this.sessionService = sessionService;
        this.alimtalkSendTypeService = alimtalkSendTypeService;
    }

    /**
     * 페이지 이동
     *
     * @param request
     * @param response
     * @param model
     */
    @RequestMapping(value = "/alimtalkSendTab/list.sb", method = RequestMethod.GET)
    public String alimtalkSendTabView(HttpServletRequest request, HttpServletResponse response, Model model) {

        return "adi/alimtalk/alimtalkSendTab/alimtalkSendTab";
    }
}