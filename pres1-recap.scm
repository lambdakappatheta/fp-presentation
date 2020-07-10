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


#| ================ ================ ================ Teil 1 ================ ================ ================ |#
#| ================ ================ ============= Wiederholung ============= ================ ================ |#


#| ---- ---- ---- ---- Paare ---- ---- ---- ---- |#
;;; SICP p115 - Pairs

(define pair (cons 2 3))
(show pair)
(define head (car pair))
(show head)
(define tail (cdr pair))
(show tail)

;;; merkwuerdig: Ausgabe is nicht symmetrisch
(define b (cons (cons 1 2) (cons 3 4)))
(show b)


#| ---- ---- ---- ---- Listen ---- ---- ---- ---- |#
;;; SICP 2.2.1 Representing Sequences


;;; leere Liste: ()
(show ())

(define l (cons 27 ()))
(show l)
(define l (cons 27 (cons 11 ())))
(show l)
(define l (cons 27 (cons 11 (cons 2019 ()))))
(show l)


;;; Bemerkung:
;;; Listen werden "rueckwaerts aufgebaut"
;;; Insbesondere werden Elemente immer vorne eingefuegt

;;; Ueberlegungen:
;;; Hat man nur einen Zeiger, der auf das erste Paar zeigt,
;;; so kann man vorne in O(1) aber hinten nur in O(n) einfuegen

;;; Noch schlimmer:
;;; Wie fuegt man hinten ein?
;;; Erstelle ein Paar new-pair mit dem neuem Element und die leere Liste
;;; Finde das letzte Paar p in der originalen Liste
;;; ERSETZE die leere Liste in (cdr p) mit p
;;; aber wie sollte das Ersetzen gehen, wenn in funktionalen Programmen alle Konstrukte immutable sind?!

;;; cons(a b) ist wie prepend(a b) mit dem Ergebnis,
;;; dass der Liste b das Element a vorangestellt wird


(define primes (cons 2 (cons 3 (cons 5 (cons 7 (cons 11 (cons 13 (cons 17 ()))))))))
(show primes)


;;; Listen von Paaren

(define x (cons (cons 3 4) (cons (cons 5 6) ())))
(show x)

(define y (cons (cons 1 2) (cons (cons 3 4) (cons (cons 5 6) ()))))
(show y)

(define y   (cons (cons 1 2)
                (cons (cons 3 4)
                    (cons (cons 5 6)
                        ()))))
(show y)

(define z (cons (cons 1 2) x))
(show z)


;;; syntactic sugar

(define a (list 2 3 5 7))
(show a)

(define b (list (cons 1 2) (cons 3 4) (cons 5 6)))
(show b)


#| ---- ---- ---- ---- Baume ---- ---- ---- ---- |#
;;; 2.2.2 Hierarchical Structures

;;; Mit Paaren koennen binaere Baeume auf natuerliche Art repraesentiert werden.
;;; Aber wir wollen auch k-naere Baeume repraesentieren koennen.

;;; Idee:
;;; Der Zeiger im zweiten Element eines Paars zeigt auf die Geschwister


#|
ternaerer Baum

 / | \
/\ 3 4
12

._ -> 3_ -> 4/
|
-> 1_ -> 2/

|#

(define b (cons (list 1 2) (list 3 4)))
(show b)

;;; wie frueher erwaehnt,
;;; (cons a b) ist wie prepend, wenn b eine Liste ist
(define x (cons 1 (list 3 4)))
(show x)

;;; also ist der Ausdruck
;;; (define b (cons (list 1 2) (list 3 4)))
;;; aequivalent zu
(define b (list (list 1 2) 3 4))
(show b)

;;; deshalb ist die Ausgabe von frueher unsymmetrisch
(define b (cons (cons 1 2) (cons 3 4)))
(show b)

;;; Uebrigens
;;; Eine einfache Liste der Laenge n ist eigentlich ein n-aerer Baeum mit Tiefe 1


#|
binaerer Baum

 / \
/\ /\
12 34

._ -> ./
|     |
|     -> 3_ -> 4/
-> 1_ -> 2/

|#

(define b (list (list 1 2) (list 3 4)))
(show b)


;;; Baeume von Paaren

(define b (cons (list (cons 1 2) (cons 3 4)) (list (cons 5 6) (cons 7 8))))
(show b)


#| ---- ---- ---- ---- Define ---- ---- ---- ---- |#

#|
Definition einer Prozedur:

(define (⟨name⟩ ⟨formal parameters⟩)
    ⟨body⟩)
|#

(define (avg a b)
    (/ (+ a b) 2))

(show (avg 4 10))


#| ---- ---- ---- ---- If ---- ---- ---- ---- |#

;;; (if test-expr then-expr else-expr)

(show (if (< 1 2) 'true 'false))
(show (if (> 1 2) 'true 'false))

(define (max a b)
    (if (> a b) a b))

(show (max -2 -4))

(show (null? (list 2 3 5 7)))
(show (null? ()))
