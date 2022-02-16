/* Query Data to obtain specific information */
SELECT date_of_birth FROM animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE date_of_birth BETWEEN '01-01-2016' AND '31-12-2019';
SELECT name FROM animals WHERE neutered IS true AND escape_attempts < 3;
SELECT name FROM animals WHERE name IN ('Agumon', 'Pikachu');
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.50;
SELECT name FROM animals WHERE neutered IS true;
SELECT name FROM animals WHERE name != ('Gabumon');
SELECT name FROM animals WHERE (weight_kg >= 10.40 AND weight_kg <= 17.30);

/* Write queries to answer the following questions */
/* How many animals are there? */
SELECT COUNT(name) FROM animals;

/* How many animals have never tried to escape? */
SELECT COUNT(name) FROM animals WHERE escape_attempts = 0;

/* What is the average weight of animals? */
SELECT AVG(weight_kg) FROM animals;

/* Who escapes the most, neutered or not neutered animals? */
SELECT MAX(escape_attempts) FROM animals;
SELECT COUNT(name) FROM animals WHERE neutered = '0';
SELECT COUNT(name) FROM animals WHERE neutered = '1';

/* What is the minimum and maximum weight of each type of animal? */
SELECT MIN(weight_kg) FROM animals GROUP BY species; 
SELECT MAX(weight_kg) FROM animals GROUP BY species; 

/* What is the average number of escape attempts per animal type of those born between 1990 and 2000? */
SELECT AVG(escape_attempts) FROM animals WHERE date_of_birth BETWEEN '01-01-1990' AND '31-12-2000'  GROUP BY species;