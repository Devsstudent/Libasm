#include <stdlib.h>
#include "libasm.h"


void putnbr(int n) {
    if (n < 0) {
        putchar('-');
        n = -n;
    }
    if (n >= 10) {
        putnbr(n / 10);
    }
    putchar('0' + n % 10);
}

int wrap_strcmp(u_int64_t s1, u_int64_t s2) {

  const char *str1 = (const char *)s1;
  const char *str2 = (const char *)s2;

  int result = strcmp(str1, str2);
	return (result);
}

int main(void){
	t_list *head;
	t_list elem;
	elem.next = NULL;
	elem.data = (u_int64_t)strdup("Z");
	head = &elem;
	ft_list_push_front(&head, (u_int64_t)strdup("A"));
	ft_list_push_front(&head, (u_int64_t)strdup("B"));
	ft_list_push_front(&head, (u_int64_t)strdup("C"));
	ft_list_sort_v2(&head, wrap_strcmp);
	free(head->next->next);
	free(head->next);
	free(head);
}
