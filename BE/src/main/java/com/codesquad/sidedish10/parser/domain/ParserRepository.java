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
  @Query("INSERT INTO item (detail_hash, alt, title, description, image, menu_id) VALUES (:detail_hash, :alt, :title, :description, :image, :menu_id)")
  void insertItemElements(@Param("detail_hash") String detail_hash,
      @Param("alt") String alt, @Param("title") String title,
      @Param("description") String description, @Param("image") String image,
      @Param("menu_id") int menu_id);

  @Modifying
  @Query("INSERT INTO s_price (s_price, detail_hash) VALUES (:s_price, :detail_hash)")
  void insert_s_price(@Param("s_price") String s_price, @Param("detail_hash") String detail_hash);

  @Modifying
  @Query("INSERT INTO n_price (n_price, detail_hash) VALUES (:n_price, :detail_hash)")
  void insert_n_price(@Param("n_price") String n_price, @Param("detail_hash") String detail_hash);

  @Modifying
  @Query("INSERT INTO badge (title, color, detail_hash) VALUES (:title, :color, :detail_hash)")
  void insert_badge_info(@Param("title") String title, @Param("color") String color,
      @Param("detail_hash") String detail_hash);

  @Modifying
  @Query("INSERT INTO delivery_type (title, detail_hash) VALUES (:title, :detail_hash)")
  void insert_delivery_type(@Param("title") String title, @Param("detail_hash") String detail_hash);

  @Modifying
  @Query("INSERT INTO detail (detail_hash, top_image, product_description, point, delivery_info, delivery_fee) VALUES (:detail_hash, :top_image, :product_description, :point, :delivery_info, :delivery_fee)")
  void insertDetailWithOutPrices(@Param("detail_hash") String detail_hash,
      @Param("top_image") String top_image,
      @Param("product_description") String product_description, @Param("point") String point,
      @Param("delivery_info") String delivery_info, @Param("delivery_fee") String delivery_fee);

  @Modifying
  @Query("INSERT INTO item (detail_hash) VALUES (:detail_hash)")
  void insertItemDetailHash(String detail_hash);

  @Modifying
  @Query("INSERT INTO detail (detail_hash) VALUES (:detail_hash)")
  void insertDetailDetailHash(String detail_hash);


  @Modifying
  @Query("INSERT INTO thumb_images (link, detail_hash) VALUES (:link, :detail_hash)")
  void insertThumbImages(@Param("link") String link, @Param("detail_hash") String detail_hash);

  @Modifying
  @Query("INSERT INTO detail_section (link, detail_hash) VALUES (:link, :detail_hash)")
  void insertDetailSection(@Param("link") String link, @Param("detail_hash") String detail_hash);
}
