package com.codesquad.sidedish10.getter.service;

import com.codesquad.sidedish10.getter.domain.BabChanDetailReturnObject;
import com.codesquad.sidedish10.getter.dto.BabChanDetailDto;
import com.codesquad.sidedish10.getter.dto.BabChanItemResponseDto;
import com.codesquad.sidedish10.getter.dto.BabChanOrderDto;
import com.codesquad.sidedish10.getter.repository.BabChanDetailRepository;
import com.codesquad.sidedish10.getter.repository.BabChanItemRepository;
import com.codesquad.sidedish10.getter.dto.BabChanSectionInfoDto;
import com.codesquad.sidedish10.getter.repository.BabChanSectionInfoRepository;
import com.codesquad.sidedish10.parser.domain.BabChanDetailObject;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.springframework.stereotype.Service;

@Service
public class GetterService {

  private final BabChanItemRepository babChanItemRepository;
  private final BabChanSectionInfoRepository babChanSectionInfoRepository;
  private final BabChanDetailRepository babChanDetailRepository;

  public GetterService(
      BabChanItemRepository babChanItemRepository,
      BabChanSectionInfoRepository babChanSectionInfoRepository,
      BabChanDetailRepository babChanDetailRepository) {
    this.babChanItemRepository = babChanItemRepository;
    this.babChanSectionInfoRepository = babChanSectionInfoRepository;
    this.babChanDetailRepository = babChanDetailRepository;
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
          if (babChanItemRepository.get_badge_title_by_detail_hash(element.getDetail_hash())
              != null) {
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

  public BabChanDetailDto getSpecificBabChanItemDetail(Long id) {

    String nowDetailHash = babChanItemRepository.get_detail_hash_by_item_id(id);

    BabChanDetailReturnObject babChanDetailObject = babChanDetailRepository
        .getBabChanItemDetailByHash(nowDetailHash);

    BabChanDetailDto dto = BabChanDetailDto.create(babChanDetailObject.getId(), babChanDetailObject.getDetail_hash(),
        babChanDetailObject.getTop_image(), babChanDetailObject.getProduct_description(),
        babChanDetailObject.getPoint(), babChanDetailObject.getDelivery_info(),
        babChanDetailObject.getDelivery_fee());

    //TODO 진짜 최악의 코드인데 어떻게 해야 리팩토링할 수 있을 지 고민해본다.
    if (babChanDetailRepository.get_n_price_by_detail_hash(dto.getDetail_hash()) != null) {
      dto.setN_price(
          babChanDetailRepository.get_n_price_by_detail_hash(dto.getDetail_hash()));
    }
    if (babChanDetailRepository.get_s_price_by_detail_hash(dto.getDetail_hash()) != null) {
      dto.setS_price(
          babChanDetailRepository.get_s_price_by_detail_hash(dto.getDetail_hash()));
    }
    if (babChanDetailRepository.getBabChanThumbImages(dto.getDetail_hash()) != null) {
      dto.setThumb_images(
          babChanDetailRepository.getBabChanThumbImages(dto.getDetail_hash()));
    }
    if (babChanDetailRepository.getBabChanDetailSectionByHash(dto.getDetail_hash()) != null) {
      dto.setDetail_section(
          babChanDetailRepository.getBabChanDetailSectionByHash(dto.getDetail_hash()));
    }

    return dto;
  }

  public BabChanOrderDto checkOrderAvailability(Long id) {
    String nowHash = babChanItemRepository.get_detail_hash_by_item_id(id);
    BabChanDetailReturnObject object = babChanDetailRepository.getBabChanItemDetailByHash(nowHash);
    int stock = babChanDetailRepository.getAvailabilityByDetailHash(nowHash);
    BabChanOrderDto dto = new BabChanOrderDto();
    dto.setId(object.getId());
    dto.setStock(stock);

    return dto;
  }
}
