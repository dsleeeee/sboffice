package kr.co.solbipos.base.service.store.tablelayout;

import static kr.co.common.utils.DateUtil.*;
import java.util.ArrayList;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import com.mxgraph.io.mxCodec;
import com.mxgraph.model.mxCell;
import com.mxgraph.model.mxGeometry;
import com.mxgraph.model.mxIGraphModel;
import com.mxgraph.util.mxXmlUtils;
import com.mxgraph.view.mxGraph;
import kr.co.common.data.enums.Status;
import kr.co.common.data.structure.DefaultMap;
import kr.co.common.data.structure.Result;
import kr.co.common.exception.BizException;
import kr.co.common.service.message.MessageService;
import kr.co.solbipos.application.domain.login.SessionInfoVO;
import kr.co.solbipos.base.domain.store.tablelayout.TableVO;
import kr.co.solbipos.base.domain.store.tablelayout.TableGroupVO;
import kr.co.solbipos.base.enums.ConfgFg;
import kr.co.solbipos.base.enums.Style;
import kr.co.solbipos.base.enums.TblGrpFg;
import kr.co.solbipos.base.enums.TblTypeFg;
import kr.co.solbipos.base.persistence.store.tableattr.TableAttrMapper;
import kr.co.solbipos.base.persistence.store.tablelayout.TableLayoutMapper;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@Transactional
public class TableLayoutServiceImpl implements TableLayoutService {

    @Autowired
    MessageService messageService;

    @Autowired
    private TableLayoutMapper mapper;

    @Autowired
    private TableAttrMapper attrMapper;

    @Override
    public String selectTableLayoutByStore(SessionInfoVO sessionInfoVO) {
        DefaultMap<String> param = new DefaultMap<String>();
        param.put("storeCd", sessionInfoVO.getOrgnCd());
        param.put("confgFg", ConfgFg.TABLE_LAYOUT.getCode());
        String returnStr = attrMapper.selectXmlByStore(param);
        return returnStr;
    }

    @Override
    public Result setTableLayout(SessionInfoVO sessionInfoVO, String xml) {

        //XML 저장
        DefaultMap<String> param = new DefaultMap<String>();
        param.put("storeCd", sessionInfoVO.getOrgnCd());
        param.put("confgFg", ConfgFg.TABLE_LAYOUT.getCode());
        param.put("xml", xml);
        param.put("useYn", "Y");
        param.put("regDt", currentDateTimeString());
        param.put("regId", sessionInfoVO.getUserId());

        if( attrMapper.selectXmlByStore(param) != null ) {
            if( attrMapper.updateStoreConfgXml(param) != 1 ) {
                throw new BizException( messageService.get("label.modifyFail") );
            }
        }
        else {
            if( attrMapper.insertStoreConfgXml(param) != 1 ) {
                throw new BizException( messageService.get("label.insertFail") );
            }
        }

        //XML 분석, TableGroup, Table Domain 생성
        //테이블속성 TABLE(TB_MS_TABLE_GROUP, TB_MS_TABLE)
        List<TableGroupVO> tableGroupVOs = parseXML(xml);

        //매장의 현재 설정정보 삭제
        mapper.deleteTableGroupByStore(sessionInfoVO.getOrgnCd());
        mapper.deleteTableByStore(sessionInfoVO.getOrgnCd());

        //리스트의 아이템을 DB에 Merge
        for(TableGroupVO tableGroupVO : tableGroupVOs) {
            //테이블 그룹 저장
            tableGroupVO.setStoreCd(sessionInfoVO.getOrgnCd());
            tableGroupVO.setRegId(sessionInfoVO.getUserId());

            if( mapper.mergeTableGroupByStore(tableGroupVO) != 1 ) {
                throw new BizException( messageService.get("label.modifyFail") );
            }
            //테이블 저장
            for(TableVO tableVO : tableGroupVO.getTables()) {
                tableVO.setStoreCd(sessionInfoVO.getOrgnCd());
                tableVO.setRegId(sessionInfoVO.getUserId());
                if( mapper.mergeTableByStore(tableVO) != 1 ) {
                    throw new BizException( messageService.get("label.modifyFail") );
                }
            }
        }
        return new Result(Status.OK);
    }

