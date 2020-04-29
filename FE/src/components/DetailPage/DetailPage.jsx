import React from "react";
import MiniCarousel from "./MiniCarousel/MiniCarousel";
import { openModal, closeModal } from "../../actions/modalAction";
import { connect } from "react-redux";

import "./DetailPage.css";

class DetailPage extends React.Component {
  constructor() {
    super();
    this.state = {
      counts: 0,
      totalSum: 0,
    };
    this.buttonClickHandler = this.buttonClickHandler.bind(this);
    this.inputChangeHandler = this.inputChangeHandler.bind(this);
    this.addCommaToPrice = this.addCommaToPrice.bind(this);
  }

  componentDidMount() {
    const { s_price } = this.props.targetProfile;
    const priceValue = parseInt(s_price.split("원")[0].replace(",", ""));
    this.setState({ ...this.state, priceValue });
  }

  buttonClickHandler() {
    this.props.closeModal();
  }

  inputChangeHandler(e) {
    let { value } = e.target;
    if (value < 0) {
      value = 0;
    }

    const totalSum = value * this.state.priceValue;
    this.setState({ ...this.state, counts: value, totalSum });
  }

  getProperRemainder(price) {
    const remainder = price % 1000;
    if (remainder >= 100) {
      return `${remainder}`;
    }
    if (remainder >= 10) {
      return `0${remainder}`;
    }
    return `00${remainder}`;
  }

  addCommaToPrice(price) {
    const quotient = Math.floor(price / 1000);
    const remainder = this.getProperRemainder(price);
    if (quotient < 1) {
      return "0";
    }
    return `${quotient},${remainder}`;
  }

  render() {
    const { image, title, s_price } = this.props.targetProfile;
    return (
      <div className="detail-page">
        <div className="upper-page">
          <div
            className="banchan-picture"
            style={{ backgroundImage: `url(${image})` }}
          ></div>
          <div className="explanation">
            <div className="explanation-header underline">
              <div className="explanation-title">
                <span>{title}</span>
                <span className="close-button" onClick={this.props.closeModal}>
                  X
                </span>
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
                  <li>{Math.floor(this.state.priceValue / 100)}원</li>
                  <li>
                    서울 경기(일부 지역) 택배배송 / 전국택배 (제주 및 도서산간
                    불가) [월 화 수 목 금 토] 수입 가능한 상품입니다.
                  </li>
                  <li>2500원(40,000원) 이상 구매 시 무료</li>
                </div>
              </div>
              <div className="explanation-price">{s_price}</div>
            </div>
            <div className="shipment-count">
              <div className="counts">수량</div>
              <div className="counts-input">
                <input
                  type="number"
                  value={this.state.counts}
                  onChange={this.inputChangeHandler}
                />
              </div>
            </div>
            <div className="total-price">
              <div className="total-price-label">총 상품금액</div>
              <div className="total-price-data">
                {this.addCommaToPrice(this.state.totalSum)}원
              </div>
            </div>
            <button className="add-button" onClick={this.buttonClickHandler}>
              담기
            </button>
          </div>
        </div>
        <div className="lower-page">
          <div className="lower-title">밥 같이 먹으면 좋은 아이돌</div>
          <MiniCarousel />
        </div>
      </div>
    );
  }
}

const mapStateToProps = (state, props) => {
  return {
    targetProfile: state.modal.targetProfile,
    on: state.modal.on,
  };
};

const mapDispatchToProps = (dispatch) => {
  return {
    openModal: () => dispatch(openModal()),
    closeModal: () => dispatch(closeModal()),
  };
};

export default connect(mapStateToProps, mapDispatchToProps)(DetailPage);
