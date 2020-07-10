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
#| ================ ================ ============= Modularität 0 ============ ================ ================ |#


;;; Erinnerung:
;;; Wie sah die rekursive Prozedure aus,
;;; die den iterativen Prozess generiert?

#|
(factorial 4)
(fact-iter 1 1 4)
(fact-iter 1 2 4)
(fact-iter 2 3 4)
(fact-iter 6 4 4)
(fact-iter 24 45 4)
24
|#


(define (fact n)
    (fact-iter 1 1 n))

(define (fact-iter product counter n)
    (if (> counter n)
        product
        (fact-iter (* product counter) (+ counter 1) n)))

;;; beabsichtigte Nutzung
(show (fact 4))

;;; Klienten entdecken, dass sie 4*5*6*7*8 folgendermassen berechnen koennen:
(show (fact-iter 4 5 8))


;;; Spaeter entdecken wir, die Autoren der Bibliothek,
;;; dass wir fact-iter veraendern koennten.
;;; z.B. durch eine Formel ersetzen (wie die Gaußsche Summenformel)
;;; Aber das koennen wir nur dann tun,
;;; wenn wir Abwaertskompatibilitaet aufgeben
