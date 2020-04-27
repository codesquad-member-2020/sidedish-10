import React from "react";
import { Provider } from "react-redux";
import configStore from "../../configStore";

class DataProvider extends React.Component {
  store = configStore({ modal: { on: false, targetProfile: {} } });
  constructor(props) {
    super(props);
  }

  render() {
    return <Provider store={this.store}>{this.props.children}</Provider>;
  }
}

export default DataProvider;
