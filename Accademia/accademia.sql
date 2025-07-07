CREATE TYPE Strutturato as ENUM (
    'Ricercatore', 'Professore Associato', 'Professore Ordinario'
    );

CREATE TYPE LavoroProgetto as ENUM (
    'Ricerca e Sviluppo', 'Dimostrazione', 'Altro'
);

CREATE TYPE LavoroNonProgettuale as ENUM (
    'Didattica', 'Ricerca', 'Missione', 'Incontro Dipartimentale', 'Incontro Accademico', 'Altro'
);

CREATE TYPE CausaAssenza as ENUM (
    'Chiusura Universitaria', 'Maternita', 'Malattia'
);

CREATE DOMAIN PostInteger AS integer
    CHECK (value >= 0);

CREATE DOMAIN StringaM AS varchar(100);

CREATE DOMAIN NumeroOre AS integer
    CHECK (value >= 0 and value <= 8);

CREATE DOMAIN Denaro AS integer
    CHECK(value >= 0);


CREATE TABLE Persona(
    id PostInteger NOT NULL,
    nome StringaM  NOT NULL,
    cognome StringaM NOT NULL,
    posizione Strutturato NOT NULL,

    PRIMARY KEY (id)
);

CREATE TABLE Progetto(
    id PostInteger NOT NULL UNIQUE,
    nome StringaM NOT NULL UNIQUE,
    inizio date NOT NULL,
    fine date NOT NULL,
    CHECK(inizio > fine),
    budget Denaro NOT NULL

);

CREATE TABLE WP(
    progetto PostInteger UNIQUE NOT NULL,
    FOREIGN KEY(progetto)
        references Progetto(id),
    id PostInteger NOT NULL,
    nome StringaM Not Null UNIQUE,
    inizio date NOT NULL,
    fine date NOT NULL,
    CHECK(inizio > fine)
    PRIMARY KEY(progetto)
    
);

CREATE TABLE AttivitaProgetto(

    id PostInteger UNIQUE NOT NULL,
    persona PostInteger NOT NULL,
    FOREIGN KEY (persona)
        references Progetto(id),
    progetto PostInteger NOT NULL,
    wp PostInteger NOT NULL,
    FOREIGN KEY (progetto, wp)
        REFERENCES WP(progetto, id),
    giorno DATE NOT NULL,
    tipo LavoroProgetto NOT NULL,
    oreDurata NumeroOre NOT NULL

);

CREATE TABLE AttivitaNonProgettuale(

    id PostInteger UNIQUE NOT NULL,
    persona PostInteger NOT NULL,
    FOREIGN KEY (persona)
        references Progetto(id),
    giorno DATE NOT NULL,
    tipo LavoroNonProgettuale NOT NULL,
    oreDurata NumeroOre NOT NULL
    PRIMARY KEY(id)

);

CREATE TABLE Assenza(
    id PostInteger NOT NULL UNIQUE,
    persona PostInteger NOT NULL UNIQUE,
    tipo CausaAssenza NOT NUll,
    giorno DATE  NOT NULL,

    FOREIGN KEY(persona)
        REFERENCES Persona(id)
    PRIMARY KEY(id)

)