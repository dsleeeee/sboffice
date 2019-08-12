package kr.co.solbipos.base.prod.touchkey.web;

import com.nhncorp.lucy.security.xss.XssPreventer;
import kr.co.common.data.enums.Status;
import kr.co.common.data.structure.DefaultMap;
import kr.co.common.data.structure.Result;
import kr.co.common.service.session.SessionService;
import kr.co.common.utils.CmmUtil;
import kr.co.common.utils.grid.ReturnUtil;
import kr.co.common.utils.jsp.CmmCodeUtil;
import kr.co.common.utils.jsp.CmmEnvUtil;
import kr.co.common.utils.spring.StringUtil;
import kr.co.solbipos.application.session.auth.service.SessionInfoVO;
import kr.co.solbipos.base.prod.touchkey.service.TouchKeyClassVO;
import kr.co.solbipos.base.prod.touchkey.service.TouchKeyService;
import kr.co.solbipos.base.prod.touchkey.service.TouchKeyStyleVO;
import kr.co.solbipos.base.prod.touchkey.service.TouchKeyVO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

import static kr.co.common.utils.grid.ReturnUtil.returnJson;
import static kr.co.common.utils.grid.ReturnUtil.returnListJson;
import static kr.co.common.utils.spring.StringUtil.convertToJson;

/**
 * @Class Name : TouchKeyController.java
 * @Description : 기초관리 - 상품관리 - 판매터치키등록
 * @Modification Information
 * @
 * @ 수정일      수정자              수정내용
 * @ ----------  ---------   -------------------------------
 * @ 2018.05.01  조병준      최초생성
 * @ 2018.09.19  노현수      메소드정리/분리
 *
 * @author NHN한국사이버결제 KCP 조병준
 * @Copyright (C) by SOLBIPOS CORP. All right reserved.
 * @since 2018. 05.01
 * @version 1.0
 *
 * @Copyright (C) by SOLBIPOS CORP. All right reserved.
 */
@Controller
@RequestMapping(value = "/base/prod/touchKey/touchKey")
public class TouchKeyController {

    private final Logger LOGGER = LoggerFactory.getLogger(this.getClass());

    private final SessionService sessionService;
    private final TouchKeyService touchkeyService;
    private final CmmEnvUtil cmmEnvUtil;
    private final CmmCodeUtil cmmCodeUtil;

    /** Constructor Injection */
    @Autowired
    public TouchKeyController(SessionService sessionService,
        TouchKeyService touchkeyService, CmmEnvUtil cmmEnvUtil, CmmCodeUtil cmmCodeUtil) {
        this.sessionService = sessionService;
        this.touchkeyService = touchkeyService;
        this.cmmEnvUtil = cmmEnvUtil;
        this.cmmCodeUtil = cmmCodeUtil;
    }

    /**
     * 판매 터치키 화면 오픈
     *
     * @param request HttpServletRequest
     * @param session HttpSession
     * @param model   Model
     * @return
     */
    @RequestMapping(value = "/view.sb", method = RequestMethod.GET)
    public String touchKeyView(HttpServletRequest request, HttpSession session, Model model) {

        SessionInfoVO sessionInfoVO = sessionService.getSessionInfo(request);

        TouchKeyVO params = new TouchKeyVO();
        params.setOrgnFg(sessionInfoVO.getOrgnFg().getCode());
        params.setStoreCd(sessionInfoVO.getStoreCd());
        params.setHqOfficeCd(sessionInfoVO.getHqOfficeCd());

        TouchKeyClassVO touchKeyClassVO = new TouchKeyClassVO();
        touchKeyClassVO.setOrgnFg(sessionInfoVO.getOrgnFg().getCode());
        touchKeyClassVO.setStoreCd(sessionInfoVO.getStoreCd());
        touchKeyClassVO.setHqOfficeCd(sessionInfoVO.getHqOfficeCd());
        touchKeyClassVO.setPageNo(1);

        TouchKeyStyleVO touchKeyStyleVO = new TouchKeyStyleVO();
        touchKeyStyleVO.setStyleCd("");

        // 본사or매장의 터치키 환경 설정 값을 조회해서 셋팅
        if ( "H".equals(sessionInfoVO.getOrgnFg().getCode()) ) {
            model.addAttribute("maxClassRow", cmmEnvUtil.getHqEnvst(sessionInfoVO, "0041"));
        } else {
            model.addAttribute("maxClassRow", cmmEnvUtil.getStoreEnvst(sessionInfoVO, "1041"));
        }

        // 터치키 관련 권한정보 가져오기 : 2019-08-08 이다솜
        String envstCd = "0017";
        String touchKeyEnvstVal = StringUtil.getOrBlank(cmmEnvUtil.getHqEnvst(sessionInfoVO, envstCd));
        model.addAttribute("touchKeyEnvstVal", touchKeyEnvstVal);

        return "base/prod/touchKey/touchKey";
    }

    /**
     * 터치키 분류 페이지별 스타일 코드 조회
     *
     * @param request HttpServletRequest
     * @param response HttpServletResponse
     * @param model   Model
     * @return
     */
    @RequestMapping(value = "/getTouchKeyStyleCd.sb", method = RequestMethod.POST)
    @ResponseBody
    public Result getTouchKeyStyleCd(HttpServletRequest request, HttpServletResponse response, Model model) {
        SessionInfoVO sessionInfoVO = sessionService.getSessionInfo(request);
        return returnJson(Status.OK, convertToJson(touchkeyService.getTouchKeyPageStyleCd(sessionInfoVO)));
    }

