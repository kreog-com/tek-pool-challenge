##
## EPITECH POOL CHALLENGE, 2023
## general makefile
##

SRC	=	$(shell find exercises -name "*.c")
TEST_SRC	                           =	$(shell find tests -name "*.c")
OBJ	=	$(SRC:.c=.o)
TEST_OBJ	=	$(TEST_SRC:.c=.o)
COV		                           	                           =	 	                           ./*.gcda ./*.gcno

NAME	                           	                           	                           	=	superlib.a
TEST_FILE_NAME		                           	                           	                           =tests.out

all:	$(NAME)

$(NAME):	$(OBJ)
	ar rc $(NAME) $(OBJ)
	echo "Library compiled successfully"

clean:
	rm -f $(OBJ)
	echo "Cleaned .o"

fclean: clean
	rm -f $(NAME)
	echo "Cleaned '$(NAME)'"
	rm -f $(TEST_FILE_NAME)
	rm -f $(TEST_OBJ)
	rm -rf *.gcno *.gcda
	echo "Cleaned '$(TEST_FILE_NAME)' binary & residual files"

re:	fclean all

test: $(TEST_OBJ)
	gcc -fprofile-arcs -ftest-coverage -o $(TEST_FILE_NAME) $(TEST_OBJ) $(SRC) -lcriterion

run:	fclean test
	./$(TEST_FILE_NAME) --verbose

runc: test
	gcovr -e tests
	gcovr -e tests -bu

norm:
	./csc.sh exercises . 

.PHONY: all clean fclean re test run runc norm