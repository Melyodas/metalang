#lang racket
(require racket/block)
(define last-char 0)
(define next-char (lambda () (set! last-char (read-char (current-input-port)))))
(next-char)
(define mread-int (lambda ()
  (if (eq? #\- last-char)
  (block
    (next-char) (- 0 (mread-int)))
    (letrec ([w (lambda (out)
      (if (eof-object? last-char)
        out
        (if (and last-char (>= (char->integer last-char) (char->integer #\0)) (<= (char->integer last-char) (char->integer #\9)))
          (let ([out (+ (* 10 out) (- (char->integer last-char) (char->integer #\0)))])
            (block
              (next-char)
              (w out)
          ))
        out
      )))]) (w 0)))))
(define mread-blank (lambda ()
  (if (or (eq? last-char #\NewLine) (eq? last-char #\Space) ) (block (next-char) (mread-blank)) '())
))

(struct toto ([bar #:mutable] [blah #:mutable] [foo #:mutable]))

(define (mktoto v1)
  (toto v1 v1 v1)
)

(define (mktoto2 v1)
  (toto (+ v1 2) (+ v1 1) (+ v1 3))
)

(define (result t_ t2_)
  (let ([t0 t_])
  (let ([t2 t2_])
  (let ([t3 (toto 0 0 0)])
  (let ([t3 t2])
  (let ([t0 t2])
  (let ([t2 t3])
  (block
    (set-toto-blah! t0 (+ (toto-blah t0) 1))
    (let ([len 1])
    (let ([cache0 (build-vector len (lambda (i) 
                                      (- i)))])
    (let ([cache1 (build-vector len (lambda (j) 
                                      j))])
    (let ([cache2 cache0])
    (let ([cache0 cache1])
    (let ([cache2 cache0])
    (+ (toto-foo t0) (* (toto-blah t0) (toto-bar t0)) (* (toto-bar t0) (toto-foo t0)))))))))
  )))))))
)

(define main
  (let ([t0 (mktoto 4)])
  (let ([t2 (mktoto 5)])
  ((lambda (a) 
     (block
       (set-toto-bar! t0 a)
       (mread-blank)
       ((lambda (b) 
          (block
            (set-toto-blah! t0 b)
            (mread-blank)
            ((lambda (c) 
               (block
                 (set-toto-bar! t2 c)
                 (mread-blank)
                 ((lambda (d) 
                    (block
                      (set-toto-blah! t2 d)
                      (printf "~a~a" (result t0 t2) (toto-blah t0))
                      )) (mread-int))
               )) (mread-int))
       )) (mread-int))
  )) (mread-int))))
)

