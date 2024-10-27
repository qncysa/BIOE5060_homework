
fizzbuzz:
	gcc fizzbuzz.c -o fizzbuzz -g -Wall -pedantic
fizzbuzz.txt: fizzbuzz
	./fizzbuzz > fizzbuzz.txt
test: fizzbuzz.txt
	diff fizzbuzz.txt fizzbuzz_expected.txt > diff.txt
	[ -s diff.txt ] && echo "false" || echo "true"

