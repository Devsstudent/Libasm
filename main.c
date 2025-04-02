/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   main.c                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: odessein <marvin@42.fr>                    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2023/10/25 10:30:19 by odessein          #+#    #+#             */
/*   Updated: 2023/10/26 15:11:21 by odessein         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */
#include "libasm.h"
#include <fcntl.h>
void test_strdup(){
	char s[1000] = "alllay";
	char s_bis[1000] = "heyooo";
	char *res = ft_strdup(s);
	char *res1 = strdup(s);
	if (strcmp(res, res1) != 0)
		printf("KO\n");
	else
		printf("OK\n");
	free(res);
	free(res1);
	res = ft_strdup("");
	res1 = strdup("");
	if (strcmp(res, res1) != 0)
		printf("KO\n");
	else
		printf("OK\n");
	free(res);
	free(res1);
	res = ft_strdup(s_bis);
	res1 = strdup(s_bis);
	if (strcmp(res, res1) != 0)
		printf("KO\n");
	else
		printf("OK\n");
	free(res);
	free(res1);
}

void test_strcmp(){
	char s[100] = "allo";
	char s_bis[100] = "allo";
	int res = 0;
	int res_bis = 0;

	res = strcmp(s, s_bis);
	res_bis = ft_strcmp(s, s_bis);
	if (res != res_bis)
		printf("KO %s %s, %i %i\n", s, s_bis, res, res_bis);
	else
		printf("OK\n");
	bzero(s, 100);
	res = strcmp(s, s_bis);
	res_bis = ft_strcmp(s, s_bis);
	if (res != res_bis)
		printf("KO %s %s, %i %i\n", s, s_bis, res, res_bis);
	else
		printf("OK\n");
	bzero(s_bis, 100);
	res = strcmp(s, s_bis);
	res_bis = ft_strcmp(s, s_bis);
	if (res != res_bis)
		printf("KO %s %s, %i %i\n", s, s_bis, res, res_bis);
	else
		printf("OK\n");
	char s_s[100] = "askldjasjd";
	char s_s_bis[100] = "askldj";
	res = strcmp(s_s, s_s_bis);
	res_bis = ft_strcmp(s_s, s_s_bis);
	if (res != res_bis)
		printf("KO %s %s, %i %i\n", s, s_bis, res, res_bis);
	else
		printf("OK\n");
	char s_bis_s[100] = "askldjAAAA";
	res = strcmp(s, s_bis_s);
	res_bis = ft_strcmp(s, s_bis_s);
	if (res != res_bis)
		printf("KO %s %s, %i %i\n", s, s_bis, res, res_bis);
	else
		printf("OK\n");
}

void test_strcpy(){
	char s1[1000];
	char s1_bis[1000];
	char *res;
	char *res1;
	{
		char s[1000] = "alllay";
		char s_bis[1000] = "alllay";
		res = ft_strcpy(s1, s);
		res1 = strcpy(s1_bis, s_bis);
		if (strcmp(res, res1) != 0)
			printf("KO %s %s\n", res, res1);
		else
			printf("OK \n");
	}
	{
	char s[100] = "ZOW:L";
	char s_bis[100] = "ZOW:L";
	res = ft_strcpy(s1, s);
	res1 = strcpy(s1_bis, s_bis);
	if (strcmp(res, res1) != 0)
		printf("KO %s %s\n", res, res1);
	else
		printf("OK\n");
	}
	{
	char s[100] = "";
	char s_bis[100] = "";
	res = ft_strcpy(s1, s);
	res1 = strcpy(s1_bis, s_bis);
	if (strcmp(res, res1) != 0)
		printf("KO %s %s\n", s, s_bis);
	else
		printf("OK\n");
	}
	{
	char s[100] = "\n\n\n\n";
	char s_bis[100] = "\n\n\n\n";
	res = ft_strcpy(s1, s);
	res1 = strcpy(s1_bis, s_bis);
	if (strcmp(res, res1) != 0)
		printf("KO %s %s\n", s, s_bis);
	else
		printf("OK\n");
	}
}

void test_strlen(){
	char s[100] = "allo";
	char s_bis[100] = "allo";

	if (strlen("allo\n") != ft_strlen("allo\n"))
		printf("KO\n");
	else
		printf("OK\n");
	if (strlen("") != ft_strlen(""))
		printf("KO\n");
	else
		printf("OK\n");
	if (strlen("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaa") != ft_strlen("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"))
		printf("KO\n");
	else
		printf("OK\n");
}


void test_read(){
	char str[1000];
	char str1[1000] = "0123456789";
	char str2[1000] = "hello";
	bzero(str, 1000);
	// test read sur stdin
//	ft_read(0, str, 10);
//	if (!strncmp(str, str1, 10))
//		printf("OK %s %s\n", str, str1);
//	else
//		printf("KO %s %s\n", str, str1);
	printf("OK %i\n",ft_read(-1, str, 1000));
	perror("hello");
	int fd = open("./hello", O_RDWR);
	if (!fd)
			return ;
	bzero(str, 1000);
	ft_read(fd, str, 5);
	if (!strncmp(str, str2, 5))
		printf("OK %s %s\n", str, str2);
	else
		printf("KO %s %s\n", str, str2);
}

void test_write(){
	char str[1000] = "hello\n";
	int a = ft_write(1, str, 5);
	int b = write(1, str, 5);
	if (a != b)
		printf("KO %i %i\n", a, b);
	else
		printf("OK\n", a, b);
	int fd = open("./hello", O_RDWR | O_APPEND);
	if (!fd)
			return ;
	a = ft_write(fd, str, 5);
	b = write(fd, str, 5);
	if (a != b)
		printf("KO %i %i\n", a, b);
	else
		printf("OK\n", a, b);
	if (ft_write(-1, str, 100) < 0){
		printf("OK\n");
		perror("error:");
	}
	else
		printf("KO\n");
}

int main(void){
	printf("test strdup :\n");
	test_strdup();
	printf("test strcmp :\n");
	test_strcmp();
	printf("test strcpy :\n");
	test_strcpy();
	printf("test strlen :\n");
	test_strlen();
	printf("test read:\n");
	test_read();
	printf("test write:\n");
	test_write();
}
