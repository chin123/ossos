TEXT _multiboot(SB), $0
	LONG	$0x1BADB002			/* multiboot magic*/
	LONG	$0x00000003			/* flags */
	LONG	$-(0x1BADB002 + 0x00000003)	/* checksum */
