package com.codesquad.sidedish10.getter.repository;

import com.codesquad.sidedish10.getter.domain.BabChanDetailReturnObject;
import com.codesquad.sidedish10.getter.dto.BabChanDetailDto;
import com.codesquad.sidedish10.parser.domain.BabChanDetailObject;
import java.util.List;
import org.springframework.data.jdbc.repository.query.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;

public interface BabChanDetailRepository extends CrudRepository<BabChanDetailObject, Long> {

  @Query("SELECT detail_hash FROM item WHERE id = :id")
  Long findDetailHashById(@Param("id") Long id);

  @Query("SELECT * FROM detail WHERE detail_hash = :detail_hash")
  BabChanDetailReturnObject getBabChanItemDetailByHash(@Param("detail_hash") String detail_hash);

  @Query("SELECT link FROM thumb_images WHERE detail_hash = :detail_hash")
  List<String> getBabChanThumbImages(@Param("detail_hash") String detail_hash);

  @Query("SELECT link FROM detail_section WHERE detail_hash = :detail_hash")
  List<String> getBabChanDetailSectionByHash(String detail_hash);

  @Query("SELECT np.n_price FROM n_price np WHERE np.detail_hash = :detail_hash")
  String get_n_price_by_detail_hash(@Param("detail_hash") String hash);

  @Query("SELECT sp.s_price FROM s_price sp WHERE sp.detail_hash = :detail_hash")
  String get_s_price_by_detail_hash(@Param("detail_hash") String hash);

  @Query("SELECT availability FROM detail WHERE detail_hash = :detail_hash")
  int getAvailabilityByDetailHash(String detail_hash);
}
