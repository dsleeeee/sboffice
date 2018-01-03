package kr.co.solbipos.application.controller.sample;

import static kr.co.solbipos.utils.spring.StringUtil.*;
import java.util.HashMap;
import java.util.List;
import java.util.Optional;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import kr.co.solbipos.application.domain.sample.CommonCode;
import kr.co.solbipos.application.domain.sample.SslTrdtlT;
import kr.co.solbipos.application.domain.sample.CcdCodemT;
import kr.co.solbipos.application.domain.sample.TmpDragtT;
import kr.co.solbipos.application.service.sample.SampleService;
import kr.co.solbipos.service.grid.GridSupportService;
import kr.co.solbipos.service.message.MessageService;
import kr.co.solbipos.structure.DefaultMap;
import kr.co.solbipos.structure.JsonResult;
import kr.co.solbipos.structure.Result;
import kr.co.solbipos.structure.Result.Status;
import lombok.extern.slf4j.Slf4j;

/**
 * 샘플 컨트롤러다.
 * 
 * @author 정용길
 */

@Slf4j
@Controller
public class SampleWijimoController {

    @Autowired
    SampleService sampleService;

    @Autowired
    MessageService messageService;

    @Autowired
    GridSupportService gsService;

    @RequestMapping(value = "sampleGridMain.sb")
    public String sampleGridMain(HttpSession session, Model model) {
        return "sampleWijmo/sampleGridMain";
    }

    /**
     * 그리드 샘플
     * 
     * @param session
     * @param model
     * @return
     */
    @RequestMapping(value = "sampleGrid.sb")
    public String sample4(HttpSession session, Model model) {
        List<DefaultMap<Object>> temp = sampleService.selectDdSum();
        model.addAttribute("data", temp);
        return "sampleWijmo/sampleGrid";
    }

    /**
     * 그냥 테스트용
     * 
     * @param rnum
     * @param model
     * @return
     */
    @RequestMapping(value = "sampleGrid2.sb")
    public String sample5(Integer rnum, Model model) {
        model.addAttribute("data", getDdlTrdtlT(rnum).toString());
        return "sampleWijmo/sampleGrid2";
    }

    /**
     * 그리드 헤더 번역용...
     * 
     * @param rnum
     * @param model
     * @return
     */
    @RequestMapping(value = "exGridHeader.sb")
    public String exGridHeader(Integer rnum, Model model) {

        List<DefaultMap<Object>> data = sampleService.selectDdlTrdtlT(rnum);

        // List<String> columns = Arrays.asList("dcmSaleAmt", "prodCd", "prmProcYn");

        model.addAttribute("columnList", convertToJson(gsService.getGridColumns(data.get(0))));
        model.addAttribute("data", convertToJson(data));

        return "sampleWijmo/exGridHeader";
    }

    public String getDdlTrdtlT(Integer rnum) {
        Integer param = Optional.ofNullable(rnum).orElse(100);
        List<DefaultMap<Object>> data = sampleService.selectDdlTrdtlT(param);
        return convertToJson(data);
    }



    @RequestMapping(value = "cmmcode.sb")
    public JsonResult cmmcode(Model model) {

        List<DefaultMap<Object>> temp = sampleService.selectCommonCodeList("001");

        Result result = new Result(Status.OK, temp);

        return new JsonResult(result);
    }


    /**
     * 위즈모 input 샘플
     * 
     * @param model
     * @return
     */
    @RequestMapping(value = "exInput.sb")
    public String exInput(Model model) {
        return "sampleWijmo/exInput";
    }

    /**
     * 위즈모 트리 샘플
     * 
     * @param model
     * @return
     */
    @RequestMapping(value = "exTree.sb")
    public String exTree(Model model) {
        return "sampleWijmo/exTree";
    }
    /**
     * 위즈모 트리 데이터 로드 테스트 (메뉴 테스트)
     * @param model
     * @return
     */
   @RequestMapping(value="exTreeMenu.sb")
   public String exTreeLoadTest(Model model) {
     List<DefaultMap<Object>> data = sampleService.selectTreeMenu();
     model.addAttribute("menuList", convertToJson(data));
     return "sampleWijmo/exTreeMenu";
   }

