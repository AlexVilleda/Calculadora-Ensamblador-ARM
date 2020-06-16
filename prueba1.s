/* Prueba de calculadora con numeros enteros*/
    .data
msj1:   .asciz  "\n\n\tCALCULADORA DE OPERACIONES ARITMÉTICAS CON NUMEROS EN COMA FLOTANTE \n\n "
msj2:   .asciz  "\n\tMENU DE OPERACIONES\n\n1. SUMA\n2. RESTA\n3. MULTIPLICACIÓN\n4. POTENCIACIÓN\n0. CERRAR LA CALCULADORA\n\n\nINGRESE EL NÚMERO DE LA OPERACIÓN QUE DESEA REALIZAR: "
msj3:   .asciz  "\nIngrese el primer número: "
msj4:   .asciz  "\nIngrese el segundo número: "
msj5:   .asciz  "\n El resultado de la SUMA es: %d "
msj6:   .asciz  "\n El resultado de la RESTA es: %d "
msj7:   .asciz  "\n El resultado de la MULTIPLICACIÓN es: %d "
msj8:   .asciz  "\n El resultado de la POTENCIACIÓN es: %d"
msj9:   .asciz  "\n ¿DESEA SALIR?\t0. SI\t1. NO: "
msj10:  .asciz  "\n ¡El número ingresado deber estar entre 0 y 4! \n"
num1:  .word 0
op1:   .word 0      //Operando 1
op2:   .word 0      //Operando 2

fmt1:   .asciz  "%d"
    .text
    .global main

main:
    PUSH    {LR}
   //IMPRESION DE MENSAJES DE INICIO
    LDR     R0, =msj1
    BL      printf
    LDR     R0, =msj2
    BL      printf
    LDR     R0, =fmt1
    LDR     R1, =num1   
    BL      scanf
   
     //PROCESO DE VALIDACIÓN
    LDR     R2, =num1
    LDR     R2, [R2]
      
    CMP     R2, #0          //Compara el valor del R2 con 0 
    LDR     R0, =msj10
    BLLT     printf          //Si de la instruccion anterior CMP R2, #0 Resulta que R2 es menor que 0 Imprime el mensaje de validación
    
    LDR     R2, =num1       //Asignamos nuevamente el valor de num1 en el R2 para verificar la validación
    LDR     R2, [R2]    
    CMP     R2, #0          //Comparamos para hacer la validación y si el valor ingresado no cumple, retorna al main
    BLLT    main            //Si el valor ingresado no cumplió la validación, retorna al main

    LDR     R3, =num1       
    LDR     R3, [R3]
      
    CMP     R3, #4          //Compara el valor del R3 con 0 
    LDR     R0, =msj10
    BLGT    printf          //Si de la instruccion anterior CMP R3, #0 Resulta que R3 es mayor que 4 Imprime el mensaje de validación
    
    LDR     R3, =num1       //Asignamos nuevamente el valor de num1 en el R3 para verificar la validación
    LDR     R3, [R3]
    CMP     R3, #4          //Comparamos para hacer la validación y si el valor ingresado no cumple, retorna al main
    BLGT    main            //Si el valor ingresado no cumplió la validación, retorna al main
     
    //LEER PRIMER NUMERO
    LDR     R0, =msj3
    BL      printf
    LDR     R0, =fmt1
    LDR     R1, =op1   
    BL      scanf

     //LEER SEGUNDO NUMERO
    LDR     R0, =msj4
    BL      printf
    LDR     R0, =fmt1
    LDR     R1, =op2   
    BL      scanf

   
    POP     {PC}

_exit:
	MOV 	R7, #1 // Exit Syscall
	SWI 	0
