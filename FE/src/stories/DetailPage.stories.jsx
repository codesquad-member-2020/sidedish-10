import React from "react";
import { storiesOf } from "@storybook/react";
import luda from "../mockData/imgs/luda3.jpg";

import DetailPage from "../components/DetailPage/DetailPage";

storiesOf("DetailPage", module).addWithJSX("기본 설정", () => (
  <DetailPage
    target={{ s_price: "3,800원", title: "루다 포토 카드", image: luda }}
  />
));
