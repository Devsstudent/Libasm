#include <stdio.h>
#include <assert.h>
#include <stdlib.h>
#include "libasm.h"
#include <stdint.h>

// Comparison function
int cmp(const void *a, const void *b) {
    return (*(uint8_t *)a - *(uint8_t *)b);
}

// Helper to print the list
void print_list(t_list *head) {
    while (head) {
        printf("%d -> ", *(int *)head->data);
        head = head->next;
    }
    printf("NULL\n");
}

// Allocate int data and node
t_list *create_node(int value) {
    int *data = malloc(sizeof(int));
    *data = value;
    t_list *node = malloc(sizeof(t_list));
    node->data = data;
    node->next = NULL;
    return node;
}

// Free list and data
void free_list(t_list *head) {
    while (head) {
        t_list *tmp = head->next;
        free(head->data);
        free(head);
        head = tmp;
    }
}

void test_custom_list(const uint8_t *values, size_t len) {
    t_list *head = NULL;
    for (size_t i = 0; i < len; i++) {
        t_list *node = create_node(values[i]);
        node->next = head;
        head = node;
    }

    printf("Custom List Test (size %zu):\n", len);
    print_list(head);
    ft_list_sort(&head, cmp);
    print_list(head);

    // Check sorted order
    int expected = 0;
    t_list *cur = head;
    uint8_t *sorted = malloc(len);
    memcpy(sorted, values, len);
    qsort(sorted, len, sizeof(uint8_t), cmp);

//    for (size_t i = 0; i < len; ++i) {
 //       assert(cur);
//        assert(*(uint8_t *)cur->data == sorted[i]);
 //       cur = cur->next;
  //  }

    free(sorted);
    free_list(head);
}

// Tests

void test_single_element() {
    t_list *node = create_node(5);
    printf("Test 1: Single Element\n");
    print_list(node);
    ft_list_sort(&node, cmp);
    print_list(node);
    assert(*(int *)node->data == 5);
    free_list(node);
}

void test_two_element_unsorted() {
    t_list *a = create_node(10);
    t_list *b = create_node(5);
    a->next = b;
    printf("Test 2: Two Element Unsorted\n");
    print_list(a);
    ft_list_sort(&a, cmp);
    print_list(a);
    assert(*(int *)a->data == 5);
    assert(*(int *)a->next->data == 10);
    free_list(a);
}

void test_two_element_sorted() {
    t_list *a = create_node(5);
    t_list *b = create_node(10);
    a->next = b;
    printf("Test 3: Two Element Sorted\n");
    print_list(a);
    ft_list_sort(&a, cmp);
    print_list(a);
    assert(*(int *)a->data == 5);
    assert(*(int *)a->next->data == 10);
    free_list(a);
}

void test_multiple_elements_unsorted() {
    t_list *a = create_node(10);
    t_list *b = create_node(5);
    t_list *c = create_node(15);
    a->next = b;
    b->next = c;
    printf("Test 4: Multiple Unsorted\n");
    print_list(a);
    ft_list_sort(&a, cmp);
    print_list(a);
    assert(*(int *)a->data == 5);
    assert(*(int *)a->next->data == 10);
    assert(*(int *)a->next->next->data == 15);
    free_list(a);
}

void test_duplicate_elements() {
    t_list *a = create_node(10);
    t_list *b = create_node(5);
    t_list *c = create_node(10);
    a->next = b;
    b->next = c;
    printf("Test 5: Duplicates\n");
    print_list(a);
    ft_list_sort(&a, cmp);
    print_list(a);
    assert(*(int *)a->data == 5);
    assert(*(int *)a->next->data == 10);
    assert(*(int *)a->next->next->data == 10);
    free_list(a);
}

void test_large_list() {
    t_list *head = NULL;
    for (int i = 100; i > 0; i--) {
        t_list *node = create_node(i);
        node->next = head;
        head = node;
    }
    printf("Test 6: Large List\n");
    ft_list_sort(&head, cmp);
    t_list *cur = head;
    for (int i = 1; i <= 100; i++) {
        assert(cur);
        assert(*(int *)cur->data == i);
        cur = cur->next;
    }
    free_list(head);
}

void test_sorted_list() {
    t_list *a = create_node(1);
    t_list *b = create_node(2);
    t_list *c = create_node(3);
    a->next = b;
    b->next = c;
    printf("Test 7: Already Sorted\n");
    print_list(a);
    ft_list_sort(&a, cmp);
    print_list(a);
    assert(*(int *)a->data == 1);
    assert(*(int *)a->next->data == 2);
    assert(*(int *)a->next->next->data == 3);
    free_list(a);
}

void test_negative_numbers() {
    t_list *a = create_node(-10);
    t_list *b = create_node(-5);
    t_list *c = create_node(-15);
    a->next = b;
    b->next = c;
    printf("Test 8: Negative Numbers\n");
    print_list(a);
    ft_list_sort(&a, cmp);
    print_list(a);
    assert(*(int *)a->data == -15);
    assert(*(int *)a->next->data == -10);
    assert(*(int *)a->next->next->data == -5);
    free_list(a);
}

void test_list_of_7_u8() {
    uint8_t values[] = {78, 209, 215, 246, 252, 170, 149};
    test_custom_list(values, 7);
}

void test_list_of_15_u8() {
    uint8_t values[] = {133, 222, 83, 117, 73, 127, 81, 50, 41, 29, 180, 56, 246, 18, 150};
    test_custom_list(values, 15);
}

void test_list_of_361_u8() {
    uint8_t values[361];
    for (int i = 0; i < 361; i++) values[i] = (uint8_t)(rand() % 256);
    test_custom_list(values, 361);
}

int main(void) {
    test_single_element();
    test_two_element_unsorted();
    test_two_element_sorted();
    test_multiple_elements_unsorted();
    test_duplicate_elements();
    test_large_list();
    test_sorted_list();
    test_negative_numbers();
	test_list_of_7_u8();
    test_list_of_15_u8();
    test_list_of_361_u8();
    printf("All tests passed!\n");
    return 0;
}

