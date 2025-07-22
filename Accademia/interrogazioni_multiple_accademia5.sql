-- 1-Quali sono il nome, la data di inizio e la data di fine dei WP del progetto di nome ‘Pegasus’?

select pj.nome as nome, pj.inizio as pj, Progetto.fine as datafine
from Progetto
where Progetto.nome = 'Pegasus';


-- 2. Quali sono il nome, il cognome e la posizione degli strutturati che hanno almeno una attività nel progetto ‘Pegasus’, ordinati per cognome decrescente?

select p.nome, p.cognome, p.posizione

from AttivitaProgetto ap
join Persona p
on p.id = ap.persona
join Progetto pj
on ap.progetto = pj.id
join WP w
on w.progetto = ap.progetto

where pj.nome = 'Pegasus'
order by cognome desc;


-- 3. Quali sono il nome, il cognome e la posizione degli strutturati che hanno più di una attività nel progetto ‘Pegasus’?

select p.nome, p.cognome, p.posizione

from AttivitaProgetto ap
join Persona p
on p.id = ap.persona
join Progetto pj
on ap.progetto = pj.id
join WP w
on w.progetto = ap.progetto

where pj.nome = 'Pegasus' and posizione in ('Ricercatore', 'Professore Associato', 'Professore Ordinario')
group by p.cognome having(count(w.progetto) > 1)
order by cognome desc;



-- 4. Quali sono il nome, il cognome e la posizione dei Professori Ordinari che hanno fatto almeno una assenza per malattia?

select p.nome, p.cognome, p.posizione

from Persona p
join Assenza a 
on a.persona = p.id

where posizione = 'Professore Ordinario'
group by p.id, p.nome, p.cognome, p.posizione
having count(CASE WHEN a.tipo = 'Malattia' THEN 1 END)>= 1;

-- 5. Quali sono il nome, il cognome e la posizione dei Professori Ordinari che hanno fatto più di una assenza per malattia?
select p.nome, p.cognome, p.posizione

from Persona p
join Assenza a 
on a.persona = p.id
where posizione = 'Professore Ordinario'
group by p.id, p.nome, p.cognome, p.posizione
having count(CASE WHEN a.tipo = 'Malattia' THEN 1 END)> 1;

-- 6. Quali sono il nome, il cognome e la posizione dei Ricercatori che hanno almeno un impegno per didattica?

select p.nome , p.cognome, p.posizione
from Persona p
join AttivitaNonProgettuale anp
on p.id = anp.persona

where posizione = 'Ricercatore'
group by p.id, p.nome, p.cognome, p.posizione
having count(CASE WHEN anp.tipo = 'Didattica' THEN 1 END)>=1;

-- 7. Quali sono il nome, il cognome e la posizione dei Ricercatori che hanno più di un impegno per didattica?
select p.nome , p.cognome, p.posizione

from Persona p
join AttivitaNonProgettuale anp
on p.id = anp.persona

where posizione = 'Ricercatore'
group by p.id, p.nome, p.cognome, p.posizione
having count(CASE WHEN anp.tipo = 'Didattica' THEN 1 END)>1;

-- 8. Quali sono il nome e il cognome degli strutturati che nello stesso giorno hanno sia attività progettuali che attività non progettuali?

select p.nome , p.cognome

from Persona p
join AttivitaNonProgettuale anp
on p.id = anp.persona
join AttivitaProgetto ap
on p.id = ap.persona

where ap.giorno = anp.giorno;

--9. Quali sono il nome e il cognome degli strutturati che nello stesso giorno hanno sia attività progettuali che attività non progettuali? Si richiede anche di proiettare il giorno, il nome del progetto, il tipo di attività non progettuali e la durata in ore di entrambe le attività.

select p.nome , p.cognome, ap.giorno, 
pj.nome as nome_progetto, 
anp.tipo as tipo_attivita_non_progettuale, 
anp.oreDurata as ore_attivita_non_progettuale, 
ap.oreDurata ore_attivita_progettuale

from Persona p
join AttivitaNonProgettuale anp
on p.id = anp.persona
join AttivitaProgetto ap
on p.id = ap.persona
join Progetto pj
on pj.id = ap.progetto

where ap.giorno = anp.giorno and posizione in ('Ricercatore', 'Professore Associato', 'Professore Ordinario');

--10. Quali sono il nome e il cognome degli strutturati che nello stesso giorno sono assenti e hanno attività progettuali?

select p.nome , p.cognome

from Persona p
join Assenza a
on p.id = a.persona
join AttivitaProgetto ap
on p.id = ap.persona

where ap.giorno = a.giorno and posizione in ('Ricercatore', 'Professore Associato', 'Professore Ordinario');

-- 11. Quali sono il nome e il cognome degli strutturati che nello stesso giorno sono assenti e hanno attività progettuali? Si richiede anche di proiettare il giorno, il nome del progetto, la causa di assenza e la durata in ore della attività progettuale

select p.nome , p.cognome,
pj.nome as nome_progetto,
ap.giorno as giorno_attivita_progettuale,
a.tipo as causa_assenza,
ap.oreDurata as durata_attivita_progettuale

from Persona p
join AttivitaProgetto ap
on p.id = ap.persona
join Progetto pj
on ap.progetto = pj.id
join Assenza a
on p.id = a.persona


where ap.giorno = a.giorno and posizione in ('Ricercatore', 'Professore Associato', 'Professore Ordinario');

--12. Quali sono i WP che hanno lo stesso nome, ma appartengono a progetti diversi?

select nome

from WP 

group by nome
having count(distinct progetto) > 1; 