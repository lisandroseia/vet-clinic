/* Database schema to keep the structure of entire database. */
CREATE TABLE animals(
    id INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(100),
    date_of_birth DATE,
    escape_attempts INT,
    neutered BOOLEAN,
    weight_kg DECIMAL,
    PRIMARY KEY(id)
);

/* day 2 */
ALTER TABLE
    animals
ADD
    species varchar(250);

/* day 3 */
CREATE TABLE owners(
    id INT GENERATED ALWAYS AS IDENTITY,
    full_name VARCHAR(250),
    age INT,
    PRIMARY KEY (id)
);

CREATE TABLE species(
    id INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(250),
    PRIMARY KEY (id)
);

ALTER TABLE
    animals DROP COLUMN species;

ALTER TABLE
    animals
ADD
    COLUMN species_id INT;

ALTER TABLE
    animals
ADD
    owner_id INT;

ALTER TABLE
    animals
ADD
    CONSTRAINT species_key FOREIGN KEY (species_id) REFERENCES species(id);

ALTER TABLE
    animals
ADD
    CONSTRAINT owner_key FOREIGN KEY (owner_id) REFERENCES owners(id);
