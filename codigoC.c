//Inclusiones de librerias
#include<stdio.h>

//Programa principal
void main()
{
     int n=0,m=0,x=0;
     printf("Ingrese un numero: ");
     scanf("%d",&n);
     if (n>999 && n<=10000)
     {
        x=n;
        m=x%10;
        x=x/10;
        m=(m*10)+(x%10);
        x=x/10;
        m=(m*10)+(x%10);
        x=x/10;
        m=(m*10)+(x%10);
        if (n==m)
        {
           printf("El numero es PALINDROMO");
        }
        else
        {
            printf("El numero NO es PALINDROMO");
        }
     }
     else
     {
         printf("Solo se aceptan numeros de cuatro digitos");
     }    
}
//Fin del programa
