SELECT date_of_birth FROM animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE date_of_birth LIKE '%2016' AND '%2019';
SELECT name FROM animals WHERE neutered IS true AND escape_attempts < 3;
SELECT name FROM animals WHERE name IN ('Agumon', 'Pikachu');
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.50;
SELECT name FROM animals WHERE neutered IS true;
SELECT name FROM animals WHERE name != ('Gabumon');
SELECT name FROM animals WHERE weight_kg >= 10.40 AND <= 17.30;
