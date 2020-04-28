import React from "react";

import "./Profile.css";

class Profile extends React.Component {
  constructor(props) {
    super();
  }
  render() {
    const { title, description, n_price, s_price, badges } = this.props;
    return (
      <div className="profile">
        <div className="profile-title">{title}</div>
        <div className="profile-description">{description}</div>
        <div className="profile-prices">
          {n_price && <p className="profile-n_price">{n_price}</p>}
          <p className="profile-s_price">{s_price}</p>
        </div>
        {badges &&
          badges.map((badge, index) => (
            <span key={badge.name + index} className="profile-badges">
              {badge.name}
            </span>
          ))}
      </div>
    );
  }
}

export default Profile;
