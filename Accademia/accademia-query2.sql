-- 1. Elencare tutti i progetti la cui fine è successiva al 2023-12-31.

SELECT p.nome
FROM Progetto p
WHERE p.fine > 2023-12-31;