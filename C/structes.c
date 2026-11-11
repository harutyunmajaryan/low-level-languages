#include <stdio.h>
#include <stdlib.h>


typedef struct{
   int number1;
   long number2;

}mystruct;

int main(){
    mystruct ms = {10, 15.2};

    printf("first number of the struct: %d\n", ms.number1);
    printf("second number of the struct: %ld\n", ms.number2);


    return 0;
}
