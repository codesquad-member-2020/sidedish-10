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
      refer,
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
        <div className="panel-side panel-back" ref={refer}>
          <img src={profile.imgSrc}></img>
        </div>
      </div>
    );
  }
}

export default Panel;
