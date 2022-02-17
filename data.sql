/* ADDED TABLE DATA */
INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES (1, 'Agumon',  '02-03-2020', 0, true, 10.23 );
INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES (2, 'Gabumon',  '15-11-2018', 2, true, 8.00 );
INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES (3, 'Pikachu',  '01-07-2021', 2, false, 15.04 );
INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES (4, 'Devimon',  '05-12-2017', 5, true, 11.00 );

/* ADDED MORE TABLE DATA */
INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES (5, 'Charmander',  '08-02-2020', 0, false, 11.00 );
INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES (6, 'Plantmon',  '15-11-2022', 2, true, -5.70 );
INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES (7, 'Squirtle',  '02-04-1993', 3, false, -12.13 );
INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES (8, 'Angemon',  '12-06-2005', 1, true, -45.00 );
INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES (9, 'Boarmon',  '07-06-2005', 7, true, 20.40 );
INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES (10, 'Blossom',  '13-10-1998', 3, true, 17.00 );

/* WORKING WITH TRANSACTION */
/* UPDATING SPECIES COLUMN WITH 'unspecified' WITH A ROLLBACK TO REVERT PREVIOUS STATE*/
UPDATE animals
SET species = 'unspecified';
ROLLBACK;

/* UPDATING SPECIES COLUMN WITH 'digimon' FOR ALL ANIMALS THAT ENDS WITH 'mon' */
UPDATE animals
SET species = 'digimon'
WHERE name LIKE '%mon';

/* UPDATING SPECIES COLUMN WITH 'pokemon' FOR ALL ANIMALS WITHOUT 'digimon' */
UPDATE animals
SET species = 'pokemon'
WHERE species != ('digimon');

/* COMMITTING TRANSACTION */
COMMIT;

/* DELETING ALL RECORDS FROM TABLE AND ROLLING RECORDS BACK TO REVERT PREVIOUS STATE*/
DELETE FROM animals
ROLLBACK;

/* DELETING ALL ANIMALS BORN AFTER 'Jan 1st, 2022' */
DELETE FROM animals WHERE date_of_birth > '01-01-2022';

/* CREATING A SAVEPOINT FOR TRANSACTION */
SAVEPOINT SP1;

/* UPDATING ALL ANIMALS' WEIGHT TO BE THEIR INITIAL WEIGHT MULTIPLIED BY -1 */
UPDATE animals SET weight_kg = weight_kg * -1;

/* ROLLING BACK TO SAVEPOINT */
ROLLBACK TO SP1;

/* UPDATING ALL ANIMALS' WEIGHTS THAT ARE NEGATIVE TO BE THEIR INITIAL WEIGHT MULTIPLIED BY -1*/
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;

/* COMMITTING TRANSACTION TO SAVE UPDATE */
COMMIT;


/* INSERT DATA INTO THE 'owners' TABLE */
INSERT INTO owners (full_name, age) VALUES ('Sam Smith', 34);
INSERT INTO owners (full_name, age) VALUES ('Jennifer Orwell', 19);
INSERT INTO owners (full_name, age) VALUES ('Bob', 45);
INSERT INTO owners (full_name, age) VALUES ('Melody Pond', 77);
INSERT INTO owners (full_name, age) VALUES ('Dean Winchester', 14);
INSERT INTO owners (full_name, age) VALUES ('Jodie Whittaker', 38);

/* INSERT DATA INTO THE 'species' TABLE */
INSERT INTO species (name) VALUES ('Pokemon');
INSERT INTO species (name) VALUES ('Digimon');

UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;

/* MODIFY YOUR INSERTED ANIMALS SO IT INCLUDES THE 'species_id' VALUE */
BEGIN TRANSACTION;

UPDATE animals
  SET species_id = 
    (SELECT id FROM species WHERE name = 'Digimon')
  WHERE name LIKE '%mon';

UPDATE animals
  SET species_id = 
    (SELECT id FROM species WHERE name = 'Pokemon')
  WHERE species_id IS NULL;

COMMIT TRANSACTION;

/* MODIFY YOUR INSERTED ANIMALS TO INCLUDE OWNER INFORMATION 'owners_id' */
BEGIN TRANSACTION;

UPDATE animals
  SET owner_id = 
    (SELECT id FROM owners WHERE full_name = 'Sam Smith')
  WHERE name = 'Agumon';

UPDATE animals
  SET owner_id = 
    (SELECT id FROM owners WHERE full_name = 'Jennifer Orwell')
  WHERE name IN ('Gabumon', 'Pikachu');

UPDATE animals
  SET owner_id = 
    (SELECT id FROM owners WHERE full_name = 'Bob')
  WHERE name IN ('Devimon','Plantmon');

UPDATE animals
  SET owner_id = 
    (SELECT id FROM owners WHERE full_name = 'Melody Pond')
  WHERE name IN ('Charmander', 'Squirtle','Blossom');

UPDATE animals
  SET owner_id = 
    (SELECT id FROM owners WHERE full_name = 'Dean Winchester')
  WHERE name IN ('Angemon', 'Boarmon');

COMMIT TRANSACTION;
