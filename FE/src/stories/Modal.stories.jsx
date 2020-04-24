import React from "react";
import { storiesOf } from "@storybook/react";

import Modal from "../components/Modal/Modal";
import DetailPage from "../components/DetailPage/DetailPage";

storiesOf("DetailPage Modal", module).addWithJSX("기본 설정", () => (
  <Modal>
    <DetailPage price={2900} />
  </Modal>
));
