package kr.co.solbipos.application.enums.login;

import org.apache.ibatis.type.MappedTypes;
import com.fasterxml.jackson.annotation.JsonValue;
import kr.co.solbipos.enums.CodeEnum;
import kr.co.solbipos.system.CodeEnumTypeHandler;

/**
 * {@link kr.co.solbipos.application.domain.login.LoginHist}<br>
 * {@code loginOrgn} enum type<br>
 * 로그인 시도 웹, 포스 구분
 * 
 * @author bjcho
 */
public enum LoginOrigin implements CodeEnum  {

  /** 웹 로그인 */
    WEB("WEB")
    /** 포스 로그인 */
    , POS("POS")
    /** 기타 */
    , ETC("ETC")
    ;

  private String code;
  private LoginOrigin[] value;

  LoginOrigin(String code, LoginOrigin... values) {
      this.code = code;
      this.value = values;
  }

  public LoginOrigin[] getValues() {
      return value;
  }
 
  @MappedTypes(LoginOrigin.class)
  public static class TypeHandler extends CodeEnumTypeHandler<LoginOrigin> {
      public TypeHandler() {
          super(LoginOrigin.class);
      }
  }
   
  @Override
  @JsonValue
  public String getCode() {
      return code;
  }
}
