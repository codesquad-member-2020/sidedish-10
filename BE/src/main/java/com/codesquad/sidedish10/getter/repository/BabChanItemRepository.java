package com.codesquad.sidedish10.getter.repository;

import com.codesquad.sidedish10.getter.dto.BabChanItemRequestDto;
import com.codesquad.sidedish10.getter.dto.BabChanItemResponseDto;
import com.codesquad.sidedish10.parser.domain.BabChanDetailObject;
import java.util.List;
import java.util.Map;
import org.springframework.data.jdbc.repository.query.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;

public interface BabChanItemRepository extends CrudRepository<BabChanItemResponseDto, Long> {

  //TODO 아래의 쿼리 세 개를 하나의 조인으로 합칠 수 있는 방법 고민해보기
//  @Modifying
//  @Query("SELECT i.id, i.alt, i.title, i.description, i.image, i.menu_id, sp.s_price, np.n_price, b.badge "
//      + "FROM item i, s_price sp, n_price np, badge b "
//      + "WHERE i.detail_hash = sp.detail_hash"
//      + "AND i.detail_hash = np.detail_hash"
//      + "AND i.detail_hash = b.detail_hash")
//  void BabChanBasicItemInfoJoin();

  @Query("SELECT * FROM item")
  List<BabChanItemRequestDto> getItemBasicInfo();

  @Query("SELECT detail_hash FROM item WHERE id = :id")
  String get_detail_hash_by_item_id(@Param("id") Long id);

  @Query("SELECT np.n_price FROM n_price np WHERE np.detail_hash = :detail_hash")
  String get_n_price_by_detail_hash(@Param("detail_hash") String hash);

  @Query("SELECT sp.s_price FROM s_price sp WHERE sp.detail_hash = :detail_hash")
  String get_s_price_by_detail_hash(@Param("detail_hash") String hash);

  @Query("SELECT bd.title FROM badge bd WHERE bd.detail_hash = :detail_hash")
  List<String> get_badge_title_by_detail_hash(@Param("detail_hash") String hash);

  @Query("SELECT * FROM (SELECT color FROM badge WHERE title = :title) COLOR LIMIT 1")
  String get_badge_color_by_title(@Param("title") String title);
}
