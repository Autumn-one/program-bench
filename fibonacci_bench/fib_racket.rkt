#lang racket

(define (fib n)
  (if (<= n 1)
      n
      (+ (fib (- n 1)) (fib (- n 2)))))

(define (main)
  (define start-time (current-inexact-milliseconds))
  (define result (fib 41))
  (define end-time (current-inexact-milliseconds))
  (define elapsed-ms (- end-time start-time))
  
  (printf "Result: ~a\n" result)
  (printf "Racket: ~a ms\n" (~r elapsed-ms #:precision 2)))

(main)
