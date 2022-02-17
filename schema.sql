/* Create a database vet_clinic  */
CREATE DATABASE vet_clinic;

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

/* NEW TABLE "owners" */
CREATE TABLE owners(
   id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
   full_name VARCHAR (250) NOT NULL,
   age INT NOT NULL
);

/* NEW TABLE "species" */
CREATE TABLE species(
   id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
   name VARCHAR (250) NOT NULL
);

/* MODIFY ANIMALS TABLE */
/* SET ID AS AUTOICREMENTED PRIMARY KEY */
ALTER TABLE animals 
  DROP COLUMN id; /* REMOVE ID COLUMN FIRST */
  
ALTER TABLE animals 
  ADD id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY;

/* REMOVE COLUMN SPECIES */
ALTER TABLE animals
  DROP COLUMN species;

/* ADD COLUMN 'species_id' WHICH IS A FOREIGN KEY REFERENCING 'species' TABLE */
ALTER TABLE animals
  ADD species_id INT,
  ADD CONSTRAINT fk_species
  FOREIGN KEY (species_id)
  REFERENCES species (id);

/* ADD COLUMN 'owners_id' WHICH IS A FOREIGN KEY REFERENCING 'owners' TABLE */
ALTER TABLE owners
  ADD owner_id INT,
  ADD CONSTRAINT fk_owner
  FOREIGN KEY (owner_id)
  REFERENCES owners (id);
