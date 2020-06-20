/* Prueba de calculadora con numeros flotantes*/
	.data
msj1:   .asciz  "\n\n\tCALCULADORA DE OPERACIONES ARITMÉTICAS CON NÚMEROS EN COMA FLOTANTE\n\n\n\t\tMENÚ DE OPERACIONES\n\n1. SUMA\n2. RESTA\n3. MULTIPLICACIÓN\n4. POTENCIACIÓN\n\n0. CERRAR LA CALCULADORA\n"
msj2:   .asciz  "\n\nINGRESE EL NÚMERO DE LA OPERACIÓN QUE DESEA REALIZAR: "
msj3:   .asciz  "\nIngrese el primer operando: "
msj4:   .asciz  "\nIngrese el segundo operando: "
msj5:   .asciz  "\nIngrese el valor de la base: "
msj6:   .asciz  "\nIngrese el valor del exponente: "
msj7:   .asciz  "\nEl resultado de la SUMA es: %f "
msj8:   .asciz  "\nEl resultado de la RESTA es: %f "
msj9:   .asciz  "\nEl resultado de la MULTIPLICACIÓN es: %f "
msj10:   .asciz  "\nEl resultado de la POTENCIACIÓN es: %f "
msj11:   .asciz  "\n\n\n¿DESEA SALIR DE LA CALCULADORA?\t( SÍ = 1 | NO = 0)\n\t¿Salir? : "
msj12:	.asciz  "\n¡El número ingresado debe ser un entero entre 0 y 4!\n"
num1:	.word 0		//Contendrá el valor de la operacion aritmética seleccionada
uno:    .single 1.0     //Variable de tipo flotante inicializada en uno, que se utilizará en el proceso
salir:	.word 1		//Utilizada para indicar si cerrar la calculadora o continuar
op1:	.single 0      	//Operando 1 en formato flotante, En la operación de potencia representa la base
op2:	.single 0      	//Operando 2 en formato flotante, En la operación de potencia representa el exponente
fmt1:   .asciz  "%d"    //Formato de tipo entero 
fmt2:   .asciz  "%f"    //Formato de tipo flotante

	.text
	.global main

main:
    //	PUSH    {LR}

   	//IMPRESION DE MENSAJE DE INICIO
    	LDR     R0, =msj1
    	BL      printf

_lecturaTipoDeOperacion:
	//SOLICITAMOS EL TIPO DE OPERACION QUE SE DESEA REALIZAR
    	LDR     R0, =msj2
    	BL      printf
    	LDR     R0, =fmt1
    	LDR     R1, =num1
    	BL      scanf

     	//PROCESO DE VALIDACIÓN DE OPCIÓN INGRESADA
    	LDR     R3, =num1
    	LDR     R3, [R3]

    	CMP     R3, #0                          //Comparación del valor que contiene el registro R3 con 0 --->num1==0
    	BLT    _operacionFueraDelRango		//Si num1<0, saltar al mensaje de error

    	LDR     R3, =num1
    	LDR     R3, [R3]

    	CMP     R3, #4                          //Comparación del valor que contiene el registro R3 con 4 --->num1==4
    	BGT    _operacionFueraDelRango		//Si num1>4, saltar al mensaje de error

        //PROCESO DE VALIDACIÓN SI DESEA SALIR O CONTINUAR
	LDR	R2, =num1
	LDR	R2, [R2]
	CMP	R2, #0                          //Comparación del valor que contiene el registro R2 con 0 --->num1==0
	BEQ	_exit				//Si num1=0, salir de la calculadora

/*NOTA: Debido a que para la operacíon de potenciación se necesitará mostrar mensajes diferentes al solicitar los datos de entrada,
        que debe ser Base y exponente los que se requieren, se validará si selecciono la opción de potenciación para que salte
        directamente a la etiqueta de _potenciacion, y haga su proceso interno, con los mensajes adecuados*/

        //PROCESO DE VALIDACIÓN PARA SABER SI SELECCIONE LA OPERACIÓN 4 QUE REPRESENTA LA POTENCIACIÓN
	LDR	R2, =num1
	LDR	R2, [R2]
	CMP	R2, #4                          //Comparación del valor que contiene el registro R2 con 4 --->num1==4
	BEQ	_potenciacion		        //Si num1=4, salta a la etiqueta _potenciacion

    	//LEER PRIMER NÚMERO PARA OPERACIONES DE SUMA, RESTA Y MULTIPLICACIÓN
    	LDR     R0, =msj3
	BL      printf
	LDR     R0, =fmt2
	LDR     R1, =op1
	BL      scanf

	//LEER SEGUNDO NÚMERO PARA OPERACIONES DE SUMA, RESTA Y MULTIPLICACIÓN
	LDR	R0, =msj4
	BL      printf
	LDR     R0, =fmt2
	LDR     R1, =op2
	BL      scanf


