import React from "react";
import { storiesOf } from "@storybook/react";

import MiniCarousel from "../components/DetailPage/MiniCarousel/MiniCarousel";

storiesOf("MiniCarousel", module).addWithJSX("기본 설정", () => (
  <MiniCarousel />
));
