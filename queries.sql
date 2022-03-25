/*Queries that provide answers to the questions from all projects.*/
SELECT
    *
from
    animals
WHERE
    name LIKE '%mon%';

SELECT
    name
FROM
    animals
WHERE
    date_of_birth BETWEEN '2016-01-01'
    AND '2019-01-01';

SELECT
    name
FROM
    animals
WHERE
    neutered = true
    AND escape_attempts < 3;

SELECT
    date_of_birth
FROM
    animals
WHERE
    name = 'Agumon'
    OR name = 'Pikachu';

SELECT
    name,
    escape_attempts
FROM
    animals
WHERE
    weight_kg > 10.5;

SELECT
    *
from
    animals
WHERE
    neutered = true;

SELECT
    *
from
    animals
WHERE
    name != 'Gabumon';

SELECT
    *
from
    animals
WHERE
    weight_kg BETWEEN 10.4
    AND 17.3;

/* transaction 1*/
BEGIN;

UPDATE
    animals
SET
    species = 'unspecified';

SELECT
    id,
    species
FROM
    animals;

ROLLBACK;

SELECT
    id,
    species
FROM
    animals;

/* transaction 2 */
BEGIN;

UPDATE
    animals
SET
    species = 'digimon'
WHERE
    name LIKE '%mon%';

UPDATE
    animals
SET
    species = 'pokemon'
WHERE
    species IS NULL;

COMMIT;

SELECT
    name,
    species
FROM
    animals;

/* transaction 3 */
BEGIN;

DELETE FROM
    animals;

ROLLBACK;

SELECT
    *
FROM
    animals;

/* transaction 4 */
BEGIN;

DELETE FROM
    animals
WHERE
    date_of_birth > '2022-1-1';

SAVEPOINT SP1;

UPDATE
    animals
SET
    weight_kg = weight_kg * (-1);

ROLLBACK TO SP1;

UPDATE
    animals
SET
    weight_kg = weight_kg * (-1)
WHERE
    weight_kg < 0;

COMMIT;

/* query */
/* question 1*/
SELECT
    count(*)
FROM
    animals;

/* question 2*/
SELECT
    COUNT(*)
FROM
    animals
WHERE
    escape_attempts = 0;

/* question 3*/
SELECT
    AVG(weight_kg)
FROM
    animals;

/* question 4*/
SELECT
    neutered,
    COUNT(escape_attempts) AS "scapes: "
FROM
    animals
GROUP BY
    neutered;

/* question 5*/
SELECT
    species,
    MIN(weight_kg),
    MAX(weight_kg)
FROM
    animals
GROUP BY
    species;

/* question 6*/
SELECT
    species,
    AVG(escape_attempts)
FROM
    animals
WHERE
    date_of_birth BETWEEN '1990-1-1'
    AND '2000-12-31'
GROUP BY
    species;

/* day 3 */
/* question 1 */
SELECT
    name
FROM
    animals
    JOIN owners on animals.owner_id = owners.id
WHERE
    full_name = 'Melody Pond';

/* question 2 */
SELECT
    animals.name,
    species.name as specie
FROM
    animals
    JOIN species on animals.species_id = species.id
WHERE
    species.name = 'Pokemon';

/* question 3 */
SELECT
    full_name,
    name
FROM
    animals
    RIGHT JOIN owners on animals.owner_id = owner_id;

/* question 4 */
SELECT
    COUNT(animals.name),
    species.name
FROM
    species
    JOIN animals on species.id = animals.species_id
GROUP BY
    (species.name);

/* question 5 */
SELECT
    animals.name
FROM
    animals
    JOIN owners on animals.owner_id = owners.id
    JOIN species on animals.species_id = species.id
WHERE
    species.name = 'Digimon'
    AND full_name = 'Jennifer Orwell';

/* quiestion 6 */
SELECT
    animals.name
FROM
    animals
    JOIN owners on animals.owner_id = owners.id
WHERE
    escape_attempts = 0
    AND full_name = 'Dean Winchester';

/* question 7 */
SELECT
    full_name
FROM
    owners
    JOIN animals on animals.owner_id = owners.id
GROUP BY
    full_name
ORDER BY
    COUNT(animals.owner_id) DESC
LIMIT
    1;

/* day 4 */
/* question 1 */
SELECT
    animals.name,
    visits.visit_date
FROM
    animals
    JOIN visits ON animals.id = visits.animals_id
    JOIN vets on visits.vets_id = vets.id
WHERE
    vets.name = 'William Tatcher'
ORDER BY
    visits.visit_date DESC
LIMIT
    1;

/* question 2 */
SELECT
    COUNT(animals.name)
FROM
    animals
    JOIN visits ON animals.id = visits.animals_id
    JOIN vets ON visits.vets_id = vets.id
WHERE
    vets.name = 'Stephanie Mendez';

/* question 3 */
SELECT
    vets.name AS veterinary,
    species.name AS specialization
FROM
    vets
    LEFT JOIN specializations ON vets.id = specializations.vets_id
    LEFT JOIN species ON specializations.species_id = species.id;

/* question 4 */
SELECT
    animals.name
FROM
    animals
    JOIN visits ON animals.id = visits.animals_id
    JOIN vets ON visits.vets_id = vets.id
WHERE
    vets.name = 'Stephanie Mendez'
    AND visits.visit_date BETWEEN '2020-04-1'
    AND '2020-08-30';

/* question 5 */
SELECT
    animals.name,
    COUNT(animals.name)
FROM
    animals
    JOIN visits ON animals.id = visits.animals_id
GROUP BY
    animals.name
ORDER BY
    COUNT DESC
LIMIT
    1;

/* question 6 */
SELECT
    animals.name
FROM
    animals
    JOIN visits ON animals.id = visits.animals_id
    JOIN vets ON visits.vets_id = vets.id
WHERE
    vets.name = 'Maisy Smith'
ORDER BY
    visits.visit_date ASC
LIMIT
    1;

/* question 7 */
SELECT
    animals.name,
    animals.date_of_birth,
    animals.escape_attempts,
    animals.neutered,
    animals.weight_kg,
    vets.name,
    vets.age,
    vets.date_of_graduation,
    visits.visit_date
FROM
    animals
    JOIN visits ON animals.id = visits.animals_id
    JOIN vets ON visits.vets_id = vets.id
ORDER BY
    visits.visit_date ASC
LIMIT
    1;

/* questio 8 */
SELECT
    COUNT(visits.visit_date)
FROM
    vets
    JOIN visits ON visits.vets_id = vets.id
    JOIN animals ON animals.id = visits.animals_id
    JOIN specializations ON vets.id = specializations.vets_id
    JOIN species ON specializations.species_id = species.id
WHERE
    animals.species_id <> specializations.species_id;

/* question 9 */

SELECT
  species.name
FROM
  species
  INNER JOIN (
    SELECT
      animals.species_id AS id,
      COUNT(*)
    FROM
      visits
      INNER JOIN vets ON visits.vets_id = vets.id
      INNER JOIN animals ON animals.id = visits.animals_id
    WHERE
      vets.name = 'Maisy Smith'
    GROUP BY
      animals.species_id
  ) AS newTable ON species.id = newTable.id
ORDER BY
  newTable.COUNT DESC
LIMIT
  1;