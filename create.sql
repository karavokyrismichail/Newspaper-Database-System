CREATE DATABASE IF NOT EXISTS db1;
USE db1;


CREATE TABLE IF NOT EXISTS publisher (
	email VARCHAR(128) NOT NULL,
	name VARCHAR(128) NOT NULL,
	surname VARCHAR(128) NOT NULL,
	PRIMARY KEY(email)
);


CREATE TABLE IF NOT EXISTS worker (
	email VARCHAR(128) NOT NULL,
	name VARCHAR(128) NOT NULL,
	surname VARCHAR(128) NOT NULL,
	salary INT NOT NULL,
	recruitment_date DATE NOT NULL,
	PRIMARY KEY(email)
);


CREATE TABLE IF NOT EXISTS journalist (
	email VARCHAR(128) NOT NULL,
	work_experience INT NOT NULL, /* number of months */
	cv VARCHAR(128) NOT NULL,
	PRIMARY KEY(email),
	CONSTRAINT CON0 FOREIGN KEY (email) REFERENCES worker(email)
	ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE IF NOT EXISTS newspaper (
	name VARCHAR(128) NOT NULL,
	owner VARCHAR(128) NOT NULL,
	frequency ENUM('daily', 'weekly', 'monthly') NOT NULL,
	publisher VARCHAR(128) NOT NULL,
	chief_editor VARCHAR(128) NOT NULL,
	PRIMARY KEY(name),
	CONSTRAINT CON1 FOREIGN KEY (publisher) REFERENCES publisher(email)
	ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT CON2 FOREIGN KEY (chief_editor) REFERENCES journalist(email)
	ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE IF NOT EXISTS paper (
	id INT NOT NULL AUTO_INCREMENT,
	publish_date DATE NOT NULL,
	pages INT DEFAULT 30 NOT NULL,
	copies INT NOT NULL,
	newspaper VARCHAR(128) NOT NULL,
	PRIMARY KEY(id, newspaper),
	CONSTRAINT CON3 FOREIGN KEY (newspaper) REFERENCES newspaper(name)
	ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE IF NOT EXISTS category (
	name VARCHAR(128) NOT NULL,
	description VARCHAR(128) NOT NULL,
	my_category VARCHAR(128),
	PRIMARY KEY(name),
	CONSTRAINT CON4 FOREIGN KEY (my_category) REFERENCES category(name)
	ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE IF NOT EXISTS article (
	path VARCHAR(128) NOT NULL,
	title VARCHAR(128) NOT NULL,
	order_in_paper INT,
	description VARCHAR(128) NOT NULL,
	state ENUM('INITIAL', 'ACCEPTED', 'REJECTED', 'CHANGES_NEEDED') DEFAULT 'INITIAL' NOT NULL,
	checkdate DATE DEFAULT NULL,
	paper INT DEFAULT NULL,
	category VARCHAR(128) DEFAULT NULL,
	num_of_pages INT NOT NULL,
	newspaper VARCHAR(128) NOT NULL,
	PRIMARY KEY(path),
	CONSTRAINT CON5 FOREIGN KEY (paper) REFERENCES paper(id)
	ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT CON6 FOREIGN KEY (category) REFERENCES category(name)
	ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT CON7 FOREIGN KEY (newspaper) REFERENCES newspaper(name)
	ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE IF NOT EXISTS key_words (
	article VARCHAR(128) NOT NULL,
	key_word VARCHAR(128) NOT NULL,
	PRIMARY KEY(article, key_word),
	CONSTRAINT CON8 FOREIGN KEY (article) REFERENCES article(path)
	ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE IF NOT EXISTS administrator (
	email VARCHAR(128) NOT NULL,
	duty VARCHAR(128) NOT NULL,
	street VARCHAR(128) NOT NULL,
	number INT NOT NULL,
	city VARCHAR(128) NOT NULL,
	PRIMARY KEY(email),
	CONSTRAINT CON9 FOREIGN KEY (email) REFERENCES worker(email)
	ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE IF NOT EXISTS phone_numbers (
	admin VARCHAR(128) NOT NULL,
	number BIGINT NOT NULL,
	PRIMARY KEY(admin, number),
	CONSTRAINT CON10 FOREIGN KEY (admin) REFERENCES administrator(email)
	ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE IF NOT EXISTS works (
	newspaper VARCHAR(128) NOT NULL,
	worker VARCHAR(128) NOT NULL,
	PRIMARY KEY(newspaper, worker),
	CONSTRAINT CON11 FOREIGN KEY (newspaper) REFERENCES newspaper(name)
	ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT CON12 FOREIGN KEY (worker) REFERENCES worker(email)
	ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE IF NOT EXISTS submission (
	journalist VARCHAR(128) NOT NULL,
	article VARCHAR(128) NOT NULL,
	date DATE NOT NULL,
	PRIMARY KEY(journalist, article),
	CONSTRAINT CON13 FOREIGN KEY (journalist) REFERENCES journalist(email)
	ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT CON14 FOREIGN KEY (article) REFERENCES article(path)
	ON DELETE CASCADE ON UPDATE CASCADE
);
