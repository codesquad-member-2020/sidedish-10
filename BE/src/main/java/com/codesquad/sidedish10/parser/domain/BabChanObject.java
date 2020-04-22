package com.codesquad.sidedish10.parser.domain;

import java.util.ArrayList;
import java.util.List;

public class BabChanObject {
  private String image;
  private String alt;
  private List<String> delivery_types = new ArrayList<>();
  private String title;
  private String description;
  private int n_price;
  private int s_price;
  private List<String> badges = new ArrayList<>();

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

  public List<String> getDelivery_types() {
    return delivery_types;
  }

  public void setDelivery_types(List<String> delivery_types) {
    this.delivery_types = delivery_types;
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

  public List<String> getBadges() {
    return badges;
  }

  public void setBadges(List<String> badges) {
    this.badges = badges;
  }

  public int getN_price() {
    return n_price;
  }

  public void setN_price(int n_price) {
    this.n_price = n_price;
  }

  public int getS_price() {
    return s_price;
  }

  public void setS_price(int s_price) {
    this.s_price = s_price;
  }
}