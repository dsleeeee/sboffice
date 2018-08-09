package kr.co.common.data.enums;

import org.apache.ibatis.type.MappedTypes;
import com.fasterxml.jackson.annotation.JsonValue;
import kr.co.common.data.enums.CodeEnum;
import kr.co.common.data.handler.CodeEnumTypeHandler;

/**
 * 사용 여부 Y:사용, N:미사용 enum type<br>
 * 프로젝트 전체에서 사용
 * 
 * @author bjcho
 *
 */
public enum UseYn implements CodeEnum {
    
    /** 전체 */
    ALL(""),
    /** 사용 */
    Y("Y"),
    /** 미사용 */
    N("N"),
    /** 선택 */
    S("");
    
    
    private String code;
  
    UseYn(String code) {
        this.code = code;
    }
    
    @MappedTypes(UseYn.class)
    public static class TypeHandler extends CodeEnumTypeHandler<UseYn> {
        public TypeHandler() {
            super(UseYn.class);
        }
    }
     
    @Override
    @JsonValue
    public String getCode() {
        return code;
    }
}
