(defun first-be-even (x)
    (if (evenp x)
        x
        (+ x 1)))

(defun same-sign-bigger-abs (x)
    (if (> x 0)
        (+ x 1)
        (- x 1)))

(defun sorted-list (x y)
    (if (x > y)
        (list x y)
        (list y x)))

(defun sorted-list (x y)
    (list (min x y) (max x y)))

(defun x-from-y-to-z (x y z)
    (and (< y x) (< x z)))

(and 'fee 'fie 'foe) ; foe
(or nil 'fie 'foe) ; fie
(and (equal 'abc 'abc) 'yes) ; yes
(or 'fee 'fie 'foe) ; fee
(and nil 'fie 'foe) ; nil
(or (equal 'abc 'abc) 'yes) ; T

(defun bigger-or-equal-p (x y)
    (>= x y))

(defun pred1 (x)
    (and (numberp x) (plusp x)))

(defun pred2 (x)
    (and (plusp x)(numberp x)))

(defun x-from-y-to-z (x y z)
    (if (< y x)
        (if (< x z)
            T
            Nil)
        Nil))

(defun x-from-y-to-z (x y z)
    (cond ((< y x) (cond ((< x z) T) (T Nil))) (T Nil)))

(defun x-from-y-to-z (x y z)
    (and (< y x) (< x z)))

(defun how_alike (x y)
    (cond ((or (= x y) (equal x y)) 'the_same)
        ((and (oddp x) (oddp y)) 'both_odd)
        ((and (evenp x) (evenp y)) 'both_even)
        (T 'difference)
))

(defun how_alike (x y)
    (if (if (= x y)
            (equal x y))
        'the_same
        (if (if (oddp x)
            (oddp y))
        'both_odd
        (if (if (evenp x)
            (evenp y))
        'both_even
        'difference
))))

(defun how_alike (x y)
    (or
        (and (= x y) (equal x y) 'the_same)
        (and (oddp x) (oddp y) 'both_odd)
        (and (evenp x) (evenp y) 'both_even)
        'difference
))
