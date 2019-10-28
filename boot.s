#define HLT		BYTE $0xF4
#define NOP		BYTE $0x90		/* NOP */
#define DELAY		BYTE $0xEB; BYTE $0x00	/* JMP .+2 */
GLOBL	stack_static+0(SB), $4000			/* statically allocated stack, quick hack */

TEXT _startkernel(SB), $0
	/* set up the gdt */
	MOVL	$gdtptr(SB), AX
	MOVL	(AX), GDTR
	MOVW	$1, AX
	/* MSW is the lower 16 bits of CR0 */
	MOVW	AX, MSW

	/* Loading segment selectors */
	MOVW	$(0x10), AX
	MOVW	AX, DS
	MOVW	AX, SS
	MOVW	AX, ES
	MOVW	AX, FS
	MOVW	AX, GS
	STI

/*	JMP	$(0x08):$mode32bit(SB) /**/
	BYTE	$0xEA
	LONG	$_reached32(SB)
	WORD	$(0x08)

TEXT _reached32(SB), $0
	MOVL	$stack_static+0(SB), SP
	MOVL	$0, 0(SP)
	ADDL	$4000, SP			/* move address of stack to SP */
	CALL	kernel_main(SB)
	CLI
inf_loop:
	HLT
	JMP	inf_loop

TEXT _hangkernel(SB), $0
hang:
	STI
	HLT
	JMP	hang

TEXT gdt(SB), $0
	LONG $0x0000; LONG $0 /* Intel null segment */
	LONG $0xFFFF0000; BYTE $0; BYTE $0x9A; BYTE $0xCF; BYTE $0 /* code segment */
	LONG $0xFFFF0000; BYTE $0; BYTE $0x92; BYTE $0xCF; BYTE $0 /* data segment */

TEXT gdtptr(SB), $0
	WORD	$(8*3-1)	/* size of gdt */
	LONG	$gdt(SB)	/* will need to change when using higher half kernel*/