   /**
     * 위즈모 트리 데이터 로드 (본사/매장)
     * @param model
     * @return
     */
   @RequestMapping(value="exTreeStore.sb")
   public String exTreeStore(Model model) {
     List<DefaultMap<Object>> data = sampleService.getgroupGridSample();
     model.addAttribute("shopList", convertToJson(data));
     return "sampleWijmo/exTreeStore";
   }
   
   /**
    * 위즈모 트리 데이터 로드 (본사/매장) - 매장 단일선택 샘플
    * @param model
    * @return
    */
    @RequestMapping(value="exTreeStore2.sb")
    public String exTreeStore2(Model model) {
      List<DefaultMap<Object>> data = sampleService.getgroupGridSample();
      model.addAttribute("shopList", convertToJson(data));
      return "sampleWijmo/exTreeStore2";
    }
  
  /**
   * drag & drop 
   * @param model
   * @return
   */
   @RequestMapping(value="exDragNDrop.sb")
   public String exDragNDrop(Model model) {
  
     TmpDragtT tmpDragt = new TmpDragtT();
     tmpDragt.setComFg("1");
     
     // 등록된 데이터(왼쪽)
     List<DefaultMap<Object>> data1 = sampleService.getDragNDropSample(tmpDragt);
     model.addAttribute("leftData", convertToJson(data1));
     
     // 미등록 데이터(오른쪽)
     tmpDragt.setComFg("2");
     List<DefaultMap<Object>> data2 = sampleService.getDragNDropSample(tmpDragt);
     model.addAttribute("rightData", convertToJson(data2));
     
     return "sampleWijmo/exDragNDrop";
   }
 
   /**
    * save Drag & Drop 
    * @param model
    * @return
    */
   @RequestMapping(value = "saveDragNDrop.sb", method = RequestMethod.POST)
   @ResponseBody
   public JsonResult saveDragNDrop(HttpSession sessions, Model model, @RequestBody TmpDragtT[] tmpDragtT) {

     log.error("tmpDragtT.length  : " + tmpDragtT.length);
  
     if(tmpDragtT.length > 0) {
       for(int i=0; i<tmpDragtT.length; i++) {
         
         log.error(i + " : " + tmpDragtT[i]);
         log.error("comCd : " + tmpDragtT[i].getComCd());
         
         //TODO insert, update, delete 로직 추가
       }
     }
   
     List<DefaultMap<Object>> temp = sampleService.selectDdSum();
     Result result = new Result(Status.OK, temp);
     return new JsonResult(result);
   }
 
   /**
    * drag & drop  test
    * @param model
    * @return
    */
   @RequestMapping(value="exDragNDrop2.sb")
   public String exDragNDrop2(Model model) {
     return "sampleWijmo/exDragNDrop2";
   }
 
  /**
   * data insert test
   * @param model
   * @return
   */
   @RequestMapping(value="exGridInsert.sb")
   public String exGridInsert(Model model) {
 
     // 공통코드
     CcdCodemT ccdCodemT = new CcdCodemT();
     ccdCodemT.setComCdFg("012");
     List<DefaultMap<Object>> commList = sampleService.selectCode(ccdCodemT);
   
     // 테스트 리스트
     TmpDragtT tmpDragt = new TmpDragtT();
     tmpDragt.setComFg("");
     List<DefaultMap<Object>> list = sampleService.getDragNDropSample(tmpDragt);
   
     model.addAttribute("list", convertToJson(list));
     model.addAttribute("commList", convertToJson(commList));
     return "sampleWijmo/exGridInsert";
   }
 
   /**
    * data insert test
    * @param model
    * @return
    */
   @RequestMapping(value="exGridInsertJson.sb")
   @ResponseBody
   public JsonResult exGridInsertJson(HttpSession session, Model model) {
     // 테스트 리스트
     TmpDragtT tmpDragt = new TmpDragtT();
     tmpDragt.setComFg("");
     List<DefaultMap<Object>> list = sampleService.getDragNDropSample(tmpDragt);
     Result result = new Result(Status.OK, list);
     return new JsonResult(result);
   }
   
}


