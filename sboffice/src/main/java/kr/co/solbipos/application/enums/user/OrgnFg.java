package kr.co.solbipos.application.enums.user;

import org.apache.ibatis.type.MappedTypes;
import com.fasterxml.jackson.annotation.JsonValue;
import kr.co.solbipos.enums.CodeEnum;
import kr.co.solbipos.system.CodeEnumTypeHandler;

/**
 * 소속 구분
 * 
 * @author bjcho
 */
public enum OrgnFg implements CodeEnum  {
    
    /** 시스템 */
    MASTER("M"),
    /** 대리점 */
    AGENCY("A"),
    /** 본사 */
    HQ("H"),
    /** 매장 */
    STORE("S");
    
    private String code;
  
    OrgnFg(String code) {
        this.code = code;
    }
   
    @MappedTypes(OrgnFg.class)
    public static class TypeHandler extends CodeEnumTypeHandler<OrgnFg> {
        public TypeHandler() {
        super(OrgnFg.class);
        }
    }
     
    @Override
    @JsonValue
    public String getCode() {
        return code;
    }
}
