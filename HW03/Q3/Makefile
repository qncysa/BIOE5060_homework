
collatz:
	gcc collatz.c -o collatz -g -Wall -pedantic
collatz.txt: collatz
	./collatz 7 > collatz.txt
test: collatz.txt
	diff collatz.txt collatz_expected.txt > diff.txt
	[ -s diff.txt ] && echo "false" || echo "true"
clean:
	rm -rf collatz.txt collatz
