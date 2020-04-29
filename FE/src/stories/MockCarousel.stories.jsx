import React from "react";
import { storiesOf } from "@storybook/react";

import MockCarousel from "../components/Carousels/MockCarousel/MockCarousel";

storiesOf("MockCarousel", module).addWithJSX("기본 설정", () => (
  <MockCarousel />
));
