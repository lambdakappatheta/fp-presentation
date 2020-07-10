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


#| ================ ================ ================ Teil 2 ================ ================ ================ |#
#| ================ ================ =============== Rekursion ============== ================ ================ |#


#| ---- ---- ---- ---- Rekursion ---- ---- ---- ---- |#
;;; SICP 1.2.1 Linear Recursion and Iteration


(define (factorial-1 n)
    (if (< n 2)
        1
        (* n (factorial-1 (- n 1))) ))

(show (factorial-1 0))
(show (factorial-1 1))
(show (factorial-1 2))
(show (factorial-1 3))
(show (factorial-1 4))
(show (factorial-1 5))
(show (factorial-1 6))


(define (factorial-2 n)
    (fact-iter 1 1 n) )

(define (fact-iter product counter n)
    (if (> counter n)
        product
        (fact-iter (* product counter) (+ counter 1) n) ))

(show (factorial-2 0))
(show (factorial-2 1))
(show (factorial-2 2))
(show (factorial-2 3))
(show (factorial-2 4))
(show (factorial-2 5))
(show (factorial-2 6))

#|
(factorial 4)
(* 4 (factorial 3))
(* 4 (* 3 (factorial 2)))
(* 4 (* 3 (* 2 (factorial 1))))
(* 4 (* 3 (* 2 1)))
(* 4 (* 3 2))
(* 4 6)
24
|#

#|
(factorial 4)
(fact-iter 1 1 4)
(fact-iter 1 2 4)
(fact-iter 2 3 4)
(fact-iter 6 4 4)
(fact-iter 24 45 4)
24
|#

;;; Die Authoren von SICP unterscheiden zwischen rekursiven Prozessen und iterativen Prozessen
;;; Die erste Im­ple­men­tie­rung generiert einen rekursiven Prozess
;;; Die zweite Im­ple­men­tie­rung generiert einen iterativen Prozess

;;; Wenn man die Prozesse visualisiert
;;; stellt man fest, dass ihre Figuren verschieden sind

;;; Der wesentliche Unterschied ist, dass der rekursive Prozess Operationen aufschiebt
;;; Beim rekursiven Abstieg wird die Definition von (factorial-1) expandiert
;;; Beim rekursiven Aufstieg werden die aufgeschobenen Operationen ausgefuehrt

;;; Dagegen ist beim iterativen Prozess der Rueckgabewert bereits nach dem rekursiven Abstieg berechnet worden
;;; Bemerkung:
;;; Der Ruckgabewert von
;;; (fact-iter 1 2 4)
;;; ist der Ruckgabewert von
;;; (fact-iter 2 3 4)
;;; Das bedeutet, dass (fact-iter 1 2 4) spurlos verschwinden darf nachdem (fact-iter 2 3 4) gerufen wurde

;;; Weiterer Unterschied:
;;; Wenn man den iterativen Prozess unterbricht und seine aktuellen Werte abspeichert,
;;; kann man mit der Berechnung spaeter weitermachen
;;; Das ist bei dem rekursiven Prozess nicht der Fall, weil er einen "internen" Zustand hat

;;; Diese Zustaende aufzubewahren kostet uebrigens auch Platz!
;;; Waehrend der Platzverbrauch des iterativen Prozesses nur konstant ist,
;;; ist der Platzverbaruch des rekursiven Prozesses linear

;;; Die ganze Wahrheit: die Algorithmen sind eigentlich pseudopolynomial


;;; Syntaktisch beziehen sich beide Funktionen (Prozeduren) auf sich selbst in ihren Definitionen
;;; Prozeduren mit dieser Eigenschaft werden rekursive Prozeduren genannt

;;; Terminologie:
;;; Die rekursive Prozedur factorial1 generiert einen rekursiven Prozess
;;; Die rekursive Prozedur fact-iter generiert einen iterativen Prozess


;;; Der Hauptpunkt:
;;; Ein rekursiver Prozedur ist nicht unbedingt eine Quelle von Ineffizienz
;;; mit-scheme braucht fuer die Ausfuehrung iterativer Prozesse konstanten Platz
;;; erreicht wird das durch Endrekursion (tail-recursion)


#| ---- ---- ---- ---- Rekursion auf Listen ---- ---- ---- ---- |#
;;; Erinnerung:
;;; (null? l) testet ob die Liste l die leere List ist (Basisfall)


;;; sum

(define (sum-1 l)
    (if (null? l)
        0
        (+ (car l) (sum-1 (cdr l)))))

(show (sum-1 (list 4 4 7)))


(define (sum-2 l)
    (sum-iter 0 l))

(define (sum-iter initial l)
    (if (null? l)
        initial
        (sum-iter (+ initial (car l)) (cdr l))))

(show (sum-2 (list 4 4 7)))


;;; es geht uebrings noch eleganter

;;; eval takes as arguments an expression and an environment
(define (sum-3 l)
    (eval (cons '+ l) user-initial-environment))

(show (sum-3 (list 4 4 7)))

(define (sum-4 l)
    (apply + l))

(show (sum-4 (list 4 4 7)))


;;; product

(define (product l)
    (if (null? l)
        1
        (* (car l) (product (cdr l)))))

(show (product (list 4 4 7)))


;;; Das ging eingeltich ziemlich einfach..
;;; Die Funktion ist eine exakte Kopie von (sum-1 l) wobei
;;; der Operator + mit *
;;; und der initiale Wert 0 mit 1 ersetzt wurde

;;; Wir haben eine Abstraktion entdeckt
;;; Lass uns mal sie einen Namen geben und implementieren

(define (accumulate op initial l)
    (if (null? l)
        initial
        (op (car l) (accumulate op initial (cdr l)))))

(show (accumulate + 0 (list 1 3 5)))

(show (accumulate - 0 (list 1 3 7)))

;;; (- 1 (- 3 (- 7 0)))
