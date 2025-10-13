-- 1. Quanti sono gli strutturati di ogni fascia?

SELECT p.posizione AS fascia, count(*) AS numero_strutturati
FROM Persona p
GROUP BY posizione;

-- 2. Quanti sono gli strutturati con stipendio ≥ 40000?

SELECT count(*) AS numero_strutturati
FROM Persona p
WHERE p.stipendio >= 40000;


-- 3. Quanti sono i progetti già finiti che superano il budget di 50000?

SELECT count(*) AS progetti_finiti
FROM Progetto p
WHERE p. fine <= current_date AND p.budget > 50000;

-- 4. Qual è la media, il massimo e il minimo delle ore delle attività relative al progetto ‘Pegasus’?

SELECT p.nome, round(avg(ap.oredurata)::numeric, 1) AS durata_media, min(ap.oredurata) AS durata_minima, max(ap.oredurata) AS durata_massima
FROM Progetto p, attivitaprogetto ap
WHERE p.id = ap.progetto AND p.nome = 'Pegasus'
GROUP BY nome;

-- 5. Quali sono le medie, i massimi e i minimi delle ore giornaliere dedicate al progetto ‘Pegasus’ da ogni singolo docente?

SELECT p.nome AS nome, p.cognome AS cognome, round(avg(ap.oreDurata)::numeric, 2) AS media_ore, min(ap.oreDurata) AS minimo, max(ap.oreDurata) AS massimo
FROM Persona p, progetto pr, AttivitaProgetto ap
WHERE ap.persona = p.id AND ap.progetto = pr.id AND pr.nome = 'Pegasus'
GROUP BY p.nome, p.cognome;

-- 6. Qual è il numero totale di ore dedicate alla didattica da ogni docente?

SELECT p.id AS id_persona, p.nome AS nome, p.cognome AS cognome, SUM(anp.oreDurata) AS ore_dedicate
FROM Persona p, AttivitaNonProgettuale anp
WHERE anp.tipo = 'Didattica' AND anp.persona = p.id
GROUP BY p.id, p.nome, p.cognome;

-- 7. Qual è la media, il massimo e il minimo degli stipendi dei ricercatori?

SELECT min(p.stipendio) AS minimo, max(p.stipendio) AS massimo, avg(p.stipendio) AS media
FROM Persona p
WHERE p.posizione = 'Ricercatore'; 

-- 8. Quali sono le medie, i massimi e i minimi degli stipendi dei ricercatori, dei professori associati e dei professori ordinari?

SELECT p.posizione AS posizione, min(p.stipendio) AS minimo, max(p.stipendio) AS massimo, avg(p.stipendio) AS media
FROM Persona p
GROUP BY p.posizione;

-- 9. Quante ore ‘Ginevra Riva’ ha dedicato ad ogni progetto nel quale ha lavorato?

SELECT pr.id AS id_progetto, pr.nome AS nome, SUM(ap.oreDurata) AS ore_dedicate
FROM Persona p, Progetto pr, attivitaprogetto ap
WHERE ap.persona = p.id AND p.nome = 'Ginevra' AND p.cognome = 'Riva' AND ap.progetto = pr.id
GROUP BY pr.id, pr.nome;