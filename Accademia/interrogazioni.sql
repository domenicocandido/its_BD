-- 1-Quali sono il nome, la data di inizio e la data di fine dei WP del progetto di nome ‘Pegasus’?

select Progetto.nome as nome, Progetto.inizio as datainizio, Progetto.fine as datafine
from Progetto
where Progetto.nome = 'Pegasus';


-- 2. Quali sono il nome, il cognome e la posizione degli strutturati che hanno almeno una attività nel progetto ‘Pegasus’, ordinati per cognome decrescente?

select distinct Persona.nome as nome, Persona.cognome as cognome, Persona.posizione as posizione
from Persona, Progetto
where (Persona.posizione = 'Ricercatore'or Persona.posizione = 'Professore Associato' or Persona.posizione = 'Professore Ordinario') and Progetto.nome = 'Pegasus' 
ORDER BY cognome DESC;