/* Erstellen Sie einen parametrisierten Cursor, der eine Job_id und
 * einen Vergleichswert f�r das Gehalt erwartet, und mittels einer Abfrage
 * den Nachnamen, Vornamen und den Wert (Gehalt - Vergleichswert) der 
 * Mitarbeiter abfragt, deren Gehalt �ber dem Vergleichswert liegt.
 * Die Ergebnisse sollen mit dem Hinweis "Overpaid" einmal f�r die Kombination 
 * ('ST_CLERK', 5000)   und  einmal f�r die Kombination ('SA_REP', 10000)
 * ausgegeben werden, d.h. der Cursor wird jeweils mit der entsprechenden
 * Parametrisierung verwendet.
 */
