import React from "react";

import seulgi from "../../../mockData/imgs/seulgi.jpg";
import luda from "../../../mockData/imgs/luda3.jpg";
import luda1 from "../../../mockData/imgs/luda2.jpg";
import jiae from "../../../mockData/imgs/jiae.jpg";
import minju from "../../../mockData/imgs/minju.jpg";
import jisu from "../../../mockData/imgs/jisu.jpg";

import "./MiniCarousel.css";

class MiniCarousel extends React.Component {
  constructor() {
    super();
    this.move = this.move.bind(this);
    this.next = this.next.bind(this);
    this.prev = this.prev.bind(this);
    this.nextTransform = this.nextTransform.bind(this);
    this.prevTransform = this.prevTransform.bind(this);
    this.pictures = [seulgi, luda, luda1, jiae, minju, jisu];
    this.refers = [];
    this.transforms = [
      { x: 0, z: "-40px", scale: 0.9, opacity: 0.8 },
      { x: "-55%", z: "-20px", scale: 0.95, opacity: 0.9 },
      { x: 0, z: 0, scale: 1, opacity: 1 },
      { x: "105%", z: "0px", scale: 1, opacity: 1 },
      { x: "155%", z: "-20px", scale: 0.95, opacity: 0.9 },
      { x: "105%", z: "-40px", scale: 0.9, opacity: 0.8 },
    ];
  }

  shouldComponentUpdate() {
    return false;
  }

  nextTransform(x) {
    if (x >= this.refers.length - 1) {
      return 0;
    }
    return x + 1;
  }

  prevTransform(x) {
    if (x === 0) {
      return this.refers.length - 1;
    }
    return x - 1;
  }

  next() {
    for (let i = 0; i < this.refers.length; i++) {
      this.refers[i].current.style.transform = `translateX(${
        this.transforms[this.nextTransform(i)].x
      }) translateZ(${this.transforms[this.nextTransform(i)].z}) scale(${
        this.transforms[this.nextTransform(i)].scale
      })`;
      this.refers[i].current.style.opacity = this.transforms[
        this.nextTransform(i)
      ].opacity;
    }
    this.transforms.push(this.transforms.shift());
  }

  prev() {
    for (let i = 0; i < this.refers.length; i++) {
      this.refers[i].current.style.transform = `translateX(${
        this.transforms[this.prevTransform(i)].x
      }) translateZ(${this.transforms[this.prevTransform(i)].z}) scale(${
        this.transforms[this.prevTransform(i)].scale
      })`;
      this.refers[i].current.style.opacity = this.transforms[
        this.prevTransform(i)
      ].opacity;
    }
    this.transforms.unshift(this.transforms.pop());
  }

  move(e) {
    const rect = e.currentTarget.getBoundingClientRect();
    const offsetX = e.clientX - rect.left;
    if (offsetX >= 200) {
      this.next();
      return;
    }
    this.prev();
  }

  render() {
    return (
      <div className="mini-stage">
        <div className="mini-carousel" onClick={this.move}>
          {this.pictures.map((picture) => {
            const pictureRef = React.createRef();
            this.refers.push(pictureRef);
            return (
              <div className="mini-panels" ref={pictureRef}>
                <img src={picture}></img>
              </div>
            );
          })}
        </div>
      </div>
    );
  }
}

export default MiniCarousel;
