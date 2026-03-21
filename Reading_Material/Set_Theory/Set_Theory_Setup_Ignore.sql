CREATE TABLE People (
    PersonId INT PRIMARY KEY,
    PersonName NVARCHAR(50) NOT NULL
);

CREATE TABLE LikesOlives (
    PersonId INT NOT NULL,
    CONSTRAINT FK_LikesOlives_People
        FOREIGN KEY (PersonId) REFERENCES People(PersonId)
);

CREATE TABLE LikesCapers (
    PersonId INT NOT NULL,
    CONSTRAINT FK_LikesCapers_People
        FOREIGN KEY (PersonId) REFERENCES People(PersonId)
);

INSERT INTO People (PersonId, PersonName)
VALUES
    (1, 'Asha'),
    (2, 'Bilal'),
    (3, 'Cerys'),
    (4, 'Dilan'),
    (5, 'Elif'),
    (6, 'Farah'),
    (7, 'Goran'),
    (8, 'Hana');

INSERT INTO LikesOlives (PersonId)
VALUES
    (1),
    (2),
    (3),
    (4),
    (7);

INSERT INTO LikesCapers (PersonId)
VALUES
    (2),
    (4),
    (5),
    (6),
    (7);

CREATE TABLE Vegetables (
    id INT PRIMARY KEY,
    Name VARCHAR(50)
);

CREATE TABLE Wizards (
    id INT PRIMARY KEY,
    Name VARCHAR(50),
    Age Int
);

CREATE TABLE Things (
    id INT PRIMARY KEY,
    thing VARCHAR(50)
);

INSERT INTO Vegetables (id, [Name]) VALUES
(1, 'Carrot'),
(2, 'Broccoli'),
(3, 'Turnip'),
(4, 'Cucumber'),
(5, 'Spinach'),
(6, 'Parsnip'),
(7, 'Zucchini'),
(8, 'Beetroot');

INSERT INTO Wizards (id, [Name], Age) VALUES
(1, 'Bumblefog', 55),
(2, 'Wizzlebeard', 105),
(3, 'Snortleflame', 991),
(4, 'Muffinspell', 3),
(5, 'Grumblewand', 13),
(6, 'Fizzlebark', 2000),
(7, 'Toadwink', 301),
(8, 'Zapples', 1);

INSERT INTO Things (id, thing) VALUES
(1, 'Paperclip'),
(2, 'Worm'),
(3, 'Peanut'),
(4, 'Candle'),
(5, 'Sock'),
(6, 'Spoon'),
(7, 'Button'),
(8, 'Rubber Duck');