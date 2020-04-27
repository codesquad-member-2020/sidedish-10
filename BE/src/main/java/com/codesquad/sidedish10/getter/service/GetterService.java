package com.codesquad.sidedish10.getter.service;

import com.codesquad.sidedish10.getter.dto.BabChanItemResponseDto;
import com.codesquad.sidedish10.getter.repository.BabChanItemRepository;
import com.codesquad.sidedish10.getter.dto.BabChanSectionInfoDto;
import com.codesquad.sidedish10.getter.repository.BabChanSectionInfoRepository;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.springframework.stereotype.Service;

@Service
public class GetterService {

  private final BabChanItemRepository babChanItemRepository;
  private final BabChanSectionInfoRepository babChanSectionInfoRepository;

  public GetterService(
      BabChanItemRepository babChanItemRepository,
      BabChanSectionInfoRepository babChanSectionInfoRepository) {
    this.babChanItemRepository = babChanItemRepository;
    this.babChanSectionInfoRepository = babChanSectionInfoRepository;
  }

  public List<BabChanItemResponseDto> getBabChanItemLists() {

    List<BabChanItemResponseDto> babChanItemResponseDtoList = new ArrayList<>();
    babChanItemRepository.getItemBasicInfo().forEach(
        element -> babChanItemResponseDtoList.add(BabChanItemResponseDto
            .create(element.getId(), element.getDetail_hash(), element.getImage(), element.getAlt(),
                element.getTitle(), element.getDescription(), element.getMenu_id()))
    );

    babChanItemResponseDtoList
        .forEach(element -> {
          if (babChanItemRepository.get_n_price_by_detail_hash(element.getDetail_hash()) != null) {
            element.setN_price(
                babChanItemRepository.get_n_price_by_detail_hash(element.getDetail_hash()));
          }
          if (babChanItemRepository.get_s_price_by_detail_hash(element.getDetail_hash()) != null) {
            element.setS_price(
                babChanItemRepository.get_s_price_by_detail_hash(element.getDetail_hash()));
          }
          if (babChanItemRepository.get_badge_title_by_detail_hash(element.getDetail_hash()) != null) {
            List<Map<String, String>> nowList = new ArrayList<>();
            babChanItemRepository.get_badge_title_by_detail_hash(element.getDetail_hash())
                .forEach(title -> {
                  HashMap<String, String> badgeMap = new HashMap<>();
                  String thisColor = babChanItemRepository.get_badge_color_by_title(title);
                  badgeMap.put("name", title);
                  badgeMap.put("color", thisColor);
                  nowList.add(badgeMap);
                });
            element.setBadges(nowList);
          }
        });
    return babChanItemResponseDtoList;
  }

  public List<BabChanSectionInfoDto> getBabChanMenuList() {
    return babChanSectionInfoRepository.getInfoLists();
  }
}
