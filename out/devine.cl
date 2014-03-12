
(si::use-fast-links nil)

(defun array_init (len fun)
  (let ((out (make-array len)) (i 0))
    (while (not (= i len))
           (progn
             (setf (aref out i) (funcall fun i))
             (setq i (+ 1 i ))
             )
           )
    out
    ))

(let ((last-char 0)))
(defun next-char () (setq last-char (read-char *standard-input* nil)))
(next-char)


(defun quotient (a b) (truncate a b))
(defun not-equal (a b) (not (eq a b)))

(defun mread-char ()
  (let (( out last-char))
    (progn
      (next-char)
      out
    )))

(defun mread-int ()
  (if (eq #\- last-char)
  (progn (next-char) (- 0 (mread-int)))
  (let ((out 0))
    (progn
      (while (and last-char (>= (char-int last-char) (char-int #\0)) (<= (char-int last-char) (char-int #\9)))
        (progn
          (setq out (+ (* 10 out) (- (char-int last-char) (char-int #\0))))
          (next-char)
        )
      )
      out
    ))))

(defun mread-blank () (progn
  (while (or (eq last-char #\NewLine) (eq last-char #\Space) ) (next-char))
))



(defun devine_ (nombre tab len)
(progn
  (let ((min_ (aref tab 0)))
    (let ((max_ (aref tab 1)))
      (do
        ((i 2 (+ 1 i)))
        ((> i (- len 1)))
        (progn
          (if
            (or
            (>
            (aref tab i)
            max_)
            (<
            (aref tab i)
            min_))
            (progn
              (return-from devine_ nil)
            ))
          (if
            (<
            (aref tab i)
            nombre)
            (progn
              (setq min_ (aref tab i))
            ))
          (if
            (>
            (aref tab i)
            nombre)
            (progn
              (setq max_ (aref tab i))
            ))
          (if
            (and
            (eq
            (aref tab i)
            nombre)
            (not-equal
            len
            (+
            i
            1)))
            (progn
              (return-from devine_ nil)
            ))
        )
      )
      (return-from devine_ t)
    ))))

(progn
  (let ((nombre (mread-int )))
    (mread-blank)
    (let ((len (mread-int )))
      (mread-blank)
      (let
       ((tab (array_init
                len
                (function (lambda (i)
                (block lambda_1
                  (let ((tmp (mread-int )))
                    (mread-blank)
                    (return-from lambda_1 tmp)
                  )))
                ))))
      (let ((a (devine_ nombre tab len)))
        (if
          a
          (progn
            (princ "True")
          )
          (progn
            (princ "False")
          ))
      )))))
