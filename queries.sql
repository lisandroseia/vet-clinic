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