/* Populate database with sample data. */
INSERT INTO
    animals (
        name,
        date_of_birth,
        escape_attempts,
        neutered,
        weight_kg
    )
VALUES
    ('Agumon', '2020-02-3', 0, true, 10.23);

INSERT INTO
    animals (
        name,
        date_of_birth,
        escape_attempts,
        neutered,
        weight_kg
    )
VALUES
    ('Gabumon', '2018-11-15', 2, true, 8);

INSERT INTO
    animals (
        name,
        date_of_birth,
        escape_attempts,
        neutered,
        weight_kg
    )
VALUES
    ('Pikachu', '2021-01-7', 1, false, 15.04);

INSERT INTO
    animals (
        name,
        date_of_birth,
        escape_attempts,
        neutered,
        weight_kg
    )
VALUES
    ('Devimon', '2017-05-12', 5, true, 11);

/* day 2 */
INSERT INTO
    animals (
        name,
        date_of_birth,
        escape_attempts,
        neutered,
        weight_kg
    )
VALUES
    ('Charmander', '2020-02-08', 0, false, -11),
    ('Plantmon', '2021-11-15', 2, true, -5.7),
    ('Squirtle', '1993-07-02', 3, false, -12.13),
    ('Angemon', '2005-05-12', 1, true, -45),
    ('Boarmon', '2005-05-07', 7, true, 20.4),
    ('Blossom', '1998-10-13', 3, true, 17),
    ('Ditto', '2022-05-14', 4, true, 22);

/* day 3 */
INSERT INTO
    owners (full_name, age)
VALUES
    ('Sam Smith', 34),
    ('Jennifer Orwell', 19),
    ('Bob', 45),
    ('Melody Pond', 77),
    ('Dean Winchester', 14),
    ('Jodie Whittaker', 38);

INSERT INTO
    species(name)
VALUES
    ('Pokemon'),
    ('Digimon');

/* modify species */
UPDATE
    animals
SET
    species_id = (
        SELECT
            id
        FROM
            species
        WHERE
            name = 'Digimon'
    )
WHERE
    name LIKE '%mon%';

UPDATE
    animals
SET
    species_id = (
        SELECT
            id
        FROM
            species
        WHERE
            name = 'Pokemon'
    )
WHERE
    species_id IS NULL;

/* requested updates */
UPDATE
    animals
SET
    owner_id = (
        SELECT
            id
        FROM
            owners
        WHERE
            full_name = 'Sam Smith'
    )
WHERE
    name = 'Agumon';

UPDATE
    animals
SET
    owner_id = (
        SELECT
            id
        FROM
            owners
        WHERE
            full_name = 'Jennifer Orwell'
    )
WHERE
    name IN ('Gabumon', 'Pikachu');

UPDATE
    animals
SET
    owner_id = (
        SELECT
            id
        FROM
            owners
        WHERE
            full_name = 'Bob'
    )
WHERE
    name IN ('Devimon', 'Plantmon');    

UPDATE
    animals
SET
    owner_id = (
        SELECT
            id
        FROM
            owners
        WHERE
            full_name = 'Melody Pond'
    )
WHERE
    name IN ('Charmander', 'Squirtle', 'Blossom');

UPDATE
    animals
SET
    owner_id = (
        SELECT
            id
        FROM
            owners
        WHERE
            full_name = 'Dean Winchester'
    )
WHERE
    name IN ('Angemon', 'Boarmon');