    /**
     * 터치키 스타일 코드 목록 조회
     *
     * @param request HttpServletRequest
     * @param response HttpServletResponse
     * @param model   Model
     * @return
     */
    @RequestMapping(value = "/getTouchKeyStyleCdList.sb", method = RequestMethod.POST)
    @ResponseBody
    public Result getTouchKeyStyleCdList(HttpServletRequest request, HttpServletResponse response, Model model) {
        SessionInfoVO sessionInfoVO = sessionService.getSessionInfo(request);
        List<DefaultMap<String>> list = touchkeyService.getTouchKeyStyleCdList();

        return returnJson(Status.OK, convertToJson(list));
    }

    /**
     * 터치키 스타일 목록 조회
     *
     * @param touchKeyStyleVO TouchKeyStyleVO
     * @param request HttpServletRequest
     * @param response HttpServletResponse
     * @param model   Model
     * @return
     */
    @RequestMapping(value = "/getTouchKeyStyleList.sb", method = RequestMethod.POST)
    @ResponseBody
    public Result getTouchKeyStyles(TouchKeyStyleVO touchKeyStyleVO, HttpServletRequest request, HttpServletResponse response, Model model) {
        SessionInfoVO sessionInfoVO = sessionService.getSessionInfo(request);
        List<DefaultMap<String>> list = touchkeyService.getTouchKeyStyleList(touchKeyStyleVO, sessionInfoVO);

        return ReturnUtil.returnListJson(Status.OK, list, touchKeyStyleVO);
    }

    /**
     * 판매 터치키 목록 조회 (상품정보 목록)
     *
     * @param touchKeyVO TouchKeyVO
     * @param request HttpServletRequest
     * @param response HttpServletResponse
     * @param model   Model
     * @return
     */
    @RequestMapping(value = "/list.sb", method = RequestMethod.POST)
    @ResponseBody
    public Result getProductListForTouchKey(TouchKeyVO touchKeyVO, HttpServletRequest request, HttpServletResponse response, Model model) {
        SessionInfoVO sessionInfoVO = sessionService.getSessionInfo(request);

        return returnListJson(Status.OK, touchkeyService.getProductListForTouchKey(touchKeyVO, sessionInfoVO));
    }

    /**
     * 판매 터치키 기존 설정 조회
     *
     * @param request HttpServletRequest
     * @param session HttpSession
     * @param model   Model
     * @return
     */
    @RequestMapping(value = "/touchKeyList.sb", method = RequestMethod.POST)
    @ResponseBody
    public Result getTouchKeyXml(HttpServletRequest request, HttpSession session, Model model) {
        SessionInfoVO sessionInfoVO = sessionService.getSessionInfo(request);
        String xml = touchkeyService.getTouchKeyXml(sessionInfoVO);
        return new Result(Status.OK, xml);
    }

    /**
     * 판매 터치키 저장
     *
     * @param request HttpServletRequest
     * @param session HttpSession
     * @param model   Model
     * @return
     */
    @RequestMapping(value = "/save.sb", method = RequestMethod.POST)
    @ResponseBody
    public Result saveTouchKey(HttpServletRequest request, HttpSession session, Model model) {

        SessionInfoVO sessionInfoVO = sessionService.getSessionInfo(request);

        Result result = new Result(Status.FAIL);
        String xml = CmmUtil.decoder(request.getParameter("xml"));
        xml.replace("\n", "&#xa;");

        result = touchkeyService.saveTouchkey(sessionInfoVO, XssPreventer.unescape(xml));

        return result;
    }

    /**
     * 판매 터치키 매장적용 - 매장조회
     *
     * @param request HttpServletRequest
     * @param response HttpServletResponse
     * @param touchKeyVO TouchKeyVO
     * @param model Model
     * @return Result
     * @author 노현수
     * @since 2018. 12. 28.
     */
    @RequestMapping(value = "/storeList.sb", method = RequestMethod.POST)
    @ResponseBody
    public Result getStoreList(HttpServletRequest request, HttpServletResponse response,
        TouchKeyVO touchKeyVO, Model model) {

        SessionInfoVO sessionInfoVO = sessionService.getSessionInfo(request);

        List<DefaultMap<String>> list = new ArrayList<DefaultMap<String>>();
        // 매장 목록 조회
        list = touchkeyService.getStoreList(touchKeyVO, sessionInfoVO);

        return ReturnUtil.returnListJson(Status.OK, list, touchKeyVO);

    }

    /**
     * 판매 터치키 매장적용 - 매장적용
     *
     * @param touchKeyVOs TouchKeyVO[]
     * @param request HttpServletRequest
     * @param response HttpServletResponse
     * @param model Model
     * @return Result
     * @author 노현수
     * @since 2018. 12. 28.
     */
    @RequestMapping(value = "/applyStore.sb", method = RequestMethod.POST)
    @ResponseBody
    public Result saveTouchKeyToStore(@RequestBody TouchKeyVO[] touchKeyVOs, HttpServletRequest request, HttpServletResponse response,
        Model model) {

        SessionInfoVO sessionInfoVO = sessionService.getSessionInfo(request);
        int result = touchkeyService.saveTouchKeyToStore(touchKeyVOs, sessionInfoVO);

        return returnJson(Status.OK, result);

    }
}
