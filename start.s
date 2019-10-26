#define HLT		BYTE $0xF4
TEXT _multiboot(SB), $0
	LONG	$0x1BADB002			/* multiboot magic*/
	LONG	$0x00000003			/* flags */
	LONG	$-(0x1BADB002 + 0x00000003)	/* checksum */

GLOBL	stack_static+0(SB), $4000			/* statically allocated stack */

TEXT _startkernel(SB), $0
	MOVL	$stack_static+0(SB), SP
	MOVL	$0, 0(SP)
	ADDL	$4000, SP			/* move address of stack to SP */
	CALL	kernel_main(SB)
	CLI
inf_loop:
	HLT
	JMP	inf_loop

// hang for edge cases
TEXT _hangkernel(SB), $0
hang:
	STI
	HLT
	JMP	hang
