
forloop:
	gcc forloop.c -o forloop -g -Wall -pedantic
whileloop:
	gcc whileloop.c -o whileloop -g -Wall -pedantic


for.txt: forloop
	./forloop > for.txt

while.txt: whileloop
	./whileloop > while.txt

test: for.txt while.txt
	diff for.txt while.txt > diff.txt
	[ -s diff.txt ] && echo "false" || echo "true"


