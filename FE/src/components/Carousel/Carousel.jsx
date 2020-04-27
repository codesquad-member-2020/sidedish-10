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
  constructor(props) {
    super(props);
    const panels = Array(props.carouselData.length).fill(false);
    this.state = {
      profiles: props.carouselData,
      panels,
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
    const { title } = this.props;
    return (
      <div className="stage">
        <div className="carousel">
          <div className="carousel-title">
            <span>언제 먹어도</span>
            <span className="carousel-title-main">{title}</span>
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
