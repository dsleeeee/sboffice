package kr.co.solbipos.iostock.order.dstbCloseStore.service.impl;

import kr.co.common.data.structure.DefaultMap;
import kr.co.solbipos.iostock.order.dstbCloseStore.service.DstbCloseStoreVO;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;

@Mapper
@Repository
public interface DstbCloseStoreMapper {

    /** 분배마감 리스트 조회 */
    List<DefaultMap<String>> getDstbCloseStoreList(DstbCloseStoreVO dstbCloseStoreVO);

    /** 분배마감 리스트 확정 */
    int updateDstbCloseConfirm(DstbCloseStoreVO dstbCloseStoreVO);

    /** 분배마감 상세 리스트 조회 */
    List<DefaultMap<String>> getDstbCloseStoreDtlList(DstbCloseStoreVO dstbCloseStoreVO);

    /** 분배마감 상세 리스트 수정 */
    int updateDstbCloseDtl(DstbCloseStoreVO dstbCloseStoreVO);

    /** 분배마감 상세 리스트 확정 */
    int updateDstbCloseDtlConfirm(DstbCloseStoreVO dstbCloseStoreVO);

    /** 분배마감 상세 리스트 삭제 */
    int deleteDstbCloseDtl(DstbCloseStoreVO dstbCloseStoreVO);

    /** 분배마감 - 추가분배시 주문가능여부 조회 */
    DefaultMap<String> getOrderFg(DstbCloseStoreVO dstbCloseStoreVO);

    /** 분배마감 - 추가분배 상세 리스트 조회 */
    List<DefaultMap<String>> getDstbAddList(DstbCloseStoreVO dstbCloseStoreVO);

    /** 분배마감 - 추가분배 등록 */
    int insertDstbAdd(DstbCloseStoreVO dstbCloseStoreVO);

    /** 분배마감 - 추가분배 수정 */
    int updateDstbAdd(DstbCloseStoreVO dstbCloseStoreVO);

    /** 분배마감 - 추가분배 삭제 */
    int deleteDstbAdd(DstbCloseStoreVO dstbCloseStoreVO);

}
