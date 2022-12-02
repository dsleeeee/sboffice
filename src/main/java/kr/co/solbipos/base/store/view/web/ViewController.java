package kr.co.solbipos.base.store.view.web;

import kr.co.common.data.enums.Status;
import kr.co.common.data.structure.DefaultMap;
import kr.co.common.data.structure.Result;
import kr.co.common.service.session.SessionService;
import kr.co.common.utils.CmmUtil;
import kr.co.common.utils.grid.ReturnUtil;
import kr.co.common.utils.jsp.CmmCodeUtil;
import kr.co.common.utils.jsp.CmmEnvUtil;
import kr.co.solbipos.application.session.auth.service.SessionInfoVO;
import kr.co.solbipos.base.store.view.service.CopyStoreEnvVO;
import kr.co.solbipos.base.store.view.service.VanConfigVO;
import kr.co.solbipos.base.store.view.service.ViewService;
import kr.co.solbipos.base.store.view.service.ViewVO;
import kr.co.solbipos.base.store.view.service.enums.CornerUseYn;
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
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static kr.co.common.utils.grid.ReturnUtil.returnJson;
import static kr.co.common.utils.grid.ReturnUtil.returnListJson;

/**
* @Class Name : ViewController.java
* @Description : 기초관리 > 매장관리 > 매장정보조회
* @Modification Information
* @
* @  수정일      수정자              수정내용
* @ ----------  ---------   -------------------------------
 * @ 2018.08.13  김영근      최초생성
 * @ 2018.11.20  김지은      기능오류 수정 및 angular 변경
 * @ 2018.12.28  김지은      매장환경 복사 팝업 생성
*
* @author nhn kcp 개발2팀 김영근
* @since 2018. 08.13
* @version 1.0
*
*  Copyright (C) by SOLBIPOS CORP. All right reserved.
*/
@Controller
@RequestMapping(value = "/base/store/view")
public class ViewController {

    private final Logger LOGGER = LoggerFactory.getLogger(this.getClass());

    private final ViewService viewService;
    private final SessionService sessionService;
    private final CmmCodeUtil cmmCodeUtil;
    private final CmmEnvUtil cmmEnvUtil;

    /** Constructor Injection */
    @Autowired
    public ViewController(ViewService viewService, SessionService sessionService, CmmCodeUtil cmmCodeUtil, CmmEnvUtil cmmEnvUtil) {
        this.viewService = viewService;
        this.sessionService = sessionService;
        this.cmmCodeUtil = cmmCodeUtil;
        this.cmmEnvUtil = cmmEnvUtil;
    }

    /**
     * 매장정보조회 화면 이동
     *
     * @param request
     * @param response
     * @param model
     * @return
     */
    @RequestMapping(value = "/view/list.sb", method = RequestMethod.GET)
    public String list(HttpServletRequest request, HttpServletResponse response,
            Model model) {
        return "base/store/view/view";
    }

    /**
     * 매장정보 리스트조회
     *
     * @param viewVO
     * @param request
     * @param response
     * @param model
     * @return
     */
    @RequestMapping(value = "/view/list.sb", method = RequestMethod.POST)
    @ResponseBody
    public Result list(ViewVO viewVO, HttpServletRequest request,
            HttpServletResponse response, Model model) {

        SessionInfoVO sessionInfoVO = sessionService.getSessionInfo();

        List<DefaultMap<String>> list = viewService.getViewList(viewVO, sessionInfoVO);

        return returnListJson(Status.OK, list, viewVO);
    }

    /**
     * 매장정보 리스트 엑셀 조회
     *
     * @param viewVO
     * @param request
     * @param response
     * @param model
     * @return
     */
    @RequestMapping(value = "/view/getStoreListExcel.sb", method = RequestMethod.POST)
    @ResponseBody
    public Result getStoreListExcel(ViewVO viewVO, HttpServletRequest request,
                       HttpServletResponse response, Model model) {

        SessionInfoVO sessionInfoVO = sessionService.getSessionInfo();

        List<DefaultMap<String>> list = viewService.getStoreListExcel(viewVO, sessionInfoVO);

        return returnListJson(Status.OK, list, viewVO);
    }

    /**
     * 매장정보 상세조회
     *
     * @param viewVO
     * @param request
     * @param response
     * @param model
     * @return
     */
    @RequestMapping(value = "/dtl/list.sb", method = RequestMethod.POST)
    @ResponseBody
    public Result detail(ViewVO viewVO, HttpServletRequest request,
            HttpServletResponse response, Model model) {

        //매장 상세정보
        DefaultMap<String> storeInfo = viewService.getViewDetail(viewVO);

        DefaultMap<Object> resultMap = new DefaultMap<Object>();
        resultMap.put("storeInfo", storeInfo);

        return returnJson(Status.OK, resultMap);
    }

    /**
     * VAN사 환경설정 정보 조회
     * 벤사 목록도 함께 조회 (코너, 포스)
     * @param vanConfgVO
     * @param request
     * @param response
     * @param model
     * @return
     */
    @RequestMapping(value = "/vanConfg/vanConfigInfo.sb", method = RequestMethod.POST)
    @ResponseBody
    public Result vanConfigInfo(VanConfigVO vanConfgVO, HttpServletRequest request,
        HttpServletResponse response, Model model) {

        Map<String, Object> resultMap = new HashMap<String, Object>();

        List<DefaultMap<String>> posTerminalList = null;
        List<DefaultMap<String>> cornrTerminalList = null;

        CornerUseYn cornerUseYnVal = CornerUseYn.getEnum(viewService.getCornerUseYnVal(vanConfgVO));

        // 포스별승인 목록
        posTerminalList = viewService.getPosTerminalList(vanConfgVO);

        // 코너개별승인 목록
        cornrTerminalList = viewService.getCornerTerminalList(vanConfgVO);


        resultMap.put("cornerUseYnVal", cornerUseYnVal);
        resultMap.put("posTerminalList", posTerminalList);
        resultMap.put("cornrTerminalList", cornrTerminalList);

        return returnJson(Status.OK, resultMap);
    }


