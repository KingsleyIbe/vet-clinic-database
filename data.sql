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

/* INSIDE TRANSACTION */
UPDATE animals
SET species = 'unspecified';
ROLLBACK;

UPDATE animals
SET species = 'digimon'
WHERE name LIKE '%mon';

UPDATE animals
SET species = 'pokemon'
WHERE species != ('digimon');

COMMIT;


DELETE FROM animals
ROLLBACK;