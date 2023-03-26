(ns hello-repl)

(defn matMake
  [rows cols val]
  (with-local-vars [result [], i 0, j 0, tmp []]
	(while (< @i rows)
	  (var-set tmp [])
	  (var-set j 0)
	  (while (< @j cols)
		(var-set tmp (conj @tmp val))
		(var-set j (inc @j)))
	  (var-set result (conj @result @tmp))
	  (var-set i (inc @i)))
	@result))

(defn vecMake
  [n val]
  (with-local-vars [result [], i 0]
	(while (< @i n)
	  (var-set result (conj @result val))
	  (var-set i (inc @i)))
	@result))

(defn matDecompose
  [matrix n lum perm result]
  (with-local-vars [tmp [], toggle 1, i 0, j 0, k 0, mx 0.0, piv 0, xij 0.0, ij 0.0, t 0.0]
	(while (< @i n)
	  (var-set j 0)
	  (var-set tmp [])
	  (while (< @j n)
		(var-set tmp (conj @tmp ((matrix @i) @j)))
		(var-set j (inc @j)))
	  (var-set lum (assoc @lum @i @tmp))
	  (var-set i (inc @i)))

	(var-set i 0)
	(var-set tmp [])
	(while (< @i n)
	  (var-set tmp (conj @tmp @i))
	  (var-set i (inc @i)))
	(var-set perm (vec @tmp))

	(var-set i 0)
	(var-set j 0)
	(while (< @j (- n 1))
	  (var-set mx (abs ((@lum @j) @j)))
	  (var-set piv @j)
	  (var-set i (inc @j))

	  (while (< @i n)
		(var-set ij (abs ((@lum @i) @j)))
		(if (> @ij @mx)
		  (do
			(var-set mx @ij)
			(var-set piv @i)
			true))

		(var-set i (inc @i)))

	  (if-not (= @piv @j)
		(do (var-set t (@lum @piv))
			(var-set lum (assoc @lum @piv (@lum @j)))
			(var-set lum (assoc @lum @j @t))

			(var-set t (@perm @piv))
			(var-set perm (assoc @perm @piv (@perm @j)))
			(var-set perm (assoc @perm @j @t))

			(var-set toggle (* -1 @toggle))
			true))

	  (var-set xij ((@lum @j) @j))
	  (if-not (= @xij 0)
		(do
		  (var-set i (inc @j))

		  (while (< @i n)
			(var-set tmp (@lum @i))
			(var-set ij (/ ((@lum @i) @j) @xij))
			(var-set tmp (assoc @tmp @j @ij))
			(var-set k (inc @j))
			(var-set lum (assoc @lum @i @tmp))

			(while (< @k n)

			  (var-set tmp (assoc @tmp @k (- (@tmp @k) (* ((@lum @j) @k) @ij))))
			  (var-set k (inc @k)))

			(var-set lum (assoc @lum @i @tmp))

			(var-set i (inc @i)))

		  true))
	  (var-set j (inc @j)))


	(var-set result @toggle)))

(defn matDeterminant
  [matrix n]
  (with-local-vars [result 0, lum (matMake n n 0.0), perm (vecMake n 0.0), i 0]
	(matDecompose matrix n lum perm result)
	(while (< @i n)
	  (var-set result (* @result ((@lum @i) @i)))
	  (var-set i (inc @i)))
	@result))

(defn myReduce
  [n lum b x]
  (with-local-vars [i 0, j 0, tmp [], sum 0.0]

	(var-set i 0)
	(var-set tmp [])
	(while (< @i n)
	  (var-set tmp (conj @tmp (@b @i)))
	  (var-set i (inc @i)))
	(var-set x (vec @tmp))

	(var-set i 1)
	(while (< @i n)
	  (var-set sum (@x @i))
	  (var-set j 0)

	  (while (< @j @i)
		(var-set sum (- @sum (* ((@lum @i) @j) (@x @j))))
		(print @sum)
		(print "\n")
		(var-set j (inc @j)))

	  (var-set x (assoc @x @i @sum))

	  (var-set i (inc @i)))
	(var-set x (assoc @x (- n 1) (/ (@x (- n 1)) ((@lum (- n 1)) (- n 1)))))

	(var-set i (- n 2))

	(while (>= @i 0)
	  (var-set sum (@x @i))
	  (var-set j (inc @i))
	  (while (< @j n)
		(var-set sum (- @sum (* ((@lum @i) @j) (@x @j))))
		(print @sum)
		(print "\n")
		(var-set j (inc @j)))
	  (var-set x (assoc @x @i (/ @sum ((@lum @i) @i))))

	  (var-set i (dec @i)))
	@x))

(defn matInverse
  [matrix n]
  (with-local-vars [result (matMake n n 0.0), lum (matMake n n 0.0), perm (vecMake n 0.0), i 0, j 0, tmp [], det 0.0, b (vecMake n 0.0), x (vecMake n 0.0)]

	(while (< @i n)
	  (var-set j 0)
	  (var-set tmp [])
	  (while (< @j n)
		(var-set tmp (conj @tmp ((matrix @i) @j)))
		(var-set j (inc @j)))
	  (var-set result (assoc @result @i @tmp))
	  (var-set i (inc @i)))

	(matDecompose matrix n lum perm det)

	(var-set i 0)
	(while (< @i n)
	  (var-set j 0)
	  (while (< @j n)
		(if (= @i (@perm @j))
		  (var-set b (assoc @b @j 1.0))
		  (var-set b (assoc @b @j 0.0)))
		(var-set j (inc @j)))

	  (myReduce n lum b x)

	  (var-set j 0)
	  (while (< @j n)
		(var-set tmp (@result @j))
		(var-set tmp (assoc @tmp @i (@x @j)))
		(var-set result (assoc @result @j @tmp))
		(var-set j (inc @j)))

	  (var-set i (inc @i)))


	@result))

;; (matDeterminant [[1.0 2.0] [3.0 4.0]] 2)
;; (matDeterminant [[1.0 2.0 3.0] [4.0 5.0 6.0] [7.0 8.0 9.0]] 3)
;; (matInverse [[1.0 2.0] [3.0 4.0]] 2)
;; (matInverse [[3.0 7.0 2.0 5.0] [4.0 0.0 1.0 1.0] [1.0 6.0 3.0 0.0] [2.0 8.0 4.0 3.0]] 4)