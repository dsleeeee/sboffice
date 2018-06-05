package kr.co.solbipos.store.controller.hq.hqbrand;

import static kr.co.common.utils.grid.ReturnUtil.returnJson;
import static kr.co.common.utils.grid.ReturnUtil.returnListJson;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import kr.co.common.data.enums.Status;
import kr.co.common.data.structure.DefaultMap;
import kr.co.common.data.structure.Result;
import kr.co.common.service.session.SessionService;
import kr.co.common.utils.jsp.CmmCodeUtil;
import kr.co.solbipos.application.domain.login.SessionInfoVO;
import kr.co.solbipos.store.domain.hq.hqbrand.HqBrandVO;
import kr.co.solbipos.store.domain.hq.hqbrand.HqClsVO;
import kr.co.solbipos.store.domain.hq.hqbrand.HqEnvstVO;
import kr.co.solbipos.store.service.hq.hqbrand.HqBrandService;

/**
 * 가맹점관리 > 본사정보 > 브랜드정보관리
 * 
 * @author 김지은
 */
@Controller
@RequestMapping(value = "/store/hq/hqbrand/")
public class HqBrandManageController {

    @Autowired
    HqBrandService service;
    
    @Autowired
    SessionService sessionService;
    
    @Autowired
    CmmCodeUtil cmmCodeUtil;

    /**
     * 브랜드정보관리 화면 이동
     * @param request
     * @param response
     * @param model
     * @return
     */
    @RequestMapping(value = "hqbrandmanage/list.sb", method = RequestMethod.GET)
    public String list(HttpServletRequest request, HttpServletResponse response, 
            Model model) {
        return "store/hq/hqbrand/hqbrandmanage";
    }
    
    /**
     * 브랜드 목록 조회
     * @param hqBrand
     * @param request
     * @param response
     * @param model
     * @return
     */
    @RequestMapping(value = "hqbrandmanage/list.sb", method = RequestMethod.POST)
    @ResponseBody
    public Result list(HqBrandVO hqBrand, HttpServletRequest request,
            HttpServletResponse response, Model model) {
        
        List<DefaultMap<String>> list = service.list(hqBrand);
        
        return returnListJson(Status.OK, list, hqBrand);
    }
    
    /**
     * 브랜드 등록, 수정
     * @param hqBrandVOs
     * @param request
     * @param response
     * @param model
     * @return
     */
    @RequestMapping(value = "hqbrandmanage/save.sb", method = RequestMethod.POST)
    @ResponseBody
    public Result save(@RequestBody HqBrandVO[] hqBrandVOs, HttpServletRequest request,
            HttpServletResponse response, Model model) {
        
        SessionInfoVO sessionInfoVO = sessionService.getSessionInfo(request);

        int result = service.save(hqBrandVOs, sessionInfoVO);
        
        return returnJson(Status.OK, result);
    }
    
    /**
     * 환경설정 조회
     * @param hqBrand
     * @param request
     * @param response
     * @param model
     * @return
     */
    @RequestMapping(value = "config/list.sb", method = RequestMethod.POST)
    @ResponseBody
    public Result configList(HqBrandVO hqBrand, HttpServletRequest request,
            HttpServletResponse response, Model model) {
        
        List<DefaultMap<String>> list = service.getConfigList(hqBrand);
        
        return returnListJson(Status.OK, list, hqBrand);
    }
    
    /**
     * 환경설정 저장
     * @param hqBrands
     * @param request
     * @param response
     * @param model
     * @return
     */
    @RequestMapping(value = "config/save.sb", method = RequestMethod.POST)
    @ResponseBody
    public Result saveConfig(@RequestBody HqEnvstVO[] hqEnvsts, HttpServletRequest request,
            HttpServletResponse response, Model model) {
        
        SessionInfoVO sessionInfoVO = sessionService.getSessionInfo(request);

        int result = service.saveConfig(hqEnvsts, sessionInfoVO);
        
        return returnJson(Status.OK, result);
    }
    
    /**
     * 분류 조회
     * @param hqBrand
     * @param request
     * @param response
     * @param model
     * @return
     */
    @RequestMapping(value = "productclass/list.sb", method = RequestMethod.POST)
    @ResponseBody
    public Result clsList(HqBrandVO hqBrand, HttpServletRequest request,
            HttpServletResponse response, Model model) {
        
        List<HqClsVO> list = service.getClsList(hqBrand);
        
        return returnListJson(Status.OK, list, hqBrand);
    }
    
    
    /**
     * 분류 등록
     * @param hqBrand
     * @param request
     * @param response
     * @param model
     * @return
     */
    @RequestMapping(value = "productclass/save.sb", method = RequestMethod.POST)
    @ResponseBody
    public Result clsSave(@RequestBody HqClsVO[] HqClsVOs, HttpServletRequest request,
            HttpServletResponse response, Model model) {
        
        SessionInfoVO sessionInfoVO = sessionService.getSessionInfo(request);

        int result = service.clsSave(HqClsVOs, sessionInfoVO);
        
        return returnJson(Status.OK, result);
    }
    
    
    
    
    
}
