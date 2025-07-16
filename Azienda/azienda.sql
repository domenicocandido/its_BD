begin transaction;

set constraints all deferred;

CREATE DOMAIN Stringa as varchar;

CREATE DOMAIN RealGEZ as real
    check (value >= 0);

CREATE TYPE Indirizzo as (
    via Stringa,
    civico Stringa
);

CREATE TABLE Impiegato (
    id integer primary key,
    nome Stringa not null,
    cognome Stringa not null,
    nascita date not null,
    stipendio RealGEZ not null

);

CREATE TABLE Progetto (
    id integer primary key,
    nome Stringa not null,
    budget RealGEZ not null

);

CREATE TABLE Dipartimento (
    id integer primary key,
    nome Stringa not null,
    indirizzo Indirizzo

);

CREATE TABLE NumeroTelefono (
    telefono Stringa primary key

);

CREATE TABLE Afferenza (
    impiegato integer not null,
    dipartimento integer not null,
    dataAfferenza date not null,

    primary key(dipartimento),

    foreign key (impiegato) references Impiegato(id) deferrable,
    foreign key (dipartimento) references Dipartimento(id) deferrable
);

CREATE TABLE direzione (
    impiegato integer primary key,
    dipartimento integer not null,
    foreign key (impiegato) references Impiegato(id) deferrable,
    foreign key(dipartimento) references Dipartimento(id) deferrable
);

CREATE TABLE dip_tel (
    dipartimento integer not null,
    telefono Stringa not null,
    primary key (dipartimento, telefono),
    foreign key (dipartimento) references Dipartimento(id) deferrable,
    foreign key (telefono) references NumeroTelefono(telefono) deferrable
);

CREATE TABLE coinvolto(
    impiegato integer not null,
    progetto integer not null,
    primary key (impiegato, progetto),
    foreign key (impiegato) references Impiegato(id) deferrable,
    foreign key (progetto) references Progetto(id) deferrable
);

commit;