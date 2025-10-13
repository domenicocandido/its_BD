-- 1. Quante sono le compagnie che operano (sia in arrivo che in partenza) nei diversi aeroporti?

SELECT a.codice AS codice, a.nome AS nome, count(DISTINCT ap.comp) AS numero_compagnie
FROM  Aeroporto a, ArrPart ap
WHERE ap.arrivo = a.codice OR ap.partenza = a.codice
GROUP BY a.codice, a.nome;

-- 2. Quanti sono i voli che partono dall’aeroporto ‘HTR’ e hanno una durata di almeno 100 minuti?

SELECT count(v.codice) AS num_voli
FROM  Aeroporto a, Volo v,  ArrPart ap

WHERE a.codice = ap.partenza 
AND v.codice = ap.codice 
AND v.comp = ap.comp 
AND a.codice = 'HTR' 
AND v.durataMinuti >= 100;

-- 3. Quanti sono gli aeroporti sui quali opera la compagnia ‘Apitalia’, per ogni nazione nella 
--    quale opera?


-- 4. Qual è la media, il massimo e il minimo della durata dei voli effettuati dalla 
--    compagnia ‘MagicFly’?


-- 5. Qual è l’anno di fondazione della compagnia più vecchia che opera in ognuno degli aeroporti?


-- 6. Quante sono le nazioni (diverse) raggiungibili da ogni nazione tramite uno o più voli?


-- 7. Qual è la durata media dei voli che partono da ognuno degli aeroporti?


-- 8. Qual è la durata complessiva dei voli operati da ognuna delle compagnie fondate a partire 
--    dal 1950?