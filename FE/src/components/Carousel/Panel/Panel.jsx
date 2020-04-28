import React from "react";
import Profile from "./Profile/Profile";

import "./Panel.css";

class Panel extends React.Component {
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
            title={profile.title}
            name={profile.name}
            n_price={profile.n_price}
            s_price={profile.s_price}
            description={profile.description}
            badges={profile.badges}
            key={profile.title}
          />
        </div>
        <div
          className={
            show ? "panel-side panel-back panel-hide" : "panel-side panel-back"
          }
        >
          <div
            className="panel-img"
            style={{ backgroundImage: `url(${profile.image})` }}
          ></div>
        </div>
      </div>
    );
  }
}

export default Panel;
