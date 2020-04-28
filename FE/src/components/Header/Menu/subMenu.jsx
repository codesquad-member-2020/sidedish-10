import React, { } from "react";
import { makeStyles } from "@material-ui/styles";
import MenuItem from "@material-ui/core/MenuItem";
const useStyles = makeStyles((theme) => ({
  menuItem: {
    fontSize: 14,
    focus: "none",
    width: 120,
  },
}));
export function SubMenu({ subMenu }) {
  const classes = useStyles();
  const focusSubMenu = (event) => {
    event.target.style.color = "#3AC5C5";
    event.target.style.fontWeight = "bold";
    event.target.style.textDecoration = "underline";
  };
  const unfocusSubMenu = (event) => {
    event.target.style.color = "#000000";
    event.target.style.fontWeight = "normal";
    event.target.style.textDecoration = "none";
  };
  return (
    <MenuItem
      onMouseEnter={focusSubMenu}
      onMouseLeave={unfocusSubMenu}
      classes={{
        root: classes.menuItem,
      }}
    >
      {subMenu.title}
    </MenuItem>
  );
}
export default SubMenu;