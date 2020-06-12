package kr.co.solbipos.membr.info.grade.service.impl;

import kr.co.common.data.structure.DefaultMap;
import kr.co.solbipos.membr.info.grade.service.MembrClassVO;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;

@Mapper
@Repository
public interface MemberClassMapper {
    List<DefaultMap<String>> getMemberClassList(MembrClassVO membrClassVO);

    List<DefaultMap<String>> getMemberClassPoint(MembrClassVO membrClassVO);

    DefaultMap<String> getMemberClassDetail(MembrClassVO membrClassVO);

    int insertClassInfo(MembrClassVO membrClassVO);

    int classInfoChk(MembrClassVO membrClassVO);

    int updateClassInfo(MembrClassVO membrClassVO);

    int deleteClassInfo(MembrClassVO membrClassVO);
}
