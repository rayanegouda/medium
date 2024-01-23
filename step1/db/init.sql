------/*Creation du schema.*/
CREATE SCHEMA connect_schema;
------/*Creation de la table students.*/
CREATE TABLE IF NOT EXISTS connect_schema.students (
    id SERIAL NOT NULL PRIMARY KEY,
    nom VARCHAR NOT NULL,
    pays VARCHAR NOT NULL,
    update_ts TIMESTAMP DEFAULT current_timestamp NOT NULL
);
------/*Insertion des données dans la table students.*/
INSERT INTO connect_schema.students  (nom, pays) VALUES
('Raphael Dodson','Costa Rica'),
('Delilah Hopper','Pakistan'),
('Allistair Crosby','Norway');
------/*Trigger pour maj de la date "update_ts"*/
CREATE OR REPLACE FUNCTION maj_date()
RETURNS TRIGGER AS $$
BEGIN
    NEW.update_ts := NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER maj_date_trigger
BEFORE INSERT OR UPDATE ON connect_schema.students
FOR EACH ROW
EXECUTE FUNCTION maj_date();
------/*Tres utile pour obtenir des details dans la section before de la donnée*/
ALTER TABLE connect_schema.students REPLICA IDENTITY FULL;
