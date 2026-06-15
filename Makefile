NAME = libasm.a

SRCS =	ft_write.s \
		ft_read.s \
		ft_strcmp.s \
		ft_strcpy.s \
		ft_strdup.s \
		ft_strlen.s

CC = gcc
CFLAGS = -Wall -Wextra -Werror
NASM = nasm
NASMFLAGS = -f elf64

OBJ = $(SRCS:.s=.o)

all: $(NAME)

$(NAME): $(OBJ)
	ar rcs $(NAME) $(OBJ)
	ranlib $(NAME)

%.o: %.s
	$(NASM) $(NASMFLAGS) $< -o $@

test: $(NAME)
	$(CC) $(CFLAGS) main.c $(NAME) -o test
	./test

clean:
	rm -f $(OBJ)

fclean: clean
	rm -f $(NAME) test

re: fclean all

.PHONY: all test clean fclean re
