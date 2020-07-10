;;; Um den Befehl 
;;; mit-scheme --quiet < presentation.scm
;;; nutzen zu konnen,
;;; wird die Hilfsfunktion (show f) definiert.
;;; --quiet unterdrueckt alle Ausgaben die nicht explizit zur Ausgabe schreiben)
;;;
;;; (display obj) schreibt zur Standardausgabe (ohne Newline am Ende)
;;; (begin <exp1> <exp2> ... <expk>) evaluiert die Ausdruecke der Reihe nach
;;; (begin (display f) (newline)) ist quasi println()
(define (show f) (begin (display f) (newline)))


#| ================ ================ ================ Teil 5 ================ ================ ================ |#
#| ================ ================ ============== Modularität ============= ================ ================ |#

;;; Diese neue Definition von (fact n) versteck nicht nur die (fact-iter product counter n) Funktion
;;; Sie hat eine neue Struktur!
;;; Aber der Unterschied ist subtil

(define (fact n)
    (define (fact-iter product counter)
        (if (> counter n)
            product
            (fact-iter (* product counter) (+ counter 1) )))
    (fact-iter 1 1))

(show (fact 4))

;;; n muss in der Parameterliste der Funktion (fact-iter product counter) gar nicht mehr auftauchen
;;; Als Argumnt von (fact n),
;;; ist der Wert von n
;;; in der gesamten (fact n) Funktion verfuegbar


;;; Uebrigens
;;; n ist nicht verfuegbar ausserhalb (fact n)
;;; Unbound variable: n
;; (show n)
