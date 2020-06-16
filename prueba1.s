/* Prueba de calculadora con numeros enteros*/
	.data
msj1:   .asciz  "\n\n\tCALCULADORA DE OPERACIONES ARITMÉTICAS CON NÚMEROS EN COMA FLOTANTE\n\n\n\t\tMENÚ DE OPERACIONES\n\n1. SUMA\n2. RESTA\n3. MULTIPLICACIÓN\n4. POTENCIACIÓN\n\n0. CERRAR LA CALCULADORA\n"
msj2:   .asciz  "\n\nINGRESE EL NÚMERO DE LA OPERACIÓN QUE DESEA REALIZAR: "
msj3:   .asciz  "\nIngrese el primer número: "
msj4:   .asciz  "\nIngrese el segundo número: "
msj5:   .asciz  "\nEl resultado de la SUMA es: %d "
msj6:   .asciz  "\nEl resultado de la RESTA es: %d "
msj7:   .asciz  "\nEl resultado de la MULTIPLICACIÓN es: %d "
msj8:   .asciz  "\nEl resultado de la POTENCIACIÓN es: %d "
msj9:   .asciz  "\n\n\n¿DESEA SALIR DE LA CALCULADORA?\t( SÍ = 1 | NO = 0)\n\t¿Salir? : "
msj10:	.asciz  "\n¡El número ingresado debe ser un entero entre 0 y 4!\n"
num1:	.word 0		//Contendrá el valor de la operacion aritmética seleccionada
salir:	.word 1		//Utilizada para indica si cerrar la calculadora o continuar
op1:	.word 0      	//Operando 1
op2:	.word 0      	//Operando 2

fmt1:   .asciz  "%d"

	.text
	.global main

main:
    	PUSH    {LR}

   	//IMPRESION DE MENSAJE DE INICIO
    	LDR     R0, =msj1
    	BL      printf

_lecturaTipoDeOperacion:
	//Solicitamos el tipo de operación aritmética a realizar
    	LDR     R0, =msj2
    	BL      printf
    	LDR     R0, =fmt1
    	LDR     R1, =num1
    	BL      scanf

     	//PROCESO DE VALIDACIÓN
    	LDR     R3, =num1
    	LDR     R3, [R3]

    	CMP     R3, #0
    	BLT    _operacionFueraDelRango		//Si num1<0, saltar al mensaje de error

    	LDR     R3, =num1
    	LDR     R3, [R3]

    	CMP     R3, #4
    	BGT    _operacionFueraDelRango		//Si num1>4, saltar al mensaje de error

	LDR	R2, =num1
	LDR	R2, [R2]
	CMP	R2, #0
	BEQ	_exit				//Si num1=0, salir de la calculadora

    	//LEER PRIMER NÚMERO
    	LDR     R0, =msj3
	BL      printf
	LDR     R0, =fmt1
	LDR     R1, =op1
	BL      scanf

	//LEER SEGUNDO NÚMERO
	LDR	R0, =msj4
	BL      printf
	LDR     R0, =fmt1
	LDR     R1, =op2
	BL      scanf

//Saltamos al tipo de operación elegida
//Nota: Cada vez que hacemos una comparacion con CMP, el registro utilizado pierde su valor, así que para volverlo a utilizar, debemos volver a cargar el valor en el registro deseado

	LDR	R3, =num1
	LDR	R3, [R3]
	CMP	R3, #1
	BEQ	_suma

	LDR	R3, =num1
	LDR	R3, [R3]
	CMP	R3, #2
	BEQ	_resta

	LDR	R3, =num1
	LDR	R3, [R3]
	CMP	R3, #3
	BEQ	_multiplicacion

/*	Desmarcar esto para activar la potenciación
	LDR	R3, =num1
	LDR	R3, [R3]
	CMP	R3, #4
	BEQ	_potenciacion */

_suma:
	//CARGAMOS LOS 2 OPERANDOS EN MEMORIA A SUS RESPECTIVOS REGISTROS
	LDR	R0, =op1
	LDR	R0, [R0]
	LDR	R1, =op2
	LDR	R1, [R1]

	//REALIZAMOS LA OPERACIÓN DE SUMA
	ADD	R1, R0, R1	//R1 = R0 + R1
	LDR	R0, =msj5
	BL	printf
	BL	_salirDeCalculadora

_resta:
	//CARGAMOS LOS 2 OPERANDOS EN MEMORIA A SUS RESPECTIVOS REGISTROS
	LDR	R0, =op1
	LDR	R0, [R0]
	LDR	R1, =op2
	LDR	R1, [R1]

	//REALIZAMOS LA OPERACIÓN DE SUMA
	SUB	R1, R0, R1	//R1 = R0 - R1
	LDR	R0, =msj6
	BL	printf
	BL	_salirDeCalculadora

_multiplicacion:
	//CARGAMOS LOS 2 OPERANDOS EN MEMORIA A SUS RESPECTIVOS REGISTROS
	LDR	R0, =op1
	LDR	R0, [R0]
	LDR	R1, =op2
	LDR	R1, [R1]

	//REALIZAMOS LA OPERACIÓN DE SUMA
	MUL	R1, R0, R1	//R1 = R0 * R1
	LDR	R0, =msj7
	BL	printf
	BL	_salirDeCalculadora

/*			LA POTENCIACION AUN NO ESTA DISPONIBLE
_potenciacion:

	//CARGAMOS LOS 2 OPERANDOS EN MEMORIA A SUS RESPECTIVOS REGISTROS
	LDR	R0, =op1
	LDR	R0, [R0]
	LDR	R1, =op2
	LDR	R1, [R1]

	//REALIZAMOS LA OPERACIÓN DE SUMA
	ADD	R1, R1, R0	//R1 = R1 + R0
	LDR	R0, =msj5
	BL	printf
	BL	_salirDeCalculadora
*/
_salirDeCalculadora:
	//Leer el valor
	LDR     R0, =msj9
	BL      printf
	LDR     R0, =fmt1
	LDR     R1, =salir
	BL      scanf

	LDR	R2, =salir
	LDR	R2, [R2]
	CMP	R2, #0		//Si salir = 0, se reinicia la calculadora
	BEQ	main		//O saltamos a _lecturaTipoDeOperacion para que pregunte directamente el tipo de operacion a realizar sin que muestre el menú de operaciones de nuevo

	LDR	R3, =salir
	LDR	R3, [R3]
	CMP	R3, #1		//Si salir = 1, se cerrará la calculadora
	BEQ	_exit
	BAL	_salirDeCalculadora

_exit:
	POP     {PC}
	MOV 	R7, #1		// Exit Syscall
	SWI 	0

_operacionFueraDelRango:	//Imprime que el numero de la operacion seleccionada debe estar dentro del rango
	LDR	R0, =msj10
	BL	printf
	BL	_lecturaTipoDeOperacion
