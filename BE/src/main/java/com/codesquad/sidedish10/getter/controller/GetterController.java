package com.codesquad.sidedish10.getter.controller;

import com.codesquad.sidedish10.getter.domain.BabChanItemResponseDto;
import com.codesquad.sidedish10.getter.service.GetterService;
import com.codesquad.sidedish10.getter.utils.ApiResponse;
import com.codesquad.sidedish10.getter.utils.IndexCollection;
import java.util.List;
import java.util.stream.Collectors;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.GetMapping;
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
  public ApiResponse getMainItems() {
    ApiResponse response = new ApiResponse();
    response.setStatusCode(HttpStatus.OK.value());
    List<BabChanItemResponseDto> mainItems = getterService.getBabChanItemLists().stream()
        .filter(element -> element.getMenu_id() == IndexCollection.MAIN_ITEMS_NUMBER)
        .collect(Collectors.toList());
    response.setBody(mainItems);
    return response;
  }

  @GetMapping("/develop/baminchan/soup")
  public ApiResponse getSoupItems() {
    ApiResponse response = new ApiResponse();
    response.setStatusCode(HttpStatus.OK.value());
    List<BabChanItemResponseDto> mainItems = getterService.getBabChanItemLists().stream()
        .filter(element -> element.getMenu_id() == IndexCollection.SOUP_ITEMS_NUMBER)
        .collect(Collectors.toList());
    response.setBody(mainItems);
    return response;
  }

  @GetMapping("/develop/baminchan/side")
  public ApiResponse getSideItems() {
    ApiResponse response = new ApiResponse();
    response.setStatusCode(HttpStatus.OK.value());
    List<BabChanItemResponseDto> mainItems = getterService.getBabChanItemLists().stream()
        .filter(element -> element.getMenu_id() == IndexCollection.SIDE_ITEMS_NUMBER)
        .collect(Collectors.toList());
    response.setBody(mainItems);
    return response;
  }
}
