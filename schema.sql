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


/* day 4 */

CREATE TABLE vets(
    id INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(100),
    age INT,
    date_of_graduation DATE,
    PRIMARY KEY(id)
);

CREATE TABLE specializations(
    species_id INT NOT NULL,
    vets_id INT NOT NULL,
    FOREIGN KEY (species_id) REFERENCES species(id) ON UPDATE CASCADE,
    FOREIGN KEY (vets_id) REFERENCES vets(id) ON UPDATE CASCADE,
    PRIMARY KEY(species_id, vets_id)
);

CREATE TABLE visits(
    id INT GENERATED ALWAYS AS IDENTITY,
    animals_id INT,
    vets_id INT,
    FOREIGN KEY (animals_id) REFERENCES animals(id) ON UPDATE CASCADE,
    FOREIGN KEY (vets_id) REFERENCES vets(id) ON UPDATE CASCADE,
    visit_date DATE,
    PRIMARY KEY(id, vets_id, animals_id)
);