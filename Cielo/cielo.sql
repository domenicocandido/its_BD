-- Il database di Cielo

create domain posinteger as integer
    check (value >= 0);

create domain stringam as varchar(100);

create DOMAIN codIATA as char(3);

create table compagnia(
    nome stringam primary key,
    annofondaz posinteger
);

create table volo(
    codice posinteger not null,
    comp stringam not null,
    primary key (codice, comp),
    durataMinuti posinteger not null,
    foreign key (comp)
        references compagnia(nome)

);

create table aeroporto(
    codice codIATA primary key,
    nome stringam not null,
    -- posticipo la definiziopne di fk
    -- verso luogoaeroporto, che ancora non esiste
);

create table luogoaeroporto(
    aeroporto codIATA,
    città stringam not null,
    nazione stringam not null,
    foreign key (aeroporto)
        references aeroporto(nome) defferable
),

alter table aeroporto
    add constraint aeroporto_luogoaeroporto_fk
        foreign key (codice)
            references luogoaeroporto(aeroporto) defferable on delete cascade;

create table arrpart (
    codice posinteger not null,
    comp stringam not null,
    primary key (codice,comp)
    foreign key (codice,comp)
        references volo(codice,comp)
    partenza codIATA not null,
    arrivo codIATA not null,

);

-- foreign key di volo posticipata per evitare errore

alter table volo
    add constraint volo_arrpart_fk
    foreign key (codice,comp)
        references arrpart(codice, comp) defferable;
