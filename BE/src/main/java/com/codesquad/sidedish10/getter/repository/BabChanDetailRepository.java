package com.codesquad.sidedish10.getter.repository;

import com.codesquad.sidedish10.getter.domain.BabChanDetailReturnObject;
import com.codesquad.sidedish10.getter.dto.BabChanDetailDto;
import com.codesquad.sidedish10.parser.domain.BabChanDetailObject;
import java.util.List;
import org.springframework.data.jdbc.repository.query.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;

public interface BabChanDetailRepository extends CrudRepository<BabChanDetailObject, Long> {

  @Query("SELECT * FROM detail WHERE id = :id")
  BabChanDetailReturnObject getBabChanItemDetailByHash(@Param("id") Long id);

  @Query("SELECT link FROM thumb_images WHERE detail_hash = :detail_hash")
  List<String> getBabChanThumbImages(@Param("detail_hash") String detail_hash);

  @Query("SELECT link FROM detail_section WHERE detail_hash = :detail_hash")
  List<String> getBabChanDetailSectionByHash(String detail_hash);
}
