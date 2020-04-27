package com.codesquad.sidedish10.getter.dto;

import com.fasterxml.jackson.annotation.JsonAutoDetect;
import com.fasterxml.jackson.annotation.JsonAutoDetect.Visibility;

@JsonAutoDetect(fieldVisibility = Visibility.ANY)
public class BabChanSectionInfoDto {
  private Long menu_id;
  private String eng_name;
  private String title;
  private String info;

  public BabChanSectionInfoDto(Long menu_id, String eng_name, String title, String info) {
    this.menu_id = menu_id;
    this.eng_name = eng_name;
    this.title = title;
    this.info = info;
  }
}
