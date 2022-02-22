/* ADDED TABLE DATA */
INSERT INTO 
  animals
    (id, name, date_of_birth, escape_attempts, neutered, weight_kg)
  VALUES (1, 'Agumon',  '02-03-2020', 0, true, 10.23 ),
    (2, 'Gabumon',  '15-11-2018', 2, true, 8.00 ),
    (3, 'Pikachu',  '01-07-2021', 2, false, 15.04 ),
    (4, 'Devimon',  '05-12-2017', 5, true, 11.00 );

/* ADDED MORE TABLE DATA */
INSERT INTO 
  animals 
    (id, name, date_of_birth, escape_attempts, neutered, weight_kg) 
  VALUES 
    (5, 'Charmander',  '08-02-2020', 0, false, 11.00 ),
    (6, 'Plantmon',  '15-11-2022', 2, true, -5.70 ),
    (7, 'Squirtle',  '02-04-1993', 3, false, -12.13 ),
    (8, 'Angemon',  '12-06-2005', 1, true, -45.00 ),
    (9, 'Boarmon',  '07-06-2005', 7, true, 20.40 ),
    (10, 'Blossom',  '13-10-1998', 3, true, 17.00 );

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
INSERT INTO 
  owners 
    (full_name, age)
  VALUES ('Sam Smith', 34),
   ('Jennifer Orwell', 19),
   ('Bob', 45),
   ('Melody Pond', 77),
   ('Dean Winchester', 14),
   ('Jodie Whittaker', 38);

/* INSERT DATA INTO THE 'species' TABLE */
INSERT INTO 
  species 
    (name) 
  VALUES ('Pokemon'),
    ('Digimon');

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

/* POPULATE THE 'vets' TABLE WITH DATA */
INSERT INTO
  vets
    (name, age, date_of_graduation)
  VALUES
    ('William Tatcher', 45, 'Apr 23, 2000'),
    ('Maisy Smith', 26, 'Jan 17, 2019'),
    ('Stephanie Mendez', 64, 'May 4, 1981'),
    ('Jack Harkness', 38, 'Jun 8, 2008');

/* POPULATE THE 'specialization' TABLE WITH DATA */
INSERT INTO 
  specializations
    (species_id, vets_id)
  VALUES
    (
      (
        SELECT id 
        FROM species 
        WHERE name = 'Pokemon'
      ),
      (
        SELECT id 
        FROM vets 
        WHERE name = 'William Tatcher'
      )
    ),
    (
      (
        SELECT id 
        FROM species 
        WHERE name = 'Pokemon'
      ),
      (
        SELECT id 
        FROM vets 
        WHERE name = 'Stephanie Mendez'
      )
    ),
    (
      (
        SELECT id 
        FROM species 
        WHERE name = 'Digimon'
      ),
      (
        SELECT id 
        FROM vets 
        WHERE name = 'Stephanie Mendez'
      )
    ),
    (
      (
        SELECT id 
        FROM species 
        WHERE name = 'Digimon'
      ),
      (
        SELECT id 
        FROM vets 
        WHERE name = 'Jack Harkness'
      )
    );