    /**
     * 매장환경 복사를 위한 정보 조회
     * @param copyStoreEnvVO
     * @param request
     * @param response
     * @param model
     * @return
     */
//    @RequestMapping(value = "/copyStoreEnv/getStoreEnvInfo.sb", method = RequestMethod.POST)
//    @ResponseBody
//    public Result getStoreEnvInfo(CopyStoreEnvVO copyStoreEnvVO, HttpServletRequest request,
//        HttpServletResponse response, Model model) {
//
//        LOGGER.info(copyStoreEnvVO.getProperties());
//
//        // 복사할 매장환경 목록 조회
//        CommonCodeVO envVO = cmmCodeUtil.getCommCodeData("101");
//
//        Map<String, Object> resultMap = new HashMap<String, Object>();
//
//        resultMap.put("envList", envVO.getCodeList());
//
//        return returnJson(Status.OK, resultMap);
//    }
    /**
     * 매장환경 복사를 위한 정보 조회
     *
     * @param copyStoreEnvVO
     * @param request
     * @param response
     * @param model
     * @return  Object
     * @author  김설아
     * @since   2021. 07. 14.
     */
    @RequestMapping(value = "/copyStoreEnv/getStoreEnvInfoList.sb", method = RequestMethod.POST)
    @ResponseBody
    public Result getStoreEnvInfoList(CopyStoreEnvVO copyStoreEnvVO, HttpServletRequest request,
                                   HttpServletResponse response, Model model) {

        SessionInfoVO sessionInfoVO = sessionService.getSessionInfo(request);

        List<DefaultMap<String>> result = viewService.getStoreEnvInfoList(copyStoreEnvVO, sessionInfoVO);

        // [1250] 맘스터치백오피스인경우 상품 복사기능 보이게 처리
        if(CmmUtil.nvl(cmmEnvUtil.getHqEnvst(sessionInfoVO, "1250"), "0").equals("1")) {

            DefaultMap<String> envProd = new DefaultMap<String>();
            envProd.put("NMCODE_CD", "04");
            envProd.put("NMCODE_NM", "상품");

            result.add(3, envProd);
        }

        return ReturnUtil.returnListJson(Status.OK, result, copyStoreEnvVO);
    }

    /**
     * 매장환경 복사
     * @param copyStoreEnvVOs
     * @param request
     * @param response
     * @param model
     * @return
     * @author 김지은
     * @since 2018.12.29
     */
    @RequestMapping(value = "/copyStoreEnv/copyStoreEnvInfo.sb", method = RequestMethod.POST)
    @ResponseBody
    public Result copyStoreEnvInfo(@RequestBody CopyStoreEnvVO[] copyStoreEnvVOs, HttpServletRequest request,
        HttpServletResponse response, Model model) {

        SessionInfoVO sessionInfoVO = sessionService.getSessionInfo(request);

        Map<String, Object> posParam = new HashMap<String, Object>();
        posParam.put("originalStoreCd", request.getParameter("originalStoreCd"));
        posParam.put("targetStoreCd", request.getParameter("targetStoreCd"));

        int result = viewService.copyStoreEnv(copyStoreEnvVOs, posParam, sessionInfoVO);

        return returnJson(Status.OK, result);
    }

    /**
     * 매장 리스트 조회
     *
     * @param viewVO
     * @param request
     * @param response
     * @param model
     * @return
     * @author 이다솜
     * @since 2022.04.29
     */
    @RequestMapping(value = "/view/getStoreList.sb", method = RequestMethod.POST)
    @ResponseBody
    public Result getStoreList(ViewVO viewVO, HttpServletRequest request,
                                    HttpServletResponse response, Model model) {

        SessionInfoVO sessionInfoVO = sessionService.getSessionInfo();

        List<DefaultMap<String>> list = viewService.getStoreList(viewVO, sessionInfoVO);

        return returnListJson(Status.OK, list, viewVO);
    }

    /**
     * 매장 판매터치키 콤보박스 데이터 조회
     * @param viewVO
     * @param request
     * @param response
     * @param model
     * @return
     */
    @RequestMapping(value = "/view/getStoreTouchKeyGrpCombo.sb", method = RequestMethod.POST)
    @ResponseBody
    public Result getStoreTouchKeyGrpCombo(ViewVO viewVO, HttpServletRequest request,
                                  HttpServletResponse response, Model model) {

        SessionInfoVO sessionInfoVO = sessionService.getSessionInfo(request);

        List<DefaultMap<String>> result = viewService.getStoreTouchKeyGrpCombo(viewVO, sessionInfoVO);

        return ReturnUtil.returnListJson(Status.OK, result, viewVO);
    }

    /**
     * 매장 판매터치키 선택그룹 복사
     * @param copyStoreEnvVOs
     * @param request
     * @param response
     * @param model
     * @return
     */
    @RequestMapping(value = "/view/copyStoreTouchKeyGrp.sb", method = RequestMethod.POST)
    @ResponseBody
    public Result copyStoreTouchKeyGrp(@RequestBody CopyStoreEnvVO[] copyStoreEnvVOs, HttpServletRequest request,
                                          HttpServletResponse response, Model model) {

        SessionInfoVO sessionInfoVO = sessionService.getSessionInfo(request);

        int result = viewService.copyStoreTouchKeyGrp(copyStoreEnvVOs, sessionInfoVO);

        return returnJson(Status.OK, result);
    }
}
