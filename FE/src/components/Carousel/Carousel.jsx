import React from "react";
import Panel from "./Panel/Panel";
import {
  openModal,
  closeModal,
  setTargetProfile,
} from "../../actions/modalAction";
import { connect } from "react-redux";

import "./Carousel.css";

class Carousel extends React.Component {
  constructor() {
    super();
    this.state = {
      profiles: [
        {
          image:
            "http://public.codesquad.kr/jk/storeapp/data/2d3f99a9a35601f4e98837bc4d39b2c8.jpg",
          alt: "[미노리키친] 규동 250g",
          title: "[미노리키친] 규동 250g",
          description: "일본인의 소울푸드! 한국인도 좋아하는 소고기덮밥",
          n_price: "6,500원",
          s_price: "7,000원",
          id: 1,
          menu_id: 1,
          badges: ["이벤트특가"],
        },
        {
          image:
            "http://public.codesquad.kr/jk/storeapp/data/7674311a02ba7c88675f3186ddaeef9e.jpg",
          alt: "[빅마마의밥친구] 아삭 고소한 연근고기조림 250g",
          title: "[빅마마의밥친구] 아삭 고소한 연근고기조림 250g",
          description: "편식하는 아이도 좋아하는 건강한 연근조림",
          n_price: null,
          s_price: "5,500원",
          id: 2,
          menu_id: 1,
          badges: [],
        },
        {
          image:
            "http://public.codesquad.kr/jk/storeapp/data/cad8eee316cf7151e07638aa57b32a9d.jpg",
          alt: "[소중한식사] 골뱅이무침 195g",
          title: "[소중한식사] 골뱅이무침 195g",
          description: "매콤새콤달콤, 반찬으로도 안주로도 좋은",
          n_price: "7,000원",
          s_price: "6,300원",
          id: 3,
          menu_id: 1,
          badges: ["이벤트특가"],
        },
        {
          image:
            "http://public.codesquad.kr/jk/storeapp/data/b6beada6b89af950289003d929936d9c.jpg",
          alt: "[옹가솜씨] 꽁치간장조림 240g",
          title: "[옹가솜씨] 꽁치간장조림 240g",
          description: "생강 향이 산뜻한",
          n_price: null,
          s_price: "5,800원",
          id: 4,
          menu_id: 1,
          badges: [],
        },
        {
          image:
            "http://public.codesquad.kr/jk/storeapp/data/0221110ead70dfd455e40703bbdd6252.jpg",
          alt: "[마더앤찬] 코다리구이 320g",
          title: "[마더앤찬] 코다리구이 320g",
          description:
            "큼지막하고 살집 많은 동태 한 마리로 만든 코다리구이입니다.",
          n_price: "7,500원",
          s_price: "6,750원",
          id: 5,
          menu_id: 1,
          badges: ["론칭특가"],
        },
        {
          image:
            "http://public.codesquad.kr/jk/storeapp/data/385f4106ac26f6e4fe7c640714f405a5.jpg",
          alt: "[남도애꽃] 반건조 문어조림 120g",
          title: "[남도애꽃] 반건조 문어조림 120g",
          description: "씹을수록 감칠맛나는 문어살의 쫄깃함",
          n_price: null,
          s_price: "4,600원",
          id: 6,
          menu_id: 1,
          badges: [],
        },
        {
          image:
            "http://public.codesquad.kr/jk/storeapp/data/2455226945d52f5aefd51f35d663bb16.jpg",
          alt: "[마샐미디쉬] 매콤마늘쫑 해산물볶음 180g",
          title: "[마샐미디쉬] 매콤마늘쫑 해산물볶음 180g",
          description:
            "탱글탱글한 새우와 오징어를 마늘쫑과 함께 매콤하게 볶아냈어요.",
          n_price: "6,900원",
          s_price: "6,210원",
          id: 7,
          menu_id: 1,
          badges: ["론칭특가"],
        },
        {
          image:
            "http://public.codesquad.kr/jk/storeapp/data/bc3b777115e8377a48c7bd762fe5fdc9.jpg",
          alt: "[빅마마의밥친구] 비빔오징어 150g",
          title: "[빅마마의밥친구] 비빔오징어 150g",
          description: "달콤한 신야초발효액이 포인트!",
          n_price: null,
          s_price: "5,000원",
          id: 8,
          menu_id: 1,
          badges: [],
        },
      ],
      panels: [false, false, false, false, false, false, false, false],
    };
  }

  toggleCard(index) {
    const { setTargetProfile, openModal, closeModal } = this.props;
    const newPanels = [...this.state.panels];
    newPanels[index] = !newPanels[index];
    setTargetProfile(this.state.profiles[index]);
    if (newPanels[index] === true) {
      this.setState({
        ...this.state,
        panels: newPanels,
      });
      closeModal();
      return;
    }
    this.setState({
      ...this.state,
      panels: newPanels,
    });
    openModal();
  }

  render() {
    const oneUnitDeg = 360 / this.state.profiles.length;
    const oneUnitRadian = Math.PI / this.state.profiles.length;
    const height = 170 / (2 * Math.tan(oneUnitRadian));

    return (
      <div className="stage">
        <div className="carousel">
          <div className="carousel-title">
            <span>언제 먹어도</span>
            <span className="carousel-title-main">든든한 밑반찬</span>
          </div>
          {this.state.profiles.map((profile, index) => {
            return (
              <Panel
                key={index}
                rotateYDeg={oneUnitDeg * index}
                translateZPx={height}
                clickHandler={this.toggleCard.bind(this, index)}
                show={this.state.panels[index]}
                profile={profile}
              />
            );
          })}
        </div>
      </div>
    );
  }
}

const mapStateToProps = (state, props) => {
  return {
    on: state.modal.on,
    targetProfile: state.modal.targetProfile,
  };
};

const mapDispatchToProps = (dispatch) => {
  return {
    openModal: () => dispatch(openModal()),
    closeModal: () => dispatch(closeModal()),
    setTargetProfile: (targetProfile) =>
      dispatch(setTargetProfile(targetProfile)),
  };
};

export default connect(mapStateToProps, mapDispatchToProps)(Carousel);
