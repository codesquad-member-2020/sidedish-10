package com.codesquad.sidedish10.getter.repository;

import com.codesquad.sidedish10.getter.dto.BabChanSectionInfoDto;
import java.util.List;
import org.springframework.data.jdbc.repository.query.Query;
import org.springframework.data.repository.CrudRepository;

public interface BabChanSectionInfoRepository extends CrudRepository<BabChanSectionInfoDto, Long> {
  @Query("SELECT m.menu_id, m.title, m.eng_name, m.info FROM menu m")
  List<BabChanSectionInfoDto> getInfoLists();
}