//Saltamos al tipo de operación elegida
//Nota: Cada vez que hacemos una comparacion con CMP, el registro utilizado pierde su valor, así que para volverlo a utilizar, debemos volver a cargar el valor en el registro deseado

        //SALTO A OPERACIÓN SUMA
	LDR	R3, =num1
	LDR	R3, [R3]
	CMP	R3, #1
	BEQ	_suma
        //SALTO A OPERACIÓN RESTA
	LDR	R3, =num1
	LDR	R3, [R3]
	CMP	R3, #2
	BEQ	_resta
        //SALTO A OPERACIÓN MULTIPLICACIÓN
	LDR	R3, =num1
	LDR	R3, [R3]
	CMP	R3, #3
	BEQ	_multiplicacion

	//SALTO A OPERACIÓN DE POTENCIACIÓN
	LDR	R3, =num1
	LDR	R3, [R3]
	CMP	R3, #4
	BEQ	_potenciacion 

_suma:
	//CARGAMOS LOS 2 OPERANDOS EN MEMORIA A SUS RESPECTIVOS REGISTROS
	LDR	R0, =op1                    
	VLDR	S1, [R0]                    //Cargamos el valor del R0 en un registro S1 de 32 bits de tipo flotante
	LDR	R1, =op2                    
	VLDR	S2, [R1]                    //Cargamos el valor del R1 en un registro S2 de 32 bits de tipo flotante

	//REALIZAMOS LA OPERACIÓN DE SUMA
	VADD.F32        S0, S1, S2          //Se realiza la operacion S0=S1+S2, con valores en punto flotante de 32 bits
	VCVT.F64.F32	D3, S0              //Convierte el registro S0 de 32 bits a un registro D3 de 64 bits

	VMOV	R2, R3, D3                  //Mueve el registro D3 de 64 bits a dos registros (R2,R3) de 32 bits para poder imprimir
	LDR	R0, =msj7
	BL	printf
	BL	_salirDeCalculadora         //Realiza un salto a la etiqueta _salirCalculadora para verificar si desea salir o continuar

_resta:
	//CARGAMOS LOS 2 OPERANDOS EN MEMORIA A SUS RESPECTIVOS REGISTROS
	LDR	R0, =op1
	VLDR	S1, [R0]                    //Cargamos el valor del R0 en un registro S1 de 32 bits de tipo flotante
	LDR	R1, =op2
	VLDR	S2, [R1]                    //Cargamos el valor del R1 en un registro S2 de 32 bits de tipo flotante

	//REALIZAMOS LA OPERACIÓN DE RESTA
	VSUB.F32        S0, S1, S2          //Se realiza la operacion S0=S1-S2, con valores en punto flotante de 32 bits
	VCVT.F64.F32	D3, S0              //Convierte el registro S0 de 32 bits a un registro D3 de 64 bits

	VMOV	R2, R3, D3                  //Mueve el registro D3 de 64 bits a dos registros (R2,R3) de 32 bits para poder imprimir
	LDR	R0, =msj8
	BL	printf
	BL	_salirDeCalculadora         //Realiza un salto a la etiqueta _salirCalculadora para verificar si desea salir o continuar

_multiplicacion:
	//CARGAMOS LOS 2 OPERANDOS EN MEMORIA A SUS RESPECTIVOS REGISTROS
	LDR	R0, =op1
	VLDR	S1, [R0]                    //Cargamos el valor del R0 en un registro S1 de 32 bits de tipo flotante
	LDR	R1, =op2
	VLDR	S2, [R1]                    //Cargamos el valor del R1 en un registro S2 de 32 bits de tipo flotante

	//REALIZAMOS LA OPERACIÓN DE RESTA
	VMUL.F32        S0, S1, S2          //Se realiza la operacion S0=S1*S2, con valores en punto flotante de 32 bits
	VCVT.F64.F32	D3, S0              //Convierte el registro S0 de 32 bits a un registro D3 de 64 bits

	VMOV	R2, R3, D3                  //Mueve el registro D3 de 64 bits a dos registros (R2,R3) de 32 bits para poder imprimir
	LDR	R0, =msj9
	BL	printf
	BL	_salirDeCalculadora         //Realiza un salto a la etiqueta _salirCalculadora para verificar si desea salir o continuar


