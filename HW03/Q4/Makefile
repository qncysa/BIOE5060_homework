BUILD_FLAG?=-g -Wall -pedantic
OBJSUFFIX:=.o

BINARY:=laplace2d_solver
FILES:=laplace2d_func laplace2d_solver

OBJS:= $(addsuffix $(OBJSUFFIX), $(FILES))


release: BUILD_FLAG=-O3
release: all

all: $(BINARY)

$(BINARY): $(OBJS)
	$(CC) $(OBJS) -o $(BINARY)

%$(OBJSUFFIX): %.c
	$(CC) $(CFLAGS) $(BUILD_FLAG) $(INCLUDEDIRS) $(CPPOPT) -c -o $@  $<

clean:  # run "make clean" to delete the output files
	rm -rf $(OBJS) $(BINARY)

.DEFAULT_GOAL := all