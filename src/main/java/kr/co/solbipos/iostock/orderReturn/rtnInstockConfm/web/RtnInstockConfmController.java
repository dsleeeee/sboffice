package kr.co.solbipos.iostock.orderReturn.rtnInstockConfm.web;

import kr.co.common.data.enums.Status;
import kr.co.common.data.structure.DefaultMap;
import kr.co.common.data.structure.Result;
import kr.co.common.service.code.CmmEnvService;
import kr.co.common.service.session.SessionService;
import kr.co.common.utils.grid.ReturnUtil;
import kr.co.solbipos.application.session.auth.service.SessionInfoVO;
import kr.co.solbipos.iostock.orderReturn.rtnInstockConfm.service.RtnInstockConfmService;
import kr.co.solbipos.iostock.orderReturn.rtnInstockConfm.service.RtnInstockConfmVO;
import kr.co.solbipos.store.hq.brand.service.HqEnvstVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

/**
 * @Class Name : RtnInstockConfmController.java
 * @Description : 수불관리 > 매장반품관리 > 반품본사입고
 * @Modification Information
 * @
 * @  수정일      수정자              수정내용
 * @ ----------  ---------   -------------------------------
 * @ 2018.10.17  안동관      최초생성
 *
 * @author 솔비포스 차세대개발실 안동관
 * @since 2018.10.17
 * @version 1.0
 * @see
 *
 * @Copyright (C) by SOLBIPOS CORP. All right reserved.
 */

@Controller
@RequestMapping("/iostock/orderReturn/rtnInstockConfm")
public class RtnInstockConfmController {
    private final SessionService sessionService;
    private final RtnInstockConfmService rtnInstockConfmService;
    private final CmmEnvService cmmEnvService;

    @Autowired
    public RtnInstockConfmController(SessionService sessionService, RtnInstockConfmService rtnInstockConfmService, CmmEnvService cmmEnvService) {
        this.sessionService = sessionService;
        this.rtnInstockConfmService = rtnInstockConfmService;
        this.cmmEnvService = cmmEnvService;
    }

    /**
     * 반품본사입고 - 페이지 이동
     * @param   request
     * @param   response
     * @param   model
     * @return  String
     * @author  안동관
     * @since   2018. 10. 17.
     */
    @RequestMapping(value = "/rtnInstockConfm/view.sb", method = RequestMethod.GET)
    public String rtnInstockConfmView(HttpServletRequest request, HttpServletResponse response, Model model) {
        SessionInfoVO sessionInfoVO = sessionService.getSessionInfo(request);
        // 매장입고 환경변수 조회
        HqEnvstVO hqEnvstVO = new HqEnvstVO();
        hqEnvstVO.setHqOfficeCd(sessionInfoVO.getHqOfficeCd());
        hqEnvstVO.setEnvstCd("176");
        String envst176 = cmmEnvService.getHqEnvst(hqEnvstVO);
        model.addAttribute("envst176", envst176);

        return "iostock/orderReturn/rtnInstockConfm/rtnInstockConfm";
    }

    /**
     * 반품본사입고 - 반품본사입고 리스트 조회
     * @param   request
     * @param   response
     * @param   model
     * @param   rtnInstockConfmVO
     * @return  String
     * @author  안동관
     * @since   2018. 10. 17.
     */
    @RequestMapping(value = "/rtnInstockConfm/list.sb", method = RequestMethod.POST)
    @ResponseBody
    public Result getRtnInstockConfmList(HttpServletRequest request, HttpServletResponse response,
        Model model, RtnInstockConfmVO rtnInstockConfmVO) {

        SessionInfoVO sessionInfoVO = sessionService.getSessionInfo(request);
        rtnInstockConfmVO.setHqOfficeCd(sessionInfoVO.getHqOfficeCd());

        List<DefaultMap<String>> list = rtnInstockConfmService.getRtnInstockConfmList(rtnInstockConfmVO);

        return ReturnUtil.returnListJson(Status.OK, list, rtnInstockConfmVO);
    }

    /**
     * 반품본사입고 - 전표상세 조회
     * @param   request
     * @param   response
     * @param   model
     * @param   rtnInstockConfmVO
     * @return  String
     * @author  안동관
     * @since   2018. 10. 17.
     */
    @RequestMapping(value = "/rtnInstockConfmDtl/getSlipNoInfo.sb", method = RequestMethod.POST)
    @ResponseBody
    public Result getSlipNoInfo(HttpServletRequest request, HttpServletResponse response,
        Model model, RtnInstockConfmVO rtnInstockConfmVO) {

        SessionInfoVO sessionInfoVO = sessionService.getSessionInfo(request);
        rtnInstockConfmVO.setHqOfficeCd(sessionInfoVO.getHqOfficeCd());

        DefaultMap<String> result = rtnInstockConfmService.getSlipNoInfo(rtnInstockConfmVO);

        return ReturnUtil.returnJson(Status.OK, result);
    }

    /**
     * 반품본사입고 - 반품본사입고 상세 리스트 조회
     * @param   request
     * @param   response
     * @param   model
     * @param   rtnInstockConfmVO
     * @return  String
     * @author  안동관
     * @since   2018. 10. 17.
     */
    @RequestMapping(value = "/rtnInstockConfmDtl/list.sb", method = RequestMethod.POST)
    @ResponseBody
    public Result getRtnInstockConfmDtlList(HttpServletRequest request, HttpServletResponse response,
        Model model, RtnInstockConfmVO rtnInstockConfmVO) {

        SessionInfoVO sessionInfoVO = sessionService.getSessionInfo(request);
        rtnInstockConfmVO.setHqOfficeCd(sessionInfoVO.getHqOfficeCd());

        List<DefaultMap<String>> list = rtnInstockConfmService.getRtnInstockConfmDtlList(rtnInstockConfmVO);

        return ReturnUtil.returnListJson(Status.OK, list, rtnInstockConfmVO);
    }

    /**
     * 반품본사입고 - 반품본사입고 상세 리스트 저장
     * @param   request
     * @param   response
     * @param   model
     * @param   rtnInstockConfmVOs
     * @return  String
     * @author  안동관
     * @since   2018. 10. 17.
     */
    @RequestMapping(value = "/rtnInstockConfmDtl/save", method = RequestMethod.POST)
    @ResponseBody
    public Result saveRtnInstockConfmDtl(HttpServletRequest request, HttpServletResponse response,
        Model model, @RequestBody RtnInstockConfmVO[] rtnInstockConfmVOs) {

        SessionInfoVO sessionInfoVO = sessionService.getSessionInfo(request);

        int result = rtnInstockConfmService.saveRtnInstockConfmDtl(rtnInstockConfmVOs, sessionInfoVO);

        return ReturnUtil.returnJson(Status.OK, result);
    }
}
