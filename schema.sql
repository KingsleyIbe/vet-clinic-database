/* CREATED TABLE */

CREATE TABLE animals( 
id INT PRIMARY KEY NOT NULL, 
name            TEXT       NOT NULL, 
date_of_birth   DATE       NOT NULL, 
escape_attempts INT        NOT NULL, 
neutered        BOOL       NOT NULL, 
weight_kg       REAL       NOT NULL 
);

/* ADD COLUMN */
ALTER TABLE animals 
ADD COLUMN species VARCHAR(255);
