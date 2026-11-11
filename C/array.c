#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[]) {
    int count = argc - 1;

    if (count > 10) {
        printf("Your program takes no more than 10 integers as command line parameters.\n");
        return 1;
    }

    int array[10];

    for (int i = 0; i < count; i++) {
        array[i] = atoi(argv[i + 1]);
    }

    int temp;
    for (int i = 0; i < count - 1; i++) {
        for (int j = 0; j < count - i - 1; j++) {
            if (array[j] > array[j + 1]) {
                temp = array[j];
                array[j] = array[j + 1];
                array[j + 1] = temp;
            }
        }
    }

    for (int i = 0; i < count; i++) {
        printf("%d ", array[i]);
    }
    printf("\n");

    return 0;
}
