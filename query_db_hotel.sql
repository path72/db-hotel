-- -------------------------------------------------------------
-- QUERY_1.1   
-- Seleziona tutti gli ospiti che sono stati identificati con la carta di identità
SELECT
    ospiti.name,
    ospiti.lastname,
    ospiti.document_type
FROM
    ospiti
WHERE
    ospiti.document_type = 'CI'


-- -------------------------------------------------------------
-- QUERY_1.2
-- Seleziona tutti gli ospiti che sono nati dopo il 1988
SELECT
    ospiti.name,
    ospiti.lastname,
    ospiti.date_of_birth
FROM
    ospiti
WHERE
    YEAR(ospiti.date_of_birth) > '1988'


-- -------------------------------------------------------------
-- QUERY_1.3
-- Seleziona tutti gli ospiti che hanno più di 20 anni (al momento dell’esecuzione della query)
SELECT
    ospiti.name,
    ospiti.lastname,
    YEAR(ospiti.date_of_birth) AS 'year_of_birth',
    TIMESTAMPDIFF(YEAR,ospiti.date_of_birth,CURDATE()) AS 'age'
FROM
    ospiti 
WHERE
	TIMESTAMPDIFF(YEAR,ospiti.date_of_birth,CURDATE()) > 20
ORDER BY 
	ospiti.lastname


-- -------------------------------------------------------------
-- QUERY_1.4
-- Seleziona tutti gli ospiti il cui nome inizia con la D
SELECT
    ospiti.name,
    ospiti.lastname
FROM
    ospiti
WHERE
	ospiti.name LIKE 'D%'


-- -------------------------------------------------------------
-- QUERY_1.5
-- Calcola la somma del valore dei pagamenti in stato “accepted”
SELECT
    pagamenti.status,
    SUM(pagamenti.price) AS 'total_price',
    COUNT(pagamenti.id) as 'total_#_of_payments'
FROM
    pagamenti
WHERE
    pagamenti.status = 'accepted'
GROUP BY
    pagamenti.status


-- -------------------------------------------------------------
-- QUERY_1.6
-- Qual è il prezzo massimo pagato?
SELECT
    MAX(pagamenti.price) AS 'max_price'
FROM
    pagamenti


-- -------------------------------------------------------------
-- QUERY_1.7
-- Seleziona gli ospiti riconosciuti con patente e nati nel 1975
SELECT
    ospiti.name,
    ospiti.lastname,
    ospiti.document_type,
    YEAR(ospiti.date_of_birth) AS 'year_of_birth'
FROM
    ospiti
WHERE
    ospiti.document_type = 'Driver License'
	AND YEAR(ospiti.date_of_birth) = '1975'


-- -------------------------------------------------------------
-- QUERY_1.8
-- Quanti paganti sono anche ospiti?
SELECT
	COUNT(paganti.id)
FROM
    paganti
WHERE
	paganti.ospite_id <> 0


-- -------------------------------------------------------------
-- QUERY_1.9
-- Quanti posti letto ha l’hotel in totale?
SELECT
	SUM(stanze.beds) AS 'total_beds'
FROM
    stanze


-- -------------------------------------------------------------



-- GROUP BY --

-- -------------------------------------------------------------
-- QUERY_2.1
-- Conta gli ospiti raggruppandoli per anno di nascita
SELECT
	COUNT(ospiti.id) AS '#_of_guests',
    YEAR(ospiti.date_of_birth) AS 'year_of_birth'
FROM
    ospiti
GROUP BY
	`year_of_birth`


-- -------------------------------------------------------------
-- QUERY_2.2
-- Somma i prezzi dei pagamenti raggruppandoli per status
SELECT
    pagamenti.status,
    SUM(pagamenti.price) AS 'total_price'
FROM
	pagamenti
GROUP BY
	pagamenti.status


-- -------------------------------------------------------------
-- QUERY_2.3
-- Conta quante volte è stata prenotata ogni stanza
SELECT 
	stanze.room_number,
    COUNT(prenotazioni.id) AS '#_of_reservations'
FROM
	prenotazioni
INNER JOIN stanze ON stanze.id = prenotazioni.stanza_id
GROUP BY
	prenotazioni.stanza_id


-- -------------------------------------------------------------
-- QUERY_2.4
-- Fai una analisi per vedere se ci sono ore in cui le prenotazioni sono più frequenti
SELECT
    HOUR(prenotazioni.created_at) AS 'day_hour',
    COUNT(prenotazioni.id) AS '#_of_reservations'
