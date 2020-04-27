package com.codesquad.sidedish10.getter.service;

import com.codesquad.sidedish10.getter.dto.BabChanItemResponseDto;
import com.codesquad.sidedish10.getter.dto.BabChanItemRepository;
import java.util.ArrayList;
import java.util.List;
import org.springframework.stereotype.Service;

@Service
public class GetterService {

  private final BabChanItemRepository babChanItemRepository;

  public GetterService(
      BabChanItemRepository babChanItemRepository) {
    this.babChanItemRepository = babChanItemRepository;
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
          if (babChanItemRepository.get_badge_by_detail_hash(element.getDetail_hash()) != null) {
            element.setBadges(
                babChanItemRepository.get_badge_by_detail_hash(element.getDetail_hash()));
          }
        });
    return babChanItemResponseDtoList;
  }
}
