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


#| ================ ================ ================ Teil 4 ================ ================ ================ |#
#| ================ ================ ===== more higher order functions ====== ================ ================ |#


;;; Primzahlen erzeugen

;;; erzeuge eine Liste zwischen 2 und num-1                                 (iota (- num 2) 2)
;;; fuer jedes Element x der Liste, berechne ob x ein Teiler von num ist    map
;;; falls mindestens ein Element wahr ist,                                  fold-left
;;; ist die Zahl keine Primzahl                                             not

(define (isPrime? num)
    (not
        (fold-left
            (lambda (x y) (or x y))
            #f
            (map
                (lambda (x)
                    (= 0 (remainder num x)))
                (iota (- num 2) 2) ))))

(show (isPrime? 4))
(show (isPrime? 5))


(define (primes to)
    (filter isPrime? (iota to 2)))

(show (primes 100))


#|
primes mit isPrime? als eine verschachtelte Funktion

(define (primes to)
    (remove
        (lambda (num)
            (fold-left
                (lambda (x y) (or x y))
                #f
                (map
                    (lambda (x)
                        (= 0 (remainder num x)))
                    (iota (- num 2) 2))
            )
        )
        (iota to 2)
    )
)

(show (primes 100))
|#


;;; Was ist die zwanzigste Primzahl?

(define primes-to-400 (primes 400))

(define (prime-at n)
        (filter
            (lambda (x) (= (car x) n))
            (zip (iota (length primes-to-400) 1) primes-to-400)))


(show (prime-at 20))


;;; QuickSort

;;; https://www.gnu.org/software/guile/manual/html_node/Multiple-Values.html#Multiple-Values

;;; sortiert die Liste seq aufsteigend
(define (quick-sort seq)
    (if (< (length seq) 2)
        seq
        (receive (lte gt)
            (partition
                (lambda (x) (<= x (car seq)))
                seq)
            (append (quick-sort (cdr lte)) (list (car lte)) (quick-sort gt))
        )
    )
)

(show (quick-sort (list 4 2 6 5 1)))

;;; sortiert die Liste seq
;;; Klienten muessen mit comp spezifizieren,
;;; wie die Elemente der Liste seq zu ordnen sind

;;; fuer a < b muss (comp a b) #t zueruckgeben
;;; fuer a = b muss (comp a b) #t zueruckgeben
;;; fuer a > b muss (comp a b) #f zueruckgeben

(define (quick-sort seq comp)
    (if (< (length seq) 2)
        seq
        (receive (lte gt)
            (partition
                (lambda (x) (comp x (car seq)))
                seq)
            (append (quick-sort (cdr lte) comp) (list (car lte)) (quick-sort gt comp))
        )
    )
)


(define l1 (list 7 6 8 1 6))
(define l2 (list 5 3 8 10 4 6 4 5))
(define l3 (list 5 9 15 13 14 15 7 7 8 9 10 13 9 9 15 9 11 5 15 6 14 4 4 3 14 1 8 3 12 10 2 8))

(show (quick-sort l1 (lambda (x y) (<= x y))))
(show (quick-sort l1 (lambda (x y) (>= x y))))
(show (quick-sort l2 (lambda (x y) (<= x y))))
(show (quick-sort l2 (lambda (x y) (>= x y))))
(show (quick-sort l3 (lambda (x y) (<= x y))))
(show (quick-sort l3 (lambda (x y) (>= x y))))
