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
(defun absdiff
    (l)
    (
let
        ((sd 
            (- 
                (first l) 
                (second l)
            )
        ))
        (if 
            (> 0 sd) 
            (* -1 sd) 
            (* 1 sd))
)
)
(format t "~A" 
    (let 
        (
            (z 
                (mapcar #'splitandparse 
                    (uiop:split-string 
                        (uiop:read-file-string 
                            (merge-pathnames "input" 
                                (uiop/os:getcwd))) :separator uiop:+lf+
))))        
        (apply '+ (mapcar #'absdiff 
            (mapcar #'list 
                (sort 
                    (loop :for x :in z :collect 
                        (first x)) '<) 
                (sort 
                    (loop :for x :in z :collect 
                        (second x)) '<))))
)
)