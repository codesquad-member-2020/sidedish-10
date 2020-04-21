import React from "react";
import Panel from "./Panel/Panel";

import irene from "../../mockData/imgs/irene.jpg";
import jisu from "../../mockData/imgs/jisu.jpg";
import luda from "../../mockData/imgs/luda3.jpg";
import nauen from "../../mockData/imgs/nauen.jpg";
import rachel from "../../mockData/imgs/rachel.jpg";
import seulgi from "../../mockData/imgs/seulgi.jpg";
import joy from "../../mockData/imgs/joy.jpg";
import bona from "../../mockData/imgs/bona.jpg";
import minju from "../../mockData/imgs/minju.jpg";
import seula from "../../mockData/imgs/seula.jpg";
import jiae from "../../mockData/imgs/jiae.jpg";

import "./Carousel.css";

class Carousel extends React.Component {
  constructor() {
    super();
    this.state = {
      profiles: [
        {
          imgSrc: irene,
          name: "아이린",
          birthday: "1991-03-29",
          pay: "연봉 1억",
          description:
            "노래할 때 음색은 말할 때와 비슷하며 전체적으로 섬세하다. 라이브도 안정적으로 소화하기 때문에 신인 시절에 비보컬 멤버로 보였던 것에 비하면 파트의 비중을 많이 차지한다.",
        },
        {
          imgSrc: jisu,
          name: "지수",
          birthday: "1994-02-11",
          pay: "연봉 2억",
          description:
            "항상 밝고 명랑한 성격으로 러블리즈의 웃음을 책임진다. 활동적인 에너지와 몸을 아끼지 않는 개인기로 방송 전면에 서며 이미주와 함께 러블리즈의 예능적 가치를 증명하는 재원이기도 하다.",
        },
        {
          imgSrc: luda,
          name: "루다",
          birthday: "1997-03-06",
          pay: "연봉 2억",
          description:
            "우주소녀의 서브보컬로 여리여리한 체구 속에 노력과 끈기로 똘똘 뭉쳐진 연습벌레. 평소엔 수줍고 조용한 성격이나 무대에서만 서면 숨겨진 새로운 매력을 마음껏 보여주는 명랑소녀.",
        },
        {
          imgSrc: nauen,
          name: "나은",
          birthday: "1995-05-05",
          pay: "연봉 4억",
          description:
            "곡명인 예쁜 게 죄가 납득이 가는 얼굴로 자타공인 APRIL의 공식 비주얼 멤버.",
        },
        {
          imgSrc: rachel,
          name: "레이첼",
          birthday: "2000-08-28",
          pay: "연봉 3억",
          description:
            "웃을 때 생기는 보조개가 매력적이며, 본인도 자신의 매력으로 어필 중이다.",
        },
        {
          imgSrc: seulgi,
          name: "슬기",
          birthday: "1994-02-10",
          pay: "연봉 5억",
          description:
            "본인은 팀에서 카리스마를 맡고 있다고 주장하지만, 팬들에게나 같은 팀 멤버들, 또는 무대 아래서 슬기의 모습은 순한 곰돌이다.",
        },
        {
          imgSrc: joy,
          name: "조이",
          birthday: "1996-09-03",
          pay: "연봉 3억",
          description:
            "레드벨벳 내에서 서브보컬 포지션을 맡고 있으며, 음색이 가장 돋보이는 보컬이며 비중이 상당히 많은 편.",
        },
        {
          imgSrc: bona,
          name: "보나",
          birthday: "1995-08-19",
          pay: "연봉 2억",
          description:
            "우주소녀의 서브보컬, 리드댄서로 새침해 보이는 외모다. 대구 사투리를 구사하는 매력도 보여준다.",
        },
        {
          imgSrc: minju,
          name: "민주",
          birthday: "2001-02-05",
          pay: "연봉 2억",
          description:
            "얼반웍스이엔티 소속 연예인으로, 대한민국과 일본에서 활동하는 걸그룹 IZ*ONE의 멤버이다.",
        },
        {
          imgSrc: jiae,
          name: "지애",
          birthday: "1993-05-21",
          pay: "연봉 3.5억",
          description:
            "그리고 무엇보다도 수많은 앓이들을 양산해 낸, 러블리즈에서 귀여움과 미모면 1순위로 꼽히는 멤버다.",
        },
        {
          imgSrc: seula,
          name: "설아",
          birthday: "1994-12-24",
          pay: "연봉 4억",
          description:
            "우주소녀의 리드보컬로 새벽에 듣기 좋은 꿀성대의 소유자. 어려 보이는 외모와 달리 팀의 맏언니이기도 하다.",
        },
      ],
    };
    this.panelBacks = [];
  }

  toggleCard(index) {
    let { transform } = this.panelBacks[index].current.style;
    if (!transform) {
      this.panelBacks[index].current.style.transform = `rotateY(90deg)`;
      return;
    }
    this.panelBacks[index].current.style.transform = "";
  }

  render() {
    const oneUnitDeg = 360 / this.state.profiles.length;
    const oneUnitRadian = Math.PI / this.state.profiles.length;
    const height = 150 / (2 * Math.tan(oneUnitRadian));

    return (
      <div className="stage">
        <div className="carousel">
          {this.state.profiles.map((profile, index) => {
            const panelBack = React.createRef();
            this.panelBacks.push(panelBack);
            return (
              <Panel
                key={index}
                rotateYDeg={oneUnitDeg * index}
                translateZPx={height}
                clickHandler={this.toggleCard.bind(this, index)}
                refer={panelBack}
                profile={profile}
              />
            );
          })}
        </div>
      </div>
    );
  }
}

export default Carousel;
