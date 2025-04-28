#include "libasm.h"
#include <stdlib.h>
#include <string.h>


int cmp_str(void *a, void *b) {
    return strcmp((char *)a, (char *)b);
}

t_list *create_elem(void *data) {
    t_list *new = malloc(sizeof(t_list));
    if (!new) return NULL;
    new->data = data;
    new->next = NULL;
    return new;
}

void free_data(void *data) {
    free(data);
}

void print_list(t_list *head) {
    while (head) {
        printf("%s -> ", (char *)head->data);
        head = head->next;
    }
    printf("NULL\n");
}
int main() {
    // Test 1: Basic removal
    printf("Test 1: Basic removal of 'apple'\n");
    t_list *list1 = create_elem(strdup("apple"));
    list1->next = create_elem(strdup("banana"));
    list1->next->next = create_elem(strdup("apple"));
    list1->next->next->next = create_elem(strdup("cherry"));

    printf("Original list:\n");
    print_list(list1);
    ft_list_remove_if(&list1, "apple", cmp_str, free_data);
    printf("List after removing 'apple':\n");
    print_list(list1);

    // Clean up
    while (list1) {
        t_list *tmp = list1;
        list1 = list1->next;
        free_data(tmp->data);
        free(tmp);
    }

    // Test 2: Remove element that doesn’t exist
    printf("\nTest 2: Try removing 'orange' (not in list)\n");
    t_list *list2 = create_elem(strdup("banana"));
    list2->next = create_elem(strdup("cherry"));
    list2->next->next = create_elem(strdup("date"));

    printf("Original list:\n");
    print_list(list2);
    ft_list_remove_if(&list2, "orange", cmp_str, free_data);
    printf("List after attempting to remove 'orange':\n");
    print_list(list2);

    // Clean up
    while (list2) {
        t_list *tmp = list2;
        list2 = list2->next;
        free_data(tmp->data);
        free(tmp);
    }

    // Test 3: All elements match (all should be removed)
    printf("\nTest 3: All elements are 'apple' (remove all)\n");
    t_list *list3 = create_elem(strdup("apple"));
    list3->next = create_elem(strdup("apple"));
    list3->next->next = create_elem(strdup("apple"));

    printf("Original list:\n");
    print_list(list3);
    ft_list_remove_if(&list3, "apple", cmp_str, free_data);
    printf("List after removing 'apple':\n");
    print_list(list3);  // Should print "NULL"

    // No need to clean up, all should be removed

    // Test 4: Empty list
    printf("\nTest 4: Empty list\n");
    t_list *list4 = NULL;
    ft_list_remove_if(&list4, "apple", cmp_str, free_data);
    printf("List after removal attempt:\n");
    print_list(list4);  // Should print "NULL"

    return 0;
}

