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

;;; Was passiert hier?

(define n 4)

(define (fact n)
    (define (fact-iter product counter)
        (if (> counter n)
            product
            (fact-iter (* product counter) (+ counter 1) )))
    (fact-iter 1 1))

(show (fact 6))

(show n)
