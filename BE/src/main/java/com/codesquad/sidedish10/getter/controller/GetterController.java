package com.codesquad.sidedish10.getter.controller;

import com.codesquad.sidedish10.getter.dto.BabChanDetailDto;
import com.codesquad.sidedish10.getter.dto.BabChanItemResponseDto;
import com.codesquad.sidedish10.getter.dto.BabChanOrderDto;
import com.codesquad.sidedish10.getter.dto.BabChanSectionInfoDto;
import com.codesquad.sidedish10.getter.service.GetterService;
import com.codesquad.sidedish10.getter.response.ApiResponse;
import com.codesquad.sidedish10.getter.response.ApiResponseForItem;
import com.codesquad.sidedish10.getter.utils.IndexCollection;
import java.util.List;
import java.util.stream.Collectors;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class GetterController {

  private final GetterService getterService;

  public GetterController(GetterService getterService) {
    this.getterService = getterService;
  }

  @GetMapping("/develop/baminchan/all")
  public ApiResponse getAllItems() {
    ApiResponse response = new ApiResponse();
    response.setStatusCode(HttpStatus.OK.value());
    response.setBody(getterService.getBabChanItemLists());
    return response;
  }

  @GetMapping("/develop/baminchan/main")
  //TODO: ApiResponse와 ApiResponseItem 통합하기
  public ApiResponseForItem getMainItems() {
    ApiResponseForItem response = new ApiResponseForItem();
    response.setStatusCode(HttpStatus.OK.value());
    List<BabChanItemResponseDto> mainItems = getterService.getBabChanItemLists().stream()
        .filter(element -> element.getMenu_id() == IndexCollection.MAIN_ITEMS_NUMBER)
        .collect(Collectors.toList());
    response.setBody(mainItems);
    response.setMenuId(IndexCollection.MAIN_ITEMS_NUMBER);
    return response;
  }

  @GetMapping("/develop/baminchan/soup")
  public ApiResponseForItem getSoupItems() {
    ApiResponseForItem response = new ApiResponseForItem();
    response.setStatusCode(HttpStatus.OK.value());
    List<BabChanItemResponseDto> mainItems = getterService.getBabChanItemLists().stream()
        .filter(element -> element.getMenu_id() == IndexCollection.SOUP_ITEMS_NUMBER)
        .collect(Collectors.toList());
    response.setBody(mainItems);
    response.setMenuId(IndexCollection.SOUP_ITEMS_NUMBER);
    return response;
  }

  @GetMapping("/develop/baminchan/side")
  public ApiResponseForItem getSideItems() {
    ApiResponseForItem response = new ApiResponseForItem();
    response.setStatusCode(HttpStatus.OK.value());
    List<BabChanItemResponseDto> mainItems = getterService.getBabChanItemLists().stream()
        .filter(element -> element.getMenu_id() == IndexCollection.SIDE_ITEMS_NUMBER)
        .collect(Collectors.toList());
    response.setBody(mainItems);
    response.setMenuId(IndexCollection.SIDE_ITEMS_NUMBER);
    return response;
  }

  @GetMapping("/develop/baminchan/menuinfo")
  public ApiResponse getMenuInfoList() {
    ApiResponse response = new ApiResponse();
    response.setStatusCode(HttpStatus.OK.value());
    List<BabChanSectionInfoDto> infoMenu = getterService.getBabChanMenuList();
    response.setBody(infoMenu);
    return response;
  }

  @GetMapping("/develop/baminchan/detail/{id}")
  public ApiResponse getSpecificItem(@PathVariable Long id) {
    ApiResponse response = new ApiResponse();
    response.setStatusCode(HttpStatus.OK.value());
    BabChanDetailDto babChanDetailDto = getterService.getSpecificBabChanItemDetail(id);
    response.setBody(babChanDetailDto);
    return response;
  }

  @GetMapping("/develop/baminchan/order/{id}")
  public ApiResponse orderSpecificItem(@PathVariable Long id) {
    ApiResponse response = new ApiResponse();
    response.setStatusCode(HttpStatus.OK.value());
    BabChanOrderDto dto = getterService.checkOrderAvailability(id);
    response.setBody(dto);

    return response;
  }
}
