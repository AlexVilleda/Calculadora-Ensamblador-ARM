// Enunciado:
// *** Nombre: Villeda Romero, Alfredo Alexander        Carnet: VR15004

// ****************** Seccion de datos para definir las variables
        .data
numero1:	.double   0
numero2:	.double	  0
//const:        .word   16
msj1:   .asciz  "\nIngrese el primer numero: "
msj2:   .asciz  "\nIngrese el segundo numero: "
msj3:	.asciz	"\nLa suma es: %lf\n\n"
fmt:    .asciz  "%lf"


// *******************************************
        .text
        .global main
main:
        PUSH    {LR}

	LDR	R0, =msj1
	BL	printf
	LDR	R0, =fmt
	LDR	R1, =numero1
	BL	scanf
	LDR	R2, =numero1
	LDR	R2, [R2]

	LDR	R0, =msj2
	BL	printf
	LDR	R0, =fmt
	LDR	R1, =numero2
	BL	scanf
	LDR	R3, =numero2
	LDR	R3, [R1]

	VLDR	d0, [R2]
	//VLDR	s0, [s0]
	VLDR	d1, [R3]
	//VLDR	s1, [s1]
	VMUL.F64	d0, d0, d1

	LDR	R0, =fmt
	VMOV	R2, R3, d0

	BL printf


        POP     {PC}
_exit:
        MOV     R7, #1
        SVC     0
