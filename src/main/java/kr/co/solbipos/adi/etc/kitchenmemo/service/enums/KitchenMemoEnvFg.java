package kr.co.solbipos.adi.etc.kitchenmemo.service.enums;

import com.fasterxml.jackson.annotation.JsonValue;
import kr.co.common.data.enums.CodeEnum;
import kr.co.common.data.handler.CodeEnumTypeHandler;
import kr.co.solbipos.base.pay.coupon.service.enums.PayTypeFg;
import org.apache.ibatis.type.MappedTypes;

import java.util.Arrays;
import java.util.List;

/**
 * @Class Name : CoupnEnvFg.java
 * @Description : 쿠폰등록 본사통제구분 enum type
 *                TB_HQ_ENVST
 * @Modification Information
 * @
 * @  수정일      수정자              수정내용
 * @ ----------  ---------   -------------------------------
 * @ 2018.08.22  김지은      최초생성
 *
 * @author 솔비포스 차세대개발실 김지은
 * @since 2018.08.22
 * @version 1.0
 *
 *  Copyright (C) by SOLBIPOS CORP. All right reserved.
 */

public enum KitchenMemoEnvFg implements CodeEnum {

    /** 본사 통제 */
    HQ("1"),
    /** 매장통제 */
    STORE("2");

    private String code;
    private KitchenMemoEnvFg[] values;

    KitchenMemoEnvFg(String code, KitchenMemoEnvFg... values) {
        this.code = code;
        this.values = values;
    }

    public KitchenMemoEnvFg[] getValues() {
        return values;
    }

    @MappedTypes(KitchenMemoEnvFg.class)
    public static class TypeHandler extends CodeEnumTypeHandler<PayTypeFg> {
        public TypeHandler() {
            super(PayTypeFg.class);
        }
    }

    @Override
    @JsonValue
    public String getCode() {
        return code;
    }

    public static KitchenMemoEnvFg getEnum(String code) {
        List<KitchenMemoEnvFg> list = Arrays.asList(KitchenMemoEnvFg.values());
        return list.stream().filter(m -> m.code.equals(code)).findAny().orElse(null);
    }
}