    /**
     * XML 파싱하여 테이블 구성 항목 추출
     * @param xml 파싱대상XML
     * @return 테이블그룹객체
     */
    private List<TableGroupVO> parseXML(String xml) {

        List<TableGroupVO> tableGroupVOs = new ArrayList<TableGroupVO>();
        TableGroupVO tableGroupVO = new TableGroupVO();

        List<TableVO> tableVOs = new ArrayList<TableVO>();

        try {
            mxGraph graph = new mxGraph();
            Document doc = mxXmlUtils.parseXml(xml);
            mxCodec codec = new mxCodec(doc);

            mxIGraphModel model = graph.getModel();
            Element elt = doc.getDocumentElement();

            codec.decode(elt, model);

            mxCell layer = new mxCell();
            String regDt = currentDateTimeString();

            for(int i = 0; i < model.getChildCount(model.getRoot()); i++) {
                layer = (mxCell)model.getChildAt(model.getRoot(), i);
                log.debug(layer.toString());

                tableGroupVO = new TableGroupVO();

                tableGroupVO.setTblGrpCd(layer.getId());
                tableGroupVO.setTblGrpNm(String.valueOf(layer.getValue()));
                //TODO 배경이미지 그룹별로 넣을 수 있게 JS부터 개발할 것
                //tableGroup.setBgImgNm("")

                //스타일
                String styleStr = layer.getStyle();
                if(styleStr != null) {
                    String[] styles = styleStr.split(";");
                    for(String style : styles) {

                        String[] styleKeyValue = style.split("=");
                        if(styleKeyValue.length < 2) {
                            continue;
                        }
                        //log.debug(styleKeyValue[0]);
                        switch(Style.getEnum(styleKeyValue[0])) {
                            case TBL_GRP_FG:
                                tableGroupVO.setTblGrpFg(TblGrpFg.getEnum(styleKeyValue[1]));
                                break;
                            case BG_COLOR:
                                tableGroupVO.setBgColor(styleKeyValue[1]);
                                break;
                            case BG_IMG:
                                tableGroupVO.setBgImgNm(styleKeyValue[1]);
                            break;
                            default:
                                break;
                        }
                    }
                }

                tableGroupVO.setDispSeq(Long.parseLong((String.valueOf(i+1))));
                tableGroupVO.setUseYn("Y");
                tableGroupVO.setRegDt(regDt);

                tableVOs = getTables(graph, layer, tableGroupVO);

                tableGroupVO.setTables(tableVOs);

                tableGroupVOs.add(tableGroupVO);

                log.debug(tableGroupVOs.toString());
            }
        }
        catch (Exception ex) {
            ex.printStackTrace();
        }
        return tableGroupVOs;
    }
    /**
     * 레이어 id로 해당 레이어에 있는 테이블 List 추출
     * @param id
     * @return
     */
    private List<TableVO> getTables(mxGraph graph, mxCell layer, TableGroupVO tableGroupVO) {
        List<TableVO> tableVOs = new ArrayList<TableVO>();
        TableVO tableVO = null;
        mxCell cell = new mxCell();
        Object[] cells = graph.getChildVertices(layer);
        for(Object c : cells) {
            cell = (mxCell) c;
            tableVO = TableVO.builder().build();
            tableVO.setStoreCd(tableGroupVO.getStoreCd());
            tableVO.setTblCd(cell.getId());
            tableVO.setTblNm(getLabel(graph, cell));
            tableVO.setTblGrpCd(tableGroupVO.getTblGrpCd());
            //TODO 테이블 좌석 수 설정
            //table.setTblSeatCnt(tblSeatCnt);
            //좌표, 크기
            mxGeometry geo = cell.getGeometry();
            tableVO.setX((long)geo.getX());
            tableVO.setY((long)geo.getY());
            tableVO.setWidth((long)geo.getWidth());
            tableVO.setHeight((long)geo.getHeight());

            tableVO.setTblTypeFg(TblTypeFg.SQUARE);
            tableVO.setUseYn(tableGroupVO.getUseYn());
            tableVO.setRegDt(tableGroupVO.getRegDt());

            tableVOs.add(tableVO);
        }
        return tableVOs;
    }
    /**
     * 주어진 셀에서 라벨 추출
     * @param id
     * @return
     */
    private String getLabel(mxGraph graph, mxCell cell) {
        Object[] labels = graph.getChildVertices(cell);
        String finalLabel = "";
        for(Object label : labels) {
            mxCell lbl = (mxCell) label;

            if("label".equals(lbl.getStyle())) {
                finalLabel = String.valueOf(lbl.getValue());
            }
        }
        return finalLabel;
    }
}
