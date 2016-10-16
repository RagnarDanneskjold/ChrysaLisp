(defmacro defun (n a b)
	`(def (,n)
		((lambda ,a ,b))))
(defmacro defvar (n b)
	`(def (,n)
		(,b)))
(defmacro setvar (n b)
	`(set (,n)
		(,b)))
(defmacro setlvar (n b)
	`(setl (,n)
		(,b)))

(defun gte (x y)
	(not (lt x y)))
(defun lte (x y)
	(or (lt x y) (eq x y)))
(defun gt (x y)
	(not (or (lt x y) (eq x y))))

(defun eql (x y)
	(eq (str x) (str y)))

(defun zip1 (a)
 	(map list a))
(defun zip2 (a b)
 	(map list a b))
(defun zip3 (a b c)
 	(map list a b c))
(defun zip4 (a b c d)
 	(map list a b c d))

(defun merge2 (a b)
	(reduce cat (zip2 a b)))
(defun merge3 (a b c)
	(reduce cat (zip3 a b c)))
(defun merge4 (a b c d)
	(reduce cat (zip4 a b c d)))

(defun squared (x)
	(mul x x))
(defun cubed (x)
	(mul x x x))
(defun divmod (x y)
	(list (div x y) (mod x y)))

(defun print_map (m)
	(progn
		(map print m)
		t))

(defun print_env (l e)
	(progn
		(print "**" l "**")
		(map print_map e)
		t))

(defun prin_num (n p c)
	(progn
		(def (s) ((str n)))
		(def (l) ((length s)))
		(while (lt l p)
			(prin c)
			(setl (l) ((add l 1))))
		(prin s)))

(defun fq (x y)
	(mod (mul (cubed x) (squared y)) 10))

(defun fxy (f w h)
	(progn
		(def (x y) (1 1))
		(until (lt h y)
			(setl (x) (1))
			(until (lt w x)
				(prin_num (f x y) 4 ".")
				(setl (x) ((add x 1))))
			(setl (y) ((add y 1)))
			(print))))

(defun repeat_fxy (l)
	(progn
		(def (c) (0))
		(while (lt c l)
			(fxy fq 10 20)
			(setl (c) ((add c 1))))))

(defmacro for (s e i b)
	(progn
		(def (_l _e _i) ((gensym) e i))
		`(progn
			(defvar ,_l ,s)
			(while (lt ,_l ,_e)
				,b
				(setlvar ,_l (add ,_l ,_i))))))
