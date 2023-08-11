/* Erstellen Sie einen parametrisierten Cursor, der eine Job_id und
 * einen Vergleichswert für das Gehalt erwartet, und mittels einer Abfrage
 * den Nachnamen, Vornamen und den Wert (Gehalt - Vergleichswert) der 
 * Mitarbeiter abfragt, deren Gehalt über dem Vergleichswert liegt.
 * Die Ergebnisse sollen mit dem Hinweis "Overpaid" einmal für die Kombination 
 * ('ST_CLERK', 5000)   und  einmal für die Kombination ('SA_REP', 10000)
 * ausgegeben werden, d.h. der Cursor wird jeweils mit der entsprechenden
 * Parametrisierung verwendet.
 */
