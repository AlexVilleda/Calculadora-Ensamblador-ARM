/*  MATERIA: MIP115-2020
    INTEGRANTES:
    Trigueros Santamaría, Raúl Antonio  TS14004
    Villeda Romero, Alfredo Alexander   VR15004
    ENUNCIADO:
    Diseño de calculadora que permite realizar las operaciones básicas con números de punto flotante,
    el programa muestra un menú que permite al usuario elegir la opción a realizar.
*/
	.data
msjr1:	.asciz	"\n\t\t----------> Estamos con exponente 0\n"    //mensaje para detallar que se trabaja con exponente 0 y el resultado de la operacion será 1, en la operacion de potenciacion

msj1:   .asciz  "====================================================================================================\n\n\tCALCULADORA DE OPERACIONES ARITMÉTICAS CON NÚMEROS EN COMA FLOTANTE\n\n\n\t\tMENÚ DE OPERACIONES\n\n1. SUMA\n2. RESTA\n3. MULTIPLICACIÓN\n4. POTENCIACIÓN\n\n0. CERRAR LA CALCULADORA\n"
msj2:   .asciz  "\n\nINGRESE EL NÚMERO DE LA OPERACIÓN QUE DESEA REALIZAR: "
msj3:   .asciz  "\nIngrese el primer operando: "
msj4:   .asciz  "Ingrese el segundo operando: "
msj5:   .asciz  "\nIngrese el valor de la base: "
msj6:   .asciz  "Ingrese el valor del exponente: "
msj7:   .asciz  "\n\nEl resultado de la SUMA es: %f \n"
msj8:   .asciz  "\n\nEl resultado de la RESTA es: %f \n"
msj9:   .asciz  "\n\nEl resultado de la MULTIPLICACIÓN es: %f \n"
msj10:  .asciz  "\n\nEl resultado de la POTENCIACIÓN es: %f \n"
msj11:  .asciz  "\n\n\n¿DESEA SALIR DE LA CALCULADORA?\t( SÍ = 1 | NO = 0)\n\t¿Salir? : "
msj12:	.asciz  "\n¡El número ingresado debe ser un entero entre 0 y 4!\n"

opcionMenu:	.float 	0	//Contendrá el valor de la operacion aritmética seleccionada
salir:          .float 	1.0	//Utilizada para indicar si cerrar la calculadora o continuar
uno:            .float	1.0     //Variable de tipo flotante inicializada en uno, que se utilizará en el proceso
op1:            .float	0      	//Operando 1 en formato flotante. En la operación de potencia representa la base
op2:            .float	0      	//Operando 2 en formato flotante. En la operación de potencia representa el exponente sin redondear
expo:           .word	0	//Valor del exponente convertido a entero
abs:            .word	0       //representa el valor absoluto del exponente
fmt:            .asciz  "%f"    //Formato de tipo flotante

	.text
	.global main

main:

	//Impresion del mensaje de inicio
	LDR	R0, =msj1
	BL 	printf

_lecturaTipoDeOperacion:

	LDR	R0, =msj2
	BL	printf
	LDR	R0, =fmt
	LDR	R1, =opcionMenu
	BL 	scanf

	//PROCESO DE VALIDACION
	LDR	R1, =opcionMenu
	VLDR	S0, [R1]
	VCVT.S32.F32	S1, S0
	VMOV		R0, S1

	LDR	R1, =opcionMenu
	STR	R0, [R1]

	//Verificamos que este dentro del rango de opciones del menu
	LDR	R3, =opcionMenu
	LDR	R3, [R3]

	CMP	R3, #0
	BLT	_operacionFueraDelRango

	LDR	R3, =opcionMenu
	LDR	R3, [R3]

	CMP	R3, #4
	BGT	_operacionFueraDelRango

	LDR	R2, =opcionMenu
	LDR	R2, [R2]
	CMP	R2, #0
	BEQ	_exit

	//LECTURA PRIMER NUMERO PARA LAS OPERACIONES DE SUMA, RESTA Y MULTIPLICACION
	LDR	R0, =msj3
	BL	printf
	LDR	R0, =fmt
	LDR	R1, =op1
	BL	scanf

	//LECTURA SEGUNDO NUMERO PARA LAS OPERACIONES DE SUMA, RESTA Y MULTIPLICACION
	LDR	R0, =msj4
	BL	printf
	LDR	R0, =fmt
	LDR	R1, =op2
	BL	scanf


	//SALTO A OPERACION DE SUMA
	LDR	R3, =opcionMenu
	LDR	R3, [R3]
	CMP	R3, #1
	BEQ	_suma

	//SALTO A OPERACION DE SUMA
	LDR	R3, =opcionMenu
	LDR	R3, [R3]
	CMP	R3, #2
	BEQ	_resta


_suma:
	//CARGAMOS LOS 2 OPERANDOS EN MEMORIA A SUS RESPECTIVOS REGISTROS
	LDR	R0, =op1
	VLDR	S1, [R0]
	LDR	R1, =op2
	VLDR	S2, [R1]

	//REALIZAMOS LA OPERACION DE SUMA
	VADD.F32	S0, S1, S2
	VCVT.F64.F32	D3, S0

	VMOV	R2, R3, D3
	LDR	R0, =msj7
	BL	printf
	BL	_exit

_resta:
	//CARGAMOS LOS 2 OPERANDOS EN MEMORIA A SUS RESPECTIVOS REGISTROS
	LDR	R0, =op1
	VLDR	S1, [R0]
	LDR	R1, =op2
	VLDR	S2, [R1]

	//REALIZAMOS LA OPERACION DE SUMA
	VSUB.F32	S0, S1, S2
	VCVT.F64.F32	D3, S0

	VMOV	R2, R3, D3
	LDR	R0, =msj8
	BL	printf
	BL	_exit

_operacionFueraDelRango:
	LDR	R0, =msj12
	BL	printf
	BL	_lecturaTipoDeOperacion

_exit:
	MOV	R7, #1
	SWI	0
