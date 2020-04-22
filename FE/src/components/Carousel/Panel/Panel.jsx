import React from "react";
import Profile from "./Profile/Profile";

import "./Panel.css";

class Panel extends React.Component {
  constructor() {
    super();
  }

  render() {
    const {
      rotateYDeg,
      translateZPx,
      clickHandler,
      show,
      profile,
    } = this.props;

    return (
      <div
        style={{
          transform: `rotateY(${rotateYDeg}deg) translateZ(${translateZPx}px)`,
        }}
        className="panel"
        onClick={clickHandler}
      >
        <div className="panel-side panel-front">
          <Profile
            birthday={profile.birthday}
            name={profile.name}
            pay={profile.pay}
            description={profile.description}
          />
        </div>
        <div
          className={
            show ? "panel-side panel-back panel-hide" : "panel-side panel-back"
          }
        >
          <img src={profile.imgSrc}></img>
        </div>
      </div>
    );
  }
}

export default Panel;
