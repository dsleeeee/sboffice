package kr.co.solbipos.pos.confg.vermanage.service.impl;

import static kr.co.common.utils.DateUtil.currentDateTimeString;
import java.io.File;
import java.util.Iterator;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import kr.co.common.data.enums.Status;
import kr.co.common.data.enums.UseYn;
import kr.co.common.data.structure.DefaultMap;
import kr.co.common.exception.JsonException;
import kr.co.common.service.message.MessageService;
import kr.co.common.system.BaseEnv;
import kr.co.solbipos.application.session.auth.service.SessionInfoVO;
import kr.co.solbipos.pos.confg.vermanage.service.ApplcStoreVO;
import kr.co.solbipos.pos.confg.vermanage.service.VerInfoVO;
import kr.co.solbipos.pos.confg.vermanage.service.VerManageService;
import kr.co.solbipos.pos.confg.verrecv.enums.VerRecvFg;

/**
* @Class Name : VerManageServiceImpl.java
* @Description : 포스관리 > POS 설정관리 > POS 버전 관리
* @Modification Information
* @
* @  수정일      수정자              수정내용
* @ ----------  ---------   -------------------------------
* @ 2018.06.01  김지은      최초생성
*
* @author 솔비포스 차세대개발실 김지은
* @since 2018. 05.01
* @version 1.0
*
*  Copyright (C) by SOLBIPOS CORP. All right reserved.
*/
@Service("verManageService")
public class VerManageServiceImpl implements VerManageService {

    @Autowired
    VerManageMapper mapper;

    @Autowired
    MessageService messageService;

    /** 포스버전 목록 조회 */
    @Override
    public List<DefaultMap<String>> list(VerInfoVO verInfo) {
        return mapper.getList(verInfo);
    }

    /** 포스버전정보 상세 조회 */
    @Override
    public DefaultMap<String> dtlInfo(VerInfoVO verInfo) {
        return mapper.dtlInfo(verInfo);
    }

    /** 매장목록 조회 */
    @Override
    public List<DefaultMap<String>> storeList(VerInfoVO verInfo) {
        return mapper.storeList(verInfo);
    }

    /** 버전 삭제 */
    @Override
    public int verDelete(VerInfoVO verInfo) {
        return mapper.verDelete(verInfo);
    }

    /** 버전 시리얼넘버 중복 체크 */
    @Override
    public int chkVerSerNo(VerInfoVO verInfo) {
        return mapper.chkVerSerNo(verInfo);
    }

    /** 버전 등록 */
    @Override
    public boolean regist(MultipartHttpServletRequest multi, SessionInfoVO sessionInfo) {

        boolean isSuccess = false;

        try{

            VerInfoVO verInfo = uploadFile(multi);

            String insertDt = currentDateTimeString();

            verInfo.setVerSerNo((String)multi.getParameter("verSerNo"));
            verInfo.setVerSerNm((String)multi.getParameter("verSerNm"));
            verInfo.setFileSize((String)multi.getParameter("fileSize"));
            verInfo.setFileDesc((String)multi.getParameter("fileDesc"));
            verInfo.setProgFg((String)multi.getParameter("progFg"));
            verInfo.setPgmYn((String)multi.getParameter("pgmYn"));
            verInfo.setImgYn((String)multi.getParameter("imgYn"));
            verInfo.setDbYn((String)multi.getParameter("dbYn"));

            if(String.valueOf(UseYn.Y) == multi.getParameter("useYn")){
                verInfo.setUseYn(UseYn.Y);
            } else {
                verInfo.setUseYn(UseYn.N);
            }

            verInfo.setRegDt(insertDt);
            verInfo.setRegId(sessionInfo.getUserId());
            verInfo.setModDt(insertDt);
            verInfo.setModId(sessionInfo.getUserId());

            mapper.verRegist(verInfo);

            isSuccess = true;

        }catch(Exception e){

            isSuccess = false;
        }
        return isSuccess;
    }

