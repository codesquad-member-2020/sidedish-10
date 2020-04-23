import React from "react";

import irene from "../../mockData/imgs/irene.jpg";

import "./DetailPage.css";

class DetailPage extends React.Component {
  constructor() {
    super();
  }

  render() {
    return (
      <div className="detail-page">
        <div className="upper-page">
          <div className="banchan-picture">
            <img src={irene}></img>
          </div>
          <div className="explanation">
            <div className="explanation-header underline">
              <div className="explanation-title">
                <span>[아이린]</span>
                <span>엑스표</span>
              </div>
              <div className="explanation-memo">칼칼해서 더 좋아요</div>
            </div>
            <div className="explanation-shipment">
              <div className="shipment-contents">
                <div className="shipment-type">
                  <li>적립금</li>
                  <li>배송 정보</li>
                  <li>배송비</li>
                </div>
                <div className="shipment-data">
                  <li>42원</li>
                  <li>
                    서울 경기(일부 지역) 택배배송 / 전국택배 (제주 및 도서산간
                    불가) [월 화 수 목 금 토] 수입 가능한 상품입니다.
                  </li>
                  <li>2500원(40,000원) 이상 구매 시 무료</li>
                </div>
              </div>
              <div className="explanation-price">4200원</div>
            </div>
            <div className="shipment-count">
              <div className="counts">수량</div>
              <div className="counts-input">
                <input type="number"></input>
              </div>
            </div>
            <div className="total-price">
              <div className="total-price-label">총 상품금액</div>
              <div className="total-price-data">4200원</div>
            </div>
            <div className="add-button">담기</div>
          </div>
        </div>
        <div className="lower-page"></div>
      </div>
    );
  }
}

export default DetailPage;
