package com.codesquad.sidedish10.parser.service;

import com.codesquad.sidedish10.parser.domain.BabChanObject;
import com.codesquad.sidedish10.parser.domain.ParserRepository;
import com.codesquad.sidedish10.parser.utils.URLJsonParser;
import java.text.ParseException;
import java.util.List;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class ParseService {

  private final ParserRepository parserRepository;

  public ParseService(ParserRepository parserRepository) {
    this.parserRepository = parserRepository;
  }

  @Transactional
  public void insertItemAltTitleDescImage() throws ParseException {
    URLJsonParser urlJsonParser = new URLJsonParser();
    List<BabChanObject> babChanObjectList = urlJsonParser.MainBanChanParser();
    // TODO 스트림으로 아래 nullable 처리를 못하나 궁금
    String thisAlt = "";
    String thisTitle = "";
    String thisDescription = "";
    String thisImage = "";

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
      if (babChanObject.getBadges() != null) {
        babChanObject.getBadges().forEach(parserRepository::insert_badge_title);
      }
      if (babChanObject.getN_price() != 0) {
        parserRepository.insert_n_price(babChanObject.getN_price());
      }
      parserRepository.insertItemAltTitleDescImage(thisAlt, thisTitle, thisDescription, thisImage);
      parserRepository.insert_s_price(babChanObject.getS_price());
    }
  }
}
