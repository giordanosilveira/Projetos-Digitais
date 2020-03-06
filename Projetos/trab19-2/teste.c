#include <stdio.h>
#include <stdlib.h>

int logaritmo (int n) {
    if(n < 2) 
        return 0;
    else        //  divisão com  deslocamento
        return(1 + logaritmo(n/2)); 
}

//  empilhe o que  deve  ser  empilhado
int power(int n,int exp) {
    if (exp > 1) 
        return(n * power(n,exp -1));
    else
        return(n);
}

int main () {

    int i,n;
    for(i = 4; i > 0; i--) {
        printf ("%d\n", i);
        n = logaritmo (power(i, 4));
        printf ("%d\n", n);
    }
    return 0;
}