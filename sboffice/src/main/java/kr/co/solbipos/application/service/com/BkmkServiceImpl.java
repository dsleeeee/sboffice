package kr.co.solbipos.application.service.com;

import static kr.co.common.utils.DateUtil.currentDateTimeString;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import kr.co.solbipos.application.domain.com.BkmkVO;
import kr.co.solbipos.application.persistence.com.BkmkMapper;

@Service
public class BkmkServiceImpl implements BkmkService {

    @Autowired
    BkmkMapper bkmkMapper;

    @Override
    public int saveBkmk( BkmkVO bkmkVO, String userId ) {

        int result = 0;

        bkmkVO.setUserId( userId );
        bkmkVO.setRegDt( currentDateTimeString() );
        bkmkVO.setRegId( userId );
        // 삭제후 재등록
        if ( bkmkMapper.deleteBkmk( bkmkVO ) > -1 ) {
            if ( bkmkVO.getResrceCds() != null && bkmkVO.getResrceCds().length > 0 ) {
                result = bkmkMapper.insertBkmk( bkmkVO );
            }
        }
        return result;
    }

}
