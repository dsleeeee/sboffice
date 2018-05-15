package kr.co.solbipos.pos.service.confg.vermanage;

import java.util.List;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import kr.co.common.data.structure.DefaultMap;
import kr.co.solbipos.application.domain.login.SessionInfoVO;
import kr.co.solbipos.pos.domain.confg.vermanage.ApplcStoreVO;
import kr.co.solbipos.pos.domain.confg.vermanage.VerInfoVO;

/**
 * 포스관리 > POS 설정관리 > POS 버전 관리
 * 
 * @author 김지은
 */
public interface VerManageService {

    /**
     * 포스버전 목록 조회
     * 
     * @param verInfo
     * @return
     */
    List<DefaultMap<String>> list(VerInfoVO verInfo);

    /**
     * 포스버전정보 상세 조회
     * 
     * @param verInfo
     * @return
     */
    DefaultMap<String> dtlInfo(VerInfoVO verInfo);

    /**
     * 매장목록 조회
     * 
     * @param verInfo
     * @return
     */
    List<DefaultMap<String>> storeList(VerInfoVO verInfo);
    
    /**
     * 버전 삭제
     * 
     * @param verInfo
     * @return
     */
    int verDelete(VerInfoVO verInfo);
    
    /**
     * 버전 중복 체크
     * 
     * @param verInfo
     * @return
     */
    int chkVerSerNo(VerInfoVO verInfo);
    
    /**
     * 버전 등록
     * 
     * @param request
     * @param verInfo
     * @return
     */
    boolean regist(MultipartHttpServletRequest multi, SessionInfoVO sessionInfo);
    
    /**
     * 버전 수정
     * 
     * @param request
     * @param verInfo
     * @return
     */
    boolean modify(MultipartHttpServletRequest request, SessionInfoVO sessionInfo);

    /**
     * 매장추가 매장검색
     * 
     * @param applcStore
     * @return
     */
    List<DefaultMap<String>> srchStoreList(ApplcStoreVO applcStore);

    /**
     * 버전 적용 매장 등록
     * 
     * @param applcStore
     * @param sessionInfo
     * @return
     */
    int registStore(ApplcStoreVO[] applcStore, SessionInfoVO sessionInfo);

}
