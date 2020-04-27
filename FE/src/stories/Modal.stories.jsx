import React from "react";
import { storiesOf } from "@storybook/react";
import luda from "../mockData/imgs/luda3.jpg";

import Modal from "../components/Modal/Modal";
import DetailPage from "../components/DetailPage/DetailPage";

storiesOf("DetailPage Modal", module).addWithJSX("기본 설정", () => (
  <Modal>
    <DetailPage
      target={{ s_price: 3800, title: "루다 포토 카드", image: luda }}
    />
  </Modal>
));
