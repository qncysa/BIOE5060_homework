qncysa@Quincys-MacBook-Pro ~ % cd BIOE5060Homeworks/BIOE5060_homework/HW03/Q3
qncysa@Quincys-MacBook-Pro Q3 % ./collatz
format: cmd integer
qncysa@Quincys-MacBook-Pro Q3 % ./collatz 7 
7	22	11	34	17	52	26	13	40	20	10	5	16	8	4	2	1%                              
qncysa@Quincys-MacBook-Pro Q3 % make test
diff collatz.txt collatz_expected.txt > diff.txt
[ -s diff.txt ] && echo "false" || echo "true"
true
