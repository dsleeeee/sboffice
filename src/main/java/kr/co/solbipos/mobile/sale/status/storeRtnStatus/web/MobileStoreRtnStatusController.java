package kr.co.solbipos.mobile.sale.status.storeRtnStatus.web;

import kr.co.common.data.enums.Status;
import kr.co.common.data.structure.DefaultMap;
import kr.co.common.data.structure.Result;
import kr.co.common.service.session.SessionService;
import kr.co.common.utils.grid.ReturnUtil;
import kr.co.solbipos.application.session.auth.service.SessionInfoVO;
import kr.co.solbipos.mobile.sale.status.storeRtnStatus.service.MobileStoreRtnStatusService;
import kr.co.solbipos.mobile.sale.status.storeRtnStatus.service.MobileStoreRtnStatusVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

/**
 * @Class Name : MobileStoreRtnStatusController.java
 * @Description : 모바일 매장매출 > 반품현황
 * @Modification Information
 * @
 * @  수정일      수정자              수정내용
 * @ ----------  ---------   -------------------------------
 * @ 2021.09.07  권지현      최초생성
 *
 * @author 솔비포스 WEB개발팀 권지현
 * @since 2021.09.07
 * @version 1.0
 * @see
 *
 * @Copyright (C) by SOLBIPOS CORP. All right reserved.
 */

@Controller
@RequestMapping("/mobile/sale/status/storeRtnStatus")
public class MobileStoreRtnStatusController {
    private final SessionService sessionService;
    private final MobileStoreRtnStatusService mobileStoreRtnStatusService;

    @Autowired
    public MobileStoreRtnStatusController(SessionService sessionService, MobileStoreRtnStatusService mobileStoreRtnStatusService){
        this.sessionService = sessionService;
        this.mobileStoreRtnStatusService = mobileStoreRtnStatusService;
    }

    /**
     * 모바일 매장매출 - 반품현황 페이지 이동
     * @param request
     * @param response
     * @param model
     * @return  String
     * @author  권지현
     * @since   2021.09.01
     */
    @RequestMapping(value = "/mobileStoreRtnStatus/list.sb", method = RequestMethod.GET)
    public String view(HttpServletRequest request, HttpServletResponse response, Model model) {

        return "mobile/sale/status/storeRtnStatus/mobileStoreRtnStatus";
    }

    /**
     * 반품현황 - 조회
     *
     * @param mobileStoreRtnStatusVO
     * @param request
     * @param response
     * @param model
     * @return  Object
     * @author  권지현
     * @since   2021. 09.03
     */
    @RequestMapping(value = "/mobileStoreRtnStatus/getMobileStoreRtnStatusDtlList.sb", method = RequestMethod.POST)
    @ResponseBody
    public Result getMobileRtnStatusDtlList(MobileStoreRtnStatusVO mobileStoreRtnStatusVO, HttpServletRequest request,
                                           HttpServletResponse response, Model model) {

        SessionInfoVO sessionInfoVO = sessionService.getSessionInfo(request);

        List<DefaultMap<Object>> result = mobileStoreRtnStatusService.getMobileStoreRtnStatusDtlList(mobileStoreRtnStatusVO, sessionInfoVO);

        return ReturnUtil.returnListJson(Status.OK, result, mobileStoreRtnStatusVO);
    }
}
