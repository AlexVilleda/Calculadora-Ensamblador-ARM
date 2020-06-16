/* Printing a floating point number */

	.global main
//	.func main
main:
/*	LDR		R1, =value1 // Get addr of value1
	VLDR		S14, [R1] 	// Move value1 to S14
	VCVT.F64.F32	D5, S14 	// Convert to B64
	LDR		R0, =string 	// point R0 to string
	VMOV		R2, R3, D5 	// Load value
	BL		printf 		// call function
*/
/*	LDR		R2, =value2 // Get addr of value1
	VLDR		D6, [R2] 	// Move value1 to S14
	//VCVT.F64.F32	D5, S14 	// Convert to B64
	LDR		R0, =string 	// point R0 to string
	VMOV		R2, R3, D6 	// Load value
	BL		printf 		// call function
*/
	PUSH	{LR}
	LDR	R0, =msj1
	BL	printf
	LDR	R0, =fmt
	LDR	R1, =n1
	BL	scanf

	LDR	R1, =n1
	VLDR	S1, [R1]

	LDR	R0, =msj2
	BL	printf
	LDR	R0, =fmt
	LDR	R1, =n2
	BL	scanf

	LDR	R1, =n2
	VLDR	S2, [R1]

	VADD.F32        S0, S1, S2
	VCVT.F64.F32	D3, S0

	VMOV	R2, R3, D3
	LDR	R0, =msj3
	BL	printf

	POP	{PC}
_exit:
	MOV 	R7, #1 // Exit Syscall
	SWI 	0

	.data
//value1:	.float	1.54321
//value2:	.double	2323.63627
//string: .asciz	"\nFloating point value is: %f\n"
msj1:	.asciz	"\n\n\tCALCULADORA DE FLOTANTES\n\nIngrese el valor del numero 1: "
msj2:	.asciz	"\nIngrese el valor del numero 2: "
msj3:	.asciz	"\nLa suma  es: %f\n\n"
n1:	.single	0
n2:	.single	0
fmt:	.asciz	"%f"
