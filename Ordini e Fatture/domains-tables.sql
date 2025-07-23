CREATE DOMAIN RealGEZ as real
    check (value >= 0);

CREATE DOMAIN Real_0_1 as RealGEZ
    CHECK (value <= 1);

CREATE TYPE Indirizzo as (
    via VARCHAR,
    civico VARCHAR
);

CREATE DOMAIN CodiceFiscale AS char(16)
    CHECK (VALUE ~ '^[A-Z]{6}[0-9]{2}[A-Z][0-9]{2}[A-Z][0-9]{3}[A-Z]$');

CREATE DOMAIN PartitaIva AS char(11)
    CHECK (VALUE ~ '^[0-9]{11}');

CREATE DOMAIN Telefono as char(10)
    CHECK (VALUE ~ '^[0-9]{10}');

CREATE DOMAIN Email as varchar
    CHECK (VALUE  ~ '^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}$');

CREATE TYPE StatoOrdineEnum as ENUM(
'In preparazione', 'Inviato', 'Da saldare','Saldato'
);

CREATE TABLE Nazione(
    nome VARCHAR NOT NULL,

    primary key(nome)
);

CREATE TABLE Regione(
    nome VARCHAR NOT NULL,
    nazione VARCHAR NOT NULL,

    primary key (nome),

    foreign key (nazione)
        references Nazione(nome),
    
    unique(nome, nazione)

);

CREATE TABLE Citta(
    nome VARCHAR NOT NULL,
    id INTEGER NOT NULL,
    regione VARCHAR NOT NULL,

    primary key(id),

    foreign key (regione)
        references Regione(nome),

    unique(nome, regione)
);

CREATE TABLE Direttore(
    nome varchar NOT NULL,
    cognome varchar NOT NULL,
    cf CodiceFiscale NOT NULL,
    anni_servizio RealGEZ NOT NULL,
    data_nascita DATE NOT NULL,
    citta INTEGER NOT NULL,

    primary key (cf),

    foreign key (citta)
        references Citta(id)

);

CREATE TABLE Dipartimento(
    nome VARCHAR NOT NULL,
    indirizzo INDIRIZZO NOT NULL,
    direttore CodiceFiscale NOT NULL,
    citta INTEGER NOT NULL,

    primary key(nome),

    foreign key (direttore)
        references Direttore(cf),

    foreign key (citta)
        references Citta(id)

);

CREATE TABLE StatoOrdine(
    nome VARCHAR NOT NULL UNIQUE,
    id INTEGER NOT NULL,

    primary key (id)
);

CREATE TABLE Fornitore(
    ragione_sociale VARCHAR NOT NULL,
    partita_iva PartitaIva NOT NULL,
    indirizzo INDIRIZZO NOT NULL,
    telefono TELEFONO NOT NULL,
    email EMAIL NOT NULL,
    citta INTEGER NOT NULL,

    primary key (partita_iva),

    foreign key (citta)
        references Citta(id)
);

CREATE TABLE Ordine(
    data_stipula DATE NOT NULL,
    imponibile RealGEZ NOT NULL,
    aliquota Real_0_1 NOT NULL,
    descrizione VARCHAR NOT NULL,
    id INTEGER NOT NULL,
    dipartimento VARCHAR NOT NULL,
    statoOrdine INTEGER NOT NULL,
    fornitore PartitaIva NOT NULL,

    primary key (id),

    foreign key (dipartimento)
        references Dipartimento(nome),

    foreign key (statoOrdine)
        references StatoOrdine(id),

    foreign key (fornitore)
        references Fornitore(partita_iva)

);