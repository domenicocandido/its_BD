-- 1. Quanti sono gli strutturati di ogni fascia?

select p.posizione as fascia, count(*) as numero_strutturati
from Persona p
group by posizione;

-- 2. Quanti sono gli strutturati con stipendio ≥ 40000?

select p.nome, count(*) as numero_strutturati
from Persona p
where p.stipendio >= 40000
group by nome;

-- 3. Quanti sono i progetti già finiti che superano il budget di 50000?

select p.nome, count(*) as progetti_finiti
from Progetto p
where p. fine <= current_date and p.budget > 50000
group by nome;

-- 4. Qual è la media, il massimo e il minimo delle ore delle attività relative al progetto ‘Pegasus’?

select p.nome, round(avg(ap.oredurata)::numeric, 1) as durata_media, min(ap.oredurata) as durata_minima, max(ap.oredurata) as durata_massima
from Progetto p, attivitaprogetto ap
where p.id = ap.progetto and p.nome = 'Pegasus'
group by nome;