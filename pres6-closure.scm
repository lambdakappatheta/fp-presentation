;;; cd Seafile/Studium/WiSe1920/Programmierparadigmen/Presentation

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


#| ================ ================ ================ Teil 6 ================ ================ ================ |#
#| ================ ================ =============== closure ================ ================ ================ |#


#| ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ----|#
;;; Lambda-Ausdruecke
(display "Lambda-Ausdruecke\n")

;;; Ein Lamba-Ausdruck ist, wie der Name schon sagt, ein Ausdruck.
;;; Die Aufgabe eines Interpreters ist Ausdruecke auszuwerten.
;;; Dementsprechend wird vom Interpreter auch ein Lambda-Ausdruck ausgewertet.
;;; Das Resultat der Auswertung ist eine Pozedur.


;;; Was wir bereits von Prozeduren wissen:

;;; (cube x) ist eine benannte Prozedur mit einem Parameter ⟨x⟩
(define (cube x) (* x x x))

;;; Ruft man (cube x) mit der richtigen Anzahl von Argumenten auf,
;;; werden in dem Koerper der Prozedur 
;;; die formalen Parameter der Prozedur durch die Argumente ersetzt.
(cube 3)
(show (cube 3))


;;; unbenannte Prozeduren

;;; (lambda (x) (* x x x)) ist eine unbenannte Prozedur
(lambda (x) (* x x x))

;;; Wie schon erwaehnt,
;;; erzeugt die Auswertung dieses Ausdrucks eine Prozedur
(show (lambda (x) (* x x x)))

;;; Aber ein einsamer Lambda-Ausdruck macht genau so wenig Sinnn,
;;; wie zum Beispiel die folgende Zeile in C
;;; 4;
;;; oder
;;; 4 + 3;
;;; Das Ergebnis kann quasi sofort verschwinden,
;;; wenn sie keiner Variablen zugewiesen wird.

;;; Damit der Lambda-Ausdruck etwas sinnvolles macht,
;;; koennen wir die Prozedur, zu der sie evaluiert, aufrufen.

;;; Der Aufruf von benannten und unbenannten Prozeduren folgt dem gleichen Muster
;;; (⟨name⟩ ⟨args⟩) 
(show (cube 3))
;;; wobei bei unbenannten Prozeduren,
;;; der komplette Lambda-Ausdruck als Name benutzt wird.
(show ((lambda (x) (* x x x)) 3))



#| ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ----|#
;;; Prozeduren als first-class citizens
(display "\nProzeduren als first-class citizens\n")

;;; Wie haben schon gesehen, 
;;; dass Prozeduren einer anderen Prozedur als Argument uebergeben werden koennen.

(show (map (lambda (x) (* x x)) (iota 6)))


;;; Aber prozeduren koennen auch einer Variablen zugewiesen werden 

(define plus4 
    (lambda (x) (+ x 4)))

(show (plus4 17))


;;; Oder der Rueckgabewert einer Prozedur sein

(define (plus x)  
    (lambda (y) (+ x y)))

(show ((plus 4) 10))


;;; Man koennte auf die Idee kommen, 
;;; eine Reihe von Variablen zu erzugen,
;;; derer Werte jeweils eine Prozedur sind.

(define p1 (plus 1))
(define p2 (plus 2))
(define p3 (plus 3))

(show (p1 7))
(show (p2 7))
(show (p3 7))


;;; Was passiert hier eigenltich?

;;; p1 steht quasi fuer: 
;;; (lambda (y) (+ 1 y))
;;; p2 fuer: 
;;; (lambda (y) (+ 2 y))
;;; p3 fuer: 
;;; (lambda (y) (+ 3 y))

;;; aslo
;;; (p1 7) steht fuer:
(show ((lambda (y) (+ 1 y)) 7))
;;; (p2 7) steht fuer:
(show ((lambda (y) (+ 2 y)) 7))
;;; (p3 7) steht fuer:
(show ((lambda (y) (+ 3 y)) 7))


