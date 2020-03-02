package kr.co.solbipos.adi.board.board.service.impl;

import kr.co.common.data.structure.DefaultMap;
import kr.co.common.system.BaseEnv;
import kr.co.solbipos.application.session.auth.service.SessionInfoVO;
import kr.co.solbipos.application.session.user.enums.OrgnFg;
import kr.co.solbipos.adi.board.board.service.BoardService;
import kr.co.solbipos.adi.board.board.service.BoardVO;
import org.apache.commons.io.FilenameUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import kr.co.solbipos.application.com.griditem.enums.GridDataFg;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import java.io.File;
import java.util.Iterator;
import java.util.List;
import java.util.ArrayList;

import static kr.co.common.utils.DateUtil.currentDateTimeString;

/**
 * @Class Name : BoardServiceImpl.java
 * @Description : 부가서비스 > 게시판 > 일반게시판
 * @Modification Information
 * @
 * @  수정일      수정자              수정내용
 * @ ----------  ---------   -------------------------------
 * @ 2020.02.11  김설아      최초생성
 *
 * @author 솔비포스 개발본부 백엔드PT 김설아
 * @since 2020.02.11
 * @version 1.0
 *
 *  Copyright (C) by SOLBIPOS CORP. All right reserved.
 */

@Service("boardService")
@Transactional
public class BoardServiceImpl implements BoardService {
    private final BoardMapper boardMapper;

    /**
     * Constructor Injection
     */
    @Autowired
    public BoardServiceImpl(BoardMapper boardMapper) {
        this.boardMapper = boardMapper;
    }

    /** 일반게시판 조회 */
    @Override
    public List<DefaultMap<Object>> getBoardList(BoardVO boardVO, SessionInfoVO sessionInfoVO) {

        // 접속사용자의 권한(M : 시스템, A : 대리점, H : 본사, S : 매장)
        boardVO.setOrgnFg(sessionInfoVO.getOrgnFg().getCode());

        return boardMapper.getBoardList(boardVO);
    }

    /** 게시판 상세 팝업 - 조회 */
    @Override
    public DefaultMap<String> getBoardDetailList(BoardVO boardVO,  SessionInfoVO sessionInfoVO) {

        DefaultMap<String> resultMap = new DefaultMap<String>();

        String currentDt = currentDateTimeString();

        boardVO.setRegDt(currentDt);
        boardVO.setRegId(sessionInfoVO.getUserId());

        // 게시판 열람 이력 인덱스 조회(자동채번)
        String Idx = boardMapper.getBoardReadingHistIdx(boardVO);
        boardVO.setIdx(Idx);
        // 게시판 열람 이력 insert
        boardMapper.getBoardReadingHistInsert(boardVO);

        resultMap = boardMapper.getBoardDetailList(boardVO);

        // 게시판 조회수 조회
        String viewCnt = boardMapper.getBoardViewCnt(boardVO);
        boardVO.setViewCnt(viewCnt);
        // 게시판 조회수 update
        boardMapper.getBoardViewCntUpdate(boardVO);

        return resultMap;
    }

    /** 게시판 신규등록,수정 팝업 - 상세조회 */
    @Override
    public DefaultMap<String> getBoardInfoList(BoardVO boardVO,  SessionInfoVO sessionInfoVO) {

        return boardMapper.getBoardDetailList(boardVO);
    }

    /** 게시판 신규등록,수정 팝업 - 저장 */
    @Override
    public int getBoardInfoSave(BoardVO boardVO, SessionInfoVO sessionInfoVO) {

//        System.out.println("test1111");
        int procCnt = 0;
        String currentDt = currentDateTimeString();

        boardVO.setModDt(currentDt);
        boardVO.setModId(sessionInfoVO.getUserId());

        if (boardVO.getStatus() == GridDataFg.INSERT) {

            boardVO.setRegDt(currentDt);
            boardVO.setRegId(sessionInfoVO.getUserId());

            // 게시판 게시일련번호 조회(자동채번)
            String boardSeqNo = boardMapper.getBoardBoardSeqNo(boardVO);
            boardVO.setBoardSeqNo(boardSeqNo);

            procCnt = boardMapper.getBoardInfoSaveInsert(boardVO);

        } else if(boardVO.getStatus() == GridDataFg.UPDATE) {
            procCnt = boardMapper.getBoardInfoSaveUpdate(boardVO);

        } else if (boardVO.getStatus() == GridDataFg.DELETE) {
            // 게시판 delete
            procCnt = boardMapper.getBoardInfoSaveDelete(boardVO);

            // 게시판 전체 댓글 delete
            boardMapper.getBoardDetailAnswerSaveTotDelete(boardVO);
        }

        return procCnt;
    }

