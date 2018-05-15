package kr.co.solbipos.pos.persistence.confg.vermanage;

import java.util.List;
import kr.co.solbipos.pos.domain.confg.vermanage.ApplcStoreVO;
import kr.co.solbipos.pos.domain.confg.vermanage.VerInfoVO;
import kr.co.common.data.structure.DefaultMap;

/**
 * 포스관리 > POS 설정관리 > POS 버전 관리
 * 
 * @author 김지은
 */
public interface VerManageMapper {

    /**
     * 포스버전 목록 조회
     * 
     * @param verInfo
     * @return
     */
    List<DefaultMap<String>> getList(VerInfoVO verInfo);

    /**
     * 포스버전정보 상세 조회
     * 
     * @param verInfo
     * @return
     */
    DefaultMap<String> dtlInfo(VerInfoVO verInfo);

    /**
     * 버전 삭제
     * 
     * @param verInfo
     * @return
     */
    int verDelete(VerInfoVO verInfo);

    /**
     * 등록 매장 목록
     * 
     * @param verInfo
     * @return
     */
    List<DefaultMap<String>> storeList(VerInfoVO verInfo);

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
     * @return
     */
    int registStore(ApplcStoreVO applcStore);
    
    /**
     * 일련번호 중복 체크
     * 
     * @param verInfo
     * @return
     */
    int chkVerSerNo(VerInfoVO verInfo);
    
    /**
     * 버전 등록 
     * 
     * @param verInfo
     */
    int verRegist(VerInfoVO verInfo);

    /**
     * 버전 수정
     * 
     * @param verInfo
     * @return
     */
    int verModify(VerInfoVO verInfo);

   
}
