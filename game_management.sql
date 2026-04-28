use game_management;
drop table users;
create table users (
	id int primary key AUTO_INCREMENT,
    username varchar(16) not null UNIQUE,
    phone varchar(10) not null UNIQUE,
    email varchar(100) not null UNIQUE,
    display_name varchar(255) not null,
    `password` varchar(100) not null
);

create table admin (
	id int primary key AUTO_INCREMENT,
    username varchar(16) not null UNIQUE,
    password varchar(16) not null
);
drop table admin;
call login_admin('admin','123');

create table categories (
	id int primary key auto_increment,
    name varchar(255) not null unique
);

CREATE TABLE games (
    id INT PRIMARY KEY AUTO_INCREMENT,
    image VARCHAR(255),
    name VARCHAR(255) NOT NULL UNIQUE,
    description TEXT,
    price DECIMAL(10,2) NOT NULL CHECK (price >= 0)
);

alter table games
	add column category_id int(10) null,
	add foreign key (category_id) references categories(id)
    ON DELETE CASCADE;
	SELECT * FROM games ORDER BY id ASC;
	
