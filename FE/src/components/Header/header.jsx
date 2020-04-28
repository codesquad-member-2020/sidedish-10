import React from "react";
import { makeStyles } from "@material-ui/core/styles";
import ArrowDropDownIcon from "@material-ui/icons/ArrowDropDown";
import SearchIcon from "@material-ui/icons/Search";
import Menu from "./Menu/menu";
import menuData from "./Menu/menuData";
const useStyles = makeStyles((theme) => ({
    headerWrapper: {
        width: "100%",
        height: "30px",
        borderBottom: "1px solid #C4C4C4",
        lineHeight: "30px",
        color: "#3D3C3C",
    },
    topMenu: {
        display: "flex",
        justifyContent: "space-between",
        fontSize: 14,
        marginLeft: 200,
        marginRight: 200,
        marginBottom: 10,
    },
    arrowIcon: {
        width: 14,
        height: 14,
    },
    cart: {
        fontWeight: "bold",
    },
    bottomMenu: {
        display: "flex",
    },
    logo: {
        marginLeft: 200,
        marginRight: 50,
    },
    serachBox: {
        border: "1px solid #C4C4C4",
        width: 200,
        height: 30,
        marginTop: 18,
        textAlign: "right",
    },
    serachIcon: {
        marginRight: 10,
        marginTop: 5,
        width: 20,
        height: 20,
        color: "#C4C4C4",
    },
    bestEventWrapper: {
        marginRight: 200,
        marginLeft: "auto",
        height: 70,
        display: "flex",
        // width: 300,
    },
    bestWrapper: {
        marginRight: 50,
        fontWeight: "bold",
    },
    smallBest: {
        color: "#1AC2BD",
        letterSpacing: 0.1,
        height: 22,
        fontSize: 14,
    },
    bigBest: {
        fontSize: 25,
    },
    eventWrapper: {
        fontWeight: "bold",
    },
    smallEvent: {
        color: "#1AC2BD",
        letterSpacing: 0.1,
        height: 22,
        fontSize: 14,
    },
    bigEvent: {
        fontSize: 25,
    },
    menuWrapper: {
        backgroundColor: "#483F35",
        color: "#ffffff",
        fontSize: 18,
        fontWeight: "bold",
        marginTop: 10,
        height: "50px",
        lineHeight: "50px",
    },
    menuBar: {
        display: "flex",
        justifyContent: "space-between",
        marginLeft: 220,
        marginRight: 220,
    },
}));
export function Header() {
    const classes = useStyles();
    return (
        <div className={classes.headerWrapper}>
            <div className={classes.topMenu}>
                <div className={classes.leftSide}>
                    배민찬 앱 다운로드
          <ArrowDropDownIcon className={classes.arrowIcon} />
                </div>
                <div className={classes.rightSide}>
                    <span>로그인&ensp;|&ensp;</span>
                    <span>회원가입&ensp;|&ensp;</span>
                    <span>
                        마이페이지
            <ArrowDropDownIcon className={classes.arrowIcon} />
                    </span>
                    <span>
                        |&ensp;고객센터 <ArrowDropDownIcon className={classes.arrowIcon} />
                    </span>
                    <span>|&ensp;새벽배송 지역검색&ensp;|&ensp;</span>
                    <span>이벤트 게시판&ensp;|&ensp;</span>
                    <span className={classes.cart}>장바구니</span>
                </div>
            </div>
            <div className={classes.bottomMenu}>
                {/* <Avatar className={classes.logo}>배민</Avatar>
        <div className={classes.bigLetter}>찬</div>
        <div className={classes.sloganWrapper}>
          <div className={classes.slogan}>모바일</div>
          <div className={classes.slogan}>넘버원</div>
          <div className={classes.slogan}>반찬가게</div>
        </div> */}
                <img
                    className={classes.logo}
                    src="https://web.archive.org/web/20190122062652im_/https://cdn.bmf.kr/web/common/bmc-logo.png"
                    alt="배민찬 타이틀 로고"
                />
                <div className={classes.serachBox}>
                    <SearchIcon className={classes.serachIcon} />
                </div>
                <div className={classes.bestEventWrapper}>
                    <div className={classes.bestWrapper}>
                        <div className={classes.smallBest}>제일 잘 팔리는</div>
                        <div className={classes.bigBest}>베스트</div>
                    </div>
                    <div className={classes.eventWrapper}>
                        <div className={classes.smallEvent}>놓치면 후회</div>
                        <div className={classes.bigEvent}>이벤트</div>
                    </div>
                </div>
            </div>
            <div className={classes.menuWrapper}>
                <div className={classes.menuBar}>
                    {menuData.map((menu, index) => (
                        <Menu menu={menu} key={index + Math.random()} selected={0} />
                    ))}
                </div>
            </div>
        </div>
    );
}
export default Header;