    /** 버전 수정 */
    @Override
    public boolean modify(MultipartHttpServletRequest multi, SessionInfoVO sessionInfo) {

        boolean isSuccess = false;

        try{
            VerInfoVO verInfo = uploadFile(multi);

            String insertDt = currentDateTimeString();

            verInfo.setVerSerNo((String)multi.getParameter("verSerNo"));
            verInfo.setVerSerNm((String)multi.getParameter("verSerNm"));
            verInfo.setFileSize((String)multi.getParameter("fileSize"));
            verInfo.setFileDesc((String)multi.getParameter("fileDesc"));
            verInfo.setProgFg((String)multi.getParameter("progFg"));
            verInfo.setPgmYn((String)multi.getParameter("pgmYn"));
            verInfo.setImgYn((String)multi.getParameter("imgYn"));
            verInfo.setDbYn((String)multi.getParameter("dbYn"));

            if(String.valueOf(UseYn.Y) == multi.getParameter("useYn")){
                verInfo.setUseYn(UseYn.Y);
            } else {
                verInfo.setUseYn(UseYn.N);
            }

            verInfo.setRegDt(insertDt);
            verInfo.setRegId(sessionInfo.getUserId());
            verInfo.setModDt(insertDt);
            verInfo.setModId(sessionInfo.getUserId());

            mapper.verModify(verInfo);

            isSuccess = true;

        }catch(Exception e){

            isSuccess = false;
        }
        return isSuccess;

    }

    /** 파일 업로드 (등록, 수정 )  */
    private VerInfoVO uploadFile(MultipartHttpServletRequest multi) {
        VerInfoVO verInfo = new VerInfoVO();

        // 저장 경로 설정
        String root = multi.getSession().getServletContext().getRealPath("/");
//        String path = root+"resources/upload/";
        String path = root+BaseEnv.FILE_UPLOAD_DIR;


        String newFileName = ""; // 업로드 되는 파일명

        File dir = new File(path);
        if(!dir.isDirectory()){
            dir.mkdir();
        }

        Iterator<String> files = multi.getFileNames();
        while(files.hasNext()){
            String uploadFile = files.next();

            MultipartFile mFile = multi.getFile(uploadFile);
            String fileName = mFile.getOriginalFilename();
            newFileName = System.currentTimeMillis()+"."
                    +fileName.substring(fileName.lastIndexOf(".")+1);

            verInfo.setFileNm(newFileName);
            verInfo.setFileDir(path);

            try {
                mFile.transferTo(new File(path+newFileName));
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return verInfo;
    }


    /** 매장검색 (매장추가용) */
    @Override
    public List<DefaultMap<String>> srchStoreList(ApplcStoreVO applcStore) {
        return mapper.srchStoreList(applcStore);
    }

    /** 버전 적용 매장 등록 */
    @Override
    public int registStore(ApplcStoreVO[] applcStores, SessionInfoVO sessionInfo) {

        int procCnt = 0;

        String dt = currentDateTimeString();

        for(ApplcStoreVO applcStore : applcStores) {
            applcStore.setRegDt(dt);
            applcStore.setModDt(dt);
            applcStore.setRegId(sessionInfo.getUserId());
            applcStore.setModId(sessionInfo.getUserId());
            applcStore.setVerRecvFg(VerRecvFg.REG);
            applcStore.setVerRecvDt(dt);;

            procCnt += mapper.registStore(applcStore);
        }

        if(procCnt == applcStores.length) {
            return procCnt;
        } else {
            throw new JsonException(Status.FAIL, messageService.get("cmm.saveFail"));
        }
    }

    /** 버전 적용 매장 삭제 */
    @Override
    public int removeStore(ApplcStoreVO[] applcStores, SessionInfoVO sessionInfo) {

        int procCnt = 0;

        for(ApplcStoreVO applcStore : applcStores) {
            procCnt += mapper.removeStore(applcStore);
        }

        if(procCnt == applcStores.length) {
            return procCnt;
        } else {
            throw new JsonException(Status.FAIL, messageService.get("cmm.saveFail"));
        }
    }
}
