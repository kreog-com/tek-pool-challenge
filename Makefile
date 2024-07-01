##
## EPITECH POOL CHALLENGE, 2023
## general makefile
##

.SUFFIXES: .o

CC ?= gcc

SRC	:= $(shell find exercises -name "*.c")
TEST_SRC := $(shell find tests -name "*.c")

OBJ	:= $(SRC:.c=.o)
TEST_OBJ := $(TEST_SRC:.c=.o)

NAME := superlib.a
TEST_FILENAME := tests.out

.PHONY: all
all: $(NAME)

$(NAME): $(OBJ)
	$(AR) rc $@ $^

.PHONY: clean
clean:
	$(RM) $(OBJ) $(TEST_OBJ)

.PHONY: fclean
fclean: clean
	$(RM) $(NAME) $(TEST_FILENAME)
	$(RM) $(wildcard $(TEST_FILENAME)-*.gc??) $(TEST_SRC:.c=.gcno)

.PHONY: re
.NOTPARALLEL: re
re:	fclean all

$(TEST_FILENAME): CFLAGS += -fprofile-arcs -ftest-coverage
$(TEST_FILENAME): $(TEST_OBJ) $(SRC)
	$(CC) $(CFLAGS) -o $@ $^ -lcriterion

.PHONY: run
.NOTPARALLEL: run
run: fclean $(TEST_FILENAME)
	./$(TEST_FILENAME) --verbose

.PHONY: runc
runc: run
	gcovr -e tests
	gcovr -e tests -bu
