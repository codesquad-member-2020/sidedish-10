import React from "react";

import "./Profile.css";

class Profile extends React.Component {
  constructor(props) {
    super();
  }
  render() {
    const { name, birthday, description, pay } = this.props;
    return (
      <div className="profile">
        <span>{name}</span>
        <span>{birthday}</span>
        <span>{description}</span>
        <span>{pay}</span>
      </div>
    );
  }
}

export default Profile;
