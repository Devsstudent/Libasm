#include "libasm.h"
#include <stdio.h>
//
//int main() {
//
//	char *base = "011";
//	char *str = "blabla";
//
//	int a = ft_atoi_base(str, base);
//	printf("Invalide Base : %i\n", a);
//
//  char *base2 = "01";
//  char *str2 = "1010";
//	a = ft_atoi_base(str2, base2);
//	printf("Valid base : %i\n", a);
//
//  char *base1 = "ea";
//  char *str1 = "   +- aeae";
//	a = ft_atoi_base(str1, base1);
//	printf("Valid base : %i\n", a);
//
//
//	char *base3 = "0123456789abcdef";
//	char *str3 = "aeae";
//	a = ft_atoi_base(str3, base3);
//	printf("Valid base hexa : %i\n", a);
//
//	char *base4 = "ae";
//	char *str4 = "aeaze";
//	a = ft_atoi_base(str4, base4);
//	printf("Invalid str : %i\n", a);
//
//	return 0;
//}

#include <stdio.h>
#include <stdlib.h>

int ft_atoi_base(char *str, char *base); // Your function prototype

void run_test(char *str, char *base, int expected)
{
    int result = ft_atoi_base(str, base);
    if (result == expected)
        printf("[OK] \"%s\" in base \"%s\" -> %d\n", str, base, result);
    else
        printf("[FAIL] \"%s\" in base \"%s\" -> got %d, expected %d\n", str, base, result, expected);
}

int main(void)
{
    // Valid cases
    run_test("1010", "01", 10);                    // binary
    run_test("A", "0123456789ABCDEF", 10);         // hex
    run_test("FF", "0123456789ABCDEF", 255);       // hex
    run_test("-FF", "0123456789ABCDEF", -255);     // hex negative
    run_test("42", "0123456789", 42);              // decimal
    run_test("   -101", "01234567", -65);          // octal
    run_test("   +7F", "0123456789ABCDEF", 127);   // hex with +
    run_test("   -111", "01", -7);                 // binary with spaces
    run_test("0", "0123456789", 0);                // zero
    run_test("   +0", "0123456789", 0);            // positive zero

    // Invalid bases
    run_test("123", "", 0);                        // empty base
    run_test("123", "1", 0);                       // single char base
    run_test("123", "1123456789", 0);              // repeated chars
    run_test("123", "012+3456789", 0);             // invalid '+' in base
    run_test("123", "012 3456789", 0);             // space in base
    run_test("123", "012-3456789", 0);             // '-' in base

    // Strings with invalid characters
    run_test("12A", "0123456789", 12);             // stops at A
    run_test("XYZ", "0123456789", 0);              // invalid from start
    run_test("", "0123456789", 0);                 // empty string
    run_test("    ", "0123456789", 0);             // just whitespace
    run_test("--42", "0123456789", 0);             // invalid sign

    // Edge base cases
    run_test("zz", "abcdefghijklmnopqrstuvwxyz", 675);  // base 26
    run_test("-zz", "abcdefghijklmnopqrstuvwxyz", -675);
    run_test("    -ab", "ab", -3);                      // binary-like base "ab"

    return 0;
}

