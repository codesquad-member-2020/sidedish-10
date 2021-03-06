import React from "react";
import Carousel from "../Carousel/Carousel";
import MockCarousel from "./MockCarousel/MockCarousel";

import axios from "axios";

import "./Carousels.css";

class Carousels extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      loading: true,
    };
    this.categories = [
      { menu_id: 1, menu_title: "든든한 밥찬" },
      { menu_id: 2, menu_title: "든든한 국물요리" },
      { menu_id: 3, menu_title: "든든한 밑반찬" },
    ];
  }

  async componentDidMount() {
    try {
      const {
        data: { body },
      } = await axios.get(process.env.REACT_APP_SERVER_URL);
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
      this.setState({ carousels, loading: false });
    } catch (e) {
      console.error(e);
    }
  }

  render() {
    return (
      <div className="carousels">
        {this.state.loading
          ? this.categories.map((_, index) => <MockCarousel key={index} />)
          : this.categories.map((category) => {
              const { menu_id } = category;
              const { carouselData, title } = this.state.carousels[
                `${menu_id}`
              ];
              return (
                <Carousel
                  key={menu_id + title}
                  carouselData={carouselData}
                  title={title}
                />
              );
            })}
      </div>
    );
  }
}

export default Carousels;
