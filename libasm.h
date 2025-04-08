# ifndef LIBASM_H
# define LIBASM_H
#include <unistd.h>
#include <fcntl.h>
#include <unistd.h>
#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/errno.h>
#include <sys/types.h>

typedef struct s_list{
	u_int64_t data;
	struct s_list *next;
}			t_list;


size_t		ft_strlen(const char *s);
char		*ft_strcpy(char *dst, const char *src);
int			ft_strcmp(const char *s1, const char *s2);
ssize_t		ft_write(int fd, const void *buf, size_t count);
ssize_t		ft_read(int fd, void *buf, size_t count);
char		*ft_strdup(const char *s1);
unsigned int    ft_list_size(t_list *head);
void            ft_list_push_front(t_list **head, u_int64_t data);
void			ft_list_sort(t_list **begin_list, int (*cmp)(u_int64_t, u_int64_t));
void			ft_list_sort_v2(t_list **begin_list, int (*cmp)(u_int64_t, u_int64_t));

#endif
