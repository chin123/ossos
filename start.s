#define HLT		BYTE $0xF4
#define PDO(a)		(((((a))>>22) & 0x03FF)<<2)
TEXT _multiboot(SB), $0
	// multiboot magic
	LONG	$0x1BADB002
	// flags
	LONG	$0x00000003
	// checksum
	LONG	$-(0x1BADB002 + 0x00000003)

TEXT _startkernel(SB), $0
	MOVL	$0xF0100000, SP		/* initialize stack */
	MOVL	$0, 0(SP)

	ADDL	$0x00004000, SP

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
