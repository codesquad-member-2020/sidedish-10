package com.codesquad.sidedish10.getter.domain;

import com.fasterxml.jackson.annotation.JsonIgnore;
import java.util.List;

public class BabChanItemResponseDto {

  @JsonIgnore
  private String detail_hash;
  private String image;
  private String alt;
  private String title;
  private String description;
  private String n_price;
  private String s_price;
  private int id;
  private int menu_id;
  private List<String> badges;

  private BabChanItemResponseDto(String detail_hash, String image, String alt, String title,
      String description, int id, int menu_id) {
    this.detail_hash = detail_hash;
    this.image = image;
    this.alt = alt;
    this.title = title;
    this.description = description;
    this.id = id;
    this.menu_id = menu_id;
  }

  public static BabChanItemResponseDto create(int id, String detail_hash, String image, String alt,
      String title, String description, int menu_id) {
    return new BabChanItemResponseDto(detail_hash, image, alt, title, description, id, menu_id);
  }

  public String getN_price() {
    return n_price;
  }

  public void setN_price(String n_price) {
    this.n_price = n_price;
  }

  public String getS_price() {
    return s_price;
  }

  public void setS_price(String s_price) {
    this.s_price = s_price;
  }

  public String getDetail_hash() {
    return detail_hash;
  }

  public void setDetail_hash(String detail_hash) {
    this.detail_hash = detail_hash;
  }

  public String getImage() {
    return image;
  }

  public void setImage(String image) {
    this.image = image;
  }

  public String getAlt() {
    return alt;
  }

  public void setAlt(String alt) {
    this.alt = alt;
  }

  public String getTitle() {
    return title;
  }

  public void setTitle(String title) {
    this.title = title;
  }

  public String getDescription() {
    return description;
  }

  public void setDescription(String description) {
    this.description = description;
  }

  public int getId() {
    return id;
  }

  public void setId(int id) {
    this.id = id;
  }

  public int getMenu_id() {
    return menu_id;
  }

  public void setMenu_id(int menu_id) {
    this.menu_id = menu_id;
  }

  public List<String> getBadges() {
    return badges;
  }

  public void setBadges(List<String> badges) {
    this.badges = badges;
  }
}