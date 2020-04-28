import React from "react";
import { connect } from "react-redux";

import "./Modal.css";

class Modal extends React.Component {
  render() {
    const { children, on } = this.props;
    return <>{on ? <div className="modal">{children}</div> : null}</>;
  }
}

const mapStateToProps = (state, props) => {
  return {
    on: state.modal.on,
  };
};

export default connect(mapStateToProps)(Modal);
