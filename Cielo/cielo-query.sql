-- 1. Quante sono le compagnie che operano (sia in arrivo che in partenza) nei diversi aeroporti?

SELECT a.codice AS codice, a.nome AS nome, count(DISTINCT ap.comp) AS numero_compagnie
FROM  Aeroporto a, ArrPart ap
WHERE ap.arrivo = a.codice OR ap.partenza = a.codice
GROUP BY a.codice, a.nome;

-- 2. Quanti sono i voli che partono dall’aeroporto ‘HTR’ e hanno una durata di almeno 100 minuti?

SELECT count(v.codice) AS num_voli
FROM  Aeroporto a, Volo v,  ArrPart ap

WHERE a.codice = 'HTR' 
AND ap.partenza = a.codice
AND ap.codice = v.codice
AND ap.comp = v.comp
AND v.durataMinuti >= 100;

-- 3. Quanti sono gli aeroporti sui quali opera la compagnia ‘Apitalia’, per ogni nazione nella 
--    quale opera?

SELECT la.nazione AS nazione, count(DISTINCT a.codice) as num_aeroporti
FROM Compagnia c, aeroporto a, ArrPart ap, LuogoAeroporto la

WHERE c.nome = 'Apitalia'
AND (ap.arrivo = a.codice OR ap.partenza = a.codice)
AND ap.comp = c.nome
AND la.aeroporto = a.codice

GROUP BY la.nazione;


-- 4. Qual è la media, il massimo e il minimo della durata dei voli effettuati dalla 
--    compagnia ‘MagicFly’?

SELECT max(v.durataMinuti) AS massimo, min(v.durataMinuti) AS minimo, round(avg(durataMinuti), 3) AS media
FROM Volo v, Compagnia c

WHERE c.nome = 'MagicFly'
AND v.comp = c.nome;


-- 5. Qual è l’anno di fondazione della compagnia più vecchia che opera in ognuno degli aeroporti?

SELECT a.codice AS codice, a.nome AS nome, min(DISTINCT c.annoFondaz) as num_anni
FROM Aeroporto a, Compagnia c, ArrPart ap, Volo v

WHERE  (ap.arrivo = a.codice OR ap.partenza = a.codice)
AND c.nome = v.comp  -- dalla richiesta "opera" deduco ci debba essere almeno un volo
AND ap.comp = c.nome

GROUP BY a.codice, a.nome;

-- 6. Quante sono le nazioni (diverse) raggiungibili da ogni nazione tramite uno o più voli?

SELECT lp.nazione as nazione, count(DISTINCT la.nazione) as num_ragg
FROM LuogoAeroporto lp, LuogoAeroporto la, ArrPart ap-- lp: aeroporto partenza, la: aeroporto arrivo

WHERE lp.aeroporto = ap.partenza
AND la.aeroporto = ap.arrivo
AND lp.nazione != la.nazione -- esclude i voli che partono ed arrivano in una stessa nazione (ad esempio in Italia)

GROUP BY lp.nazione;

-- 7. Qual è la durata media dei voli che partono da ognuno degli aeroporti?

SELECT a.codice AS codice, a.nome AS nome, round(avg(v.durataMinuti), 3) AS durata_media
FROM Aeroporto a, ArrPart ap, Volo v

WHERE a.codice = ap.partenza
AND ap.codice = v.codice

GROUP BY a.codice, a.nome;

-- 8. Qual è la durata complessiva dei voli operati da ognuna delle compagnie fondate a partire 
--    dal 1950?

SELECT c.nome AS nome, SUM(v.durataMinuti) as durata_totale
FROM Compagnia c, Volo v

WHERE v.comp = c.nome
AND c.annoFondaz >= 1950

GROUP BY c.nome;
