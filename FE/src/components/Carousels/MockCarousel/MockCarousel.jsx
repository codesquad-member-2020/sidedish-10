import React from "react";

import "./MockCarousel.css";

class MockCarousel extends React.Component {
  constructor(props) {
    super(props);
    this.mockData = Array(
      parseInt(process.env.REACT_APP_DEFAULT_CAROUSEL_LENGTH)
    ).fill(true);
  }

  render() {
    const oneUnitDeg = 360 / this.mockData.length;
    const oneUnitRadian = Math.PI / this.mockData.length;
    const height = 250 / (2 * Math.tan(oneUnitRadian));
    return (
      <div className="mock-stage">
        <div className="mock-carousel">
          <div className="mock-carousel-title">
            <span>언제 먹어도</span>
            <span className="mock-carousel-title-main">맛있는 배민찬</span>
          </div>
          {this.mockData.map((mockDatum, index) => (
            <div
              key={index}
              style={{
                transform: `rotateY(${
                  oneUnitDeg * index
                }deg) translateZ(${height}px)`,
              }}
              className="mock-panel"
            ></div>
          ))}
        </div>
      </div>
    );
  }
}

export default MockCarousel;
