package kr.co.solbipos.sys.admin.posUtilLog.service;

import kr.co.common.data.structure.DefaultMap;

import java.util.List;

/**
 * @Class Name : PosUtilLogService.java
 * @Description : 시스템관리 > 관리자기능 > 포스유틸사용로그
 * @Modification Information
 * @
 * @  수정일      수정자              수정내용
 * @ ----------  ---------   -------------------------------
 * @ 2023.12.21  김유승      최초생성
 *
 * @author 솔비포스 WEB개발팀 김유승
 * @since 2023.12.21
 * @version 1.0
 *
 * @Copyright (C) by SOLBIPOS CORP. All right reserved.
 */
public interface PosUtilLogService {

    /** 포스유틸사용로그 - 조회 */
    List<DefaultMap<String>> getPosUtilLogList(PosUtilLogVO posUtilLogVO);
}
