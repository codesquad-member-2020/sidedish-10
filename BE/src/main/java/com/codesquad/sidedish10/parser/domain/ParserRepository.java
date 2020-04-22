package com.codesquad.sidedish10.parser.domain;

import com.codesquad.sidedish10.parser.domain.BabChanObject;
import org.springframework.data.jdbc.repository.query.Modifying;
import org.springframework.data.jdbc.repository.query.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface ParserRepository extends CrudRepository<BabChanObject, Long> {

  @Modifying
  @Query("INSERT INTO item (alt, title, description, image) VALUES (:alt, :title, :description, :image)")
  void insertItemAltTitleDescImage(@Param("alt") String alt, @Param("title") String title,
      @Param("description") String description, @Param("image") String image);

  @Modifying
  @Query("INSERT INTO s_price (s_price) VALUES (:s_price)")
  void insert_s_price(@Param("s_price") int s_price);

  @Modifying
  @Query("INSERT INTO n_price (n_price) VALUES (:n_price)")
  void insert_n_price(@Param("n_price") int n_price);

  @Modifying
  @Query("INSERT INTO badge (title) VALUES (:title)")
  void insert_badge_title(@Param("title") String title);

  @Modifying
  @Query("INSERT INTO delivery_type (title) VALUES (:title)")
  void insert_delivery_type(@Param("title") String title);
}