FROM
	prenotazioni
GROUP BY
	`day_hour`
ORDER BY
	`#_of_reservations` DESC


-- -------------------------------------------------------------
-- QUERY_2.5
-- Quante prenotazioni ha fatto l’ospite che ha fatto più prenotazioni?
SELECT
    ospiti.name,
    ospiti.lastname,
    COUNT(prenotazioni_has_ospiti.prenotazione_id) AS '#_of_reservations'
FROM 
	prenotazioni_has_ospiti
INNER JOIN ospiti ON ospiti.id = prenotazioni_has_ospiti.ospite_id
GROUP BY
   	ospiti.name,
    ospiti.lastname
ORDER BY
	`#_of_reservations` DESC


-- -------------------------------------------------------------



-- JOIN --

-- -------------------------------------------------------------
-- QUERY_3.1
-- Come si chiamano gli ospiti che hanno fatto più di due prenotazioni?
SELECT
    ospiti.name,
    ospiti.lastname,
    COUNT(prenotazioni_has_ospiti.prenotazione_id) AS '#_of_reservations'
FROM 
	prenotazioni_has_ospiti
INNER JOIN ospiti ON ospiti.id = prenotazioni_has_ospiti.ospite_id
GROUP BY
   	ospiti.name,
    ospiti.lastname
HAVING `#_of_reservations` > 2
ORDER BY
	`#_of_reservations` DESC


-- -------------------------------------------------------------
-- QUERY_3.2
-- Stampare tutti gli ospiti per ogni prenotazione
SELECT
	prenotazioni_has_ospiti.prenotazione_id,
    ospiti.name,
    ospiti.lastname
FROM prenotazioni_has_ospiti
INNER JOIN ospiti ON ospiti.id = prenotazioni_has_ospiti.ospite_id


-- -------------------------------------------------------------
-- QUERY_3.3
-- Stampare Nome, Cognome, Prezzo e Pagante per tutte le prenotazioni fatte a Maggio 2018
SELECT
	prenotazioni.id			AS 'reservation',
    prenotazioni.created_at	AS 'date',
    paganti.name			AS 'paying_name',
    paganti.lastname		AS 'paying_lastname',
    pagamenti.price,
    ospiti.name				AS 'guest_name',
    ospiti.lastname			AS 'guest_lastname'
FROM 
	prenotazioni
INNER JOIN pagamenti ON pagamenti.prenotazione_id = prenotazioni.id
INNER JOIN paganti ON paganti.id = pagamenti.pagante_id
INNER JOIN prenotazioni_has_ospiti ON prenotazioni_has_ospiti.prenotazione_id = prenotazioni.id
INNER JOIN ospiti ON ospiti.id = prenotazioni_has_ospiti.ospite_id
WHERE 
	prenotazioni.created_at LIKE '2018-05%'
ORDER BY
	`reservation`


-- -------------------------------------------------------------
-- QUERY_3.4
-- Fai la somma di tutti i prezzi delle prenotazioni per le stanze del primo piano
SELECT 
    stanze.floor,
    COUNT(prenotazioni.id) AS '#_of_reservations',
	SUM(pagamenti.price) AS 'total_price'
FROM
	pagamenti
INNER JOIN prenotazioni ON prenotazioni.id = pagamenti.prenotazione_id
INNER JOIN stanze ON stanze.id = prenotazioni.stanza_id
WHERE
	stanze.floor = 1
GROUP BY
	stanze.floor


-- -------------------------------------------------------------
-- QUERY_3.5
-- Prendi i dati di fatturazione per la prenotazione con id=7
SELECT
	prenotazioni.id AS 'reservation_#',
    paganti.name,
    paganti.lastname,
    paganti.address,
    paganti.created_at AS 'date_of_transaction'
FROM 
	prenotazioni
INNER JOIN pagamenti ON pagamenti.prenotazione_id = prenotazioni.id
INNER JOIN paganti ON paganti.id = pagamenti.pagante_id
WHERE prenotazioni.id = 7


-- -------------------------------------------------------------
-- QUERY_3.6
-- Le stanze sono state tutte prenotate almeno una volta? (Visualizzare le stanze non ancora prenotate)
SELECT
	stanze.room_number,
    prenotazioni.id
FROM
	stanze
LEFT JOIN prenotazioni ON prenotazioni.stanza_id = stanze.id
WHERE prenotazioni.id IS NULL


-- -------------------------------------------------------------


