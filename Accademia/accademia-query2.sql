-- 1. Elencare tutti i progetti la cui fine è successiva al 2023-12-31.

SELECT p.nome
FROM Progetto p
WHERE p.fine > 2023-12-31;

-- 2. Contare il numero totale di persone per ciascuna posizione (Ricercatore, Professore Associato, Professore Ordinario).

SELECT p.posizione AS pos, count(*) AS numPersone 
FROM Persona p
GROUP BY p.posizione;

-- 3. Restituire gli id e i nomi delle persone che hanno almeno un giorno di assenza per "Malattia".

SELECT p.id as personaID, p.nome as personaNome
FROM Persona p, Assenza a
WHERE a.persona = p.id AND a.tipo = 'Malattia';

-- 4. Per ogni tipo di assenza, restituire il numero complessivo di occorrenze.

SELECT a.tipo tipoAss, count(*) as numAss
FROM Assenza a
GROUP BY a.tipo;

-- 5. Calcolare lo stipendio massimo tra tutti i "Professori Ordinari".

SELECT p.id, p.nome, p.cognome, p.stipendio
FROM Persona p
WHERE posizione = 'Persone Ordinario' AND 


-- 7. Quanti sono i giorni di assenza per tipo e per persona. Per ogni persona e tipo di assenza, restituire nome, cognome, tipo assenza e giorni totali. 

SELECT *
FROM Assenza a 
