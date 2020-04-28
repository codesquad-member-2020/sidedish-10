import React from "react";
import { Provider } from "react-redux";
import configStore from "../../configStore";

class DataProvider extends React.Component {
  store = configStore();
  render() {
    return <Provider store={this.store}>{this.props.children}</Provider>;
  }
}

export default DataProvider;
