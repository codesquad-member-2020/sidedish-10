import React from "react";

import "./Modal.css";

class Modal extends React.Component {
  constructor(props) {
    super(props);
  }

  render() {
    const { children } = this.props;
    return <div className="modal">{children}</div>;
  }
}

export default Modal;
