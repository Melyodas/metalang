#lang racket
(require racket/block)

(define main
  (let ([input #\Space])
  (let ([current_pos 500])
  (let ([mem0 (build-vector 1000 (lambda (i) 
                                   0))])
  (block
    (vector-set! mem0 current_pos (+ (vector-ref mem0 current_pos) 1))
    (vector-set! mem0 current_pos (+ (vector-ref mem0 current_pos) 1))
    (vector-set! mem0 current_pos (+ (vector-ref mem0 current_pos) 1))
    (vector-set! mem0 current_pos (+ (vector-ref mem0 current_pos) 1))
    (vector-set! mem0 current_pos (+ (vector-ref mem0 current_pos) 1))
    (vector-set! mem0 current_pos (+ (vector-ref mem0 current_pos) 1))
    (vector-set! mem0 current_pos (+ (vector-ref mem0 current_pos) 1))
    (vector-set! mem0 current_pos (+ (vector-ref mem0 current_pos) 1))
    (vector-set! mem0 current_pos (+ (vector-ref mem0 current_pos) 1))
    (vector-set! mem0 current_pos (+ (vector-ref mem0 current_pos) 1))
    (vector-set! mem0 current_pos (+ (vector-ref mem0 current_pos) 1))
    (vector-set! mem0 current_pos (+ (vector-ref mem0 current_pos) 1))
    (vector-set! mem0 current_pos (+ (vector-ref mem0 current_pos) 1))
    (vector-set! mem0 current_pos (+ (vector-ref mem0 current_pos) 1))
    (vector-set! mem0 current_pos (+ (vector-ref mem0 current_pos) 1))
    (vector-set! mem0 current_pos (+ (vector-ref mem0 current_pos) 1))
    (vector-set! mem0 current_pos (+ (vector-ref mem0 current_pos) 1))
    (vector-set! mem0 current_pos (+ (vector-ref mem0 current_pos) 1))
    (vector-set! mem0 current_pos (+ (vector-ref mem0 current_pos) 1))
    (vector-set! mem0 current_pos (+ (vector-ref mem0 current_pos) 1))
    (vector-set! mem0 current_pos (+ (vector-ref mem0 current_pos) 1))
    (vector-set! mem0 current_pos (+ (vector-ref mem0 current_pos) 1))
    (vector-set! mem0 current_pos (+ (vector-ref mem0 current_pos) 1))
    (vector-set! mem0 current_pos (+ (vector-ref mem0 current_pos) 1))
    (vector-set! mem0 current_pos (+ (vector-ref mem0 current_pos) 1))
    (vector-set! mem0 current_pos (+ (vector-ref mem0 current_pos) 1))
    (vector-set! mem0 current_pos (+ (vector-ref mem0 current_pos) 1))
    (vector-set! mem0 current_pos (+ (vector-ref mem0 current_pos) 1))
    (vector-set! mem0 current_pos (+ (vector-ref mem0 current_pos) 1))
    (vector-set! mem0 current_pos (+ (vector-ref mem0 current_pos) 1))
    (vector-set! mem0 current_pos (+ (vector-ref mem0 current_pos) 1))
    (vector-set! mem0 current_pos (+ (vector-ref mem0 current_pos) 1))
    (vector-set! mem0 current_pos (+ (vector-ref mem0 current_pos) 1))
    (vector-set! mem0 current_pos (+ (vector-ref mem0 current_pos) 1))
    (vector-set! mem0 current_pos (+ (vector-ref mem0 current_pos) 1))
    (vector-set! mem0 current_pos (+ (vector-ref mem0 current_pos) 1))
    (vector-set! mem0 current_pos (+ (vector-ref mem0 current_pos) 1))
    (vector-set! mem0 current_pos (+ (vector-ref mem0 current_pos) 1))
    (vector-set! mem0 current_pos (+ (vector-ref mem0 current_pos) 1))
    (vector-set! mem0 current_pos (+ (vector-ref mem0 current_pos) 1))
    (vector-set! mem0 current_pos (+ (vector-ref mem0 current_pos) 1))
    (vector-set! mem0 current_pos (+ (vector-ref mem0 current_pos) 1))
    (vector-set! mem0 current_pos (+ (vector-ref mem0 current_pos) 1))
    (vector-set! mem0 current_pos (+ (vector-ref mem0 current_pos) 1))
    (vector-set! mem0 current_pos (+ (vector-ref mem0 current_pos) 1))
    (vector-set! mem0 current_pos (+ (vector-ref mem0 current_pos) 1))
    (vector-set! mem0 current_pos (+ (vector-ref mem0 current_pos) 1))
    (let ([current_pos (+ current_pos 1)])
    (block
      (vector-set! mem0 current_pos (+ (vector-ref mem0 current_pos) 1))
      (vector-set! mem0 current_pos (+ (vector-ref mem0 current_pos) 1))
      (vector-set! mem0 current_pos (+ (vector-ref mem0 current_pos) 1))
      (vector-set! mem0 current_pos (+ (vector-ref mem0 current_pos) 1))
      (vector-set! mem0 current_pos (+ (vector-ref mem0 current_pos) 1))
      (vector-set! mem0 current_pos (+ (vector-ref mem0 current_pos) 1))
      (vector-set! mem0 current_pos (+ (vector-ref mem0 current_pos) 1))
      (vector-set! mem0 current_pos (+ (vector-ref mem0 current_pos) 1))
      (vector-set! mem0 current_pos (+ (vector-ref mem0 current_pos) 1))
      (vector-set! mem0 current_pos (+ (vector-ref mem0 current_pos) 1))
      (letrec ([a (lambda (current_pos) (if (not (eq? (vector-ref mem0 current_pos) 0))
                                        (block
                                          (vector-set! mem0 current_pos (- (vector-ref mem0 current_pos) 1))
                                          (let ([current_pos (- current_pos 1)])
                                          (block
                                            (vector-set! mem0 current_pos (+ (vector-ref mem0 current_pos) 1))
                                            (display (integer->char (vector-ref mem0 current_pos)))
                                            (let ([current_pos (+ current_pos 1)])
                                            (a current_pos))
                                            ))
                                          )
                                        '()))])
        (a current_pos))
      ))
    ))))
)

