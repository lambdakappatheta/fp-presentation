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


#| ================ ================ ================ Teil 3 ================ ================ ================ |#
#| ================ ================ ======== higher order functions ======== ================ ================ |#


#| ---- ---- ---- ---- higher order functions ---- ---- ---- ---- |#


;;; https://www.gnu.org/software/mit-scheme/documentation/mit-scheme-ref/Reduction-of-Lists.html

;;; accumulate ist eine sehr nuetzliche Funktion und
;;; wird deshalb von der "Standardbibliothek" bereitgestellt

;;; Sie kommt in verschiedenen Varianten, wie zum Beispiel:
;;; fold-right
;;; fold-left

;;; fold-right entspricht unserer (accumulate op initial l)
(show (fold-right - 0 (list 1 3 7)))

;;; (- 1 (- 3 (- 7 0)))
;;; (1 - (3 - (7 - 0)))

;;; fold-left startet mit dem initialen Wert
;;; und arbeitet die Liste von links nach rechts ab
(show (fold-left - 0 (list 1 3 7)))

;;; (- (- (- 0 1) 3) 7)
;;; (((0 - 1) - 3) - 7)


;;; Bemekrung:
;;; fold-right generiert einen rekursiven Prozess
;;; fold-left generiert einen iterativen Prozessen


#| !!!!!!!! !!!!!!!! !!!!!!!! !!!!!!!! !!!!!!!! !!!!!!!! !!!!!!!! !!!!!!!! !!!!!!!! !!!!!!!! |#

;;; Funktionen wie fold-right und fold-left sind extrem nuetzlich in mehrfacher hinsicht:

;;; Man kann Rekursion "wegabstrahieren"

;;; Durch Kombination (Schachtelung) von solchen Funktionen,
;;; kann man komplexe Algorithmen elegant implementieren

;;; Was vs Wie
;;; Man beschreibt, was man gerne haette und nicht, wie das gemacht werden sollte

;;; Die C++ Standardbibliothek <algorithm> implementiert ungefaeher 100 solche Funktionen
;;; Folgende Aussagen habe ich schon mehrmals gehoert:
;;; - Wenn man <algorithm> nutzt, bracht man nie For-Schleifen mehr
;;; - Jedes Mal, wenn man eine For-Schleife schreibt, sollte man sich ueberlegen,
;;;   ob es durch einen geeigneten Algorithmus aus <algorithm> ersetzt werden koennte
;;; - Code, der <algorithm> extensiv benutzt, ist
;;;     lesbarer,
;;;     einfacher zu warten,
;;;     enthaelt weniger Fehler und
;;;     ist performanter.

;;; Man kann in jeder Sprache funktional programmieren
;;; Viele beliebte Sprachen
;;; wie C++, C#, Python, JavaScript oder Rust
;;; unterstuetzen den funktionalen Stil ziemlich gut!

;;; Laut Wikipedia wird der funktionale Stil seit Version 8 auch in Java unterstuetzt


#| !!!!!!!! !!!!!!!! !!!!!!!! !!!!!!!! !!!!!!!! !!!!!!!! !!!!!!!! !!!!!!!! !!!!!!!! !!!!!!!! |#

;;; Lass uns noch weitere uebliche higher order functions kennenlernen

#| ---- ---- ---- ---- map ---- ---- ---- ---- |#
;;; https://www.gnu.org/software/mit-scheme/documentation/mit-scheme-ref/Mapping-of-Lists.html

;;; map wendet ihr erstes Argument (eine Funktion) auf jedes Element ihres zweitne Arguments (eine Liste) an

;;; Terminologie:
;;; Man sagt im Kontext der funktionalen Programmierung,
;;; dass man eine Funktion auf ein Argument anwendet
;;; "die Funktion (square x) auf die Zahl 5 anzuwenden"

;;; Das ist quasi wie eine Funktion mit ein Argument aufrufen
;;; "die Funktion (square x) mit der Zahl 5 als Argument aufrufen"

(define (square x) (* x x))

(show (map square (list 1 2 3 4 5 6 7)))


;;; Lass uns map selber implementieren

(define (my-map fun list)
    (if (null? list)
        ()
        (cons (fun (car list)) (my-map fun (cdr list)))))

(show (my-map square (list 1 2 3 4 5 6 7)))


;;; es gibt uebrigens eine hilfreiche Funktion,
;;; die uns die konstruktion einer Liste erleichtert

;;; https://www.gnu.org/software/guile/manual/html_node/SRFI_002d1-Constructors.html

;;; iota count [start step]
;;; Return a list containing count numbers, starting from start and adding step each time.
;;;The default start is 0,
;;; the default step is 1.

(show (iota 8 1))

(show (my-map square (iota 21 -10)))


#| ---- ---- ---- ---- filter ---- ---- ---- ---- |#
;;; https://www.gnu.org/software/mit-scheme/documentation/mit-scheme-ref/Filtering-Lists.html

;;; filter predicate list

(show (filter odd? (iota 5 1)))

(show (filter odd? (list 1 2 3 4 5 1 2 3 4 5)))

(show (filter odd? (list 1 1 2 2 3 3 4 4 5 5)))

(define (eq2 x) (= 2 x))
(show (map eq2 (iota 4 0)))

(show (filter eq2 (list 4 3 2 1 2 3 4 )))

;;; Das ist aber nervig!
;;; Immer eine neue Funktion definieren zu muessen,
;;; auch wenn man sie nur temporaer braucht


#| ---- ---- ---- ---- lambdas ---- ---- ---- ---- |#

;;; Zum Glueck gibt es Lambda-Ausdruecke!

;;; Lambda-Ausdruecke sind unbenannte Funktionen
;;; Sie sind folgendermassen aufgebaut
;;; (lambda (⟨formal-parameters⟩) ⟨body⟩)

;;; wie zum Beispiel
;;; (lambda (x) (= 2 x))

(show ((lambda (x) (= 2 x)) 1))
(show ((lambda (x) (= 2 x)) 2))

;;; Lambda-Ausdruecke koennen bei Bedarf auch benannt werden
(define eq2-lambda (lambda (x) (= 2 x)))

(show (eq2-lambda 1))
(show (eq2-lambda 2))

;;; Nun koennen den Ausdruck
;;; (filter eq2 (list 4 3 2 1 2 3 4 ))
;;; folgendermassen umschreiben

(show (filter (lambda (x) (= 2 x)) (list 4 3 2 1 2 3 4 )))


#| ---- ---- ---- ---- zip ---- ---- ---- ---- |#

(define letters (list 'a 'b 'c 'd 'e 'f))
(show (zip (iota (length letters)) letters))

;;; Mit zip kann man die Elemente einer Liste indexieren
