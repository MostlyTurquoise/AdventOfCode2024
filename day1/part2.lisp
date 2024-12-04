(require "asdf")
(defun splitandparse 
    (s)
    (
list
        (parse-integer 
            (first 
                (uiop:split-string s :separator "   ")))
        (parse-integer 
            (nth 3 
                (uiop:split-string s :separator "   ")))

)
)
(defparameter *rlfreq* 
    (make-hash-table))
(defun mbhashfreq
    (v)
    (* v 
        (gethash v *rlfreq*))
)
(defun print-hash-entry 
    (key value)
    (format t "The value associated with the key ~S is ~S~%" key value))
(format t "~A" 
    (let 
        (
            (z 
                (mapcar #'splitandparse 
                    (uiop:split-string 
                        (uiop:read-file-string 
                            (merge-pathnames "input.txt" 
                                (uiop/os:getcwd))) :separator uiop:+lf+
))))

        (let* 
            (
                (tls 
                    (list
                        (loop :for x :in z :collect 
                            (first x))

                        (loop :for x :in z :collect 
                            (second x)))) 
                (ll 
                    (first tls)) 
                (rl 
                    (second tls))) 
            (progn 
                (loop :for x :in ll :do 
                    (setf 
                        (gethash x *rlfreq*) 0)) 
                (loop :for x :in rl :do 
                    (setf 
                        (gethash x *rlfreq*) 0))
                (loop :for x :in rl :do 
                    (setf 
                        (gethash x *rlfreq*) 
                        (+ 
                            (gethash x *rlfreq*) 1)))
                ;; (maphash #'print-hash-entry *rlfreq*)
                (apply '+ 
                    (mapcar #'mbhashfreq ll))
))
)
)