/* POPULATE 'visits' TABLE WITH DATA */
INSERT INTO
  visits
    (animal_id, vets_id,  date_of_visit)
  VALUES 
    (
      (
        SELECT id
        FROM animals
        WHERE name = 'Agumon'
      ),
      (
        SELECT id 
        FROM vets
        WHERE name = 'William Tatcher'
      ),
      'May 24, 2020'
    ),
    (
      (
        SELECT id
        FROM animals
        WHERE name = 'Agumon'
      ),
      (
        SELECT id 
        FROM vets
        WHERE name = 'Stephanie Mendez'
      ),
      'Jul 22, 2020'
    ),
    (
      (
        SELECT id
        FROM animals
        WHERE name = 'Gabumon'
      ),
      (
        SELECT id 
        FROM vets
        WHERE name = 'Jack Harkness'
      ),
      'Feb 2, 2021'
    ),
    (
      (
        SELECT id
        FROM animals
        WHERE name = 'Pikachu'
      ),
      (
        SELECT id 
        FROM vets
        WHERE name = 'Maisy Smith'
      ),
      'Jan 5, 2020'
    ),
    (
      (
        SELECT id
        FROM animals
        WHERE name = 'Pikachu'
      ),
      (
        SELECT id 
        FROM vets
        WHERE name = 'Maisy Smith'
      ),
      'Mar 8, 2020'
    ),
    (
      (
        SELECT id
        FROM animals
        WHERE name = 'Pikachu'
      ),
      (
        SELECT id 
        FROM vets
        WHERE name = 'Maisy Smith'
      ),
      'May 14, 2020'
    ),
    (
      (
        SELECT id
        FROM animals
        WHERE name = 'Devimon'
      ),
      (
        SELECT id 
        FROM vets
        WHERE name = 'Stephanie Mendez'
      ),
      'May 4, 2021'
    ),
    (
      (
        SELECT id
        FROM animals
        WHERE name = 'Charmander'
      ),
      (
        SELECT id 
        FROM vets
        WHERE name = 'Jack Harkness'
      ),
      'Feb 24, 2021'
    ),
    (
      (
        SELECT id
        FROM animals
        WHERE name = 'Plantmon'
      ),
      (
        SELECT id 
        FROM vets
        WHERE name = 'Maisy Smith'
      ),
      'Dec 21, 2019'
    ),
    (
      (
        SELECT id
        FROM animals
        WHERE name = 'Plantmon'
      ),
      (
        SELECT id 
        FROM vets
        WHERE name = 'William Tatcher'
      ),
      'Aug 10, 2020'
    ),
    (
      (
        SELECT id
        FROM animals
        WHERE name = 'Plantmon'
      ),
      (
        SELECT id 
        FROM vets
        WHERE name = 'Maisy Smith'
      ),
      'Apr 7, 2021'
    ),
    (
      (
        SELECT id
        FROM animals
        WHERE name = 'Squirtle'
      ),
      (
        SELECT id 
        FROM vets
        WHERE name = 'Stephanie Mendez'
      ),
      'Sep 29, 2019'
    ),
    (
      (
        SELECT id
        FROM animals
        WHERE name = 'Angemon'
      ),
      (
        SELECT id 
        FROM vets
        WHERE name = 'Jack Harkness'
      ),
      'Oct 3, 2020'
    ),
    (
      (
        SELECT id
        FROM animals
        WHERE name = 'Angemon'
      ),
      (
        SELECT id 
        FROM vets
        WHERE name = 'Jack Harkness'
      ),
      'Nov 4, 2020'
    ),
    (
      (
        SELECT id
        FROM animals
        WHERE name = 'Boarmon'
      ),
      (
        SELECT id 
        FROM vets
        WHERE name = 'Maisy Smith'
      ),
      'Jan 24, 2019'
    ),
     (
      (
        SELECT id
        FROM animals
        WHERE name = 'Boarmon'
      ),
      (
        SELECT id 
        FROM vets
        WHERE name = 'Maisy Smith'
      ),
      'May 15, 2019'
    ),
     (
      (
        SELECT id
        FROM animals
        WHERE name = 'Boarmon'
      ),
      (
        SELECT id 
        FROM vets
        WHERE name = 'Maisy Smith'
      ),
      'Feb 27, 2020'
    ),
     (
      (
        SELECT id
        FROM animals
        WHERE name = 'Boarmon'
      ),
      (
        SELECT id 
        FROM vets
        WHERE name = 'Maisy Smith'
      ),
      'Aug 3, 2020'
    ),
     (
      (
        SELECT id
        FROM animals
        WHERE name = 'Blossom'
      ),
      (
        SELECT id 
        FROM vets
        WHERE name = 'Stephanie Mendez'
      ),
      'May 24, 2020'
    ),
     (
      (
        SELECT id
        FROM animals
        WHERE name = 'Blossom'
      ),
      (
        SELECT id 
        FROM vets
        WHERE name = 'William Tatcher'
      ),
      'Jan 11, 2021'
    );

-- This will add 3.594.280 visits considering you have 10 animals, 4 vets, and it will use around ~87.000 timestamps (~4min approx.)
INSERT INTO visits 
  (animal_id, vet_id, date_of_visit) 
  SELECT * 
  FROM (SELECT id FROM animals) animal_ids, 
  (SELECT id FROM vets) 
  vets_ids, 
  generate_series
  ('1980-01-01'::timestamp, '2021-01-01', '4 hours') 
  visit_timestamp;

-- This will add 2.500.000 owners with full_name = 'Owner <X>' and email = 'owner_<X>@email.com' (~2min approx.)
insert into owners (full_name, email, age) 
  select 'Owner ' || generate_series(1,2500000), 
  'owner_' || generate_series(1,2500000) || '@mail.com'
  || generate_series(1,2500000);