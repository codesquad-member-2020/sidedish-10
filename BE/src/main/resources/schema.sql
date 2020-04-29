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
DROP TABLE IF EXISTS point;
DROP TABLE IF EXISTS user;

CREATE TABLE menu
(
    menu_id    int primary key auto_increment,
    title varchar(45),
    eng_name varchar(45),
    info varchar(100)
);
CREATE TABLE best_category
(
    id    int primary key auto_increment,
    title varchar(45)
);
CREATE TABLE thumb_images
(
    id   int primary key auto_increment,
    link varchar(600),
    detail_hash varchar(45)
);
CREATE TABLE detail_section
(
    id   int primary key auto_increment,
    link varchar(600),
    detail_hash varchar(45)
);
CREATE TABLE s_price
(
    id      int primary key auto_increment,
    s_price varchar(45),
    detail_hash varchar(45)
);
CREATE TABLE n_price
(
    id      int primary key auto_increment,
    n_price varchar(45),
    detail_hash varchar(45)
);
CREATE TABLE delivery_type
(
    id    int primary key auto_increment,
    title varchar(45),
    detail_hash varchar(45)
);
CREATE TABLE badge
(
    id    int primary key auto_increment,
    title varchar(45),
    color varchar(45),
    detail_hash varchar(45)
);
CREATE TABLE point
(
    id    int primary key auto_increment,
    price varchar(45),
    detail_hash varchar(45)
);
CREATE TABLE item
(
    id          int primary key auto_increment,
    detail_hash varchar(45),
    alt         varchar(45),
    title       varchar(45),
    description varchar(100),
    image       varchar(300),
    menu_id     int
);
CREATE TABLE detail
(
    id                  int auto_increment primary key,
    detail_hash         varchar(45),
    top_image           varchar(150),
    product_description varchar(150),
    point               varchar(45),
    delivery_info       varchar(150),
    delivery_fee        varchar(150),
    availability        int
);
CREATE TABLE user
(
    id                  int auto_increment primary key,
    user_id              varchar(45),
    name                varchar(45),
    email               varchar(100)
);