import React from "react";
import Header from "./components/Header/header";
import DataProvider from "./components/DataProvider/DataProvider";
import Modal from "./components/Modal/Modal";
import DetailPage from "./components/DetailPage/DetailPage";
import Carousels from "./components/Carousels/Carousels";

function App() {
  return (
    <div className="App">
      <DataProvider>
        <Modal>
          <DetailPage />
        </Modal>
        <Header />
        <Carousels />
      </DataProvider>
    </div>
  );
}

export default App;