    /** 게시판 신규등록,수정 팝업 - 첨부파일 저장 */
    @Override
    public boolean getBoardInfoAtchSave(MultipartHttpServletRequest multi, SessionInfoVO sessionInfo) {

        boolean isSuccess = false;

        try{

            // 업로드 파일 읽기
            BoardVO boardInfo = new BoardVO();

            // 파일서버 대응 경로 지정 (운영)
//        String path = BaseEnv.FILE_UPLOAD_DIR + "posVer/";
            String path = "C:/testBoardAtch/";
            // 업로드 되는 파일명
            String newFileName = "";
            // 원본 파일명
            String orgFileName="";

            // 경로에 폴도가 있는지 체크
            File dir = new File(path);
            if(!dir.isDirectory()){
                dir.mkdir();
            }

            Iterator<String> files = multi.getFileNames();

            List<MultipartFile> fileList = multi.getFiles("file");
            for(MultipartFile mFile : fileList)
            {
                newFileName = String.valueOf(System.currentTimeMillis()); // 파일명 (물리적으로 저장되는 파일명)
                orgFileName = mFile.getOriginalFilename(); // 원본 파일명

                if(mFile.getOriginalFilename().lastIndexOf('.') > 1) {

                    orgFileName = mFile.getOriginalFilename().substring(0, mFile.getOriginalFilename().lastIndexOf('.'));
                    // 파일경로
                    boardInfo.setFilePath(path);
                    // 파일명 (물리적으로 저장되는 파일명)
                    boardInfo.setFileNm(newFileName);
                    // 원본 파일명
                    boardInfo.setOrginlFileNm(orgFileName);
                }

                String currentDt = currentDateTimeString();
                boardInfo.setModDt(currentDt);
                boardInfo.setModId(sessionInfo.getUserId());
                boardInfo.setRegDt(currentDt);
                boardInfo.setRegId(sessionInfo.getUserId());

                boardInfo.setStatusS((String)multi.getParameter("status"));
                boardInfo.setBoardCd((String)multi.getParameter("boardCd"));
                boardInfo.setBoardSeqNo((String)multi.getParameter("boardSeqNo"));

                // 게시물이 신규 일때 boardSeqNo 가져오기
                if(String.valueOf(GridDataFg.INSERT).equals(multi.getParameter("status"))) {

                    boardInfo.setTitle((String)multi.getParameter("title"));
                    boardInfo.setUserNm((String)multi.getParameter("userNm"));

                    // 게시판 신규등록시 boardSeqNo 가져오기
                    String boardSeqNo = boardMapper.getBoardAtchBoardSeqNo(boardInfo);
                    boardInfo.setBoardSeqNo(boardSeqNo);
                }

//                System.out.println("test22222 StatusS : "+ boardInfo.getStatusS());
//                System.out.println("test22222 BoardCd : "+ boardInfo.getBoardCd());
//                System.out.println("test22222 BoardSeqNo : "+ boardInfo.getBoardSeqNo());
//                System.out.println("test22222 FilePath : "+ boardInfo.getFilePath());
//                System.out.println("test22222 OrginlFileNm : "+ boardInfo.getOrginlFileNm());
//                System.out.println("test22222 title : "+ boardInfo.getTitle());
//                System.out.println("test22222 userNm : "+ boardInfo.getUserNm());

                // 첨부파일 저장시 IDX (자동채번)
                String idx = boardMapper.getBoardAtchIdx(boardInfo);
                boardInfo.setIdx(idx);

                // 첨부파일 저장 isert
                if(boardMapper.getBoardInfoAtchSaveIsert(boardInfo) > 0) {
                    isSuccess = true;
                } else {
                    isSuccess = false;
                }
            }
            
        }catch(Exception e){

            isSuccess = false;
        }
        return isSuccess;
    }

    /** 게시판 댓글 조회 */
    @Override
    public List<DefaultMap<Object>> getBoardDetailAnswerList(BoardVO boardVO, SessionInfoVO sessionInfoVO) {

        boardVO.setUserId(sessionInfoVO.getUserId());

        return boardMapper.getBoardDetailAnswerList(boardVO);
    }

    /** 게시판 댓글 저장 */
    @Override
    public int getBoardDetailAnswerSave(BoardVO boardVO, SessionInfoVO sessionInfoVO) {

        int procCnt = 0;
        String currentDt = currentDateTimeString();

        boardVO.setModDt(currentDt);
        boardVO.setModId(sessionInfoVO.getUserId());

        if (boardVO.getStatus() == GridDataFg.INSERT) {

            boardVO.setRegDt(currentDt);
            boardVO.setRegId(sessionInfoVO.getUserId());
            boardVO.setUserId(sessionInfoVO.getUserId());

            // 게시판 댓글번호 조회(자동채번)
            String idx = boardMapper.getBoardAnswerIdx(boardVO);
            boardVO.setIdx(idx);

            // 아이디에 따른 작성자 조회
            String userNm = boardMapper.getBoardUserNm(boardVO);
            boardVO.setUserNm(userNm);

            procCnt = boardMapper.getBoardDetailAnswerSaveInsert(boardVO);

        } else if(boardVO.getStatus() == GridDataFg.UPDATE) {
            procCnt = boardMapper.getBoardDetailAnswerSaveUpdate(boardVO);

        } else if (boardVO.getStatus() == GridDataFg.DELETE) {
            procCnt = boardMapper.getBoardDetailAnswerSaveDelete(boardVO);
        }

        // 게시판 댓글수 조회
        String answerCnt = boardMapper.getBoardAnswerCnt(boardVO);
        boardVO.setAnswerCnt(answerCnt);
        // 게시판 댓글수 update
        boardMapper.getBoardAnswerCntUpdate(boardVO);

        return procCnt;
    }

    /** 열람자목록 팝업 - 검색 */
    @Override
    public List<DefaultMap<Object>> getBoardReadingHistList(BoardVO boardVO, SessionInfoVO sessionInfoVO) {

        boardVO.setMembrOrgnCd(sessionInfoVO.getHqOfficeCd());
        if (sessionInfoVO.getOrgnFg() == OrgnFg.STORE ){
            boardVO.setStoreCd(sessionInfoVO.getStoreCd());
        }

        return boardMapper.getBoardReadingHistList(boardVO);
    }
}
