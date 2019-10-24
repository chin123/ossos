# OS with kencc
OSDev recommends usage of gcc, however kencc is a much nicer alternative.

# Compilation
* get kencc
* `8a start.s`
* `8c kernel.c`
* `8l -o prog -l -R1 -H5 -T0x100000 start.8 kernel.8`
* `qemu-system-i386 -kernel prog`

# Legal
The code is licensed under GPLv3  
I looked at, and will continue to look at a lot of plan9 code for this, governed by the GPLv2, in [LICENSE-plan9](LICENSE-plan9).  
tfw your code is smaller than your license
