10 print "Starting"
100 LET totalsafe = 0
120 open "input" FOR input as #1
130 WHILE not eof(1)
140   input #1, line$
145   LET vals = 1
148   LET space$ = " "
150   FOR i = 1 TO len(line$)
160     IF MID$(line$,i,1) = space$ THEN 
170       vals = vals + 1
180     ENDIF
185   NEXT i
rem   full report variables
188   print "NEW LINE --------------------------------"
190   LET safe = 1
200   LET dir = 0
210   LET last = -1
rem   end full report variables
255   LET posis = 1
260   FOR i = 1 TO vals
270     LET nos$ = ""
275     LET no = 0
rem     loop start
280     IF (MID$(line$,posis,1) = space$ AND LEN(nos$) > 0) OR posis > LEN(line$) THEN
285       IF LEN(nos$) > 0 THEN
290         no = INT(nos$)
295       ENDIF
300     ELSE
310       nos$ = nos$ + MID$(line$,posis,1)
312       posis = posis + 1
314       GOTO 280
315     ENDIF rem loop end
316     print "ABOUT TO CHECK " + STR$(no) + " : " + STR$(i) rem no is now the number in the report
317     print "safe " + STR$(safe) + " | dir " + STR$(dir) + " | last " + STR$(last)
334     IF safe > 0 THEN
335       IF i = 1 THEN
340         print "First loop"
350       ELSE 
355       IF i = 2 AND ABS(last - no) > 0 AND ABS(last - no) < 4 THEN
360         dir = (last - no) / ABS(last - no)
370         print "Set Dir to " + STR$(dir) + " from " + STR$(last) + " and " + STR$(no) + " with diff " + STR$(last - no)
380       ELSE 
385       IF (last - no) / ABS(last - no) = dir AND ABS(last - no) > 0 AND ABS(last - no) < 4 THEN
390         print "Other Loops"
400       ELSE
410         safe = 0
420       ENDIF : ENDIF : ENDIF
425         last = no
590     ENDIF
rem     end actual stuff
600   NEXT i
650     print "safe? " + STR$(safe)
700     totalsafe = totalsafe + safe
1000 WEND
1010 print totalsafe - 1
2000 exit