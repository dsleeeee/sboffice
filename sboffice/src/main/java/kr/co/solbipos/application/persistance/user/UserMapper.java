package kr.co.solbipos.application.persistance.user;

import java.util.HashMap;

/**
 * 
 * @author 정용길
 *
 */
public interface UserMapper {
    /**
      * 담당자 이름, 핸드폰 번호로 userId 조회
      * @param param
      * @return
      */
    String selectUserCheck(HashMap<String, String> param);
}
