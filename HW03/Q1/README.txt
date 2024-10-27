qncysa@Quincys-MacBook-Pro Q1 % ./forloop
a=-20	b=-30
a=-19	b=-28
a=-18	b=-26
a=-17	b=-24
a=-16	b=-22
a=-15	b=-20
a=-14	b=-18
a=-13	b=-16
a=-12	b=-14
a=-11	b=-12
a=-10	b=-10
qncysa@Quincys-MacBook-Pro Q1 % ./whileloop
a=-20	b=-30
a=-19	b=-28
a=-18	b=-26
a=-17	b=-24
a=-16	b=-22
a=-15	b=-20
a=-14	b=-18
a=-13	b=-16
a=-12	b=-14
a=-11	b=-12
a=-10	b=-10
qncysa@Quincys-MacBook-Pro Q1 % make test
diff for.txt while.txt > diff.txt
[ -s diff.txt ] && echo "false" || echo "true"
true
