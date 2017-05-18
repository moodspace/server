/*
 Stack Maps
 
 Author(s): Jiacong Xu
 Created: May-6-2017

 This file contains SQL statements necessary to set up a new database
 supporting stack map querying and storage.

 We use http://www.sqlstyle.guide/ for naming conventions.
 */

/*
 Note on database:
 We assume a fresh database has been created for the use of this system. If not
 the case, uncommenting the following line may help.
 */

/* 
 CREATE DATABASE stack_maps;
 USE stack_maps;
 */

CREATE TABLE library (
    PRIMARY KEY (library_id),
    library_id      INT         NOT NULL    AUTO_INCREMENT,
    library_name    CHAR(25)
);

CREATE TABLE floor (
    PRIMARY KEY (floor_id),
    floor_id        INT         NOT NULL    AUTO_INCREMENT,
    floor_name      CHAR(25),
    floor_order     FLOAT,
    library         INT         NOT NULL,
                    INDEX (library),
                    FOREIGN KEY (library) REFERENCES library(library_id)
                    ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE wall (
    PRIMARY KEY (wall_id),
    wall_id         INT         NOT NULL    AUTO_INCREMENT,
    start_x         FLOAT,
    start_y         FLOAT,
    end_x           FLOAT,
    end_y           FLOAT,
    floor           INT,
                    INDEX(floor),
                    FOREIGN KEY (floor) REFERENCES floor(floor_id)
                    ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE aisle_area (
    PRIMARY KEY (aisle_area_id),
    aisle_area_id   INT         NOT NULL    AUTO_INCREMENT,
    center_x        FLOAT,
    center_y        FLOAT,
    width           FLOAT,
    height          FLOAT,
    rotation        FLOAT,
    floor           INT,
                    INDEX(floor),
                    FOREIGN KEY (floor) REFERENCES floor(floor_id)
                    ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE aisle (
    PRIMARY KEY (aisle_id),
    aisle_id        INT         NOT NULL    AUTO_INCREMENT,
    center_x        FLOAT,
    center_y        FLOAT,
    width           FLOAT,
    height          FLOAT,
    rotation        FLOAT,
    is_double_sided INT(1)      NOT NULL,
    aisle_area      INT,
                    INDEX (aisle_area),
                    FOREIGN KEY (aisle_area) REFERENCES aisle_area(aisle_area_id)
                    ON UPDATE CASCADE ON DELETE CASCADE,
    floor           INT,
                    INDEX (floor),
                    FOREIGN KEY (floor) REFERENCES floor(floor_id)
                    ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE call_range (
    PRIMARY KEY (call_range_id),
    call_range_id   INT         NOT NULL    AUTO_INCREMENT,
    collection      CHAR(50),
    call_start      CHAR(50),
    call_end        CHAR(50),
    side            INT,
    aisle           INT,
                    INDEX(aisle),
                    FOREIGN KEY (aisle) REFERENCES aisle(aisle_id)
                    ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE landmark (
    PRIMARY KEY (landmark_id),
    landmark_id     INT         NOT NULL    AUTO_INCREMENT,
    landmark_type   CHAR(25),
    center_x        FLOAT,
    center_y        FLOAT,
    width           FLOAT,
    height          FLOAT,
    rotation        FLOAT,
    floor           INT,
                    INDEX(floor),
                    FOREIGN KEY(floor) REFERENCES floor(floor_id)
                    ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE token (
    PRIMARY KEY (token_id),
    token_id        INT         NOT NULL    AUTO_INCREMENT,
    token_body      CHAR(64),
    expire_date     DATETIME
);

CREATE TABLE users (
    PRIMARY KEY (user_id),
    user_id         INT         NOT NULL    AUTO_INCREMENT,
    username CHAR(25),
    password CHAR(25)
);
