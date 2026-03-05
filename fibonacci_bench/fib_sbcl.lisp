(defun fib (n)
  (declare (optimize (speed 3) (safety 0))
           (type fixnum n))
  (if (<= n 1)
      n
      (+ (fib (- n 1)) (fib (- n 2)))))

(defun main ()
  (let* ((start-time (get-internal-real-time))
         (result (fib 41))
         (end-time (get-internal-real-time))
         (elapsed-ms (/ (* (- end-time start-time) 1000.0)
                        internal-time-units-per-second)))
    (format t "Result: ~a~%" result)
    (format t "SBCL: ~,2f ms~%" elapsed-ms))
  ;; 退出程序（用于可执行文件）
  #+sbcl (sb-ext:exit :code 0))
