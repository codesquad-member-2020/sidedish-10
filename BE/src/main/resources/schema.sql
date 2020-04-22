DROP TABLE IF EXISTS menu;
DROP TABLE IF EXISTS best_category;
DROP TABLE IF EXISTS thumb_images;
DROP TABLE IF EXISTS detail_section;
DROP TABLE IF EXISTS s_price;
DROP TABLE IF EXISTS n_price;
DROP TABLE IF EXISTS delivery_type;
DROP TABLE IF EXISTS badge;
DROP TABLE IF EXISTS item;
DROP TABLE IF EXISTS detail;

CREATE TABLE menu
(
    id    int,
    title varchar(45)
);
CREATE TABLE best_category
(
    id    int,
    title varchar(45)
);
CREATE TABLE thumb_images
(
    id        int primary key auto_increment,
    link      varchar(600),
    detail_id int
);
CREATE TABLE detail_section
(
    id        int primary key auto_increment,
    link      varchar(600),
    detail_id int
);
CREATE TABLE s_price
(
    id      int primary key auto_increment,
    s_price int
);
CREATE TABLE n_price
(
    id      int primary key auto_increment,
    n_price int
);
CREATE TABLE delivery_type
(
    id    int primary key auto_increment,
    title varchar(45)
);
CREATE TABLE badge
(
    id    int primary key auto_increment,
    title varchar(45)
);
CREATE TABLE item
(
    id               int primary key auto_increment,
    alt              varchar(45),
    title            varchar(45),
    description      varchar(100),
    image            varchar(300),
    menu_id          int,
    detail_id        int,
    best_category_id int,
    s_price_id       int,
    n_price_id       int,
    badge_id         int
);
CREATE TABLE detail
(
    item_id             int NOT NULL,
    top_image           varchar(45),
    product_description varchar(100),
    point               varchar(45),
    delivery_info       varchar(150),
    delivery_fee        varchar(150),
    prices              varchar(150),
    s_price_id          int,
    n_price_id          int
);