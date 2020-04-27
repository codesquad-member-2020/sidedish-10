import React from "react";
import Carousel from "../Carousel/Carousel";
import axios from "axios";

import "./Carousels.css";

class Carousels extends React.Component {
  constructor(props) {
    super(props);
    this.categories = [
      { menu_id: 1, menu_title: "든든한 밥찬" },
      { menu_id: 2, menu_title: "든든한 국물요리" },
      { menu_id: 3, menu_title: "든든한 밑반찬" },
    ];
  }

  async componentDidMount() {
    const {
      data: { body },
    } = await axios.get("http://13.125.179.178:8080/develop/baminchan/all");
    const carousels = this.categories.reduce((acc, category) => {
      const filteredBody = body.filter(
        (bodyElement) => bodyElement.menu_id === category.menu_id
      );
      return {
        ...acc,
        [`${category.menu_id}`]: {
          carouselData: filteredBody,
          title: category.menu_title,
        },
      };
    }, {});
    this.setState({ carousels });
  }

  render() {
    return (
      <div className="carousels">
        {this.state
          ? this.categories.map((category) => {
              const { menu_id } = category;
              const { carouselData, title } = this.state.carousels[
                `${menu_id}`
              ];
              return <Carousel carouselData={carouselData} title={title} />;
            })
          : null}
      </div>
    );
  }
}

export default Carousels;
