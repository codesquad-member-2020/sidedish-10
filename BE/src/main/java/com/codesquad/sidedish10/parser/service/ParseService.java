package com.codesquad.sidedish10.parser.service;

import com.codesquad.sidedish10.parser.domain.BabChanDetailObject;
import com.codesquad.sidedish10.parser.domain.BabChanObject;
import com.codesquad.sidedish10.parser.domain.ParserRepository;
import com.codesquad.sidedish10.parser.utils.URLJsonParser;
import java.text.ParseException;
import java.util.Arrays;
import java.util.List;
import org.springframework.stereotype.Service;

@Service
public class ParseService {

  private final ParserRepository parserRepository;

  public ParseService(ParserRepository parserRepository) {
    this.parserRepository = parserRepository;
  }

  URLJsonParser urlJsonParser = new URLJsonParser();

  public void IterateBabChanURLsAndInsert() {
    String URL = "https://h3rb9c0ugl.execute-api.ap-northeast-2.amazonaws.com/develop/baminchan/";
    List<String> babChanList = Arrays.asList("main", "soup", "side");
    babChanList.forEach(
        element -> {
          try {
            insertBabChanItemsService(URL + element);
          } catch (ParseException e) {
            e.printStackTrace();
          }
        }
    );
  }

  public void insertBabChanItemsService(String URL) throws ParseException {
    List<BabChanObject> babChanObjectList = urlJsonParser.BanChanParser(URL);
    // TODO 스트림으로 아래 nullable 처리를 못하나 궁금
    String thisAlt = "";
    String thisTitle = "";
    String thisDescription = "";
    String thisImage = "";
    String n_price = "";
    String s_price = "";
    String detail_hash = "";

    for (BabChanObject babChanObject : babChanObjectList) {
      if (babChanObject.getAlt() != null) {
        thisAlt = babChanObject.getAlt();
      }
      if (babChanObject.getTitle() != null) {
        thisTitle = babChanObject.getTitle();
      }
      if (babChanObject.getDescription() != null) {
        thisDescription = babChanObject.getDescription();
      }
      if (babChanObject.getImage() != null) {
        thisImage = babChanObject.getImage();
      }
      if (babChanObject.getDetail_hash() != null) {
        detail_hash = babChanObject.getDetail_hash();
      }
      if (babChanObject.getBadges() != null) {
        String finalDetail_hash = detail_hash;
        babChanObject.getBadges().forEach(element -> parserRepository.insert_badge_title(element,
            finalDetail_hash));
      }
      if (babChanObject.getN_price() != null) {
        n_price = babChanObject.getN_price();
        parserRepository.insert_n_price(n_price, detail_hash);
      }
      if (babChanObject.getS_price() != null) {
        s_price = babChanObject.getS_price();
        parserRepository.insert_s_price(s_price, detail_hash);
      }
      parserRepository.insertItemAltTitleDescImage(detail_hash, thisAlt, thisTitle, thisDescription, thisImage);
      parserRepository.insert_s_price(babChanObject.getS_price(), detail_hash);
    }
  }

  public void insertBabChanDetailService() {
    List<BabChanDetailObject> babChanDetailObjectList = urlJsonParser.DetailParser();
    String top_image = "";
    String delivery_fee = "";
    String delivery_info = "";
    String point = "";
    String product_description = "";
    String detail_hash = "";

    for (BabChanDetailObject detailObject : babChanDetailObjectList) {
      if (detailObject.getTop_image() != null) {
        top_image = detailObject.getTop_image();
      }
      if (detailObject.getDelivery_fee() != null) {
        delivery_fee = detailObject.getDelivery_fee();
      }
      if (detailObject.getDelivery_info() != null) {
        delivery_info = detailObject.getDelivery_info();
      }
      if (detailObject.getPoint() != null) {
        point = detailObject.getPoint();
      }
      if (detailObject.getProduct_description() != null) {
        product_description = detailObject.getProduct_description();
      }
      if (detailObject.getDetail_hash() != null) {
        detail_hash = detailObject.getDetail_hash();
      }
      parserRepository
          .insertDetailWithOutPrices(detail_hash, top_image, product_description, point, delivery_info,
              delivery_fee);
    }
  }
}
