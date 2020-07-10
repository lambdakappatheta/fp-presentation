#include <stdio.h>
#include <stdlib.h>

int compare_ints(const void* a, const void* b)
{
    int arg1 = *(const int*)a;
    int arg2 = *(const int*)b;
 
    if (arg1 < arg2) return 1;
    if (arg1 > arg2) return -1;
    return 0;
}

int main(void)
{
    int a[] = {2, 4, 2, 1};
    
    qsort(a, 4, sizeof(int), compare_ints);
 
    for (int i = 0; i < 4; i++) {
        printf("%d ", a[i]);
    }
 
    printf("\n");
}


// void qsort( void *ptr, 
//             size_t count,   // pointer to the array to sort
//             size_t size,    // number of element in the array
//             int (*comp)(const void *, const void *)     //comparison function
//             );

// returns 
// a negative integer value if the first argument is less than the second,
// a positive integer value if the first argument is greater than the second and 
// zero if the arguments are equal