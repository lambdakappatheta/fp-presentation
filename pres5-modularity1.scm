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


;;; Problem:
;;; fact-iter ist eine Hilfsfunktion
;;; Sie sollte nur von (fact n) gerufen werden
;;; Sie sollte also nicht im globalen Namensraum sein und
;;; sie sollte nicht oeffentlich sein

;;; Wir haben vor kurzem Lambda-Funktionen kennengelert,
;;; aber sie sind hier keine Option
;;; Wir wollen naemlich die fact-iter Funktion rekursiv rufen,
;;; wir muessen ihr also einen Namen geben


;;; block structure:
;;; Erlaubt die Verschachtelung von Definitionen

;;; Embedded definitions must come first in a procedure body.

(define (fact n)
    (define (fact-iter product counter n)
        (if (> counter n)
            product
            (fact-iter (* product counter) (+ counter 1) n)))
    (fact-iter 1 1 n))

(show (fact 4))


;;; das geht nicht mehr:
;;; Unbound variable: fact-iter
;; (show (fact-iter 4 5 6))
