-- 1. Quanti sono gli strutturati di ogni fascia?

SELECT p.posizione AS fascia, count(*) AS numero_strutturati
FROM Persona p
GROUP BY posizione;

-- 2. Quanti sono gli strutturati con stipendio ≥ 40000?

SELECT p.nome, count(*) AS numero_strutturati
FROM Persona p
WHERE p.stipendio >= 40000
GROUP BY nome;

-- 3. Quanti sono i progetti già finiti che superano il budget di 50000?

SELECT p.nome, count(*) AS progetti_finiti
FROM Progetto p
WHERE p. fine <= current_date AND p.budget > 50000
GROUP BY nome;

-- 4. Qual è la media, il massimo e il minimo delle ore delle attività relative al progetto ‘Pegasus’?

SELECT p.nome, round(avg(ap.oredurata)::numeric, 1) AS durata_media, min(ap.oredurata) AS durata_minima, max(ap.oredurata) AS durata_massima
FROM Progetto p, attivitaprogetto ap
WHERE p.id = ap.progetto AND p.nome = 'Pegasus'
GROUP BY nome;

-- 5. Quali sono le medie, i massimi e i minimi delle ore giornaliere dedicate al progetto ‘Pegasus’ da ogni singolo docente?

SELECT p.nome AS nome, p.cognome AS cognome, round(avg(ap.oreDurata)::numeric, 2) AS media_ore
FROM Persona p, progetto pr, AttivitaProgetto ap
WHERE (p.posizione = 'Professore Ordinario' or p.posizione = 'Professore Associato')
GROUP BY p.nome, p.cognome;

-- 6. Qual è il numero totale di ore dedicate alla didattica da ogni docente?

SELECT p.nome AS nome, SUM(anp.oreDurata) AS ore_dedicate
FROM Persona p, AttivitaNonProgettuale anp
WHERE anp.tipo = 'Didattica'
GROUP BY p.nome;