import React from "react";
import { storiesOf } from "@storybook/react";

import Carousel from "../components/Carousel/Carousel.jsx";

storiesOf("Carousel", module).addWithJSX("기본 설정", () => <Carousel />);
