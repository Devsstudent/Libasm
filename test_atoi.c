#include "libasm.h"
#include <stdio.h>

int main() {

	char *base = "011";
	char *str = "blabla";

	int a = ft_atoi_base(str, base);
	printf("%i\n", a);

	char *base1 = "ae";
	char *str1 = "aeae";
	a = ft_atoi_base(str1, base1);
	printf("%i\n", a);
	return 0;
}
