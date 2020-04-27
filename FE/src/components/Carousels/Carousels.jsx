import React from "react";
import Carousel from "../Carousel/Carousel";

import "./Carousels.css";

class Carousels extends React.Component {
  constructor(props) {
    super(props);
  }

  render() {
    return (
      <div className="carousels">
        <Carousel />
        <Carousel />
        <Carousel />
      </div>
    );
  }
}

export default Carousels;
