package com.codesquad.sidedish10.getter.domain;

import java.util.List;

public class BabChanDetailDto {
  private int id;
  private String detail_hash;
  private String top_image;
  private String product_description;
  private String point;
  private String delivery_info;
  private String delivery_fee;
  private List<Integer> prices;

  public int getId() {
    return id;
  }

  public void setId(int id) {
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

  public List<Integer> getPrices() {
    return prices;
  }

  public void setPrices(List<Integer> prices) {
    this.prices = prices;
  }
}
