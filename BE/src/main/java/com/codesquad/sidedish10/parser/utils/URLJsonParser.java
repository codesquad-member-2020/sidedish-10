package com.codesquad.sidedish10.parser.utils;

import com.codesquad.sidedish10.parser.domain.BabChanDetailObject;
import com.codesquad.sidedish10.parser.domain.BabChanObject;
import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.google.gson.reflect.TypeToken;
import java.lang.reflect.Type;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;
import java.util.stream.Collectors;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.client.RestTemplate;

public class URLJsonParser {

  public List<BabChanObject> BanChanParser(String URL) throws ParseException {
    //basic object setting
    RestTemplate restTemplate = new RestTemplate();
    HttpHeaders httpHeaders = new HttpHeaders();
    JsonParser jsonParser = new JsonParser();
    httpHeaders.setContentType(MediaType.APPLICATION_JSON);

    //basic array setting
    List<BabChanObject> babChanObjectList = new ArrayList<>();

    //getting JSON data from API
    ResponseEntity responseEntity = restTemplate
        .exchange(URL, HttpMethod.GET, new HttpEntity<String>(httpHeaders), String.class);
    JsonObject jsonObject = (JsonObject) jsonParser.parse(
        Objects.requireNonNull(responseEntity.getBody()).toString());

    //basic parsing
    JsonArray jsonArray = (JsonArray) jsonObject.get("body");
    for (int i = 0; i < jsonArray.size(); i++) {
      BabChanObject nowObject = new BabChanObject();
      JsonObject nowParsingArray = (JsonObject) jsonArray.get(i);
      nowObject.setImage(nowParsingArray.get("image").toString().replaceAll("\"", ""));
      nowObject.setAlt(nowParsingArray.get("alt").toString().replaceAll("\"", ""));

      JsonElement deliveryTypesElement = nowParsingArray.get("delivery_type");
      Type listType = new TypeToken<List<String>>() {
      }.getType();
      List<String> deliveryTypesList = new Gson().fromJson(deliveryTypesElement, listType);
      if (deliveryTypesList != null) {
        nowObject.setDelivery_types(deliveryTypesList.stream()
            .filter(Objects::nonNull)
            .map(element -> element.replaceAll("\"", ""))
            .collect(Collectors.toList()));
      }

      JsonElement badgeElement = nowParsingArray.get("badge");
      List<String> badgeTypeList = new Gson().fromJson(badgeElement, listType);
      if (badgeTypeList != null) {
        nowObject.setBadges(badgeTypeList.stream()
            .filter(Objects::nonNull)
            .collect(Collectors.toList()));
      }

      if (nowParsingArray.get("detail_hash") != null) {
        String detail_hash = nowParsingArray.get("detail_hash").toString().replaceAll("\"", "");
        nowObject.setDetail_hash(detail_hash);
      }

      if (nowParsingArray.get("title") != null) {
        nowObject.setTitle(nowParsingArray.get("title").toString().replaceAll("\"", ""));
      }
      nowObject.setDescription(nowParsingArray.get("description").toString().replaceAll("\"", ""));

      if (nowParsingArray.get("n_price") != null) {
        String n_price = nowParsingArray.get("n_price").toString().replaceAll("\"", "");
//        Long n_price_long = (Long) NumberFormat.getNumberInstance(java.util.Locale.US)
//            .parse(n_price);
//        nowObject.setN_price(Math.toIntExact(n_price_long));
        nowObject.setN_price(n_price);
      }

      String s_price = nowParsingArray.get("s_price").toString().replaceAll("\"", "");
//      Long s_price_long = (Long) NumberFormat.getNumberInstance(java.util.Locale.US).parse(
//          s_price.substring(0, s_price.length() - 1));
//      nowObject.setS_price(Math.toIntExact(s_price_long));
      nowObject.setS_price(s_price);
      babChanObjectList.add(nowObject);
    }
    return babChanObjectList;
  }

  public List<BabChanDetailObject> DetailParser() {
    //basic object setting
    RestTemplate restTemplate = new RestTemplate();
    HttpHeaders httpHeaders = new HttpHeaders();
    JsonParser jsonParser = new JsonParser();
    httpHeaders.setContentType(MediaType.APPLICATION_JSON);
    String URL = "https://h3rb9c0ugl.execute-api.ap-northeast-2.amazonaws.com/develop/baminchan/detail";

    List<BabChanDetailObject> babChanDetailObjectList = new ArrayList<>();

    //getting JSON data from API
    ResponseEntity responseEntity = restTemplate
        .exchange(URL, HttpMethod.GET, new HttpEntity<String>(httpHeaders), String.class);
    JsonObject jsonObject = (JsonObject) jsonParser.parse(
        Objects.requireNonNull(responseEntity.getBody()).toString());

    //basic parsing
    JsonArray jsonArray = (JsonArray) jsonObject.get("body");
    for (int i = 0; i < jsonArray.size(); i++) {
      BabChanDetailObject nowDetail = new BabChanDetailObject();
      JsonObject beforeParsingArray = (JsonObject) jsonArray.get(i);
      nowDetail.setDetail_hash(beforeParsingArray.get("hash").toString().replaceAll("\"", ""));

      JsonObject nowParsingArray = (JsonObject) beforeParsingArray.get("data");
      nowDetail.setTop_image(nowParsingArray.get("top_image").toString().replaceAll("\"", ""));
      nowDetail.setProduct_description(
          nowParsingArray.get("product_description").toString().replaceAll("\"", ""));
      nowDetail
          .setDelivery_info(nowParsingArray.get("delivery_info").toString().replaceAll("\"", ""));
      nowDetail
          .setDelivery_fee(nowParsingArray.get("delivery_fee").toString().replaceAll("\"", ""));
      nowDetail.setPoint(nowParsingArray.get("point").toString().replaceAll("\"", ""));

      JsonElement detail_section_element = nowParsingArray.get("detail_section");
      Type listType = new TypeToken<List<String>>() {
      }.getType();
      List<String> detail_section_types_list = new Gson()
          .fromJson(detail_section_element, listType);
      if (detail_section_types_list != null) {
        nowDetail.setDetail_section(detail_section_types_list.stream()
            .filter(Objects::nonNull)
            .map(element -> element.replaceAll("\"", ""))
            .collect(Collectors.toList()));
      }

      JsonElement thumb_images_element = nowParsingArray.get("thumb_images");
      List<String> thumb_images_element_list = new Gson()
          .fromJson(thumb_images_element, listType);
      if (thumb_images_element_list != null) {
        nowDetail.setThumb_images(thumb_images_element_list.stream()
            .filter(Objects::nonNull)
            .map(element -> element.replaceAll("\"", ""))
            .collect(Collectors.toList()));
      }
      babChanDetailObjectList.add(nowDetail);
    }
    return babChanDetailObjectList;
  }
}
