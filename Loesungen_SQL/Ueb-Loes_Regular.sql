-- �bungen zu regul�ren Ausdr�cken

/* Aufgabe 1  Erstellen Sie eine Abfrage, um alle Mitarbeiter zu suchen, 
deren Vorname mit "Ne" oder "Na" beginnt. Zeigen Sie die Namen an.*/

SELECT first_name, last_name
  FROM employees
  WHERE REGEXP_LIKE (first_name, '^N(e|a).*');
  
/* Aufgabe 2 Zeigen Sie alle Mitarbeiter an, bei denen die Telefonnummer 
genau 3 Punkte (.) enth�lt. */

SELECT last_name, phone_number
  FROM employees
  WHERE REGEXP_LIKE (phone_number, '^.*\..*\..*\..*$');
  
/* Aufgabe 3 Zeigen Sie alle Mitarbeiter an, bei denen die Telefonnummer 
eine 2-stellige Ziffernfolge enth�lt, die von Nichtziffern umrahmt wird. */

SELECT last_name, phone_number
  FROM employees
  WHERE REGEXP_LIKE (phone_number,'[^0-9][0-9][0-9][^0-9]');
  
-- oder alternativ

SELECT last_name, phone_number
  FROM employees
  WHERE REGEXP_LIKE (phone_number,'[^0-9][0-9]{2}[^0-9]');



/* Aufgabe 4 Erstellen Sie eine Abfrage, die bei der Anzeige der Strassen 
(Spalte STREET_ADDRESS) aus der Tabelle LOCATIONS das K�rzel 'St' durch 
'Street' ersetzt. Achten Sie darauf, dass keine Zeilen betroffen sind, die 
'Street' bereits enthalten, wobei Sie sich darauf st�tzen k�nnen, dass das 
K�rzel 'St' stets am Ende steht. */

SELECT regexp_replace(street_address, 'St$', 'Street')
  FROM locations
  WHERE regexp_like(street_address, 'St');


/* Aufgabe 5  F�gen Sie bei der Anzeige des L�ndernamens aus der
COUNTRIES-Tabelle nach jedem Zeichen des Namens ein Leerzeichen ein 
(sportliche Aufgabe).
*/
SELECT REGEXP_REPLACE(country_name, '(.)', '\1 ') FROM countries;


/* Aufgabe 6  Suchen Sie bei den Vornamen der Mitarbeiter nach Palindromen der 
L�nge 4 (Palindrome sind Zeichenketten, die vorw�rts und r�ckw�rts gelesen 
gleich sind, z.B. 'otto'. (sportliche Aufgabe)  */

SELECT last_name, first_name
  FROM employees
  WHERE REGEXP_LIKE (first_name,'^(.)(.)\2\1$');