;;; Um ueber dieses Phaenomen reden zu koennen
;;; muessen wir etwas Terminologie einfuehren.

;;; Bei der Definition einer Prozedur 
;;; stehen in dem Koerper der Prozedur Variablen

;;; Eine solche Variable heisst gebunden, 
;;; wenn sie fuer einen der Paramater der Prozedur steht

;;; Sonst nennt man die Variable eine freie Variable

;;; In dem Koerper der Prozedur (f x) in
;;; (define (f x) (+ x y z))
;;; ist x eine gebudene Variable
;;; y und z sind freie Variablen

;;; Wenn eine Prozedur mit ihren Argumenten aufgerufen wird,
;;; werden die Werte der Argumente den gebundenen Variablen zugewiesen

;;; Die freien Variablen erhalten ihren Wert aus der Umgebung

(define a 100)
(define (fun b) (+ a b))

(show (fun 4))

;;; + in (+ a b) ist uebrigens auch eine freie Variable
;;; sie wird aber von der "Standardbibliothek" definiert.


;;; Das kennt man uebrigens schon aus C

;;; Um die Funktion qsort nutzen zu koennen, 
;;; muss sie zunaechst mit 
;;; #include <stdlib.h>
;;; importiert werden.

;;; Sonst ist qsort eine freie Variable, 
;;; die ihren Wert aus der Umgebung erhalten sollte,
;;; wo sie aber nicht definiert ist.


;;; Man kann uebrignes die innere Prozedur auch benennen
;;; wenn die aussere Variable eine Prozedur definiert

;;; Analog zu
#|
(define (plus x)  
    (lambda (y) (+ x y)))
|#
;;; kann man statt des Lambda-Ausdrucks auch 
;;; eine benannte Funktion verwenden  

(define (minus x) 
    (define (f y) (- x y))
    f)

(show ((minus 5) 1))


#|
(define plus4 
    (lambda (x) (+ x 4)))
|#

;;; das geht nicht, weil minus4 keine Prozedur ist

#|
(define minus4
    (define (f x) (- x 4)))

(show minus6)
|#

;;; aber als Prozedur schon

(define (minus4) 
    (define (f x) (- x 4))
    f)

(show ((minus4) 14))



#| ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ----|#
;;; Objekte


;;; Paare:
(display "\nPaare\n")

;;; Wir wollen die schon existierende Funktionen
;;; (cons a b)
;;; (car p)
;;; (cdr p)
;;; nachbauen.

;;; Wir werden sie 
;;; (make-pair a b)
;;; (fst p)
;;; (snd p)
;;; nennen.

(define (make-pair a b)
    (lambda (x)
        (cond 
            ((= x 0) a)
            ((= x 1) b)
            (else 'error))))

(define (fst p) (p 0))
(define (snd p) (p 1))


(define p1 (make-pair 4 7))
(define p2 (make-pair 14 17))

(show (fst p1))
(show (snd p1))

(show (fst p2))
(show (snd p2))


;;; Bankkonten:
(display "\nBankkonten\n")

(define (make-account balance)
    (define (withdraw amount)
        (if (>= balance amount)
            (begin (set! balance (- balance amount))
                    balance)
                    "Insufficient funds"))
    (define (deposit amount)
        (set! balance (+ balance amount))
    balance)
    (define (dispatch m)
        (cond 
            ((eq? m 'withdraw) withdraw)
            ((eq? m 'deposit) deposit)
            (else (error "Unknown request: MAKE-ACCOUNT" m))))
    dispatch)


(define acc (make-account 100))
(define acc2 (make-account 100))

(show ((acc 'withdraw) 50))
(show ((acc 'withdraw) 60))
(show ((acc 'deposit) 40))
(show ((acc 'withdraw) 60))


(show ((acc2 'withdraw) 10))
(show ((acc2 'withdraw) 40))
(show ((acc2 'deposit) 200))
(show ((acc2 'withdraw) 60))