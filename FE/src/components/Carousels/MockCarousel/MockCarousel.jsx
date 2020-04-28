import React from "react";

import "./MockCarousel.css";

class MockCarousel extends React.Component {
  constructor(props) {
    super(props);
    this.mockData = Array(8).fill(true);
  }

  render() {
    const oneUnitDeg = 360 / this.mockData.length;
    const oneUnitRadian = Math.PI / this.mockData.length;
    const height = 170 / (2 * Math.tan(oneUnitRadian));
    return (
      <div className="mock-stage">
        <div className="mock-carousel">
          <div className="mock-carousel-title">
            <span>언제 먹어도</span>
            <span className="mock-carousel-title-main">title</span>
          </div>
          {this.mockData.map((mockDatum, index) => (
            <div
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
