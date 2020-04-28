import React, { useState, useRef } from "react";
import { makeStyles } from "@material-ui/core/styles";
import Paper from "@material-ui/core/Paper";
import Popper from "@material-ui/core/Popper";
import Grow from "@material-ui/core/Grow";
import MenuList from "@material-ui/core/MenuList";
import SubMenu from "./subMenu";
const useStyles = makeStyles((theme) => ({
  root: {
    marginTop: theme.spacing(0),
  },
  menu: {
    width: 100,
    textAlign: "center",
    backgroundColor: "#483F35",
    color: "#ffffff",
    "&:hover": {
      backgroundColor: "#ffffff",
      color: "#3AC5C5",
    },
  },
  brand: {
    backgroundColor: "#362C25",
    paddingLeft: 30,
    paddingRight: 30,
  },
  menuItem: {
    fontSize: 14,
    focus: "none",
  },
}));
export function Menu({ menu, selected }) {
  const classes = useStyles();
  const [open, setOpen] = useState(false);
  const anchorRef = useRef(null);
  const { title, list } = menu;
  const menuOpen = () => {
    setOpen(true);
  };
  const menuClose = () => {
    setOpen(false);
  };
  return (
    <div className={classes.menuWrapper}>
      <div className={classes.menuBar}>
        <div
          ref={anchorRef}
          className={classes.menu}
          onMouseEnter={menuOpen}
          style={{ cursor: "pointer" }}
          onMouseLeave={menuClose}
          role="presentation"
          aria-owns={open ? "menu-list-grow" : undefined}
        >
          {title}
          <Popper
            open={open}
            anchorEl={anchorRef.current}
            transition
            disablePortal
            className={classes.popper}
          >
            {({ TransitionProps, placement }) => (
              <Grow
                {...TransitionProps}
                id="menu-list-grow"
                style={{
                  transformOrigin:
                    placement === "bottom" ? "center top" : "center bottom",
                }}
              >
                <Paper>
                  <MenuList
                    id="menu-list-grow"
                    classes={{
                      root: classes.menuItem,
                    }}
                  >
                    {list &&
                      list.map((sub, index) => (
                        <SubMenu subMenu={sub} key={index + Math.random()} />
                      ))}
                  </MenuList>
                </Paper>
              </Grow>
            )}
          </Popper>
        </div>
      </div>
    </div>
  );
}
export default Menu;