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

/* WRITE QUERIES USING JOIN TO ANSWER THE FOLLOWING QUESTIONS: */

-- What animals belong to Melody Pond?
SELECT * FROM animals a INNER JOIN owners o ON a.owner_id = o.id WHERE o.full_name = 'Melody Pond';

-- List of all animals that are pokemon (their type is Pokemon)
SELECT * FROM animals a INNER JOIN species s ON a.species_id = s.id WHERE s.name = 'Pokemon';

-- List all owners and their animals, remember to include those that don't own any animal.
SELECT * FROM owners o FULL OUTER JOIN animals a ON o.id = a.owner_id;

-- How many animals are there per species?
SELECT s.name, COUNT(*) FROM species s LEFT JOIN animals a ON s.id =  a.species_id GROUP BY s.name;

-- List all Digimon owned by Jennifer Orwell.
SELECT * FROM animals a INNER JOIN owners o ON a.owner_id = o.id WHERE o.full_name = 'Jennifer Orwell' AND a.species_id = (SELECT id from species WHERE name = 'Digimon');

-- List all animals owned by Dean Winchester that haven't tried to escape.
SELECT * FROM animals a INNER JOIN owners o ON a.owner_id = o.id WHERE o.full_name = 'Dean Winchester' AND a.escape_attempts <= 0;

-- Who owns the most animals?
SELECT o.full_name, COUNT(*) FROM owners o LEFT JOIN animals a ON o.id =  a.owner_id GROUP BY o.full_name ORDER BY COUNT DESC LIMIT 1;