_potenciacion:
	  //LEER LA BASE PARA LA OPERACIÓN DE POTENCIACIÓN
    	LDR     R0, =msj5
	BL      printf
	LDR     R0, =fmt2
	LDR     R1, =op1
	BL      scanf

	//LEER EL EXPONENTE PARA LA OPERACIÓN DE POTENCIACIÓN
	LDR	R0, =msj6
	BL      printf
	LDR     R0, =fmt2
	LDR     R1, =op2
	BL      scanf

        //PROCESO PARA REALIZAR LA OPERACIÓN DE POTENCIACIÓN
        LDR     R1, =op1                //asignamos a un registro la direccion del operando 1 que representa la base
        VLDR    S1, [R1]                //Asignamos  un registro de punto flotante el valor del registro R1
        VMOV    S2, S1                  //Movemos el valor de la base al Registro S2 para utilizar ese registro como la base al realizar el calculo
        LDR     R5, =uno                //asignamos a un registro la variable uno 
        VLDR    S5, [R5]                //Asignamos  un registro de punto flotante el valor del registro R5
        VMOV    S4, S5                  //Iniciamos el contador en S4 con el valor que contiene el registro de punto flotante S5 (S5==1)
    _loop:                              //Ciclo que se repetirá la cantidad de veces que representa el exponente para realizar el cálculo
        LDR         R3, =op2            //asignamos a un registro la direccion del operando 2 que representa el exponente
        VLDR        S3, [R3]            //Asignamos  un registro de punto flotante el valor del registro R3
        VCMP.F32    S3, #0              //compara el exponente con 0, para hacer el calculo de la base elevado a 0 y su resultado sería 1 siempre
        BEQ     _resultado1             //Si el resultado de la comparación anterior es igual a 0, salta a la etiqueta _resultado1
        VCMP.F32    S4, S3              //Compara el contador con el valor del exponente, de tipo flotante de 32 bits
        BGE     _resultado              //Si de la instruccion anterior S4 es mayor que S3, salta a la etiqueta _resultado
        BLT     _operacion              //Si de la instrucción anterior S4 es menor que S3, salta a la etiqueta _operación

    _operacion:                         //Calcular  la potencia del numero con multiplicaciones sucesivas
        VMUL.F32    S1, S1, S2          //Multiplica la base S2, por el valor acumulado en S1
        VADD.F32    S4, S5              //Aumenta el contador en 1 -->S5==1
        BAL     _loop                   //salta siempre a la etiqueta _loop

    _resultado:                         //Contiene el resultado, cuando el exponenete es diferente de cero
        LDR             R0, =msj10
        VCVT.F64.F32	D3, S1          //Convierte el registro S1(32 bits) a D3(64 bits), para imprimir  
        VMOV            R2, R3, D3      //Mueve el valor del registro D3(64 bits) a (R2, R3) de 32 bits para que estos se utilicen en la impresion
        BL              printf          
        BL              _salirDeCalculadora
    _resultado1:                        //Contiene el resultado, cuando el exponenete es igual a cero
        LDR             R0, =msj10
        VMOV            S1, S5          //Mueve el registro S5 (S5==1) al registro S1
        VCVT.F64.F32	D3, S1          //Convierte el registro S1(32 bits) a D3(64 bits), para imprimir  
        VMOV            R2, R3, D3      //Mueve el valor del registro D3(64 bits) a (R2, R3) de 32 bits para que estos se utilicen en la impresion
        BL              printf
        BL              _salirDeCalculadora

_salirDeCalculadora:
	//Leer el valor
	LDR     R0, =msj11
	BL      printf
	LDR     R0, =fmt1
	LDR     R1, =salir
	BL      scanf

	LDR	R2, =salir
	LDR	R2, [R2]
	CMP	R2, #0              //Compara el registro R2 con 0
	BEQ	main               //Si salir = 0, se reinicia la calculadora

	LDR	R3, =salir
	LDR	R3, [R3]
	CMP	R3, #1             //Si salir = 1, se cerrará la calculadora
	BNE	_salirDeCalculadora
        BEQ     _exit



_operacionFueraDelRango:	//Imprime que el numero de la operacion seleccionada debe estar dentro del rango
	LDR	R0, =msj12
	BL	printf
	BL	_lecturaTipoDeOperacion

_exit:
	//POP     {PC}
	MOV 	R7, #1		// Exit Syscall
	SWI 	0