/* Create a database vet_clinic  */
CREATE DATABASE vet_clinic;

/* CREATED TABLE 'animals' */
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
   age INT NOT NULL,
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
ALTER TABLE animals
  ADD owner_id INT,
  ADD CONSTRAINT fk_owner
  FOREIGN KEY (owner_id)
  REFERENCES owners (id);

/* NEW TABLE "vets" */
CREATE TABLE vets(
   id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
   name VARCHAR (250) NOT NULL,
   age INT,
   date_of_graduation DATE NOT NULL
);

/* Create a "join table" called specializations to handle the relationship between species and vets */
CREATE TABLE specializations(
  id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  species_id INT,
  vets_id INT,
  CONSTRAINT fk_special_species 
  FOREIGN KEY (species_id)
  REFERENCES species (id),
  CONSTRAINT fk_special_vets 
  FOREIGN KEY (vets_id)
  REFERENCES vets (id),
);

/* Create a "join table" called visits to handle the relationship between animals and vets */
CREATE TABLE visits(
  id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  animal_id INT,
  vets_id INT,
  date_of_visit DATE,
  CONSTRAINT fk_visit_animal 
  FOREIGN KEY (animal_id)
  REFERENCES animals (id),
  CONSTRAINT fk_visit_vets 
  FOREIGN KEY (vets_id)
  REFERENCES vets (id)
);

-- Add an email column to your owners table
ALTER TABLE owners 
  ADD COLUMN email VARCHAR(120);

-- commands to create indexes for the visits and owners table
CREATE INDEX animals_id_asc ON visits(animal_id asc);
CREATE INDEX vet_id_asc ON visits(vet_id asc);
CREATE INDEX email_asc ON owners(email asc);