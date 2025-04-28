NAME=libasm.a
NASM=nasm -f elf64 -g
CC=gcc

SFILE=ft_strdup.s ft_strlen.s ft_strcpy.s ft_strcmp.s ft_write.s ft_read.s ft_list_size.s ft_list_sort.s ft_list_push_front.s ft_list_sort_v2.s ft_list_remove_if.s ft_atoi_base.s
OFILE=$(SFILE:.s=.o)

all: $(NAME)

$(NAME): $(OFILE)
	echo $(OFILE)
	ar rcs $(NAME) $(OFILE)

test: $(NAME)
	$(CC) main.c -g -L ./ -I ./ -lasm -o test

%.o: %.s
	$(NASM) $<

clean:
	rm -rf *.o

fclean:
	rm -rf *.o
	rm -rf test
	rm -rf libasm.a

re: fclean all

.PHONY:
	all re fclean clean test
