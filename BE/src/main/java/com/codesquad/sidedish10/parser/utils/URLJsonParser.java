package com.codesquad.sidedish10.parser.utils;

import com.codesquad.sidedish10.parser.domain.BabChanObject;
import com.codesquad.sidedish10.parser.domain.ParserRepository;
import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.google.gson.reflect.TypeToken;
import java.lang.reflect.Type;
import java.text.NumberFormat;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;
import java.util.stream.Collectors;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestTemplate;

public class URLJsonParser {

  public List<BabChanObject> MainBanChanParser() throws ParseException {
    //basic object setting
    RestTemplate restTemplate = new RestTemplate();
    HttpHeaders httpHeaders = new HttpHeaders();
    JsonParser jsonParser = new JsonParser();
    httpHeaders.setContentType(MediaType.APPLICATION_JSON);

    //basic array setting
    List<BabChanObject> babChanObjectList = new ArrayList<>();

    //getting JSON data from API
    String URL = "https://h3rb9c0ugl.execute-api.ap-northeast-2.amazonaws.com/develop/baminchan/main";
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

      if (nowParsingArray.get("title") != null) {
        nowObject.setTitle(nowParsingArray.get("title").toString().replaceAll("\"", ""));
      }
      nowObject.setDescription(nowParsingArray.get("description").toString().replaceAll("\"", ""));
      if (nowParsingArray.get("n_price") != null) {
        String n_price = nowParsingArray.get("n_price").toString().replaceAll("\"", "");
        Long n_price_long = (Long) NumberFormat.getNumberInstance(java.util.Locale.US)
            .parse(n_price);
        nowObject.setN_price(Math.toIntExact(n_price_long));
      }

      String s_price = nowParsingArray.get("s_price").toString().replaceAll("\"", "");
      Long s_price_long = (Long) NumberFormat.getNumberInstance(java.util.Locale.US).parse(
          s_price.substring(0, s_price.length() - 1));
      nowObject.setS_price(Math.toIntExact(s_price_long));
      babChanObjectList.add(nowObject);
    }
    return babChanObjectList;
  }
}
