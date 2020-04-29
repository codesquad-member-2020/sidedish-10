import React from "react";
import { storiesOf } from "@storybook/react";

import DataProvider from "../components/DataProvider/DataProvider";
import Carousels from "../components/Carousels/Carousels";
import Modal from "../components/Modal/Modal";
import DetailPage from "../components/DetailPage/DetailPage";

storiesOf("DataProvider", module).addWithJSX("기본 설정", () => (
  <DataProvider>
    <Modal>
      <DetailPage />
    </Modal>
    <Carousels />
  </DataProvider>
));
