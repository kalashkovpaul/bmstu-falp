(defvar *slist* '(1 2 3 4 5))

(defun hyp (x y)
  (sqrt (+ (* x x) (* y y))))

(list 'a c) ; unbound variable c, solution - (list 'a 'c)
(cons 'a (b c)) ; unbound variable (b c), solution:
(cons 'a '(b c))
(caddr (1 2 3 4 5)) ; illegal function call, solution - (caddr '(1 2 3 4 5))
(cons 'a 'b 'c) ; invalid number of arguments: 3, solution -  (cons 'a (cons'b 'c))
(list 'a (b c)) ; unbound variable b, solution - (list 'a '(b c))
(list a '(b c)) ; unbound variable a, solution - (list 'a '(b c))
(list (+ 1 '(length '(1 2 3)))) ; type error, solution - (list (+ 1 (length '(1 2 3))))

(defun longer_then (x y)
  (> (length a) (length b)))

(cons 3 (list 5 6)) ; (3 5 6)
(list 3 'from 9 'lives (- 9 3)) ; (3 from 9 lives 6)
;(+ (length for 2 too)) (car '(21 22 23)))
(+ (length '(for 2 too)) (car '(21 22 23))) ; 24
(cdr '(cons is short for ans)) ; (is short for ans)
(car (list one two)) ; unbound variable one
(cons 3 '(list 5 6)) ; (3 list 5 6)
(car (list 'one 'two)) ; one

(defun mystery (x) (list (second x) (first x)))

;(mystery (one two)) ; variable one is unbound
(mystery '(one two)) ; (two one)
; (mystery (last one two)) ; variable one is unbound
(mystery (last '(one two))) ; (nil two)
; (mystery free) ; variable free is unbound
(mystery 'free) ; the value free is not of type list
; (mystery one 'two)) ; variable one is unbound
(mystery 'one 'two)) ; invalid number of arguments

(defun f_to_c (f)
  (* (/ 5 9) (- f 32.0)))

(f_to_c 451)

(list 'cons t NIL) ; (cons t nill)
(eval (eval (list 'cons t NIL))) ; The function COMMON-LISP:T is undefined.
(apply #'cons '(t NIL)) (T) ; (T)
(list 'eval NIL) ; (eval NIL)
(eval (list 'cons t NIL)) ; (T)
(eval NIL) ; (NIL)
(eval (list 'eval NIL)) ; NIL

