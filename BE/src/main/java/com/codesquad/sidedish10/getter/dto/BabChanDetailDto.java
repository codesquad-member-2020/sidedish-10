package com.codesquad.sidedish10.getter.dto;

import com.fasterxml.jackson.annotation.JsonIgnore;
import java.util.List;

public class BabChanDetailDto {

  private Long id;

  @JsonIgnore
  private String detail_hash;
  private String top_image;
  private String product_description;
  private String point;
  private String delivery_info;
  private String delivery_fee;

  private String s_price;
  private String n_price;
  private List<String> detail_section;
  private List<String> thumb_images;

  private BabChanDetailDto(Long id, String detail_hash, String top_image,
      String product_description, String point, String delivery_info, String delivery_fee) {
    this.id = id;
    this.detail_hash = detail_hash;
    this.top_image = top_image;
    this.product_description = product_description;
    this.point = point;
    this.delivery_info = delivery_info;
    this.delivery_fee = delivery_fee;
  }

  public Long getId() {
    return id;
  }

  public void setId(Long id) {
    this.id = id;
  }

  public String getDetail_hash() {
    return detail_hash;
  }

  public void setDetail_hash(String detail_hash) {
    this.detail_hash = detail_hash;
  }

  public String getTop_image() {
    return top_image;
  }

  public void setTop_image(String top_image) {
    this.top_image = top_image;
  }

  public String getProduct_description() {
    return product_description;
  }

  public void setProduct_description(String product_description) {
    this.product_description = product_description;
  }

  public String getPoint() {
    return point;
  }

  public void setPoint(String point) {
    this.point = point;
  }

  public String getDelivery_info() {
    return delivery_info;
  }

  public void setDelivery_info(String delivery_info) {
    this.delivery_info = delivery_info;
  }

  public String getDelivery_fee() {
    return delivery_fee;
  }

  public void setDelivery_fee(String delivery_fee) {
    this.delivery_fee = delivery_fee;
  }

  public List<String> getDetail_section() {
    return detail_section;
  }

  public void setDetail_section(List<String> detail_section) {
    this.detail_section = detail_section;
  }

  public List<String> getThumb_images() {
    return thumb_images;
  }

  public void setThumb_images(List<String> thumb_images) {
    this.thumb_images = thumb_images;
  }

  public String getS_price() {
    return s_price;
  }

  public void setS_price(String s_price) {
    this.s_price = s_price;
  }

  public String getN_price() {
    return n_price;
  }

  public void setN_price(String n_price) {
    this.n_price = n_price;
  }

  public static BabChanDetailDto create(Long id, String detail_hash, String top_image,
      String product_description, String point, String delivery_info, String delivery_fee) {

    return new BabChanDetailDto(id, detail_hash, top_image, product_description, point,
        delivery_info, delivery_fee);
  }
}
